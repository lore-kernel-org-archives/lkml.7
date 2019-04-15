Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE358218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355233;
	bh=lxC8+yuu3crnRi+Gft1xk/XP3S1Sm8ISoYy5GjkXD34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=toC1RAutAKpk8Z3JBQGBfeWmKCcImlkwnXYjpoV++gD+stMGCXCIE4g/rYiSm0EFb
	 Wftq0qhRUAM9pCfJ0CEeKacr6D0SYnqmFFGtE2a4QbRac6n5ig9L654Wt7MxziJwdU
	 ZI9EUI2rNVI2IE/yhh6cEG0hqDW/QEoQk6imWhrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfDOTHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbfDOTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8752C2087C;
        Mon, 15 Apr 2019 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355227;
        bh=lxC8+yuu3crnRi+Gft1xk/XP3S1Sm8ISoYy5GjkXD34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJGTCMMGnnTnEP+cHTfdVpmth5ijqlu07yp7zWELZ4+x1CMOzP5apzsgJD/It5fB3
         1S24o83LcY72mQY1stMtXtgRCTpyx69AUrkVUWexhAuJipdf4eTmpsUZBMGLfIRMjy
         Ja72asdH/0aOWB/BSt2y7IMtBC06ihEK9wJibs+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/101] kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
Date:   Mon, 15 Apr 2019 20:58:36 +0200
Message-Id: <20190415183742.470154291@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
index 8fdfe0af5862..c07f25e2e11b 100644
--- a/Makefile
+++ b/Makefile
@@ -483,7 +483,7 @@ endif
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.19.1



