Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC66C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651A21874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sH6x2DQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfCWVRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfCWVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so5950743wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqEIZ6FPRVOsxD/5ZdDFPJFBFJJqg67FMRWbsNGHM9Y=;
        b=sH6x2DQLefyigtjy6s+ZFU1Voblc84sRKvafmxo8OzO9WHRMeDxbKCnkMuktslAzHC
         O54zjPuskrBQs/E8dqIvKxjCta0Kydbrs5opSaPOUII+7qB0ykyhGYhKjoYOOaS3N8cg
         w0yqcAu2zoHY4/KOWruHkWiTkZDhxk+ZNKTWRqVdIPkxpfA3ESHLYA2Orsa/rYUYiEki
         EdN2YFQvkBxfTbc3uVmyTxSJy4FVfGXEQpURB/MhVYFYQP8x1S01MAocw2nNIQz5LIa9
         cOTuBDsAAipI496iTrNMxtWNlf89qPyjh65jXyUuCnNnESC/KMKErzGAnfNPl3LB2z+v
         m9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqEIZ6FPRVOsxD/5ZdDFPJFBFJJqg67FMRWbsNGHM9Y=;
        b=IUwJmDTvg1Ag1H934x1KJUDJjOc3VDZaFcnEIEScmNAaOuvX1p6l1YZfmNcRwcHKuS
         SrUjWXnv2FdH59KHZJuJSNlttRNhg1sX3QBOHV6FQHH79C4iG0QGB34YJmkUeGKqPkdD
         sG8L4yptSSmCmvFV86iVdqX8so7EhhUSejX1b0/3ty2ojFtUtoG55sp9n3kC3uX0xAN8
         iZjDv9jRiAsBoKtCz4hvPpuOXTUOVenIS4KpY2z+y9XHkK1FJo7Cop5UPSzZPi1/B9nV
         /FaxtD+zcG21VZB4cLF33q+/57uTZuUwiUW1+48SVvkOXDUder5VVsMle0M+EwKwB0PU
         fZPA==
X-Gm-Message-State: APjAAAVey8PKt1wCioxb5TC6b6uu6nHzmHT1+5rDWSrCiSaoCq7+8mWq
        bMZoU7Cxxmw8ZiagLCthvCLbaA==
X-Google-Smtp-Source: APXvYqxfmp4TgFjlOCi45OjtTvOqzi/sLT6336tY80v5kBkDan8wJqT99JmznZ9LLuBNSnnM+3k0Pg==
X-Received: by 2002:a5d:624a:: with SMTP id m10mr3986055wrv.18.1553375851603;
        Sat, 23 Mar 2019 14:17:31 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:30 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 20/24] dt-bindings: serial: mtk-uart: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:08 +0100
Message-Id: <20190323211612.860-21-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mtk-uart for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 742cb470595b..1af981f7a33b 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -16,6 +16,7 @@ Required properties:
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
+  * "mediatek,mt8516-uart" for MT8516 compatible UARTS
   * "mediatek,mt6577-uart" for MT6577 and all of the above
 
 - reg: The base address of the UART register bank.
-- 
2.20.1

