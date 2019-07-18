Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D62C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F69221019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AwJGFVo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfGRQgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:36:32 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:53356 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:36:32 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6IGZOWl002955;
        Fri, 19 Jul 2019 01:35:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6IGZOWl002955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563467725;
        bh=qK9D5U+XFfqL5PNQLZVCavZVXOZYKbNuMcBF5YYDexc=;
        h=From:To:Cc:Subject:Date:From;
        b=AwJGFVo7gC9IRoHpzS9XdsWJxZf5fekGyj87nCAQUjlC6xMkr8sLpNuB7Y32wyS4T
         IFoKLw0LA22VWi10KmUS9iORar5oEEXPVBQM+4GkY3yAaLi1mPfadOPiStKG0XpiWg
         r/NB7XOxa2rVsJq4EWMndJHHYvHJjwZaGe2BuNYAD9tNLOOuL4FXPGYgN3975Kovv3
         FQih3cQX5oApRAHBZ9yi1HmgxrU4Vbrv2Srzshf5GtixkM7TD6xEp000kN94vKGQRJ
         vXkAyF35eXFIdG7gAEt3Kc3WodbSngjgSBjWCWamRAoLiEteQmUFNhS15lzLdYkXHT
         VoO1dEc3V9XxA==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: visit mach-* and plat-* directories when cleaning
Date:   Fri, 19 Jul 2019 01:35:23 +0900
Message-Id: <20190718163523.18842-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you run "make clean" for arm, it never visits mach-* or plat-*
directories because machine-y and plat-y are just empty.

When cleaning, all machine, plat directories are accumulated to
machine-, plat-, respectively. So, let's pass them to core- to
clean up those directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v5.3-rc1

 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 792f7fa16a24..c3eb0d9a2fdd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -286,6 +286,10 @@ core-y				+= arch/arm/net/
 core-y				+= arch/arm/crypto/
 core-y				+= $(machdirs) $(platdirs)
 
+# For cleaning
+core-				+= $(patsubst %,arch/arm/mach-%/, $(machine-))
+core-				+= $(patsubst %,arch/arm/plat-%/, $(plat-))
+
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 
 libs-y				:= arch/arm/lib/ $(libs-y)
-- 
2.17.1

