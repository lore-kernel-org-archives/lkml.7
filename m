Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A3A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWR8Bv0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbfDJQQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:16:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45193 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfDJQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:16:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so1822536pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5/BRccG2xIeExTffcw+2ZZ9hqODeg+MvU2FToT9bXg=;
        b=NWR8Bv0sEAJHOsYEz5oKUtI7noZf1zrJx1C9plqx3cR27ZWjzzC/G0rfrdR71TvkAG
         ujl6amadTY+EM2txDYrvySTJh9QfZU2xto/LBjlJq9mVlRD8Vd+iicRMuHLV8N0VXATL
         FtPn2OAfOSHDQy0KaRao8eQIvBbA4f9NO0FcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5/BRccG2xIeExTffcw+2ZZ9hqODeg+MvU2FToT9bXg=;
        b=Bk55tZZF1DdcDm09z4wKt6DHl1J3Uv9cXthiYEfPSWclo6ppSjzLJSm6GiiJZTpcdb
         QZfyKoISIYcmCzq1bthi+v3wLfwCuwJv01klvuYwUESgQivyPGcw5mf7/vNBat5sV5QI
         hqIMcApN2N+PCF53/N+FTWwDvYgGgQrwx7BKy/MzfaMKi8NsWClFPEc+trbZJLvoxg/n
         h/TWNm1p3ky+EYVqXsjNQZSioefrq1Gc/F2Wc3/1IJZc7RbQ6nAgR8roAjJ8ZnrEl+DG
         lHBycXRd8Ke1YcKPqKOgwzKnn/IIIeCbGzHp2hNIQrY0hkpS5kG/1Vbmn/JHRW1g7gjM
         aWgw==
X-Gm-Message-State: APjAAAXOhT5uTD11Y1Fh4tpKV86EQJIDn112MvAxdW6w66tp5HM4DYMX
        OEEAugy3laBQXwgf3/oGjq7EDg==
X-Google-Smtp-Source: APXvYqx5zqxoeu4mdw28o3dkknw+u/VucYykSlyoimQkBNMs/HQpr7yfMobG9eETx7FuUMVwNFD78g==
X-Received: by 2002:a65:6150:: with SMTP id o16mr41651327pgv.285.1554912979109;
        Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w189sm60769546pfw.147.2019.04.10.09.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:16:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 3/3] kbuild: Implement Clang's stack initialization
Date:   Wed, 10 Apr 2019 09:16:12 -0700
Message-Id: <20190410161612.18545-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410161612.18545-1-keescook@chromium.org>
References: <20190410161612.18545-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_INIT_STACK_ALL turns on stack initialization based on
-ftrivial-auto-var-init in Clang builds and on
-fplugin-arg-structleak_plugin-byref-all in GCC builds.

-ftrivial-auto-var-init is a Clang flag that provides trivial
initializers for uninitialized local variables, variable fields and
padding.

It has three possible values:
  pattern - uninitialized locals are filled with a fixed pattern
    (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
    for more details) likely to cause crashes when uninitialized value is
    used;
  zero (it's still debated whether this flag makes it to the official
    Clang release) - uninitialized locals are filled with zeroes;
  uninitialized (default) - uninitialized locals are left intact.

The proposed config builds the kernel with
-ftrivial-auto-var-init=pattern when selected.

Developers have the possibility to opt-out of this feature on a
per-variable basis by using __attribute__((uninitialized)).

Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                   |  5 +++++
 security/Kconfig.hardening | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index c0a34064c574..a7d9c6cd0267 100644
--- a/Makefile
+++ b/Makefile
@@ -745,6 +745,11 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
 endif
 
+# Initialize all stack variables with a pattern, if desired.
+ifdef CONFIG_INIT_STACK_ALL
+KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
+endif
+
 DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 9942d9869864..d744e20140b4 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -19,9 +19,13 @@ config GCC_PLUGIN_STRUCTLEAK
 
 menu "Memory initialization"
 
+config CC_HAS_AUTO_VAR_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
+	default INIT_STACK_ALL if CC_HAS_AUTO_VAR_INIT
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
@@ -77,6 +81,16 @@ choice
 		  of uninitialized stack variable exploits and information
 		  exposures.
 
+	config INIT_STACK_ALL
+		bool "0xAA-init everything on the stack (strongest)"
+		depends on CC_HAS_AUTO_VAR_INIT
+		help
+		  Initializes everything on the stack with a 0xAA
+		  pattern. This is intended to eliminate all classes
+		  of uninitialized stack variable exploits and information
+		  exposures, even variables that were warned to have been
+		  left uninitialized.
+
 endchoice
 
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
-- 
2.17.1

