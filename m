Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5F2C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C4D208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555745628;
	bh=ErOWRHFpBomKNFmEeV/VhGAJ2kjPPvGq0v4kfZScHLw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=s5pTXEXp8uxXSRv/v/hdd/rMaac0wtaihxSJDj4RROCSUm63gddo1SPyFmowfFr7D
	 2IBDXVERbKMq8hvwuqYp/lktRyled0rXs0vNFiRfyj5YNwIJHiaS7dVg0AqdFdhAqS
	 wVdTeH/+SltkewcGnS0v1L5ku9C9LivET2E3eecU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfDTHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:33:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50542 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDTHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:33:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so8456326wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nMI7LU4uLYxEFBdykrigzNLSw7GRjjm2/maBf6Yj2bk=;
        b=r/SWS74SZd1NoP2iXtoeGR56AlqRGumaBW62t/pA07V0xVatikd5PbTAp2+jox1JU3
         Z2YqRNLR5nntaaZbxVnezhVlUm48cDxvB0dwFbZgr0Uprmef6wpc7YiDkmM4zywSsjH2
         9e68NYjs4tzglJSCjZRQB6moIZuipj9Pv+Tig6hu9zcSh7obCLVNwy3dXDKfo7XKy8mb
         o2DriD9CUIqUt+OPxhjgKf+SIHtwQNYjz5xxnJPY4HjlvAOU0jF2JlUT7ygY3O/2gWxM
         wU/KYmqBW+gy1ilgWkozLt047Z+0gZnRGAAf4DLvNViDdrOn+S3lNfm5q/R7FQrwQ9K6
         ycvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=nMI7LU4uLYxEFBdykrigzNLSw7GRjjm2/maBf6Yj2bk=;
        b=oXa2K6XwPYEy8JSLPi+iPfoZ0/Wx7zqCcm44BFc2cXtSO1YeQishpM626OESQWecnq
         hnGszIfpyz89mEFpV+Au7BhPeqM2ZuhgOuK1vQqYM3j5E5dyGXshTR6/bvmEQnpjdcUM
         k5M6Q4fGG3nMRMdc1k6dAwreOgohH/Xx/4rL6OfzMKY8VKQ2BTbVVLnbT10A4KroPT5l
         KC2qHQOy1jQ4jQt026lUVs2xL8G2KSkLxsl9ROJoSVUhAjfuXX82MtXmjyR0Qc769ZzC
         8stBF4DF/0dKJjR21UCiftSDwM1EotWYpFz4KWgW7DmtJ7FGYVDNzUp4fbXOjqA3FskN
         AojA==
X-Gm-Message-State: APjAAAWpWIVN+oDcmW4I7uef1cOsMY14kRUcQ8hXE2i7+7gcL72gyAM+
        DWVj/YUwXDztUs9l9n4kVUPxWBtt
X-Google-Smtp-Source: APXvYqy3SDnsJCd2VhToUQZ7O+y+DDi1t27WX2/trjTpYfswY2/Bx66HBDk+VezzvSrItx1QPbM6eA==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr5640954wmj.44.1555745624622;
        Sat, 20 Apr 2019 00:33:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l19sm13154855wrf.35.2019.04.20.00.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:33:43 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:33:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20190420073341.GA34023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f sched/deadline: Correctly handle active 0-lag timers

A deadline scheduler warning/race fix, and a cfs_period_us quota 
calculation workaround where the real fix looks too involved to merge 
immediately.

 Thanks,

	Ingo

------------------>
Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

luca abeni (1):
      sched/deadline: Correctly handle active 0-lag timers


 kernel/sched/deadline.c |  3 +--
 kernel/sched/fair.c     | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6a73e41a2016..43901fa3f269 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
 	zerolag_time = dl_se->deadline -
@@ -269,7 +268,7 @@ static void task_non_contending(struct task_struct *p)
 	 * If the "0-lag time" already passed, decrease the active
 	 * utilization now, instead of starting a timer
 	 */
-	if (zerolag_time < 0) {
+	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40bd1e27b1b7..a4d9e14bf138 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
@@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	unsigned long flags;
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
@@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		if (++count > 3) {
+			u64 new, old = ktime_to_ns(cfs_b->period);
+
+			new = (old * 147) / 128; /* ~115% */
+			new = min(new, max_cfs_quota_period);
+
+			cfs_b->period = ns_to_ktime(new);
+
+			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
+			cfs_b->quota *= new;
+			cfs_b->quota = div64_u64(cfs_b->quota, old);
+
+			pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(),
+				div_u64(new, NSEC_PER_USEC),
+				div_u64(cfs_b->quota, NSEC_PER_USEC));
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
