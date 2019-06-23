Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861522CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WWg3J02w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFXBlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFXBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:41:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNmDeP2858999
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:48:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNmDeP2858999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333694;
        bh=XRnSXuAWjPYEZJkB8vf3MmczFKZ82gnFnAxf9/ZFQa0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WWg3J02wSu2AVjI/qmVsWlj9lvmlwP/JAz4bhotAh9x5avJdnjy3fNJE2M8kB6MmH
         Lmig32gaoGgQEW0s4ZffBfSDM2Dnaf7PwLD8E1xMwAVArtE2lxlnaNUFaPryVFnYn3
         ejpJoQOAeJTAnnJZjwLARNK+TMq1hjSllQRsXksDVShh8v6j3j5DEYBIPY6zaDBC3T
         tL23mUeTB5IJS2ooTVn0DczVtWjqeUG2hhU2XPdKJ2iJG4ggPqZRHLSKuk6gl6ePCR
         rVm+7XDBnmAXXfSz1U44J7M77nSGBEPfoJqFnLqx/RR2S8cwJ9ckM9jq1B0YKdjDCo
         VgchzhO+EFwJw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNmCho2858996;
        Sun, 23 Jun 2019 16:48:12 -0700
Date:   Sun, 23 Jun 2019 16:48:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Collingbourne <tipbot@zytor.com>
Message-ID: <tip-98cd3c3f83fbba27a6bacd75ad12e8388a61a32a@git.kernel.org>
Cc:     huw@codeweavers.com, mingo@kernel.org, salyzyn@android.com,
        vincenzo.frascino@arm.com, will.deacon@arm.com, pcc@google.com,
        linux-kernel@vger.kernel.org, sthotton@marvell.com,
        linux@armlinux.org.uk, ralf@linux-mips.org, 0x7f454c46@gmail.com,
        shuah@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de,
        arnd@arndb.de, andre.przywara@arm.com, hpa@zytor.com,
        paul.burton@mips.com, salyzyn@google.com, linux@rasmusvillemoes.dk,
        daniel.lezcano@linaro.org
Reply-To: paul.burton@mips.com, hpa@zytor.com, andre.przywara@arm.com,
          arnd@arndb.de, daniel.lezcano@linaro.org, salyzyn@google.com,
          linux@rasmusvillemoes.dk, vincenzo.frascino@arm.com,
          salyzyn@android.com, huw@codeweavers.com, mingo@kernel.org,
          catalin.marinas@arm.com, tglx@linutronix.de, shuah@kernel.org,
          0x7f454c46@gmail.com, ralf@linux-mips.org, linux@armlinux.org.uk,
          sthotton@marvell.com, linux-kernel@vger.kernel.org,
          pcc@google.com, will.deacon@arm.com
In-Reply-To: <20190621095252.32307-6-vincenzo.frascino@arm.com>
References: <20190621095252.32307-6-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: vdso: Build vDSO with -ffixed-x18
Git-Commit-ID: 98cd3c3f83fbba27a6bacd75ad12e8388a61a32a
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

Commit-ID:  98cd3c3f83fbba27a6bacd75ad12e8388a61a32a
Gitweb:     https://git.kernel.org/tip/98cd3c3f83fbba27a6bacd75ad12e8388a61a32a
Author:     Peter Collingbourne <pcc@google.com>
AuthorDate: Fri, 21 Jun 2019 10:52:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:06 +0200

arm64: vdso: Build vDSO with -ffixed-x18

The vDSO needs to be built with x18 reserved in order to accommodate
userspace platform ABIs built on top of Linux that use the register
to carry inter-procedural state, as provided for by the AAPCS.
An example of such a platform ABI is the one that will be used by an
upcoming version of Android.

Although this change is currently a no-op due to the fact that the vDSO
is currently implemented in pure assembly on arm64, it is necessary
in order to prepare for using the generic C implementation of the vDSO.

[ tglx: Massaged changelog ]

Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Mark Salyzyn <salyzyn@google.com>
Link: https://lkml.kernel.org/r/20190621095252.32307-6-vincenzo.frascino@arm.com

---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 3acfc813e966..ec81d28aeb5d 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -20,7 +20,7 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
 
-ccflags-y := -fno-common -fno-builtin -fno-stack-protector
+ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
