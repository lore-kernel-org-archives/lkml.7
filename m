Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F816208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Mcg3vD7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfF0Xnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:43:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36043 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:43:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNeRer500405
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:40:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNeRer500405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678827;
        bh=HYMo7V5MKBTB1MqwDpXm+3PxdI5PVUVHNhLcBgZ2O24=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Mcg3vD7Pb6FTJD1gxdgrbUYYRwZGEYLBr8hLpyXA+ihN2FXZt4hSHlyflaIuQmd+o
         xFUydiXp1jx51Zn6h0LKfOPRMvQBxhgU8xRK3RTxx++ANhgDsBDbBVe0joOfMPjWl0
         tyaE7lK4MIiIsBQ1uomgV6aKAVA4jTuKKxoHj373d8pQXiDf/EMjdtfxDHSjP2sdOs
         j4dl2ty9F+60Od+dhjndtUcqNzSFV+m0MYIXUnVgAZ1lB9d1ltfRQYQjEVRrJWCyl5
         Ei9inQxGsc4ucvC+Cc07kPOYukrrNA6HJ7YSEyojCUD0n8n1K+LKPcTigR17Flja60
         jK9f/pj8uAtgQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNeQH9500402;
        Thu, 27 Jun 2019 16:40:26 -0700
Date:   Thu, 27 Jun 2019 16:40:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6bdec41a0cbcbda35c9044915fc8f45503a595a0@git.kernel.org>
Cc:     eranian@google.com, ravi.v.shankar@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        peterz@infradead.org, ricardo.neri-calderon@linux.intel.com,
        tglx@linutronix.de, Suravee.Suthikulpanit@amd.com,
        ashok.raj@intel.com, hpa@zytor.com
Reply-To: peterz@infradead.org, andi.kleen@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          eranian@google.com, ravi.v.shankar@intel.com, hpa@zytor.com,
          ashok.raj@intel.com, Suravee.Suthikulpanit@amd.com,
          tglx@linutronix.de, ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20190623132434.951733064@linutronix.de>
References: <20190623132434.951733064@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Shuffle code around for readability sake
Git-Commit-ID: 6bdec41a0cbcbda35c9044915fc8f45503a595a0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6bdec41a0cbcbda35c9044915fc8f45503a595a0
Gitweb:     https://git.kernel.org/tip/6bdec41a0cbcbda35c9044915fc8f45503a595a0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:18 +0200

x86/hpet: Shuffle code around for readability sake

It doesn't make sense to have init functions in the middle of other
code. Aside of that, further changes in that area create horrible diffs if
the code stays where it is.

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.951733064@linutronix.de

---
 arch/x86/kernel/hpet.c | 81 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index d6bd0ed6885b..71533f53fa1d 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -559,6 +559,47 @@ static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
 					0x7FFFFFFF);
 }
 
+static struct hpet_dev *hpet_get_unused_timer(void)
+{
+	int i;
+
+	if (!hpet_devs)
+		return NULL;
+
+	for (i = 0; i < hpet_num_timers; i++) {
+		struct hpet_dev *hdev = &hpet_devs[i];
+
+		if (!(hdev->flags & HPET_DEV_VALID))
+			continue;
+		if (test_and_set_bit(HPET_DEV_USED_BIT,
+			(unsigned long *)&hdev->flags))
+			continue;
+		return hdev;
+	}
+	return NULL;
+}
+
+static int hpet_cpuhp_online(unsigned int cpu)
+{
+	struct hpet_dev *hdev = hpet_get_unused_timer();
+
+	if (hdev)
+		init_one_hpet_msi_clockevent(hdev, cpu);
+	return 0;
+}
+
+static int hpet_cpuhp_dead(unsigned int cpu)
+{
+	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
+
+	if (!hdev)
+		return 0;
+	free_irq(hdev->irq, hdev);
+	hdev->flags &= ~HPET_DEV_USED;
+	per_cpu(cpu_hpet_dev, cpu) = NULL;
+	return 0;
+}
+
 #ifdef CONFIG_HPET
 /* Reserve at least one timer for userspace (/dev/hpet) */
 #define RESERVE_TIMERS 1
@@ -644,46 +685,6 @@ static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
 }
 #endif
 
-static struct hpet_dev *hpet_get_unused_timer(void)
-{
-	int i;
-
-	if (!hpet_devs)
-		return NULL;
-
-	for (i = 0; i < hpet_num_timers; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
-
-		if (!(hdev->flags & HPET_DEV_VALID))
-			continue;
-		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hdev->flags))
-			continue;
-		return hdev;
-	}
-	return NULL;
-}
-
-static int hpet_cpuhp_online(unsigned int cpu)
-{
-	struct hpet_dev *hdev = hpet_get_unused_timer();
-
-	if (hdev)
-		init_one_hpet_msi_clockevent(hdev, cpu);
-	return 0;
-}
-
-static int hpet_cpuhp_dead(unsigned int cpu)
-{
-	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
-
-	if (!hdev)
-		return 0;
-	free_irq(hdev->irq, hdev);
-	hdev->flags &= ~HPET_DEV_USED;
-	per_cpu(cpu_hpet_dev, cpu) = NULL;
-	return 0;
-}
 #else
 
 static inline void hpet_msi_capability_lookup(unsigned int start_timer) { }
