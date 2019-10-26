Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3AECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9C21E6F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096252;
	bh=PR1cKbuVfWSAfCTQQycFTVQO24le7wxTVHpQTd0UA7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ecd9GGExayTGHreGB4Ocl90c+LYZg8qKE+47mJQ+ucnDCAbcZTMdkThEuJ89MZATl
	 ktyvz5LjAPQauM0Kl8tLWLFVf7vVI5Lq6WN9I0GioDh6j5YwhSh77mGiPJBl5VcOD5
	 2TGclbpflI8jnMsQ5xlh+So08qeNQ8IKp6gJ1dTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfJZNYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbfJZNX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:23:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF9A214DA;
        Sat, 26 Oct 2019 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096207;
        bh=PR1cKbuVfWSAfCTQQycFTVQO24le7wxTVHpQTd0UA7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boVyegQlclznhz4VcT5WWexDWQKLUvU38dvNpTeaJb9GRU5kV2JxepvytlEms160T
         tPtQlI4J9B49BGpKKsbS2Bfi2s0Ylxpo9qVYnUwBkq3iXWPY8UZgjeLTH0fLhvOdGf
         F/NrcXha5nAj2636vHXxGvT6utaVfIsGetDByiNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 11/17] hrtimer: Annotate lockless access to timer->base
Date:   Sat, 26 Oct 2019 09:22:55 -0400
Message-Id: <20191026132302.4622-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026132302.4622-1-sashal@kernel.org>
References: <20191026132302.4622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ff229eee3d897f52bd001c841f2d3cce8853ecdc ]

Followup to commit dd2261ed45aa ("hrtimer: Protect lockless access
to timer->base")

lock_hrtimer_base() fetches timer->base without lock exclusion.

Compiler is allowed to read timer->base twice (even if considered dumb)
which could end up trying to lock migration_base and return
&migration_base.

  base = timer->base;
  if (likely(base != &migration_base)) {

       /* compiler reads timer->base again, and now (base == &migration_base)

       raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
       if (likely(base == timer->base))
            return base; /* == &migration_base ! */

Similarly the write sides must use WRITE_ONCE() to avoid store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191008173204.180879-1-edumazet@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8c4e27cbfe7ff..df02ea41eafd7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -147,7 +147,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 	struct hrtimer_clock_base *base;
 
 	for (;;) {
-		base = timer->base;
+		base = READ_ONCE(timer->base);
 		if (likely(base != &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base == timer->base))
@@ -239,7 +239,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			return base;
 
 		/* See the comment in lock_hrtimer_base() */
-		timer->base = &migration_base;
+		WRITE_ONCE(timer->base, &migration_base);
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
@@ -248,10 +248,10 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
-			timer->base = base;
+			WRITE_ONCE(timer->base, base);
 			goto again;
 		}
-		timer->base = new_base;
+		WRITE_ONCE(timer->base, new_base);
 	} else {
 		if (new_cpu_base != this_cpu_base &&
 		    hrtimer_check_target(timer, new_base)) {
-- 
2.20.1

