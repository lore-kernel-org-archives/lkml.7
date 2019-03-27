Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D22EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C622075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712351;
	bh=9dgVZuCPRGTCL3jKF6dV4Qqyz28SQ/WpfxLMbofxLvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oyg7UbKneMO8mHowq/hAgxpBJBTC5zknR0LWbrNS/ykApx//rnhotS1Q5LV/AAIxq
	 G2ADkNw4Cz0CzTey512otcc6+KjH2Re1D/UWXsrN+Xr/mOnhtxrRsKOdYk9TrynZ/e
	 HeFKfv0A6hlcRQLNRqdPLE34kYJYJySwIBf+8AuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391389AbfC0Spt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390288AbfC0SUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AD52082F;
        Wed, 27 Mar 2019 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710843;
        bh=9dgVZuCPRGTCL3jKF6dV4Qqyz28SQ/WpfxLMbofxLvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PAyyYlaAKEVt+hvGl7q0wTDeFCIs9twTnn/XKA6YsHMVCXlh4TWMCv9/wIZWy0vgT
         7LzxCO3t8WMFa7LSCdxFICv1yjDRkuIznpzq90HWMYdcchisSsi4SjN9Xj5WUL9Ccb
         wQZKi1JPt1YgOFjy0T7SKboxtcJVamQSwCXa3aSY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 02/87] h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
Date:   Wed, 27 Mar 2019 14:19:15 -0400
Message-Id: <20190327182040.17444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

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

