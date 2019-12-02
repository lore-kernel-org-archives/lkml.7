Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B629C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E05020748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575271940;
	bh=EbsJ58fc0CLqHX1FqIIjWjlir5y2EYZXHjHc/dKTbY4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fHuTVqiPLn59XPKMLh3O6Gan/cmuzl183+/RNnLGEZ8N89FlCiMQ3j8sFLLup8rXn
	 WmaK5nudjaAc2zUvc3PNVo+mYjteK24Yts1GR12HCiJciQTYKmlJ4TOicHa5LefaMa
	 rxQmMwcolEcmNPEghxhea59gBte/7haVTkVSDe88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLBHcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 02:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfLBHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:32:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D56220748;
        Mon,  2 Dec 2019 07:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575271938;
        bh=EbsJ58fc0CLqHX1FqIIjWjlir5y2EYZXHjHc/dKTbY4=;
        h=From:To:Cc:Subject:Date:From;
        b=Vu+xG8DK/+Atzk5cWWg1xrtmUrCShuFw20QsrJyHpIX6AcXkoYrsKV0eg7uw4Mk/U
         ls6bAbnJAyiHur25EQSWRPzZYAocMYvO7BkZY/UgZqHd25jcNhmNcrZoVI8pjwpWc3
         3TGulJToQVVz64dWFGfrsCy1G7DJrlJE5kywYoeA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Date:   Mon,  2 Dec 2019 16:32:13 +0900
Message-Id: <157527193358.11113.14859628506665612104.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders reported that the lockdep warns that suspicious
RCU list usage in register_kprobe() (detected by
CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
access kprobe_table[] by hlist_for_each_entry_rcu()
without rcu_read_lock.

If we call get_kprobe() from the breakpoint handler context,
it is run with preempt disabled, so this is not a problem.
But in other cases, instead of rcu_read_lock(), we locks
kprobe_mutex so that the kprobe_table[] is not updated.
So, current code is safe, but still not good from the view
point of RCU.

Let's lock the rcu_read_lock() around get_kprobe() and
ensure kprobe_mutex is locked at those points.

Note that we can safely unlock rcu_read_lock() soon after
accessing the list, because we are sure the found kprobe has
never gone before unlocking kprobe_mutex. Unless locking
kprobe_mutex, caller must hold rcu_read_lock() until it
finished operations on that kprobe.

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..fd814ea7dbd8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -319,6 +319,7 @@ static inline void reset_kprobe_instance(void)
  * 	- under the kprobe_mutex - during kprobe_[un]register()
  * 				OR
  * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
+ * In both cases, caller must disable preempt (or acquire rcu_read_lock)
  */
 struct kprobe *get_kprobe(void *addr)
 {
@@ -435,6 +436,7 @@ static int kprobe_queued(struct kprobe *p)
 /*
  * Return an optimized kprobe whose optimizing code replaces
  * instructions including addr (exclude breakpoint).
+ * This must be called with locking kprobe_mutex.
  */
 static struct kprobe *get_optimized_kprobe(unsigned long addr)
 {
@@ -442,9 +444,12 @@ static struct kprobe *get_optimized_kprobe(unsigned long addr)
 	struct kprobe *p = NULL;
 	struct optimized_kprobe *op;
 
+	lockdep_assert_held(&kprobe_mutex);
+	rcu_read_lock();
 	/* Don't check i == 0, since that is a breakpoint case. */
 	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
 		p = get_kprobe((void *)(addr - i));
+	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
 
 	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
@@ -1478,18 +1483,21 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 {
 	struct kprobe *ap, *list_p;
 
+	lockdep_assert_held(&kprobe_mutex);
+	rcu_read_lock();
 	ap = get_kprobe(p->addr);
 	if (unlikely(!ap))
-		return NULL;
+		goto out;
 
 	if (p != ap) {
 		list_for_each_entry_rcu(list_p, &ap->list, list)
 			if (list_p == p)
 			/* kprobe p is a valid probe */
-				goto valid;
-		return NULL;
+				goto out;
+		ap = NULL;
 	}
-valid:
+out:
+	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
 	return ap;
 }
 
@@ -1602,7 +1610,9 @@ int register_kprobe(struct kprobe *p)
 
 	mutex_lock(&kprobe_mutex);
 
+	rcu_read_lock();
 	old_p = get_kprobe(p->addr);
+	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
 	if (old_p) {
 		/* Since this may unoptimize old_p, locking text_mutex. */
 		ret = register_aggr_kprobe(old_p, p);

