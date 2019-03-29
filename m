Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4882E20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JPrf9zlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfC2Kmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37906 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfC2Kmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so2219863wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbTqFTiH87EK1fVSxWqIYud8Aw5H13N60gUguYkEsk0=;
        b=JPrf9zlvQhyp189u10Vc5MOBLaMx8QgaDQakZorTeZo9OKJV3LcY/lhj7KxmBg962h
         /YqkRzf97dgrZVvLMLEQc2V7Fgk0TYSXil/mFu3XH1WsZTkk3XBitwhdF5lUrZxAQYC9
         0BdEnERr2DC7a83r6zFYdN1QTgSyb+JNIIlB96rHW/fD+cdDZOjdmaxHOKdcd7dZqXSC
         v2swrWUj5A44rT+OoSq0NdxrKWD2jN6ZnZDvDARIFQDFTAb/qbGsqauiMHhu6g/ZLb2C
         P1TW+gM56pkpU8vJtPlYnYXAyESUvVqGO2ewQUwukqZ+BEsTiCBakQzzfML1U0veOjOz
         GIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbTqFTiH87EK1fVSxWqIYud8Aw5H13N60gUguYkEsk0=;
        b=PhzJUjzKCYJXUyY8u047XCBANDwSu+ETiz7N/rohZLMO3Pg7jf9/nJttrnBaY8Q2Qb
         vhkVlp2xcUNjVqfuaf02QYp+jZnLVAsCNBKSswyugDlA/zaIrHeAZxA/LKTVJ+/9jSDx
         Cm84BqB5XUNjiX8uSEjYnTX2XaChXfeS4TYnIAllqeMHs4oVqq+Xg4jCk18F8P98xjRx
         MuEK+X5ofDhEr7DXtbO+f7ct7oAWb1+m40dSzsOC2yNQlGLptci7uc+ykGym9qKBCT4r
         RDWG6XpaVgO701/EYIta/kqgs4RJnn+ifiUAeOfn3W2W/VEeUiy0KjDsgZx+PZ9jmhxF
         gfdg==
X-Gm-Message-State: APjAAAVVQR8sKFkQejRjeZV9Ttl5rqPTOSFF1G/pfD5DTE5WxL+fMUGt
        L0uMpGU2vFd9AaCJeGxoIqvDow==
X-Google-Smtp-Source: APXvYqwrTe6pOJSGSIiBL2UrxW2af3HwetzllSOiVAGKLiCPwAdx/rNUEApZ5fP9Rc7rMc/QEtTPVA==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3115737wmb.11.1553856164077;
        Fri, 29 Mar 2019 03:42:44 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o15sm1632826wrj.59.2019.03.29.03.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 03:42:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/5] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Fri, 29 Mar 2019 11:42:36 +0100
Message-Id: <20190329104240.29585-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329104240.29585-1-narmstrong@baylibre.com>
References: <20190329104240.29585-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
for these modes in the connector if the platform supports them.
We limit these modes to DW-HDMI IP version >= 0x200a which
are designed to support HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index db761329a1e3..325a87a82048 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2621,6 +2621,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	if (hdmi->phy.ops->setup_hpd)
 		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
 
+	if (hdmi->version >= 0x200a)
+		hdmi->connector.ycbcr_420_allowed =
+			hdmi->plat_data->ycbcr_420_allowed;
+	else
+		hdmi->connector.ycbcr_420_allowed = false;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..0f0e82638fbe 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -130,6 +130,7 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.21.0

