Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBA021874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OrRvZI/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfCWVSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34222 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfCWVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so6018746wrq.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3cE3TMFkcyblg01XVc51l5mjrk592SE8nW3ut2z8Rc=;
        b=OrRvZI/xBP7IVwxK0cxVq9lP/gexguutdq3apP+04CwFppE8iUjR0cl9pYUrxWGiAA
         aXLmqEjN3H91QaXDPIrcjz4i3R9CtCygjtKOslQf9FuCaNZw2QctYj9hA4gGsAHxMOqt
         maMQDi223hYjv6l5bFeD2TO0QBpwZYe9KX8LSYkSyMhz5xxCOoSuncujUb81VlL6ZcCm
         SFYXl0TQbzOWz8WBBvek4hml1RCWpI2E9UIE/7eg84mU1VEfjQjbwHI7Tn/NO8QrlV1X
         oo3EVRRKUg05jvG6TrsU7p6m1zlOKqAaXfbDgnky9nVPvI9VIxQbR25tA8Imw3jV29zc
         j7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3cE3TMFkcyblg01XVc51l5mjrk592SE8nW3ut2z8Rc=;
        b=pBxREvZVcqLvRbGN6oxlWsr2INdXE1skJyAHz39aWJIrH/V8GptUnIne/x4tayj56T
         2BTfCZysjgjqZK2ppKmY9+GNMb6QfYgFWnnjXFWBazsks3kH4Dxi9LR/lPr2PkDhCg18
         F3VwXzLTvTBaUkztdcSQRYrW2FHkNVoIxPYZFxoBX+n8g8emgAs3w8/o1FtPjGILHCmW
         qUuRQtuzu/IDShxHqJpZQ7ey/Wz6LAQSKSs7/4l5qMc9yhMabN3mIWc+HkPEylN2NCZP
         vhKvGOnyUD54nAUjSYHpEG1LVXN86PBy7WQi9maOrhTZZItE2AKG3Ov7GshQF+bT7Y7G
         uMww==
X-Gm-Message-State: APjAAAWXvk0wmCth7MpkAsSFBDPYG5ISI6oHG7cBEEezGFxowkCBbqSm
        LmAVwqQbhkGd9Ar+nsxz05B8dw==
X-Google-Smtp-Source: APXvYqy+VwtCSJsLToTuAbnMmIBRsksKSl7qErH0WunqQXrCpPhqctKau5R5XbmZjw1YdNUP2s8Vww==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr11190641wrq.218.1553375844777;
        Sat, 23 Mar 2019 14:17:24 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:24 -0700 (PDT)
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
Subject: [PATCH 17/24] dt-bindings: wdog: mtk-wdt: add support for MT851
Date:   Sat, 23 Mar 2019 22:16:05 +0100
Message-Id: <20190323211612.860-18-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mtk-wdt for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 8682d6a93e5b..fd380eb28df5 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -9,6 +9,7 @@ Required properties:
 	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
 	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
 	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
+	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.20.1

