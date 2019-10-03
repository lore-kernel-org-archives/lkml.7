Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E2C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A1B20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122136;
	bh=Ykb93oMr+3gztSj7HV5KYl0vXoN7XcXRQ9o4/s8Ik+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7YIi2c2CVWMvpXnJR2x/DZRwJf7ul4cOE2rjLOdzEvXQdK2czQrJzgQdaqdYEzG/
	 xsNmZf6brcwUC9Yj/6IqbEbmcEwEaJRgYT9ij1dTQ2bmn/Exc84qqBwX74PhquRKaB
	 6cBnLlJFnzQ3ae84I/MHIQkVz2Rt+j8HeMsJtiEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393232AbfJCRCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404879AbfJCQn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:43:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC3720865;
        Thu,  3 Oct 2019 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121006;
        bh=Ykb93oMr+3gztSj7HV5KYl0vXoN7XcXRQ9o4/s8Ik+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuXC0dv35m2RHhPPS0WA9v2206OLTTreQRqVt1VvlmzZmY+rGPt+3kiihNf0A+Wk2
         7g0cwEnpSA3d8r5IhIEyexkMvS8DbAiYYZvfL8Srg/PsaLR6NVrDroBVScZwGOTAC+
         GDF10eUbHcmt/q1PA8MeM3exkuU95/7gF5q5nFA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 120/344] kasan/arm64: fix CONFIG_KASAN_SW_TAGS && KASAN_INLINE
Date:   Thu,  3 Oct 2019 17:51:25 +0200
Message-Id: <20191003154552.032770815@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 34b5560db40d2941cfbe82eca1641353d5aed1a9 ]

The generic Makefile.kasan propagates CONFIG_KASAN_SHADOW_OFFSET into
KASAN_SHADOW_OFFSET, but only does so for CONFIG_KASAN_GENERIC.

Since commit:

  6bd1d0be0e97936d ("arm64: kasan: Switch to using KASAN_SHADOW_OFFSET")

... arm64 defines CONFIG_KASAN_SHADOW_OFFSET in Kconfig rather than
defining KASAN_SHADOW_OFFSET in a Makefile. Thus, if
CONFIG_KASAN_SW_TAGS && KASAN_INLINE are selected, we get build time
splats due to KASAN_SHADOW_OFFSET not being set:

| [mark@lakrids:~/src/linux]% usellvm 8.0.1 usekorg 8.1.0  make ARCH=arm64 CROSS_COMPILE=aarch64-linux- CC=clang
| scripts/kconfig/conf  --syncconfig Kconfig
|   CC      scripts/mod/empty.o
| clang (LLVM option parsing): for the -hwasan-mapping-offset option: '' value invalid for uint argument!
| scripts/Makefile.build:273: recipe for target 'scripts/mod/empty.o' failed
| make[1]: *** [scripts/mod/empty.o] Error 1
| Makefile:1123: recipe for target 'prepare0' failed
| make: *** [prepare0] Error 2

Let's fix this by always propagating CONFIG_KASAN_SHADOW_OFFSET into
KASAN_SHADOW_OFFSET if CONFIG_KASAN is selected, moving the existing
common definition of +CFLAGS_KASAN_NOSANITIZE to the top of
Makefile.kasan.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Tested-by Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.kasan | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 6410bd22fe387..03757cc60e06c 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+ifdef CONFIG_KASAN
+CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
+endif
+
 ifdef CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_INLINE
@@ -7,8 +12,6 @@ else
 	call_threshold := 0
 endif
 
-KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
-
 CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
 
 cc-param = $(call cc-option, -mllvm -$(1), $(call cc-option, --param $(1)))
@@ -45,7 +48,3 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 		$(instrumentation_flags)
 
 endif # CONFIG_KASAN_SW_TAGS
-
-ifdef CONFIG_KASAN
-CFLAGS_KASAN_NOSANITIZE := -fno-builtin
-endif
-- 
2.20.1



