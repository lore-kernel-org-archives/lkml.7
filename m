Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F97C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA71F2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJxJDmdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKSBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:01:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44029 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDKSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:01:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so3861840pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3B85ofSIlvxDsMd0QSuvExy6zf6XDf2ci7ySZr6BosA=;
        b=FJxJDmdUpMx20MRWcPf82L+CMoP0+IfWGeSShTYRZwimBL6DOa2bzUzhOyN5iEpEtS
         eSnQtl/o+Go4aEZMdTcjevr2Nmu2tJ/8HRqkSin2ytgPLG8H4v0C86nFIoDN8cz+i87h
         XeXSbBS7IEYhvq1nFhKV5ZJdGKJM+Tt5ix2lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3B85ofSIlvxDsMd0QSuvExy6zf6XDf2ci7ySZr6BosA=;
        b=IVl7nySBJKVPaoAwj6OYU9cvCkFB/ySkDFes2nWxRMqPqHOHMLykrIhBkqjh9RotN6
         cZx6Y8B9BLAkKgSxr04UpKswGZjRKFaGXXM5XSSRxRv5R6Yne9ajG1uTJSk07swSdc1b
         BlvohOepjxofhx8LVngGHwPZX7RsTN6nBJOMJvyUfyT/C5Lqu2e/94r5vsFkfe6Lqj4B
         RI309m9CsT7oblgaktI51N0YW4ISMcqJlvaszZpqcNx3+Zqa9BENV7a0/Z5YO17FGigT
         mT4eNiAaJ4Eg5oIrNNvaamUaxkC0vh8rEi2pn7K1KZCYiLFpXGOlRgZSRzrLKIyDREWH
         bNYw==
X-Gm-Message-State: APjAAAXczDFw9uJrkVidTG75iOBqzOs9FBtsx86go5r64Cv8BAVG0SNo
        BN/GTMYJduK63kAtDBl0dEF7AA==
X-Google-Smtp-Source: APXvYqzrgSW9n/rdk1KPTN6pGC6tzHDVoxfPJiuwlJuazwnH8VkZvPgrN08LGboEC+mzZV3GQdJpBA==
X-Received: by 2002:a63:4e5b:: with SMTP id o27mr48786170pgl.204.1555005686906;
        Thu, 11 Apr 2019 11:01:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r145sm92291798pgr.84.2019.04.11.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 11:01:25 -0700 (PDT)
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
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] security: Implement Clang's stack initialization
Date:   Thu, 11 Apr 2019 11:01:17 -0700
Message-Id: <20190411180117.27704-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411180117.27704-1-keescook@chromium.org>
References: <20190411180117.27704-1-keescook@chromium.org>
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
 security/Kconfig.hardening | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 3dd7a28c3822..5dd61770d3f0 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -18,9 +18,12 @@ config GCC_PLUGIN_STRUCTLEAK
 
 menu "Memory initialization"
 
+config CC_HAS_AUTO_VAR_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
-	depends on GCC_PLUGINS
+	depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
@@ -76,6 +79,16 @@ choice
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

