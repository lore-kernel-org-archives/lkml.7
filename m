Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9B208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140018;
	bh=zRpED71Pha3P9aaUIrChnFmBgcBXp4EAGRk0FvmAfqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvNdvD5hzEmhwQhmTS9e1nSBa0PGwanotvLPbM7cL8pouYGFwawHqqapqcIbzxgJI
	 n98zE4+QUqLW0VoqX2TBFLesI1wSS0OXXZZxq2xTV9QkoG5CsU8rZDXYSzEypm84YR
	 bRNF/hhVsD1iljCEtGeIl1EFHidvzYMwxpg/Y+To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbfDARdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732990AbfDARde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EE52070B;
        Mon,  1 Apr 2019 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140013;
        bh=zRpED71Pha3P9aaUIrChnFmBgcBXp4EAGRk0FvmAfqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/NDAZ32KR9n5r2K8pkWayRDSESnH2GO7jKw3GAsPQXVXpPJtbmG/mhW4Vc2DzeuX
         y35o3pkqeUbiDGA0XwXk+D3orhtDknkGACt+VO+TM0kjtxJl9QtHfz1AVRsPzfKu9z
         hktueRMBNFKathhn5jX9F1+Pb0805zxW14Ap8rJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 043/131] efi: stub: define DISABLE_BRANCH_PROFILING for all architectures
Date:   Mon,  1 Apr 2019 19:01:53 +0200
Message-Id: <20190401170055.917027555@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b523e185bba36164ca48a190f5468c140d815414 ]

This moves the DISABLE_BRANCH_PROFILING define from the x86 specific
to the general CFLAGS definition for the stub. This fixes build errors
when building for arm64 with CONFIG_PROFILE_ALL_BRANCHES_ENABLED.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 88bd6829a358..edb45f72b34c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -8,7 +8,7 @@ cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ $(LINUX_INCLUDE) -O2 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
-				   -mno-mmx -mno-sse -DDISABLE_BRANCH_PROFILING
+				   -mno-mmx -mno-sse
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
@@ -16,7 +16,7 @@ cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-KBUILD_CFLAGS			:= $(cflags-y) \
+KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   $(call cc-option,-ffreestanding) \
 				   $(call cc-option,-fno-stack-protector)
 
-- 
2.19.1



