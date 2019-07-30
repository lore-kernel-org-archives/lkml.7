Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E86C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C6720693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZBWItEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfG3QsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:48:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39908 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3QsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:48:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so30356586pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJPOL/2PE+PC/AElqmQU6HOXbiWhS4dMp+5yI3ZLajU=;
        b=EZBWItEEoXKEQxGBP+RK0+UeSWzIGSTx0p7rXjGNYM2C+AB43wp4Uz+pN3NJceXO4k
         rJjgv15UfzY9YF95KcwqA79IfrpPAeIXCs7PyoBlmFS0zYTP4tqElECZdMbt2ebEtiN1
         qPgE3B6ToDx+Ltr6v6XHl8ZFwFCzdKhASHdTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJPOL/2PE+PC/AElqmQU6HOXbiWhS4dMp+5yI3ZLajU=;
        b=UsAv7ZvK/4uAyK/OVVB69//jQ9MAk15KkvnYxPRm8QdqKh9x/Fle7w8YckeKkrUx6c
         uLSoTmay6xUR4flLV5CViHthNo9M6Sm6bfEGitQ3NuLl+CqWRBvessfmG4TqYLdZBz9g
         LANxecYoEQV50LfcQfdhc0a1Li4S+oLAJS+kwk5nnhg6CS66dMe8iBjXhNpEtez8G1dT
         PDZ3Zwn4sTO8Sa0E/Qk5gdyTgcXP8DJF8XCfvbk1x79NhrIASrZpT/jcRm3h1fg5S2x1
         R/qNkDeXsPw5IuajrkmTDT0g5rj620Ow5MIRgtFBsvPokBKP1GWjY+ogJWzTaa6UxAhZ
         EQ5Q==
X-Gm-Message-State: APjAAAW6sD/GxAu6PnN0mhqnCvK5aDpW9HXIXRQmcUYIMbOFXBPtX3GV
        QQMN6kUnWMa2aMCEfL4rbWXEWw==
X-Google-Smtp-Source: APXvYqyVxZMwwRiLaOrPjYPFNQxQPXb3c3T4255whvDiLkraPUj7mSUKSmEkTde8p4zmXMglsdT6BA==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr118881270pjt.107.1564505284405;
        Tue, 30 Jul 2019 09:48:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 30sm154516103pjk.17.2019.07.30.09.48.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 09:48:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Peter Smith <peter.smith@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3] kbuild: Check for unknown options with cc-option usage in Kconfig and clang
Date:   Tue, 30 Jul 2019 09:48:03 -0700
Message-Id: <20190730164803.45080-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the particular version of clang a user has doesn't enable
-Werror=unknown-warning-option by default, even though it is the
default[1], then make sure to pass the option to the Kconfig cc-option
command so that testing options from Kconfig files works properly.
Otherwise, depending on the default values setup in the clang toolchain
we will silently assume options such as -Wmaybe-uninitialized are
supported by clang, when they really aren't.

A compilation issue only started happening for me once commit
589834b3a009 ("kbuild: Add -Werror=unknown-warning-option to
CLANG_FLAGS") was applied on top of commit b303c6df80c9 ("kbuild:
compute false-positive -Wmaybe-uninitialized cases in Kconfig"). This
leads kbuild to try and test for the existence of the
-Wmaybe-uninitialized flag with the cc-option command in
scripts/Kconfig.include, and it doesn't see an error returned from the
option test so it sets the config value to Y. Then the Makefile tries to
pass the unknown option on the command line and
-Werror=unknown-warning-option catches the invalid option and breaks the
build. Before commit 589834b3a009 ("kbuild: Add
-Werror=unknown-warning-option to CLANG_FLAGS") the build works fine,
but any cc-option test of a warning option in Kconfig files silently
evaluates to true, even if the warning option flag isn't supported on
clang.

Note: This doesn't change cc-option usages in Makefiles because those
use a different rule that includes KBUILD_CFLAGS by default (see the
__cc-option command in scripts/Kbuild.incluide). The KBUILD_CFLAGS
variable already has the -Werror=unknown-warning-option flag set. Thanks
to Doug for pointing out the different rule.

[1] https://clang.llvm.org/docs/DiagnosticsReference.html#wunknown-warning-option
Cc: Peter Smith <peter.smith@linaro.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Makefile                | 1 +
 scripts/Kconfig.include | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9be5834073f8..517d0a3f6539 100644
--- a/Makefile
+++ b/Makefile
@@ -536,6 +536,7 @@ KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
+
 # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 8a5c4d645eb1..4bbf4fc163a2 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
 
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
+cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/null -o /dev/null)
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
-- 
Sent by a computer through tubes

