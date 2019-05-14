Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A6C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB92168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GrLWanG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfENLPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52519 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfENLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so2439482wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mU8ejWHy+W5AYtnGGvQAFcqui30OeOfdUF4Rimt6ejQ=;
        b=GrLWanG/uCTvdYXVZJknxkFiKNgW/j9vvGBCnZGnRIy98x3TPbc4wVRPJuIeVgLREw
         PuB3uuz4WOf9LdlFEzX3WgQCRXsSHSbzv+h8Ea1deY/yxdKU/ROlZC8tKyGzyY8P3izB
         3PrCDuiyANEuLQp3sMZJIrkbrZ5mLdC50mMIzJPmO26/J4Os8bTM0fCA2LDSzmPoUFnD
         Yc+gmZZSdbF56ClMM4PXms+Xrm4bAOzI8FxWkaaiyle10F6PyA+fNpLX1jateVkv+Hnn
         J1jDQV0h333B2KJhRCT7TJALRYXLwDmVwmQWFSkrgE2DUzQ1G091G0Me928VC1ADZxD3
         vaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mU8ejWHy+W5AYtnGGvQAFcqui30OeOfdUF4Rimt6ejQ=;
        b=JXqpRj9Ew82J3pOM4MVCwdTLSEC3Gvljlty/Htc0dCHtyA41XMK6ZBxkbct8fq+OoP
         LbxbSz7Nq54cm799wb21LEG8OBpPJCPBy5Rnu9c5iOSwsUqtXqAq/eJgu9ctwx+wctrW
         sTfyUOLlnkzZtkL7v2fJ4rQRsizA1tHHpq2BpouVvxrSXbX0JMnS8RgYgbpby90lSg7X
         s5o12N4Pn4IY/FTul++izoShgeEGM0EsEO7bbR22q5bhEDglxaeoCWqMIkJ8H5Rj0ISh
         jouYjDQxiIgPsr/J1sY8HerIYVde1N2U3OJPZ2a1Eu+cone+gpYrEJ8Lk1zrFAGhNd0N
         mqHg==
X-Gm-Message-State: APjAAAWEeLenjpE5z45O4G0941Cq1RUpSKkPIxorvCmgg3Y7LCWfgDRz
        e/kRG1l6LfN8cYwebvcaqCzETg==
X-Google-Smtp-Source: APXvYqwNYfIz+EntwTRpSxz3e5FlMiLk8xhRV0KoFKpWfBnG4xI9Vgeb/o/oIp3AfLznSOJCmCvPgw==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr15308582wmc.90.1557832525211;
        Tue, 14 May 2019 04:15:25 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: meson: g12a: enable hdmi_tx sound dai provider
Date:   Tue, 14 May 2019 13:15:10 +0200
Message-Id: <20190514111510.23299-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the sysnopsys hdmi i2s driver provides a single playback
DAI. Add the corresponding sound-dai-cell to the hdmi device node.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index d4fc645f0ff3..5c8c93ff4816 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -158,6 +158,7 @@
 				clock-names = "isfr", "iahb", "venci";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#sound-dai-cells = <0>;
 				status = "disabled";
 
 				/* VPU VENC Input */
-- 
2.20.1

