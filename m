Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF96C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49A0222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbfISMLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:11:41 -0400
Received: from mx60.baidu.com ([61.135.168.60]:48565 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390113AbfISMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:11:40 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 08:11:38 EDT
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id CD37E204005B;
        Thu, 19 Sep 2019 20:04:47 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de
Subject: [PATCH] timer: read jiffies once when forwarding base clk
Date:   Thu, 19 Sep 2019 20:04:47 +0800
Message-Id: <1568894687-14499-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below calltrace was reported, the cause is that timer is delayed
bigger than 3 seconds

    Hardware name: New H3C Technologies Co.,Ltd. UniServer R4950 G3/RS41R4950, BIOS 2.00.06 V700R003
    Workqueue: events_unbound sched_tick_remote
    RIP: 0010:sched_tick_remote+0xee/0x100
    ...
    Call Trace:
    process_one_work+0x18c/0x3a0
    worker_thread+0x30/0x380
    ? process_one_work+0x3a0/0x3a0
    kthread+0x113/0x130
    ? kthread_create_worker_on_cpu+0x70/0x70
    ret_from_fork+0x22/0x40
    ---[ end trace 41bd884127493e39 ]---

then write a program to test timer latency, it can reproduce this issue

   static void sched_l_tick(struct timer_list *t)
   {
       unsigned long delta = jiffies - set_time;

       if (delta > 3*HZ)
               printk("abnormal %ld %d\n", delta, raw_smp_processor_id());

       set_time = jiffies+HZ;
       mod_timer(t, jiffies + HZ);
    }

further investigation shows jiffies maybe change when advence this base clk,
twice read of jiffies maybe lead to that base clk is bigger than truely next
event, and fire timer is skipped, so read jiffies once,

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Liang ZhiCheng <liangzhicheng@baidu.com>
---
 kernel/time/timer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 343c7ba33b1c..e2dbd0223635 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1593,24 +1593,27 @@ void timer_clear_idle(void)
 static int collect_expired_timers(struct timer_base *base,
 				  struct hlist_head *heads)
 {
+	unsigned long jnow;
+
+	jnow = READ_ONCE(jiffies);
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
 	 * base to current jiffies. Avoid a loop by searching the bitfield for
 	 * the next expiring timer.
 	 */
-	if ((long)(jiffies - base->clk) > 2) {
+	if ((long)(jnow - base->clk) > 2) {
 		unsigned long next = __next_timer_interrupt(base);
 
 		/*
 		 * If the next timer is ahead of time forward to current
 		 * jiffies, otherwise forward to the next expiry time:
 		 */
-		if (time_after(next, jiffies)) {
+		if (time_after(next, jnow)) {
 			/*
 			 * The call site will increment base->clk and then
 			 * terminate the expiry loop immediately.
 			 */
-			base->clk = jiffies;
+			base->clk = jnow;
 			return 0;
 		}
 		base->clk = next;
-- 
2.16.2

