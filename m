Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A237CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8622070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVk42bkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfDBHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:33:26 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:42247 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfDBHd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:33:26 -0400
Received: by mail-io1-f73.google.com with SMTP id i1so10274519ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q6AEs42Yptqy+iLpgSDIlp7Uvrf/sOqm7YVBDoal0w8=;
        b=OVk42bkFWAzTse1R7qCna/cXD/YEW+pcJNSgHWLAbCuvXR5ruo+sAq2OxXNqIOpwiD
         Ya2gQ+b6TTqPBnAfuWXSYFFePyVNION9J0/1yLUqRs49n2mPD3jKa/3HlPWzYjRvveeD
         5JuYZdLFNOoLeKhRvAy84oYIheVHHsF+mwXl3/ek4IcYM9mp1i2EbhEOQt5hnBXePQAu
         r1oxPVrlVPk3eFTyBGlwcCcLqBkI6MKAuPQOF3lPfeL1/Z5tbZzOA9iqDgKQHYm96+Uv
         5WVT/P37j1F/4nfuTJeON1/fR7KylQ1rdSvOx30ageVIaZL/Ts1tv5OOL7Lw1H20ZTMq
         QcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q6AEs42Yptqy+iLpgSDIlp7Uvrf/sOqm7YVBDoal0w8=;
        b=nr9dpu3aLqEMu1vjSsHyxM2VRhEMz9L1q+OTbFve36ayiTXTJvH2SRS9EtfVNEgNTe
         XfmqOhX7ussSpcEj/8Nkh00xhpxQPvSjZFDJotirc2XQ/XH+9gsE537+xdzQoLMhaJ29
         8RlirInOC2j3pCGa2ffphEa7KlkWOy+amdJKmAqbevRpAdxlx3guMwDOsz9c9i/Vj6zg
         5g/mDVXKgPBoIeQsf7ocpi5YBle6pOlqWfLJIjLt7Aw7Sj9QzYM0UIcoCJuUNFOoQr/t
         fUWX59QIcon39yeugbTx/40uM6/DKb7stc2zfbL0plLH6I7m0lxmP8qLKZW7KMFuT89F
         7pRg==
X-Gm-Message-State: APjAAAWRmzkZoOQjSoTeboFXMhvRVphCaU2w85ls/uh6A8cenC5KWn/M
        iN/0QnVzpHfSytIypqWOmDKhLdcG/PYBuUZlxBI=
X-Google-Smtp-Source: APXvYqzAIyTVpTGIKqj9+YaTCaolO8Lo//foJW0vSxi/3IFLTgAgyG7mci+CI+jF5Ne4FuY4HH2NLhQbkITLfgOz+dI=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr7272933itl.20.1554190405733;
 Tue, 02 Apr 2019 00:33:25 -0700 (PDT)
Date:   Tue,  2 Apr 2019 00:33:17 -0700
In-Reply-To: <20190402072726.GA16650@archlinux-ryzen>
Message-Id: <20190402073317.56529-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190402072726.GA16650@archlinux-ryzen>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4] Makefile: lld: tell clang to use lld
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yamada.masahiro@socionext.com
Cc:     keescook@chromium.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed because clang doesn't select which linker to use based on
$LD but rather -fuse-ld={bfd,gold,lld,<absolute path to linker>}.  This
is problematic especially for cc-ldoption, which checks for linker flag
support via invoking the compiler, rather than the linker.

Select the linker via absolute path from $PATH via `which`. This allows
you to build with:

$ make LD=ld.lld
$ make LD=ld.lld-8
$ make LD=/path/to/ld.lld

Add -Qunused-arguments to KBUILD_CPPFLAGS sooner, as otherwise
Clang likes to complain about -fuse-lld= being unused when compiling but
not linking (-c) such as when cc-option is used. There's no need to
guard with cc-option.

Link: https://github.com/ClangBuiltLinux/linux/issues/342
Link: https://github.com/ClangBuiltLinux/linux/issues/366
Link: https://github.com/ClangBuiltLinux/linux/issues/357
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V3->V4:
* Unconditionally add -Qunused-arguments sooners, as per Nathan.
* Slight modification to commit message for that point.
Changes V2->V3:
* Use absolute path based on `which $LD` as per Masahiro.
* Add -Qunused-arguments.
* Drop tested-by/reviewed-by tags, since this patched has changed enough
  to warrant re-testing/re-review, IMO.
* Add more info to the commit message.
Changes V1->V2:
* add reviewed and tested by tags.
* move this addition up 2 statments so that it's properly added to
  KBUILD_*FLAGS as per Nathan.

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 026fbc450906..b290e76e1ca5 100644
--- a/Makefile
+++ b/Makefile
@@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 CLANG_FLAGS	+= -no-integrated-as
+ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
+CLANG_FLAGS	+= -fuse-ld=$(shell which $(LD))
+endif
+KBUILD_CPPFLAGS	+= -Qunused-arguments
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
@@ -716,7 +720,6 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 KBUILD_CFLAGS += $(stackp-flags-y)
 
 ifdef CONFIG_CC_IS_CLANG
-KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-- 
2.21.0.392.gf8f6787159e-goog

