Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D355C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EE5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfFYOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:54:41 -0400
Received: from foss.arm.com ([217.140.110.172]:43584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfFYOyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:54:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DDA72B;
        Tue, 25 Jun 2019 07:54:40 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250683F718;
        Tue, 25 Jun 2019 07:54:39 -0700 (PDT)
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com, ndesaulniers@google.com
References: <1561464964.5154.63.camel@lca.pw>
 <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
 <1561467369.5154.67.camel@lca.pw>
 <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
 <1561470705.5154.68.camel@lca.pw>
 <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
 <1561472887.5154.72.camel@lca.pw>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
Date:   Tue, 25 Jun 2019 15:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561472887.5154.72.camel@lca.pw>
Content-Type: multipart/mixed;
 boundary="------------B290F18BD9914E255C67004C"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B290F18BD9914E255C67004C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Qian,

...

> 
> but clang 7.0 is still use in many distros by default, so maybe this commit can
> be fixed by adding a conditional check to use "small" if clang version < 8.0.
> 

Could you please verify that the patch below works for you?

Thanks,
Vincenzo

--->8----


--------------B290F18BD9914E255C67004C
Content-Type: text/x-patch;
 name="0001-arm64-vdso-Fix-compilation-with-clang-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-arm64-vdso-Fix-compilation-with-clang-8.patch"

From 0546f3bbea910cd26df8c2ff9ed1a59945bb1bec Mon Sep 17 00:00:00 2001
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date: Tue, 25 Jun 2019 15:49:37 +0100
Subject: [PATCH] arm64: vdso: Fix compilation with clang < 8

clang versions previous to 8 do not support -mcmodel=tiny.

Add a check to the vDSO Makefile for arm64 to remove the flag when these
versions of the compiler are detected.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ec81d28aeb5d..c11cbf71073f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,6 +38,11 @@ else
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
 endif
 
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+CFLAGS_REMOVE_vgettimeofday.o = -mcmodel=tiny
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.22.0


--------------B290F18BD9914E255C67004C--
