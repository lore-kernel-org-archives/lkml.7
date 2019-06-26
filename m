Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54183C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6242133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xek1I5se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfFZMj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:39:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:39:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCdkDH4105229
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:39:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCdkDH4105229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552787;
        bh=/r/AE4ylrOO+lqke/hJ0Mp6Pn97UyIiCRNUe6UMTyb8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xek1I5sevC8u9djP9PGzcR2ma9D8m5HCenh3e3qIpZ0iiehKdUAnEnAZUL3v6E9MC
         zudXh5Z4onlLgpcChUVJF7HrJGgV9GhIuHqmN8+Aa32ZnzuPypuFTSCyTt60AeARF9
         S3sskxEGIFj38B5DEt7lLu0h7RpG3nQJpsVlyJlVeVWFlQhmiyMeXjKBXVKryAiYyQ
         AntnpW6tpKcumzXN/hjt97IKmMq7oe5G6moaCywhVetljLTEJCnH/AiLNh0VVSweBk
         LNNfSest4Dgn2blKGefMLUXaf8WqDb7nu/Hhvfq6DXdQl2c6g03idRXlDOE1aFtj7x
         Oxu1LHUSoK9/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCdjcB4105224;
        Wed, 26 Jun 2019 05:39:45 -0700
Date:   Wed, 26 Jun 2019 05:39:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-3acf4be235280f14d838581a750532219d67facc@git.kernel.org>
Cc:     vincenzo.frascino@arm.com, cai@lca.pw, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: cai@lca.pw, vincenzo.frascino@arm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190626113632.9295-1-vincenzo.frascino@arm.com>
References: <20190626113632.9295-1-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: vdso: Fix compilation with clang older
 than 8
Git-Commit-ID: 3acf4be235280f14d838581a750532219d67facc
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

Commit-ID:  3acf4be235280f14d838581a750532219d67facc
Gitweb:     https://git.kernel.org/tip/3acf4be235280f14d838581a750532219d67facc
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Wed, 26 Jun 2019 12:36:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:26:55 +0200

arm64: vdso: Fix compilation with clang older than 8

clang versions older than 8 do not support -mcmodel=tiny.

Add a check to the vDSO Makefile for arm64 to remove the flag when
these versions of the compiler are detected.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qian Cai <cai@lca.pw>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: arnd@arndb.de
Cc: linux@armlinux.org.uk
Cc: ralf@linux-mips.org
Cc: paul.burton@mips.com
Cc: daniel.lezcano@linaro.org
Cc: salyzyn@android.com
Cc: pcc@google.com
Cc: shuah@kernel.org
Cc: 0x7f454c46@gmail.com
Cc: linux@rasmusvillemoes.dk
Cc: huw@codeweavers.com
Cc: sthotton@marvell.com
Cc: andre.przywara@arm.com
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/20190626113632.9295-1-vincenzo.frascino@arm.com

---
 arch/arm64/kernel/vdso/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ec81d28aeb5d..4ab863045188 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,6 +38,13 @@ else
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
 endif
 
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(CONFIG_CC_IS_CLANG), y)
+  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
+  endif
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
