Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FCD206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WIw3Lx1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfHATIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:08:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbfHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:08:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J8RHU071502
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:08:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J8RHU071502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686508;
        bh=4fpoA/AIApSz5zG8debCYd61iwWXegUm7ZZXFLrLLzc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WIw3Lx1D+8ZrNBTjECnMAHW+QSA1qIN+gmY0vUTUzO9sXhsP9/qWSVfbetNTRgvdR
         MOuXRT/p6DHEpBuPvmN4aOiGB0prgZONjksv5XYaQ1ZZP0klBqq0OJkJ+XZ92ma/0Y
         UH9LYZ4CRUPFk2VgaPsFB3GUZC2Nh/LkZ8V4rE5x1KiKOjBOIEoPCbjoUNee8sgAQG
         yvq47EXH95vZBbVsWJINw+Ro+QXGKItRNh46RF/HZZQMw33soZDfPF04qi1xSXHGqd
         lh47jRs3xSGe4bhGYGxu5KmsNFW0IERDEer9YGCG281jeluP56Iiw6xRNHN2dP5yt+
         ZMkQb6WC0faow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J8RMi071499;
        Thu, 1 Aug 2019 12:08:27 -0700
Date:   Thu, 1 Aug 2019 12:08:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-21670ee44f1e3565030bcabc62178b8e5eb2fce7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190730223828.782664411@linutronix.de>
References: <20190730223828.782664411@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Cleanup the flag/flags confusion
Git-Commit-ID: 21670ee44f1e3565030bcabc62178b8e5eb2fce7
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

Commit-ID:  21670ee44f1e3565030bcabc62178b8e5eb2fce7
Gitweb:     https://git.kernel.org/tip/21670ee44f1e3565030bcabc62178b8e5eb2fce7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:24 +0200

posix-timers: Cleanup the flag/flags confusion

do_timer_settime() has a 'flags' argument and uses 'flag' for the interrupt
flags, which is confusing at best.

Rename the argument so 'flags' can be used for interrupt flags as usual.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.782664411@linutronix.de


---
 kernel/time/posix-timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d7f2d91acdac..f5aedd2f60df 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -844,13 +844,13 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int flags,
+static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
 	const struct k_clock *kc;
 	struct k_itimer *timr;
-	unsigned long flag;
+	unsigned long flags;
 	int error = 0;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -860,7 +860,7 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 retry:
-	timr = lock_timer(timer_id, &flag);
+	timr = lock_timer(timer_id, &flags);
 	if (!timr)
 		return -EINVAL;
 
@@ -868,9 +868,9 @@ retry:
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
-		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
+		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
+	unlock_timer(timr, flags);
 	if (error == TIMER_RETRY) {
 		old_spec64 = NULL;	// We already got the old time...
 		goto retry;
