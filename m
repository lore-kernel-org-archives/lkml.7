Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A572BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756212147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368393;
	bh=SporxTRfM0/QzoeB5LOfPjJwX+8pCsCf9fI5003B0N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZEleXlwg1zKRSgxrQzfOuXnp8bLVamYkIv7h2t6hE+FbUZOfnZRE6Qk7GRHtJQaO
	 WwNVQ+C7ZoiQ+vi+CjRbYkPlVmoruyDUYapQHCXPZE65ci9C6ao22NONFpF38BmXcw
	 ZB5dnf2RG4p7wq77jTXCqG1JXVfPC5b+RXEK7UIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfDDI7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbfDDI7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4092147C;
        Thu,  4 Apr 2019 08:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368387;
        bh=SporxTRfM0/QzoeB5LOfPjJwX+8pCsCf9fI5003B0N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHwXNmnl3fbn8plTGyL7mDwNr5y4zqnFy0WepNH+K48wSnwITqqumQCH9/3ntRLDb
         3xSjxYUdHSYGwdR/iecBCGvAW4wDq49BsCUIbiuGcy2q1k8QZJsirRXGw2xz822dYT
         wCNVi6V/MJktWkSve1Nelq2oHH/JIydmoIKYkgOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/187] h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
Date:   Thu,  4 Apr 2019 10:45:43 +0200
Message-Id: <20190404084603.392944979@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fc2b47b55f17fd996f7a01975ce1c33c2f2513f6 ]

It believe it is a bad idea to hardcode a specific compiler prefix
that may or may not be installed on a user's system. It is annoying
when testing features that should not require compilers at all.

For example, mrproper, headers_install, etc. should work without
any compiler.

They look like follows on my machine.

$ make ARCH=h8300 mrproper
./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
make: h8300-unknown-linux-gcc: Command not found
make: h8300-unknown-linux-gcc: Command not found
  [ a bunch of the same error messages continue ]

$ make ARCH=h8300 headers_install
./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
make: h8300-unknown-linux-gcc: Command not found
  HOSTCC  scripts/basic/fixdep
make: h8300-unknown-linux-gcc: Command not found
  WRAP    arch/h8300/include/generated/uapi/asm/kvm_para.h
  [ snip ]

The solution is to delete this line, or to use cc-cross-prefix like
some architectures do. I chose the latter as a moderate fixup.

I added an alternative 'h8300-linux-' because it is available at:

https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/h8300/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 58634e6bae92..55f251810129 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -27,7 +27,7 @@ KBUILD_LDFLAGS += $(ldflags-y)
 CHECKFLAGS += -msize-long
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := h8300-unknown-linux-
+CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
 endif
 
 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
-- 
2.19.1



