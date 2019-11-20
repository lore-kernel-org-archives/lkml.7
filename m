Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8DBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5062245C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dl72hrPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKTBGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:06:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45721 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfKTBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:06:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so11133373pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qk+ofBX2bx2BOGB4TqoJ+/VT2N5xkCBYGbqC21Di0lw=;
        b=Dl72hrPuwamrfPqyV6plvaUBtf5zRowEghIpoZqmgJgFOczuF7EKzjTanI6iefsS9Z
         9TvygmIVih8TjwrgaGRcecyP/tDTc7gHkW1za6Qsa+kQOjj0UpGf+owodcIUwPQ/ZSDu
         QgLC6/NCcIR5lG7LQGAW6FZc2y8odHX4FtywQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qk+ofBX2bx2BOGB4TqoJ+/VT2N5xkCBYGbqC21Di0lw=;
        b=Tg0WKsuEdMR37lGPvhcK0+thebQXOsYFoBjzhb82mmWQQEDd3JeiVFmPWhUahgfPGW
         68Pqe0vXZ80kS2qo0MzkYLdH01Wn7YZa3J6aDs+1sKdulBvFMxVw4jgpvq/7Awe6QuCK
         1CTKgCZt6AVll3qGW+WbdFkKYJactYAQno5hcs9zLETDS/3g83+ipkxXFNCMcVnMMQg6
         ChNhTUKrYizDfVG5PS5f14P91MK9gZTmJYJ4jeHV800mvD8KKa1rFtn7IM00dLCquPcS
         L+YaJ9OI8+pNbcvHFmXSts1TDTSxU2878mCJfVZJl2Y3Ka4Rn3ejhsiCJ5IBehZpqJlr
         SSgQ==
X-Gm-Message-State: APjAAAVWJRaSikrx9JjCOgsBLDoQfTvZo4ACno4W6R5M5QG87p9vEDXP
        tmGZT7f2583ilmCyMrrFy25X3A==
X-Google-Smtp-Source: APXvYqwU4vILON4RTm6tdSJVl700JzP/ajHyi1fFkaWh7maGAK9WWWqyZPY7AO1vwzjH8oRIUlhNnw==
X-Received: by 2002:a63:5d10:: with SMTP id r16mr80693pgb.41.1574212003024;
        Tue, 19 Nov 2019 17:06:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm4812325pjz.12.2019.11.19.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 17:06:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 2/3] ubsan: Split "bounds" checker from other options
Date:   Tue, 19 Nov 2019 17:06:35 -0800
Message-Id: <20191120010636.27368-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120010636.27368-1-keescook@chromium.org>
References: <20191120010636.27368-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to do kernel builds with the bounds checker individually
available, introduce CONFIG_UBSAN_BOUNDS, with the remaining options
under CONFIG_UBSAN_MISC.

For example, using this, we can start to expand the coverage syzkaller is
providing. Right now, all of UBSan is disabled for syzbot builds because
taken as a whole, it is too noisy. This will let us focus on one feature
at a time.

For the bounds checker specifically, this provides a mechanism to
eliminate an entire class of array overflows with close to zero
performance overhead (I cannot measure a difference). In my (mostly)
defconfig, enabling bounds checking adds ~4200 checks to the kernel.
Performance changes are in the noise, likely due to the branch predictors
optimizing for the non-fail path.

Some notes on the bounds checker:

- it does not instrument {mem,str}*()-family functions, it only
  instruments direct indexed accesses (e.g. "foo[i]"). Dealing with
  the {mem,str}*()-family functions is a work-in-progress around
  CONFIG_FORTIFY_SOURCE[1].

- it ignores flexible array members, including the very old single
  byte (e.g. "int foo[1];") declarations. (Note that GCC's
  implementation appears to ignore _all_ trailing arrays, but Clang only
  ignores empty, 0, and 1 byte arrays[2].)

[1] https://github.com/KSPP/linux/issues/6
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92589

Suggested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.ubsan      | 19 +++++++++++++++++++
 scripts/Makefile.ubsan |  7 ++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index d69e8b21ebae..f5ed2dceef30 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -22,6 +22,25 @@ config UBSAN_TRAP
 	  can just issue a trap. This reduces the kernel size overhead but
 	  turns all warnings into full thread-killing exceptions.
 
+config UBSAN_BOUNDS
+	bool "Perform array bounds checking"
+	depends on UBSAN
+	default UBSAN
+	help
+	  This option enables detection of direct out of bounds array
+	  accesses, where the array size is known at compile time. Note
+	  that this does not protect character array overflows due to
+	  bad calls to the {str,mem}*cpy() family of functions.
+
+config UBSAN_MISC
+	bool "Enable all other Undefined Behavior sanity checks"
+	depends on UBSAN
+	default UBSAN
+	help
+	  This option enables all sanity checks that don't have their
+	  own Kconfig options. Disable this if you only want to have
+	  individually selected checks.
+
 config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
 	depends on UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 668a91510bfe..5b15bc425ec9 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -5,14 +5,19 @@ ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
 
+ifdef CONFIG_UBSAN_BOUNDS
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+endif
+
+ifdef CONFIG_UBSAN_MISC
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
+endif
 
 ifdef CONFIG_UBSAN_TRAP
       CFLAGS_UBSAN += $(call cc-option, -fsanitize-undefined-trap-on-error)
-- 
2.17.1

