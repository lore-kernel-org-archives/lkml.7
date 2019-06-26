Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NpC1OoH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfFZMfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:35:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFZMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:35:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCYNrn4104062
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:34:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCYNrn4104062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552464;
        bh=Y0enMar43bdA6z9NN9cZVbiLguylPYm5r/Gn1WI/6AI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NpC1OoH7VvhUZ2MCaZEXj4HBlVGG++8z9F9q2k2AGDar38KFFrjDK9AajjBSX4RGl
         Yt3B1bH0LrMrXjmWWGMH4qU9sjXs7AQeDOJboAp0xy1mavnXxwLslTRnjO3zctGPTL
         5TeDCh1QAOC0pLBj/cWBMmLlEYl/sSbstT6HfZbEX7Y0Mtsop+0lrFDf9pW7cfTFKV
         j5qmMmjl01p8vd/Ff06C5aTrPcpE2IdOanGZSqFaaWkFZ66SKSJb/Mc03g2J7M58jE
         0fU/J7A6L2UqmhLZ/R1Cn0NFv5jvu3cWeaO+F/1e4B7bBpJf4YMFWWr2neKhexi81/
         SazgcOL0B0p4w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCYKb84104059;
        Wed, 26 Jun 2019 05:34:20 -0700
Date:   Wed, 26 Jun 2019 05:34:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Catalin Marinas <tipbot@zytor.com>
Message-ID: <tip-ed75e8f60bb1d41d751ccad470e15bc2a57adee6@git.kernel.org>
Cc:     will.deacon@arm.com, linux@rasmusvillemoes.dk, ralf@linux-mips.org,
        0x7f454c46@gmail.com, mingo@kernel.org, sthotton@marvell.com,
        hpa@zytor.com, shuah@kernel.org, salyzyn@android.com,
        pcc@google.com, tglx@linutronix.de, vincenzo.frascino@arm.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, huw@codeweavers.com,
        catalin.marinas@arm.com, linux@armlinux.org.uk, arnd@arndb.de,
        paul.burton@mips.com
Reply-To: tglx@linutronix.de, vincenzo.frascino@arm.com, shuah@kernel.org,
          pcc@google.com, salyzyn@android.com, sthotton@marvell.com,
          hpa@zytor.com, linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
          mingo@kernel.org, ralf@linux-mips.org, will.deacon@arm.com,
          paul.burton@mips.com, daniel.lezcano@linaro.org, arnd@arndb.de,
          linux@armlinux.org.uk, catalin.marinas@arm.com,
          huw@codeweavers.com, linux-kernel@vger.kernel.org,
          andre.przywara@arm.com
In-Reply-To: <20190624135624.GB29120@arrakis.emea.arm.com>
References: <20190624135624.GB29120@arrakis.emea.arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] vdso: Remove superfluous #ifdef __KERNEL__ in
 vdso/datapage.h
Git-Commit-ID: ed75e8f60bb1d41d751ccad470e15bc2a57adee6
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

Commit-ID:  ed75e8f60bb1d41d751ccad470e15bc2a57adee6
Gitweb:     https://git.kernel.org/tip/ed75e8f60bb1d41d751ccad470e15bc2a57adee6
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Mon, 24 Jun 2019 14:56:24 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:28:09 +0200

vdso: Remove superfluous #ifdef __KERNEL__ in vdso/datapage.h

With the move to UAPI headers, such #ifdefs are no longer necessary.

Fixes: 361f8aee9b09 ("vdso: Define standardized vdso_datapage")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Link: https://lkml.kernel.org/r/20190624135624.GB29120@arrakis.emea.arm.com

---
 include/vdso/datapage.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index e6eb36c3d54f..2e302c0f41f7 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -2,8 +2,6 @@
 #ifndef __VDSO_DATAPAGE_H
 #define __VDSO_DATAPAGE_H
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bits.h>
@@ -88,6 +86,4 @@ extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")
 
 #endif /* !__ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
-
 #endif /* __VDSO_DATAPAGE_H */
