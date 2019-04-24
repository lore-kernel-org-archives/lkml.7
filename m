Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FCC20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129321;
	bh=jMTJ7/GyWXRJGjul0jbA5sFD+x7xvcwk2OwrDbJ2A6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vwtpYD02HCvLoziXCkPlLp76B7WbuYK8U83otbRqD8la0jHinGextXuRh1drYqy0x
	 PmAJarQqOsnU6Yz9LX0jB03E0sWXd2zE1z7a/mEqPawBpKZNlkIaFI8rO67ncM7wFv
	 3yGe953TTwTGbQHg8O+VJ7OMegvfvDRHsBP4NGr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbfDXSIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387954AbfDXRP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:58 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4592D2054F;
        Wed, 24 Apr 2019 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126157;
        bh=jMTJ7/GyWXRJGjul0jbA5sFD+x7xvcwk2OwrDbJ2A6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkVGfsmKHftukGwszTzPRnellz/UMlazqaiqwKydF6kdlZqAOzmITcu5foWIaua2N
         xQVMErO9r4KheZTU+LpCxtd2WGVRBUaApjH+jG63RMGV4WL5l/CrDgci0eDsAiS6gR
         r6Ps3Oit583Mc5P6J+4aj8mbrWOkaw0sZ+R1FMm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 011/168] h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
Date:   Wed, 24 Apr 2019 19:07:35 +0200
Message-Id: <20190424170924.179002283@linuxfoundation.org>
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
index e1c02ca230cb..073bba6f9f60 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -23,7 +23,7 @@ KBUILD_AFLAGS += $(aflags-y)
 LDFLAGS += $(ldflags-y)
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := h8300-unknown-linux-
+CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
 endif
 
 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
-- 
2.19.1



