Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33439C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFD72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/ZH4sY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfJNCv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 22:51:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44435 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfJNCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:51:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so12512067oie.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHmUbEEX69AqhdbGgT5mtRK+KzbNgJpahv1dD9kcoow=;
        b=Z/ZH4sY6OkTSRGyGfULWwz0nnTcjjTY56RwSiEHPADnMR79o16ZZz3J5ejCu8rRyK2
         FiHIst1HatvX4z5BXeayrSKv8Q6cNiijNfhV9FLC5OtlqooeUR7D/A3thk5TA3jSwrnC
         j0HS+iCyjhkF1zKT9g+0AOqi7iQZYr1o2uh56ZwO4lqQV2jLdJENoGxC+YWxV7WrSTY0
         B9U2K1ktlFDigtjPkqQXYfXX1i/LAxzay8brzaUSbSYVA78l4KAFgg30K6H9k962wbU4
         FMW2agc+hE9gLdzVWOi5kCL2T/ZMrJLCSZS+5o4l2ajknnUQbSnpcubxAS21upX99Nzy
         1eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHmUbEEX69AqhdbGgT5mtRK+KzbNgJpahv1dD9kcoow=;
        b=qn9z5utv2NPPWJz129X3utcT4YhR4sC6kH85l6jDGOFdzI0bRNjnBOCt/CCRlhJt3d
         d+G9YcdxmLmPeGJhnhIOcTcxfbr1UK8Xnc2xHb7KynDd8SnphX+a7lStiDp+us+BLz9i
         r+8DuO/sWq3neixfdFmYGT7rqn2oopPclzytc2/S6v8hSsUS0RsxA94X/m7F2UydjzzG
         QuDMrN2tbRD50TeQM0D6QEpSVKG49+dL0XSezmyQ+k7eTcWIPQptyQ4MrH5WRH/pmgqt
         /D07VGQ2RuHWXRrbSNuLuUG0rL878OZjIN31gW/19zjysFWebKEaGWp5vOVrWzp+2DQZ
         LCpA==
X-Gm-Message-State: APjAAAUR1pM4VMR44/sfY+xvHkexPsLIDAQw0Dmjp6nN//38h1+DP9h3
        3xnu4F3ePP5UeWYgDTC/M0w=
X-Google-Smtp-Source: APXvYqw6PeVHbSHxMK9QXZUVR43r2OehkYWUjPEpGrGg9Kg1EWZ8tl2/DaYxeecULNYz5IXa4sZ0vA==
X-Received: by 2002:aca:211a:: with SMTP id 26mr21810859oiz.122.1571021481959;
        Sun, 13 Oct 2019 19:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 11sm5612491otg.62.2019.10.13.19.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 19:51:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 1/3] powerpc: Don't add -mabi= flags when building with Clang
Date:   Sun, 13 Oct 2019 19:50:59 -0700
Message-Id: <20191014025101.18567-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building pseries_defconfig, building vdso32 errors out:

  error: unknown target ABI 'elfv1'

This happens because -m32 in clang changes the target to 32-bit,
which does not allow the ABI to be changed, as the setABI virtual
function is not overridden:

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/include/clang/Basic/TargetInfo.h#L1073-L1078

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Basic/Targets/PPC.h#L327-L365

Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
powerpc64le toolchain") added these flags to fix building big endian
kernels with a little endian GCC.

Clang doesn't need -mabi because the target triple controls the default
value. -mlittle-endian and -mbig-endian manipulate the triple into
either powerpc64-* or powerpc64le-*, which properly sets the default
ABI:

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Driver/Driver.cpp#L450-L463

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/llvm/lib/Support/Triple.cpp#L1432-L1516

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Basic/Targets/PPC.h#L377-L383

Adding a debug print out in the PPC64TargetInfo constructor after line
383 above shows this:

$ echo | ./clang -E --target=powerpc64-linux -mbig-endian -o /dev/null -
Default ABI: elfv1

$ echo | ./clang -E --target=powerpc64-linux -mlittle-endian -o /dev/null -
Default ABI: elfv2

$ echo | ./clang -E --target=powerpc64le-linux -mbig-endian -o /dev/null -
Default ABI: elfv1

$ echo | ./clang -E --target=powerpc64le-linux -mlittle-endian -o /dev/null -
Default ABI: elfv2

Don't specify -mabi when building with clang to avoid the build error
with -m32 and not change any code generation.

-mcall-aixdesc is not an implemented flag in clang so it can be
safely excluded as well, see commit 238abecde8ad ("powerpc: Don't
use gcc specific options on clang").

pseries_defconfig successfully builds after this patch and
powernv_defconfig and ppc44x_defconfig don't regress.

Link: https://github.com/ClangBuiltLinux/linux/issues/240
Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Improve commit message

v2 -> v3:

* Rebase and merge into a single series.

v3 -> v4:

* Rebase on v5.4-rc3.

* Update links to point to llvmorg-9.0.0 instead of llvmorg-9.0.0-rc2.

 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 83522c9fc7b6..37ac731a556b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -91,11 +91,13 @@ MULTIPLEWORD	:= -mmultiple
 endif
 
 ifdef CONFIG_PPC64
+ifndef CONFIG_CC_IS_CLANG
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
+endif
 
 ifndef CONFIG_CC_IS_CLANG
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
@@ -141,6 +143,7 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
+ifndef CONFIG_CC_IS_CLANG
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
@@ -149,6 +152,7 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
+endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 
-- 
2.23.0

