Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B01DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF15218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="br2GMjVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfC3MFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:05:02 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:36854 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC3MFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:05:01 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2UC4MsS021262;
        Sat, 30 Mar 2019 21:04:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2UC4MsS021262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553947468;
        bh=AlH6VdZl5Lh+GjcQTaXSUl8konDDboFGt2lJg/++ZRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br2GMjVaNqFkHG72EDZGUYosdysgF6ehYuIhTDkZb08CBOezfLr8QVtg5MJ8wzGw6
         xCZ4K0iwQK8+oUrxBEmj2HF/YFAXCbDfIQxRUk9St0+4nnEnE9f0j/eBWKytVeBQ3q
         zac5e08deDDUmNpnIkmWLpNcA+bjUOb4d+l8RuO7Meg/9h7LFzExpv/GwhO14JoMdP
         d1vFyrjaLJC6wNRPRmKjycbL1ptngSfWviAuXO+xU8nRMwXXl+L2A0QvpG3ZiQJ+cU
         UxQv69/zivJAVCT9lmZxhUeRhRwAT461Ba2QlkQEbYCDKTXeJhwn0WWijV4CcQW/xM
         Ga1NzJwt4apVg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH 6/6] memory: squash drivers/memory/Makefile.asm-offsets
Date:   Sat, 30 Mar 2019 21:04:18 +0900
Message-Id: <1553947458-8311-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
References: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/memory/Makefile.asm-offsets is small enough, and included
from a single place.

Squash it into drivers/memory/Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/memory/Makefile             | 5 ++++-
 drivers/memory/Makefile.asm-offsets | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)
 delete mode 100644 drivers/memory/Makefile.asm-offsets

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 90161de..aaf6771 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -28,6 +28,9 @@ ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
 
 AFLAGS_ti-emif-sram-pm.o	:=-Wa,-march=armv7-a
 
-include drivers/memory/Makefile.asm-offsets
+include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
+	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
+
+targets += emif-asm-offsets.s
 
 drivers/memory/ti-emif-sram-pm.o: include/generated/ti-emif-asm-offsets.h
diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
deleted file mode 100644
index 0447e17..0000000
--- a/drivers/memory/Makefile.asm-offsets
+++ /dev/null
@@ -1,4 +0,0 @@
-include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
-	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
-
-targets += emif-asm-offsets.s
-- 
2.7.4

