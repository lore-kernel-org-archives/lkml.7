Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D930EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1D321773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBarm0Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfDWTtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:49:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41721 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfDWTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:49:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so8110366pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1yvrTp26kS5NawWcZJOQE+ZT11RXDj4zCYzH5JQkb4=;
        b=gBarm0KyqlLBbUD5hPMVInIA8uyoBUU1s9w2XhxSa/TdXy16ac3S9zPTiwpec0Xjxh
         k2iBIMrLqWyOdZQO+VJ42jdLCmpOKyo2RFhUC/3BwQP8xCGDY8M5Cj2Qr/GejGmlSTGx
         /z6ix2Imuf0FkqRjO5mbUmWJ6wVb5RlU8tdLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1yvrTp26kS5NawWcZJOQE+ZT11RXDj4zCYzH5JQkb4=;
        b=HkRsx/Ztd/a8E9Ti0hEHgYnSFqmC4Nlc3xkgwT4UW5sbA0d2ijcH02H0BMknR9w93K
         qFTs6TPnhR3uZL0tfR9ebv8iEnNZsTRTLvfkzxibV6OGhYXUzpI9CHtdKGHY3tmPtJgR
         Z3zVR+DIifOqj1DVanN/p+YbGodUJ6wW5EFCyMoVIHf/Byrlgx8j19K6rngiuqbnGDS3
         pfRoCHuIJh3KRxHM3Ie8We36p7VoWWWr/CUtDbbREUoUvdqnfh0qOXWC6FmKEUyJJcJF
         b2uv8lTOXHWWylgx+3wd1IZBQbRD8r0NPwxIFn6aaqF9RljVRIWebb3dS0CECYtvYjLz
         tjIQ==
X-Gm-Message-State: APjAAAVVzczoFi+4eq9dUh5g7c5nK7EzcsO3vhVfi3cg15mvJJeAmxJG
        apSAoD4d4BRf+dc1gGi6a5Fw4Q==
X-Google-Smtp-Source: APXvYqzZKSGP0Gr7+//KabyT7/cEXmI45ZXQ8jFT1mTgjiC3sDJ9jp6sUQnfstuFJi2ylQJ0ftTsgg==
X-Received: by 2002:a63:1d45:: with SMTP id d5mr9916626pgm.184.1556048972642;
        Tue, 23 Apr 2019 12:49:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t13sm28351701pgo.14.2019.04.23.12.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 12:49:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] security: Implement Clang's stack initialization
Date:   Tue, 23 Apr 2019 12:49:25 -0700
Message-Id: <20190423194925.32151-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423194925.32151-1-keescook@chromium.org>
References: <20190423194925.32151-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_INIT_STACK_ALL turns on stack initialization based on
-ftrivial-auto-var-init in Clang builds, which has greater coverage
than CONFIG_GCC_PLUGINS_STRUCTLEAK_BYREF_ALL.

-ftrivial-auto-var-init Clang option provides trivial initializers for
uninitialized local variables, variable fields and padding.

It has three possible values:
  pattern - uninitialized locals are filled with a fixed pattern
    (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
    for more details, but 0x000000AA for 32-bit pointers) likely to cause
    crashes when uninitialized value is used;
  zero (it's still debated whether this flag makes it to the official
    Clang release) - uninitialized locals are filled with zeroes;
  uninitialized (default) - uninitialized locals are left intact.

This patch uses only the "pattern" mode when CONFIG_INIT_STACK_ALL is
enabled.

Developers have the possibility to opt-out of this feature on a
per-variable basis by using __attribute__((uninitialized)), but such
use should be well justified in comments.

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
index a96d4a43ca65..0a1d4ca314f4 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -18,9 +18,13 @@ config GCC_PLUGIN_STRUCTLEAK
 
 menu "Memory initialization"
 
+config CC_HAS_AUTO_VAR_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
+	default INIT_STACK_ALL if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
@@ -76,6 +80,16 @@ choice
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

