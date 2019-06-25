Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277CCC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217320659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gm0Vc1+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfFYHvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:51:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50347 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFYHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:50:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7oVvs3516923
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:50:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7oVvs3516923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561449032;
        bh=LWAeiaRvnA4EspPNinf6f+GmKruliu9fUWn5B93cIZk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gm0Vc1+ZFp4YJzQ1J/ODjijFLxjO4TOeoF+eywI2MVM8SFGkUIXpL8+dxNgs77dzS
         xkER888c7ILNz7HrbguYC75itEKJcu6RjcPsJlzQrbPepKKrbjNGVGTuTGAlzsIrKb
         gP8XPZlwg7bTn0zSnraKQ4KoZNL2JGR7t4pQndbdngtc0MWKfDd6G/W482RzZlmoSk
         BqybW8l1OJo6IDPJGwN7YsbYBafIQD6gTnQYlayKESxEfEtvGbVveaiZ8PO2AlKfUV
         MMZv5vKgaTDGX8BTDygVwxcnIQZgB97tbFFzgo7K5CQBB7i1IW9hDd/FmU9E4ii1i7
         fjAixmahKr67w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7oVdA3516917;
        Tue, 25 Jun 2019 00:50:31 -0700
Date:   Tue, 25 Jun 2019 00:50:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Catalin Marinas <tipbot@zytor.com>
Message-ID: <tip-53d87b37a2a4a4b6b0c7f8073c4be04022252e26@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        tglx@linutronix.de, 0x7f454c46@gmail.com, salyzyn@android.com,
        daniel.lezcano@linaro.org, shuah@kernel.org, paul.burton@mips.com,
        andre.przywara@arm.com, catalin.marinas@arm.com,
        sthotton@marvell.com, huw@codeweavers.com, ralf@linux-mips.org,
        arnd@arndb.de, pcc@google.com, linux@rasmusvillemoes.dk,
        hpa@zytor.com, mingo@kernel.org, vincenzo.frascino@arm.com,
        will.deacon@arm.com
Reply-To: 0x7f454c46@gmail.com, salyzyn@android.com,
          linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
          tglx@linutronix.de, shuah@kernel.org, daniel.lezcano@linaro.org,
          sthotton@marvell.com, ralf@linux-mips.org, huw@codeweavers.com,
          paul.burton@mips.com, andre.przywara@arm.com,
          catalin.marinas@arm.com, pcc@google.com,
          linux@rasmusvillemoes.dk, hpa@zytor.com, mingo@kernel.org,
          vincenzo.frascino@arm.com, will.deacon@arm.com, arnd@arndb.de
In-Reply-To: <20190624140018.GD29120@arrakis.emea.arm.com>
References: <20190624140018.GD29120@arrakis.emea.arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: No need for pre-ARMv7 barriers on
 an ARMv8 system
Git-Commit-ID: 53d87b37a2a4a4b6b0c7f8073c4be04022252e26
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

Commit-ID:  53d87b37a2a4a4b6b0c7f8073c4be04022252e26
Gitweb:     https://git.kernel.org/tip/53d87b37a2a4a4b6b0c7f8073c4be04022252e26
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Mon, 24 Jun 2019 15:00:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:43:38 +0200

arm64: compat: No need for pre-ARMv7 barriers on an ARMv8 system

Remove the deprecated (pre-ARMv7) compat barriers as they would not be used
on an ARMv8 system.

Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
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
Link: https://lkml.kernel.org/r/20190624140018.GD29120@arrakis.emea.arm.com
---
 arch/arm64/include/asm/vdso/compat_barrier.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index ea24ea856b07..fb60a88b5ed4 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -18,14 +18,7 @@
 #undef dmb
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7
 #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
-#elif __LINUX_ARM_ARCH__ == 6
-#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
-				    : : "r" (0) : "memory")
-#else
-#define dmb(x) __asm__ __volatile__ ("" : : : "memory")
-#endif
 
 #if __LINUX_ARM_ARCH__ >= 8
 #define aarch32_smp_mb()	dmb(ish)
