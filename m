Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF441C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8FF20861
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfFPLdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 07:33:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfFPLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 07:33:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcTPC-0008Nj-Up; Sun, 16 Jun 2019 13:33:03 +0200
Date:   Sun, 16 Jun 2019 11:29:52 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] ras fixes for 5.2
Message-ID: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

up to:  0ade0b6240c4: RAS/CEC: Convert the timer callback to a workqueue

Two small fixes for RAS:

 - Use a proper search algorithm to find the correct element in the CEC
   array. The replacement was a better choice than fixing the crash causes
   by the original search function with horrible duct tape.

 - Move the timer based decay function into thread context so it can
   actually acquire the mutex which protects the CEC array to prevent
   corruption.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      RAS/CEC: Fix binary search function

Cong Wang (1):
      RAS/CEC: Convert the timer callback to a workqueue


 drivers/ras/cec.c | 80 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 88e4f3ff0cb8..673f8a128397 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
 
 #include <asm/mce.h>
 
@@ -123,16 +124,12 @@ static u64 dfs_pfn;
 /* Amount of errors after which we offline */
 static unsigned int count_threshold = COUNT_MASK;
 
-/*
- * The timer "decays" element count each timer_interval which is 24hrs by
- * default.
- */
-
-#define CEC_TIMER_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
-#define CEC_TIMER_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
-#define CEC_TIMER_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
-static struct timer_list cec_timer;
-static u64 timer_interval = CEC_TIMER_DEFAULT_INTERVAL;
+/* Each element "decays" each decay_interval which is 24hrs by default. */
+#define CEC_DECAY_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
+#define CEC_DECAY_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
+#define CEC_DECAY_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
+static struct delayed_work cec_work;
+static u64 decay_interval = CEC_DECAY_DEFAULT_INTERVAL;
 
 /*
  * Decrement decay value. We're using DECAY_BITS bits to denote decay of an
@@ -160,20 +157,21 @@ static void do_spring_cleaning(struct ce_array *ca)
 /*
  * @interval in seconds
  */
-static void cec_mod_timer(struct timer_list *t, unsigned long interval)
+static void cec_mod_work(unsigned long interval)
 {
 	unsigned long iv;
 
-	iv = interval * HZ + jiffies;
-
-	mod_timer(t, round_jiffies(iv));
+	iv = interval * HZ;
+	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
 }
 
-static void cec_timer_fn(struct timer_list *unused)
+static void cec_work_fn(struct work_struct *work)
 {
+	mutex_lock(&ce_mutex);
 	do_spring_cleaning(&ce_arr);
+	mutex_unlock(&ce_mutex);
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(decay_interval);
 }
 
 /*
@@ -183,32 +181,38 @@ static void cec_timer_fn(struct timer_list *unused)
  */
 static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 {
+	int min = 0, max = ca->n - 1;
 	u64 this_pfn;
-	int min = 0, max = ca->n;
 
-	while (min < max) {
-		int tmp = (max + min) >> 1;
+	while (min <= max) {
+		int i = (min + max) >> 1;
 
-		this_pfn = PFN(ca->array[tmp]);
+		this_pfn = PFN(ca->array[i]);
 
 		if (this_pfn < pfn)
-			min = tmp + 1;
+			min = i + 1;
 		else if (this_pfn > pfn)
-			max = tmp;
-		else {
-			min = tmp;
-			break;
+			max = i - 1;
+		else if (this_pfn == pfn) {
+			if (to)
+				*to = i;
+
+			return i;
 		}
 	}
 
+	/*
+	 * When the loop terminates without finding @pfn, min has the index of
+	 * the element slot where the new @pfn should be inserted. The loop
+	 * terminates when min > max, which means the min index points to the
+	 * bigger element while the max index to the smaller element, in-between
+	 * which the new @pfn belongs to.
+	 *
+	 * For more details, see exercise 1, Section 6.2.1 in TAOCP, vol. 3.
+	 */
 	if (to)
 		*to = min;
 
-	this_pfn = PFN(ca->array[min]);
-
-	if (this_pfn == pfn)
-		return min;
-
 	return -ENOKEY;
 }
 
@@ -374,15 +378,15 @@ static int decay_interval_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	if (val < CEC_TIMER_MIN_INTERVAL)
+	if (val < CEC_DECAY_MIN_INTERVAL)
 		return -EINVAL;
 
-	if (val > CEC_TIMER_MAX_INTERVAL)
+	if (val > CEC_DECAY_MAX_INTERVAL)
 		return -EINVAL;
 
-	timer_interval = val;
+	decay_interval = val;
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(decay_interval);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
@@ -426,7 +430,7 @@ static int array_dump(struct seq_file *m, void *v)
 
 	seq_printf(m, "Flags: 0x%x\n", ca->flags);
 
-	seq_printf(m, "Timer interval: %lld seconds\n", timer_interval);
+	seq_printf(m, "Decay interval: %lld seconds\n", decay_interval);
 	seq_printf(m, "Decays: %lld\n", ca->decays_done);
 
 	seq_printf(m, "Action threshold: %d\n", count_threshold);
@@ -472,7 +476,7 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
-				    &timer_interval, &decay_interval_ops);
+				    &decay_interval, &decay_interval_ops);
 	if (!decay) {
 		pr_warn("Error creating decay_interval debugfs node!\n");
 		goto err;
@@ -508,8 +512,8 @@ void __init cec_init(void)
 	if (create_debugfs_nodes())
 		return;
 
-	timer_setup(&cec_timer, cec_timer_fn, 0);
-	cec_mod_timer(&cec_timer, CEC_TIMER_DEFAULT_INTERVAL);
+	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
+	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
 	pr_info("Correctable Errors collector initialized.\n");
 }

