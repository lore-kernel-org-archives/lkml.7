Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463E5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2BB20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129113;
	bh=n1a6i1R2F0WP1NiEHIgU3ozqbLHmg///H9eeAR9vrZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1XaWjLFlPEYd48PRIsMqaZvIcO4IhyUumz5EdhUPdRN9sQ9hPOkZWg/QQUtf0Rt/U
	 qDlh9qANuIkQiFsPRb3KLQNGZhZzFBOmQfQXNtVLxfGNrf8GgBGz9oaOFMwb6GNz11
	 MRA3ytJgSZZmcQQEtGWBfKKNtFHSFCWcEQIwxQsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfDXRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbfDXRSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:39 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2E521908;
        Wed, 24 Apr 2019 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126318;
        bh=n1a6i1R2F0WP1NiEHIgU3ozqbLHmg///H9eeAR9vrZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKw7vH5QW5hqD2VbIAoe/VlNff+9kFS/E3iquj7pr0Pj4yDv7d/IuZa12myOcnwnj
         Corfzax2b4X7JyJcGm7h4LbTaT5Z/kyGnl9hd3CGeqb4KdoJdzJvntl+RXTCyshYRo
         0+TS75VIVqvERKPN+IT+y6ERKtxL6a88XlGnWftQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 070/168] kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
Date:   Wed, 24 Apr 2019 19:08:34 +0200
Message-Id: <20190424170927.887118912@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ad15006cc78459d059af56729c4d9bed7c7fd860 upstream.

This causes an issue when trying to build with `make LD=ld.lld` if
ld.lld and the rest of your cross tools aren't in the same directory
(ex. /usr/local/bin) (as is the case for Android's build system), as the
GCC_TOOLCHAIN_DIR then gets set based on `which $(LD)` which will point
where LLVM tools are, not GCC/binutils tools are located.

Instead, select the GCC_TOOLCHAIN_DIR based on another tool provided by
binutils for which LLVM does not provide a substitute for, such as
elfedit.

Fixes: 785f11aa595b ("kbuild: Add better clang cross build support")
Link: https://github.com/ClangBuiltLinux/linux/issues/341
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 35be7983ef2d..7bf3fb717921 100644
--- a/Makefile
+++ b/Makefile
@@ -610,7 +610,7 @@ all: vmlinux
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.19.1



