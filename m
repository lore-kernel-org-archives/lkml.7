Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84398C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B6A20835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHfICpqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfJGUO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:14:57 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49849 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:14:56 -0400
Received: by mail-pl1-f202.google.com with SMTP id n18so9300288plp.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/4/9rYzAhldgvSUHiN1Cv8SA76p5OhElLe1pQA25ET4=;
        b=WHfICpqJKjs29U8jRSc9dCUIctFWsnqbi4mNKDsdExzLlBGWYxpnBgszgnm2xU+jI2
         tkEqMcaC4tNHu1DTKGty2qG7h/IepYofQSdPPekaqeo9wxgF1alXB5LOtCre3MkwzQTr
         g7xq+KtlZKB/WUz+SUnx9DkyunDzurGnS43mRvgojQrG4n8ZIJSWlhYFfy5ktJKVB/Qu
         ycZ4WdoXzPB7zheoSDVPQSyOtluiOp3dMUXC9jpyaQ7ksFB1x7CKxpAEELCgMlsmess6
         it1/utlJSVsXVETCYk3VLwdDIWHDc7VjbVSsKspvxtexio5lblLYxn1T7KBIuAzE/u7+
         pJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/4/9rYzAhldgvSUHiN1Cv8SA76p5OhElLe1pQA25ET4=;
        b=JGwJpx3OjpFFMOeJNla3cNBYGjp1lW1ghDhUoVfxHd+T24ifqTIG6c1lCeEqtlYFey
         BeP+7Py9VOOrVi8+ZsI2kbZeAkgrHfIUY0NaO7D9RMm6jxg5a1R0tfylJ7komck2Cyyr
         M4j3cEAsEN9q7czoGznIVAM5XOePOFkXprhZTUHgp7fAzKmQ+sPjEk6aKGcQX2aHumoA
         UHzasAYNb8/bbxPz7tPAMUCrND6k7tdDo1NTcjaYwaJ7N2gy+p32fZjG1jsHfUGhqR/Q
         xr4+7oTfPpJsBMAChtZ+AYa3WZbQTDWc6iwaoJW71Sq/LmuwLR1iF+ibDTSYeGj+VGNC
         3EYA==
X-Gm-Message-State: APjAAAX6e7I7LV28YHbJA0TG/j03B7BFVAXrNVjj3OJbehjKcQMvuNhJ
        7/LFiEcd8Lw4KX7nyKAYFn31bqQGNogDsme8c5E=
X-Google-Smtp-Source: APXvYqy2MfIgu9RYUmgEEwP98LehLmwIuauY766L4bdYigR5PXao67A9xmpIUn1yitsa1c2mHIhNSotBKObpghXtquU=
X-Received: by 2002:a65:5b8b:: with SMTP id i11mr23380217pgr.22.1570479295782;
 Mon, 07 Oct 2019 13:14:55 -0700 (PDT)
Date:   Mon,  7 Oct 2019 13:14:52 -0700
Message-Id: <20191007201452.208067-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike gcc, clang considers each inline assembly block to be independent
and therefore, when using the integrated assembler for inline assembly,
any preambles that enable features must be repeated in each block.

Instead of changing all inline assembly blocks that use LSE, this change
adds -march=armv8-a+lse to KBUILD_CFLAGS, which works with both clang
and gcc.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile          | 2 ++
 arch/arm64/include/asm/lse.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 84a3d502c5a5..7a7c0cb8ed60 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,6 +36,8 @@ lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
 ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
   ifeq ($(lseinstr),)
 $(warning LSE atomics not supported by binutils)
+  else
+KBUILD_CFLAGS	+= -march=armv8-a+lse
   endif
 endif
 
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 80b388278149..8603a9881529 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -14,8 +14,6 @@
 #include <asm/atomic_lse.h>
 #include <asm/cpucaps.h>
 
-__asm__(".arch_extension	lse");
-
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
-- 
2.23.0.581.g78d2f28ef7-goog

