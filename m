Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D4C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C78C2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dJk++uOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCWVTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42629 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfCWVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so2489662wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjSY7GkEUKTVia2V0gFbX9EZoOEjMqM9LfrLzseMi5w=;
        b=dJk++uOx5tpZufmmq0SOswI/AqF9PCcaFhN0q0rCUw5njHqtJLv5MKR3ZR2KOC/hus
         k+h9uovDHQ+mY6Lytc+UfKuxYusxcrAWABcn2cQ5ege4cGwNCV24N/k1cjc604giAIoq
         7AlGeZ3lPlwypJ3TrPfPIIVgbp+PFmydj1zMcG2RR+C+/oSpzx9CDyPFuymaIjzI1RYe
         kuSGryHEowptYI+LcGval1WkVnr2Y8UFJisyRUz2KZd07H2xqgosXAUPnAAg0B8Rn4x0
         6ivVKXCs/8sT/MI6WTmv3XYcefKa826X1emJe/XZuPSgpN9xzry8RV9Y+dE2S6USK9YH
         WfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjSY7GkEUKTVia2V0gFbX9EZoOEjMqM9LfrLzseMi5w=;
        b=Y5eIkp7Mo9UvJKkmPT7vgjeuRciuRtzVzxZF+7IFSankILA+K64w5ksaE18iqdPQ+7
         FDIF8nGapZxMuA3ZTxk/9gI4tu5wxKEfIEg6QqxYvAHkeJOm0jTP6QmYfWOpF+B0JTkd
         p8x6thl/FPn3p+nCH7CJaQncIdlbd5Xwz4s201lJWbnRVzqgN/ZoE51TIVhfpRekYzIy
         aDOCy+7AoEBn+7xfCZKevm7oExpI+iKrxnubRB4R10AF5DqpFyaSmJ0Z+syY5yyyuLYb
         Xb6coS3QkaIO6bmLWQzIN+/bepwQr+ZDRF77CrWBaJqCFebExENpQu2w3Om+5GA4q+jl
         y3Tg==
X-Gm-Message-State: APjAAAXQyVP9eMXgV/MTgBefyHjQ3X4qQtkuF0Cxi/9gC/eYQMiGjpOK
        7bkjn1TrCjW4/znw4DEmHFfRwA==
X-Google-Smtp-Source: APXvYqyYO48bTY3cyp2gU4ct6hmi4qwhdUyjfSzlyOoq5TPdIWdzRX4XfQYrpZ4rO7Tx/wA8f82/MA==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr11186790wri.103.1553375817902;
        Sat, 23 Mar 2019 14:16:57 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:57 -0700 (PDT)
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
Subject: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
Date:   Sat, 23 Mar 2019 22:15:56 +0100
Message-Id: <20190323211612.860-9-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mtk-sd for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f5bcda3980cc..91a2ec59e497 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
+	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
-- 
2.20.1

