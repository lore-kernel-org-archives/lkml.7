Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0621C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74DA238CF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GdPfWrKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfHTIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:41 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53370 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfHTIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:23 -0400
Received: by mail-wm1-f54.google.com with SMTP id 10so1851078wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lLrSRS8pvD415Y7pil0oxXPvn0IdPhB7KI2Ad+RFYU=;
        b=GdPfWrKshjNkikUSOYnn/MNowhVUPN//wLj9zC1QBalNX4iF1bDDWiGqlPTEFAjPFd
         6JdydSpSg78Ti3PB2/ndGZ8DzoNKJBprGfM+rRSOa5MlafV3yAcFw+zzVU72YvRFN9ZU
         AhwLMPGytbUritZbatAUwNNe1w/MfGVdWSEOq+1RPKIodRQKVwudCjOUNEQYPe0UuCpN
         xmY3+xUv52zUZ4WZo1Y71DCr22UbIIofmkKxlwYm+AizZIxl4+fvYeozM58PlPIUVT74
         M/uo58NK618BYuWSbelEvHQRS2wnGKQIaq9w71HbLuQUrejt37RXGrX2XnMob6rGo1Lb
         7QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lLrSRS8pvD415Y7pil0oxXPvn0IdPhB7KI2Ad+RFYU=;
        b=IY2y8uAUs+sHQ9U0ug8KpymHc2drVVKVThPHdf4jTIq7eyiFobjl/AUZXAqqFxOTIE
         4gmH27Dbou43NgEGdKJcmNUriAo0s7IyiKbcbbzgrsHd7PbCEA8Wm+gtnSsFLt6iCAxS
         YJe8aExJ9zu+Mu2wT/dNG13TJmUWjWuXaS6WaGdSTuKsnCNfbIF3ybnOfjSI/NvKNJCP
         I8KByszvqM/5hKg+Gf206iMGn4kpOpl63/ipyvwK9oWDZlHWmU8fYey3tUtACz0RlCN8
         cQGGtLONmCo0oqOVXWbAkYWX4wkKTUfgWusrO7uJ+lrV2hR9NwBvwlPueAAcmQXbSJxi
         SK0w==
X-Gm-Message-State: APjAAAV5X0Gob13Lls19Lmfyiy+Ag9ymP4yW9Ti3vk1/b4czbim277me
        slkaDVcv9fno9MSoTd71hSPGgw==
X-Google-Smtp-Source: APXvYqwiHM21/zJHepoK/A0Ag59YPDuYQqEc20EqsPCkhW8DLHYUGWxrHv5h2btYx8v7YOae1PMtsQ==
X-Received: by 2002:a1c:760b:: with SMTP id r11mr557337wmc.41.1566290481158;
        Tue, 20 Aug 2019 01:41:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 07/11] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Tue, 20 Aug 2019 10:41:05 +0200
Message-Id: <20190820084109.24616-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
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
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 316823abdd00..cb560b231d74 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2793,6 +2793,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
 
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
index c402364aec0d..04e63ed29417 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -126,6 +126,7 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.22.0

