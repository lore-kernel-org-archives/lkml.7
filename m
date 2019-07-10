Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F3C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8759F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0JgoCRt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGJSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:43:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:43:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6AIhGfV2541654
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 11:43:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6AIhGfV2541654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562784196;
        bh=jmBnu3T2PgSdwgYSqr1z4MBYxeHZf+emBUh2okLE/Xs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0JgoCRt2srBioc4CAv4xhgGBWPTz2bhGRUKtuT6gFvdiX6p0ZnpRb1gdt/+mkcj+D
         0CYuQl2jMCmR8g6K+qru2L47MNL7FqcyJ2MI2WGRdsaQreY/zdm0R4TvTrXz2HO+9H
         h+ZtdJx5WmqvFE0Y6QZP+s5kai/yWhUAAhe/hjBrYP1pznsQIFQDiIvXcr6uwNE6Vr
         zFq4jUhYI1L7y/TiO8z2lMOisS0Trm2b8oXn3DeRT1UJ1YWj53rA2YAZYafqC9AhDU
         lm70Cc7G5y83kG7nPkDqXG6OZsDYOmDV2BgdT6M6Fljjq0DCTU0aeTH2r3MkvoW6SZ
         Ly5vXGJF87RIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6AIhFFj2541648;
        Wed, 10 Jul 2019 11:43:15 -0700
Date:   Wed, 10 Jul 2019 11:43:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-0df1c9868c3a1916198ee09c323ca5932a0b8a11@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, hpa@zytor.com,
        natechancellor@gmail.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, natechancellor@gmail.com, tglx@linutronix.de,
          hpa@zytor.com, arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190710130206.1670830-1-arnd@arndb.de>
References: <20190710130206.1670830-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timekeeping/vsyscall: Use __iter_div_u64_rem()
Git-Commit-ID: 0df1c9868c3a1916198ee09c323ca5932a0b8a11
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

Commit-ID:  0df1c9868c3a1916198ee09c323ca5932a0b8a11
Gitweb:     https://git.kernel.org/tip/0df1c9868c3a1916198ee09c323ca5932a0b8a11
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Wed, 10 Jul 2019 15:01:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 20:37:49 +0200

timekeeping/vsyscall: Use __iter_div_u64_rem()

On 32-bit x86 when building with clang-9, the 'division' loop gets turned
back into an inefficient division that causes a link error:

kernel/time/vsyscall.o: In function `update_vsyscall':
vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'

Use the existing __iter_div_u64_rem() function which is used to address the
same issue in other places.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lkml.kernel.org/r/20190710130206.1670830-1-arnd@arndb.de
---
 kernel/time/vsyscall.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index a80893180826..8cf3596a4ce6 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec = nsec - NSEC_PER_SEC;
-		vdso_ts->sec++;
-	}
-	vdso_ts->nsec	= nsec;
+	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
 	if (__arch_use_vsyscall(vdata))
 		update_vdso_data(vdata, tk);
