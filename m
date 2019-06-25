Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33B320659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B33X8b5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfFYHtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:49:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7n4th3516645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:49:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7n4th3516645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561448946;
        bh=CouGrO6jXjzR3jzeMCmrNLl4qCCEDVl601aDWHI3fo8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B33X8b5iokZLlDBE5eUoSjSw1hNib9oykuUbOeuOeEjZQB+yGXTy8H2Lxn/XPgaPq
         HguK9C6Q4Z6P9Grk39rGLwL1gDbnOehHHCBM4GUveefh/qfWPekdhmLqOth3ePqh9K
         JwpdYUqFq6SWceFkJRxv/QeWvBUP/F1AV+kkFhrVWpBRUfzSIHcu0Rvx3zwJXlH7X8
         qA3One7SCmjiklnxfFkuYZm56x1WlA19X+aj/JLX+A4+zI5RxXVqIOxJa3C4FAH3xq
         tJm6Fzd9derMCLChuExTUI4W6BiKzFgsJy1/C+Wj28v8ST0AUQe0hfgvzLtSsvRh3m
         pR+X763BuBTuw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7n1lq3516638;
        Tue, 25 Jun 2019 00:49:01 -0700
Date:   Tue, 25 Jun 2019 00:49:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Catalin Marinas <tipbot@zytor.com>
Message-ID: <tip-4d33ebb02c45738296ffde4b8f2089edaf75be1c@git.kernel.org>
Cc:     vincenzo.frascino@arm.com, sthotton@marvell.com, hpa@zytor.com,
        arnd@arndb.de, pcc@google.com, will.deacon@arm.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, daniel.lezcano@linaro.org,
        ralf@linux-mips.org, huw@codeweavers.com, mingo@kernel.org,
        salyzyn@android.com, paul.burton@mips.com,
        linux@rasmusvillemoes.dk, linux@armlinux.org.uk,
        tglx@linutronix.de, catalin.marinas@arm.com, shuah@kernel.org
Reply-To: arnd@arndb.de, pcc@google.com, will.deacon@arm.com,
          vincenzo.frascino@arm.com, hpa@zytor.com, sthotton@marvell.com,
          ralf@linux-mips.org, linux-kernel@vger.kernel.org,
          daniel.lezcano@linaro.org, 0x7f454c46@gmail.com,
          andre.przywara@arm.com, paul.burton@mips.com, mingo@kernel.org,
          salyzyn@android.com, huw@codeweavers.com, shuah@kernel.org,
          catalin.marinas@arm.com, tglx@linutronix.de,
          linux@armlinux.org.uk, linux@rasmusvillemoes.dk
In-Reply-To: <20190624135624.GB29120@arrakis.emea.arm.com>
References: <20190624135624.GB29120@arrakis.emea.arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] vdso: Remove superfluous #ifdef __KERNEL__ in
 vdso/datapage.h
Git-Commit-ID: 4d33ebb02c45738296ffde4b8f2089edaf75be1c
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

Commit-ID:  4d33ebb02c45738296ffde4b8f2089edaf75be1c
Gitweb:     https://git.kernel.org/tip/4d33ebb02c45738296ffde4b8f2089edaf75be1c
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Mon, 24 Jun 2019 14:56:24 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:43:38 +0200

vdso: Remove superfluous #ifdef __KERNEL__ in vdso/datapage.h

With the move to UAPI headers, such #ifdefs are no longer necessary.

Fixes: 361f8aee9b09 ("vdso: Define standardized vdso_datapage")
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
