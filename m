Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A06C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA8E2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Enu1u18e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfCWVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfCWVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so5964770wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHGeWlxnKx94fNgtj0Ond8hQHZ5DmaSA4IEJiS/jmnc=;
        b=Enu1u18e7WYLT4TmA2pVYKijZVO5wF5fGppNJ+CGBQEVNWKSl+jMjZmOKkHZgv4qMI
         9jkPxhgqHpSJ+C8UZ3Sm4toG1PuPnQ/eDmbr/6WTWDwBl9IWcSMuCl5B+MFsyNBe+O0q
         WPdf/0dcRXY+J5/O0lFuNmSpRky7yT8yCi4yOdCBXrnlUkFn9K7gkWqapENYSZa3NZcI
         YYLeYvrwu6zHK56NxnWg07QPaZKjb+37s9l2SpAJ9NmIKXQzYcR8gKpci+QNjViwuEnS
         /d3PWAle0FQm+xVD3TtC1CGSATOFMSFIzik5frH2r2InGQ4I28QX4fIhMeK05KQa8Hpz
         sNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHGeWlxnKx94fNgtj0Ond8hQHZ5DmaSA4IEJiS/jmnc=;
        b=R0Aqkv5XVR9eDzF+O2oMgnsylYsDZUwQmvO3NpbMWzN0lK+DW8pX9X+fSpxFWHdpU2
         pW8cBluJm9/nkAeJ0KgGRQq4RcjtcaqKVMBFBeidRps+B3lFT1NAy6GyEz/+6xrobeCU
         KIInABVmVLT6kDVyb16dis3tFnHYI99j6yY30kmwrfteD5V3No/MraF3+n13Toy2VuO9
         aPzapVUQXjdCA9qljOewMOy7AFMh/tzRLIoS2DAQimwrQhH4IlVzKRj/LtbdFSsK1rI4
         jymvTQG60UYT5EfkHU4uaqFYyk17g20Yxc4ZP1pbNcCTqjQxTkqYSM8+x/lv+n75EhCX
         Q14w==
X-Gm-Message-State: APjAAAVgE4fgWiWJwsQm+WoZ+h7OWjNp5t9F4+CQP0LqAv5DGzVMQLAr
        hRx/UCmiX7uyi0nGqqVocZ++TA==
X-Google-Smtp-Source: APXvYqyLXu4uVNnQeYOK5P6eTYaqaYonyJO6CVthYaW9Pxw9jZV5naLdfXcXE0L+wT6u31jEEgwNqQ==
X-Received: by 2002:a5d:6887:: with SMTP id h7mr11460686wru.122.1553375849261;
        Sat, 23 Mar 2019 14:17:29 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:28 -0700 (PDT)
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
Subject: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:07 +0100
Message-Id: <20190323211612.860-20-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of spi-mt65xx for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 69c356767cf8..69ac5976b952 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -10,6 +10,7 @@ Required properties:
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
+    - "mediatek,mt8516-spi", "mediatek,mt2701-spi": for mt8516 platforms
 
 - #address-cells: should be 1.
 
-- 
2.20.1

