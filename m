Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F0A2245A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569529111;
	bh=Y0QL9BOd7qG/6XfLpAZEcutZdBtAqfjwl0u8UKFXPJY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BG5UhAJf7NzCng5oLrozl6ZcGoWwQChkzLj2Q+/Gm4kv0ujQi7p/Qs6mbqkEwek41
	 2IzJId37UOPzbesRpmChLrx1+1A52WTV3tdAe05aeLWMAqdhU31tJTwxwwBUVzngBU
	 EDlyMaBav5PNJX9ggkIzbTT2ED1wIMHlDATRU3TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfIZUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:18:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33671 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfIZUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:18:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so247913wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K6KGQD0Wd+OVDQn/j0vT+U0Y+5fdAsupOgYWKksgg+k=;
        b=SDt1WyGYWdB50PopMTBRB/zb0gZ4Pjpui1mg/9xGSvGATiU6IAEI5IYfInybqLwq/H
         joF96yGdL+8N5FD3zJYtUmQfbxP21AAv8geDPyG0AZH73LCThLzPG3xq3+Lzvjvd0dX9
         PWQkQC5jWk7GqtQTZiKDtK4UmwCpbsQ6jog0SzE95BndJZPyXxGGLs/s7cGHrlwEB5Rc
         KwkFds3KmxHXv2mZLB/1M9FmjBqwVsLukDADK8nggAR6Vm1JGZd21IQ9L5onkP7Z0W95
         6p3g37w1hoKnuqTuNp2fSN4kAiWJBMZ7MfffV57h35qnAti/aRwCRA0spM5G3PpjgGlL
         g/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=K6KGQD0Wd+OVDQn/j0vT+U0Y+5fdAsupOgYWKksgg+k=;
        b=HOIvv4NbuXB4YudcSoCDSAtnzU37xJBEvaI3RB4uGortH+LkD2iqzF0gXX7Nebtsxr
         EbCKen4eLduyhnm25CNKbaJK4ewBmcu03CplaIx5X+sRWWMeheXQzQkggelQk21BLJPT
         L3uwszMU5sqTBuLS2NE6ATf0JJ+ziCieFiyxmnVP9lmCCte3vmjKoJ+bPgTd3TRYTX7f
         wos1Sj7pFrdp34H6MYbXG27TRTceDOTa/s/ZdifxGXwHEAySzb0MHXACCPOR2KbwT61J
         TIpRSEWXFCisDT1UTNOczFXYSBPhORk+JCzYerkk398739NxGmU8w85eTMQM4Bk8pPs/
         7T6A==
X-Gm-Message-State: APjAAAUxbwu3z+n7VnKsRpY3dkwfYLlMCCXT5DHwh6xfeMm7KBjBqUYm
        RbLSL4GUcTFliOHjZBzuGXA=
X-Google-Smtp-Source: APXvYqwZxHqmqrp1Wtc2vFVGo/9mVB3bPGh+gG1g+jLMFlzmHXG5nlWCbVi7GmGQkJrE07ExzTowfA==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr215847wrq.18.1569529107750;
        Thu, 26 Sep 2019 13:18:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g185sm7713093wme.10.2019.09.26.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 13:18:27 -0700 (PDT)
Date:   Thu, 26 Sep 2019 22:18:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20190926201825.GA45571@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: e430d802d6a3aaf61bd3ed03d9404888a29b9bf9 timer: Read jiffies once when forwarding base clk

Fixes a timer expiry bug that would cause spurious delay of timers.

 Thanks,

	Ingo

------------------>
Li RongQing (1):
      timer: Read jiffies once when forwarding base clk


 kernel/time/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0e315a2e77ae..4820823515e9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1678,24 +1678,26 @@ void timer_clear_idle(void)
 static int collect_expired_timers(struct timer_base *base,
 				  struct hlist_head *heads)
 {
+	unsigned long now = READ_ONCE(jiffies);
+
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
 	 * base to current jiffies. Avoid a loop by searching the bitfield for
 	 * the next expiring timer.
 	 */
-	if ((long)(jiffies - base->clk) > 2) {
+	if ((long)(now - base->clk) > 2) {
 		unsigned long next = __next_timer_interrupt(base);
 
 		/*
 		 * If the next timer is ahead of time forward to current
 		 * jiffies, otherwise forward to the next expiry time:
 		 */
-		if (time_after(next, jiffies)) {
+		if (time_after(next, now)) {
 			/*
 			 * The call site will increment base->clk and then
 			 * terminate the expiry loop immediately.
 			 */
-			base->clk = jiffies;
+			base->clk = now;
 			return 0;
 		}
 		base->clk = next;
