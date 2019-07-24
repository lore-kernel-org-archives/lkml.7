Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D13C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDA42189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuRE7qFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfGXXud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:50:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388769AbfGXXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:50:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so21715088pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBjlbYIuuSYtSCBBvyjicZtrQHQMj9xf5Mp+j4uWFAY=;
        b=kuRE7qFmVRW6wv2rNykvoufyn45i/POSyeWUPXGpZ/AysyFKDppb98RVz7XC3KklfF
         giLkrxfmnlkwmDBqBr9gDztJzFhIUT/kCxohYaTO37JlSREzIQpz4U+1+WBK/HkkExCP
         AUUAmlgTnu1eYA/EjwBVv8TUgXorbLCiUL1zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBjlbYIuuSYtSCBBvyjicZtrQHQMj9xf5Mp+j4uWFAY=;
        b=OhWjQFaLeXqbSDLQNtEech76J7ONCl1+oxSF95tNcKaV0jneARCieMpVIIZXkue97D
         MhouZHPF3CK8YjQYfSu5TX8D5p4NIHzIQb92T4Z/yapBRmxIyae4RLDRu/Q0amz5HfLR
         LUHOj5y9XCtmZVdOH/AbCs0acr+uW0wC7MwrggtJJiOF/1Ac0dytpfsIyncqToMtzArc
         j+nLnyAZUZFdS8aQEB/GBeVd0Gn/dqqze/PtA3Q2ukoFfVx5Jz48o1EHid0fWdVg0EgR
         /Tab2KtYCfuy9ZnBa8oFkDCp5IfbhW9AnRMQvsPIfO8vcmlvMm2lKS7V4W7bll5C++qO
         7Alw==
X-Gm-Message-State: APjAAAUPd5+Yayl/IwXIyyDEXZzvvthF7KfDDQ+pZHAsf2Em7CQBYMGy
        5RpJzmNhrHT6/uhMFH5nS146sw==
X-Google-Smtp-Source: APXvYqy4SYlFcrJyiKOlKLdpp8NWSaE8TnNaIxq7W/I8S1GJz7au8LilVZAsYmgKaciDe1W0MdV5VA==
X-Received: by 2002:a62:303:: with SMTP id 3mr13671104pfd.118.1564012232564;
        Wed, 24 Jul 2019 16:50:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s185sm69207899pgs.67.2019.07.24.16.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:50:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Peter Smith <peter.smith@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] kbuild: Check for unknown options with cc-option and clang in Kbuild
Date:   Wed, 24 Jul 2019 16:50:30 -0700
Message-Id: <20190724235030.131144-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
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

This issue only started happening for me once commit 589834b3a009
("kbuild: Add -Werror=unknown-warning-option to CLANG_FLAGS") was
applied on top of commit b303c6df80c9 ("kbuild: compute false-positive
-Wmaybe-uninitialized cases in Kconfig"). This leads kbuild to try and
test for the existence of the -Wmaybe-uninitialized flag with the
cc-option command in scripts/Kconfig.include, and it doesn't see an
error returned from the option test so it sets the config value to Y.
Then the makefile tries to pass the unknown option on the command line
and -Werror=unknown-warning-option catches the invalid option and breaks
the build.

Note: this doesn't change the cc-option tests in Makefiles, because
those use a different rule that includes KBUILD_CFLAGS by default, and
the KBUILD_CFLAGS already has -Werror=unknown-warning-option. Thanks to
Doug for pointing out the different rule.

[1] https://clang.llvm.org/docs/DiagnosticsReference.html#wunknown-warning-option
Cc: Peter Smith <peter.smith@linaro.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Change-Id: I3bb69d45bb062d1306acbf19bc0adfb60f706442
---
 Makefile                | 5 +++++
 scripts/Kconfig.include | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9be5834073f8..28177674178a 100644
--- a/Makefile
+++ b/Makefile
@@ -517,6 +517,8 @@ ifdef building_out_of_srctree
 	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
+KCONFIG_CC_OPTION_FLAGS := -Werror
+
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -531,11 +533,14 @@ ifeq ($(shell $(AS) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS	+= -no-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
+KCONFIG_CC_OPTION_FLAGS += -Werror=unknown-warning-option
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
+export KCONFIG_CC_OPTION_FLAGS
+
 # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 8a5c4d645eb1..144e83e7cb81 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
 
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
+cc-option = $(success,$(CC) $(KCONFIG_CC_OPTION_FLAGS) $(1) -E -x c /dev/null -o /dev/null)
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
-- 
Sent by a computer through tubes

