Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD1DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAB25789
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Iqr/sqJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfE3KkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:40:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:16700 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3KkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:40:13 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4UAdVWM014412;
        Thu, 30 May 2019 19:39:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4UAdVWM014412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559212772;
        bh=yBfKarMdVIq09NQR0PtT44QeSlRwJqdSLI3JOBOKuVE=;
        h=From:To:Cc:Subject:Date:From;
        b=Iqr/sqJb/AsaRdwPGr99isNaEy2NgeA/D3F6dMppQChx5OD9k7bipp/f2Gozo4rXM
         ly1f8ceK77ecPzu0IlTO0enL80HP/AvMlHScxouQthD0fwFa4XyFv/rBEsQYV5x23F
         hNMTCxn8A8l6BeaN9zwDYrtfYuG3cgS+16kvYDTxAjyBuam0VMUp1j6HT+SPUk6rLz
         F7AqFJ6vdZBSdcuXP6UCj22CJyxhJGC10qD8I9RvReNmtzIm7qSaf1hTd9BYYtIqlF
         SSWLVw4GZYOEbLX2KF5gw8FZ6chyamZIYcU575/SiT2azy/2NfGnXlcM31zJtgHLPX
         ISUs/o92JRPig==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of/fdt: pass early_init_dt_reserve_memory_arch() with bool type nomap
Date:   Thu, 30 May 2019 19:39:27 +0900
Message-Id: <20190530103927.20952-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third argument 'nomap' of early_init_dt_reserve_memory_arch() is
bool. It is preferred to pass it with a bool type parameter.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/of/fdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index de893c9616a1..b165e8b3a347 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -551,7 +551,8 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int nomap, first = 1;
+	int first = 1;
+	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
 	if (!prop)
@@ -666,7 +667,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
 		if (!size)
 			break;
-		early_init_dt_reserve_memory_arch(base, size, 0);
+		early_init_dt_reserve_memory_arch(base, size, false);
 	}
 
 	of_scan_flat_dt(__fdt_scan_reserved_mem, NULL);
@@ -684,7 +685,7 @@ void __init early_init_fdt_reserve_self(void)
 	/* Reserve the dtb region */
 	early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
 					  fdt_totalsize(initial_boot_params),
-					  0);
+					  false);
 }
 
 /**
-- 
2.17.1

