Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F05BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B252087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sNu4hws/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfD2KXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:23:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40105 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfD2KXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:23:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so14921122wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U654s0y3/OTSiMoK1+3nXkaUK985F53Lm18Cxpkwjw=;
        b=sNu4hws/TaY8GaFc8dyvmg+FW5/ryQH20TEta7WDZ6DNboRsaDEJ1G5g+3QodO80lz
         yWV2/U6H+LDyxFWVETn1tW+Yy/z5WDXiuFOmveVhzrLUwJJGcmABzlsUaDfMCXY6mhTn
         BJALXTC/JxKGC3cGGMd1rRALKsv1IUYXlqaFZ73NOVXK+AXa6w2tfgnkzQVirczoMYbJ
         l0tAobCAA5vMUdM9a9UFg9BW4e31Ychs932Icrlkj0pg/0xjUs66axoWRZP/1xTBUf75
         VCTq01XreUR2RV5J4OZxSdTg0HT1aU2Y6JpcsQdX3m1wOqAdeSDGfvjR/LhTYBxgiA8P
         W8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U654s0y3/OTSiMoK1+3nXkaUK985F53Lm18Cxpkwjw=;
        b=Wt1vZSh/slVbW4h/9r4yU/BKOUnMZhp0G0MKvPVbCU0ZhhQ0lmtyDHOvVVnx1L7QuW
         N0/VHsBlvYdmv5GJamuNkRulTqZi13Z/DuseiJF11fi+M7DGnT1SiclJxCYDuJ3nW6Dr
         E3onrXaxOxQdLE7o0TvH5sFRk1XKeLzjY03NBUW4MLI0cw36itqGttSxUCN2580FuR+U
         Y2Yw8B1XCi8pVBDpAf9Wc85iRc/uLcNI0vQ0sskXwRPJrvi9obT42J8PN7D9r6WRUKXV
         sVqTDyCubYD/hCs39vgE2BOqV5mzPdNlMFeNYCdqlO8g7fS66a7ENqRbFifQ63+6wSd5
         xJyw==
X-Gm-Message-State: APjAAAXg4KROYHFxdQ/OrbDMWBGCPcQVhemXMdCyGFqk2932mGUZDKDP
        fhgIGv2vGASHD1rZqAK274BfPA==
X-Google-Smtp-Source: APXvYqzuIr088WqVnUik2HpohJ2FvVRToR12zoB533mbajPOk1tDXuO2RvmDLe+JxMnff/DpTnJyIg==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr16865079wmc.148.1556533418772;
        Mon, 29 Apr 2019 03:23:38 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m25sm1598874wmi.45.2019.04.29.03.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 03:23:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: imply dw-hdmi i2s audio for meson hdmi
Date:   Mon, 29 Apr 2019 12:23:25 +0200
Message-Id: <20190429102325.29022-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imply the i2s part of the Synopsys HDMI driver for Amlogic SoCs.
This will enable the i2s part by default when meson hdmi driver
is enable but let platforms not supported by the audio subsystem
disable it if necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index c28b69f48555..a480e4a80bea 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -14,3 +14,4 @@ config DRM_MESON_DW_HDMI
 	depends on DRM_MESON
 	default y if DRM_MESON
 	select DRM_DW_HDMI
+	imply DRM_DW_HDMI_I2S_AUDIO
-- 
2.20.1

