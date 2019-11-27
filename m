Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547052084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888507;
	bh=mjEAf4IZiaoy69szyp+z+zduvvrVkJ634Pi2kNlx0nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eOLAFdoqFR/RpP4DxYN7URL7LeML+vsXmftCjHMTT6GDfaUj6LUcCAVk/sQzp+VaO
	 WOjdWIMNPs92LfiSl6FiwnG20ACUr8AImmiLjO2n3dmd0XfrOxmZDayzSk30n/Hcrf
	 4lQPmxKwURnCyuCFpAd5dTvkphpI2Jz0w/+lp5D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfK0VBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731741AbfK0VBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA08A2158C;
        Wed, 27 Nov 2019 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888502;
        bh=mjEAf4IZiaoy69szyp+z+zduvvrVkJ634Pi2kNlx0nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZz7WJVXDS2bU0v7Sv8a0XSH7ngT2HGYxaZtko+VPeoQfbPoZKRwj3p+3gAbd5B9g
         q1WxZXKpXfjgUGCjkjj7ltjZHiWEa90PM6Mm/0wzAVFpo7o5YsZj47m72RXEnA3fV5
         EmfkMtl6tNIsF8pgtW5hBS3hgDrWllD9q4l+e6HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 160/306] powerpc/xmon: Relax frame size for clang
Date:   Wed, 27 Nov 2019 21:30:10 +0100
Message-Id: <20191127203127.204172470@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit 9c87156cce5a63735d1218f0096a65c50a7a32aa ]

When building with clang (8 trunk, 7.0 release) the frame size limit is
hit:

 arch/powerpc/xmon/xmon.c:452:12: warning: stack frame size of 2576
 bytes in function 'xmon_core' [-Wframe-larger-than=]

Some investigation by Naveen indicates this is due to clang saving the
addresses to printf format strings on the stack.

While this issue is investigated, bump up the frame size limit for xmon
when building with clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/252
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 9d7d8e6d705c4..9ba44e190e5e4 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -13,6 +13,12 @@ UBSAN_SANITIZE := n
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+ifdef CONFIG_CC_IS_CLANG
+# clang stores addresses on the stack causing the frame size to blow
+# out. See https://github.com/ClangBuiltLinux/linux/issues/252
+KBUILD_CFLAGS += -Wframe-larger-than=4096
+endif
+
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o spr_access.o
-- 
2.20.1



