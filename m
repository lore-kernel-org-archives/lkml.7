Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42180C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9320700
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOEx5Mmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfDBHJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:09:16 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:44714 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBHJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:09:16 -0400
Received: by mail-io1-f73.google.com with SMTP id c2so10056964ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6fjJy8yswnbkmtbxTFEZ/Qrr257jfY2BDV+aITklo40=;
        b=IOEx5MmrzBQW2a1Uik6PO/3VBDmNvgmOUIZgRpn2ByOjilXHh0sULLQE3eVnKsxLAN
         cEzdanotzIFZE4Omm1LpNIYJnnmSgsd2wsTXjbO1y0cz89L4ZPL5SIhZLU2zbzLHvC3c
         hqqLPpSLAcEhUCxg8SdyETezh17JC5YPPJpomqFLfaVKHjBxo44WXDdOU8hV27Pueccb
         UGonDZWw5675DRCB41bPERZnuZlgI1huUqNCYcrju3IRxGgXVM1/UbfnZ2BWFVKH+15G
         IW+wAuwfRc4E/ZuUZn3Vx7QQRkOVGJB7UkUnajGvwM5jX/Yfi8jEj2gDWVloual4oEwj
         lDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6fjJy8yswnbkmtbxTFEZ/Qrr257jfY2BDV+aITklo40=;
        b=tm6h+RnVjQt9Je7p/XXOKjhsfkbr0ixODoQMmo5GbtbLocaGAHYXurKTutmmFXdXu5
         ssAoUsNe3fQHznQM6LzSvElS+YicV5NSMzVWYfVrsyvA99U7tw2WKYox1VUca9wBg9W9
         LbYov6Ti6KqaKzws7mVVKhvd9XfCoOQnOoO7Q3hXSvjrop5IkvUfvTuQHMawKjkOan3E
         urVfuDdHJufScOcfN99g018l2HCQgo7ohCoI55FA1U35NwmObQGmJBhdwp6ayLtpI8Za
         w5K75klpwFyJOzvmXQlwLrFy3ThCz9qqAcKutT0tYiMwk7Gu3GBd5eRZanQTUpN769JT
         Cc7g==
X-Gm-Message-State: APjAAAVjfG47GOmIO1uLoWNo3G8ZNmPSZQB1xx/f1hSY+FmGU4+XxoFf
        AeQTW7zIsBAq77MdoWlsGjdovcCYef410DS0ztQ=
X-Google-Smtp-Source: APXvYqy5So56foJ0QDTySf1eU316xGuwVcT836f1flnZX0I0DUUVjpk4wrIqhvALaIK8oet12fd0+0UhZjFWpykKJZ0=
X-Received: by 2002:a24:455b:: with SMTP id y88mr7235585ita.14.1554188955497;
 Tue, 02 Apr 2019 00:09:15 -0700 (PDT)
Date:   Tue,  2 Apr 2019 00:08:58 -0700
In-Reply-To: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
Message-Id: <20190402070858.49597-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3] Makefile: lld: tell clang to use lld
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

Add -Qunused-arguments to KBUILD_CPPFLAGS when using LLD, as otherwise
Clang likes to complain about -fuse-lld= being unused when compiling but
not linking (-c) such as when cc-option is used.

Link: https://github.com/ClangBuiltLinux/linux/issues/342
Link: https://github.com/ClangBuiltLinux/linux/issues/366
Link: https://github.com/ClangBuiltLinux/linux/issues/357
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
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

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 026fbc450906..895c076b6305 100644
--- a/Makefile
+++ b/Makefile
@@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 CLANG_FLAGS	+= -no-integrated-as
+ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
+CLANG_FLAGS	+= -fuse-ld=$(shell which $(LD))
+KBUILD_CPPFLAGS += -Qunused-arguments
+endif
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
-- 
2.21.0.392.gf8f6787159e-goog

