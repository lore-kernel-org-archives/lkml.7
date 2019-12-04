Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5905C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41542068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575433757;
	bh=Th+ja1qyCQRZUizS3CAPhOvFnAZX5uzbVL2uOiAiGA0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2lm4IfOG3XgLCZORVhc7GnNc40GJvshWCPAgg/oAqn9zIfWuwHGGiGQc1+XiUxAGr
	 8BxLkhjOBj4QCTNAlismhNEJsIinRq8qdorfh0Y3Etmke1d0/psBtaPY2+p6+N38Tc
	 HBngaPTfUQKwUbJkoLb+pWtEZ8EjJFW3Zx9JRO1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfLDE3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:29:16 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45972 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:29:16 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xB44SEjv007912;
        Wed, 4 Dec 2019 13:28:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xB44SEjv007912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575433694;
        bh=aZBc4IVru6RGfaR7ceRLbfahtURpRZYF6EvcHQYceI0=;
        h=From:To:Cc:Subject:Date:From;
        b=HTXFfWeetey0nr5Exo6zi1nh1p8lFfnNhnAYaHttpJ+kadz/VQguBJe3bfSLKGTVt
         9CkBdwN/f2IMZ6UarVAWoE+EOE4nd+6aloabRz0AABRnWTrpg5XlgELfWvTADuGSn4
         dVX5N7gLfUKbvE6K+6EUMPYq/cRCiuPCcalsx2ME41KXgVqYb3VsBx37gKeI20QDH6
         9tfU8h0aEyKfMkcqcGMU0tGNjjsWGWJ0zXuxjF1QZwIDy72uytQrHahlC11Xj5roNJ
         tjb/d+g1uI4QmW9+VgrxNGOzVzgGxgxJ1osThXLnv9aJwZxdWuOwDO5iZwkJYDtoy5
         SJe04muS2z5vQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: decompressor: use CONFIG option instead of cc-option
Date:   Wed,  4 Dec 2019 13:28:12 +0900
Message-Id: <20191204042813.7484-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig stage (arch/Kconfig) has already evaluated whether the
compiler supports -fno-stack-protector.

You can use CONFIG_CC_HAS_STACKPROTECTOR_NONE instead of invoking
the compiler to check the flag here.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.5-rc1


 arch/arm/boot/compressed/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index a1e883c5e5c4..da599c3a1193 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -110,12 +110,12 @@ endif
 
 # -fstack-protector-strong triggers protection checks in this code,
 # but it is being used too early to link to meaningful stack_chk logic.
-nossp_flags := $(call cc-option, -fno-stack-protector)
-CFLAGS_atags_to_fdt.o := $(nossp_flags)
-CFLAGS_fdt.o := $(nossp_flags)
-CFLAGS_fdt_ro.o := $(nossp_flags)
-CFLAGS_fdt_rw.o := $(nossp_flags)
-CFLAGS_fdt_wip.o := $(nossp_flags)
+nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
+CFLAGS_atags_to_fdt.o := $(nossp-flags-y)
+CFLAGS_fdt.o := $(nossp-flags-y)
+CFLAGS_fdt_ro.o := $(nossp-flags-y)
+CFLAGS_fdt_rw.o := $(nossp-flags-y)
+CFLAGS_fdt_wip.o := $(nossp-flags-y)
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
-- 
2.17.1

