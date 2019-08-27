Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA8C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923C22CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zvmHQrGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfH0IOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:14:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50906 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfH0IOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:14:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so2074114wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rf+Fb/D78w3i+4TzbVehqskNNypv9unv9HAaSJpdWso=;
        b=zvmHQrGrjBcBUwpMSCUNi+a3SsH9bq0JxEVQOK2M1WTophp7K27yBvua8SlTjR97dG
         H76O2lQXPtJ05fdxZE83rOAWcCAWejxNKSZl0WP58qnWYTNqZGqU7qCLz7lwzjJTzF/T
         y7ya6fU2g/k8KDTPviATtF06/s3SkeUjaHrMLNmvQUXj/cHId5awbMeUIQ99/auC23u5
         ppt77F0MrskDvGO5EC7yAD23nU49wSX7E/wF6EoTPvhpDncRjwnpmxisNUf0JoUpd4tB
         CdytHWJVU0KrnNo29sSCEwqd9VWFVQAEErfRyE3ApYfUQ9o1bLnMoKt2d0NEqkkU7S3v
         lLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rf+Fb/D78w3i+4TzbVehqskNNypv9unv9HAaSJpdWso=;
        b=L/YTSe/qDw7jDhAOR6dYfeTYl7+JQzVsX+Hi5TpmlSOgP/dOavc9L6gyth4ufXdAeX
         Ei/DvRK8mhTY/j7fLOYqG7kaTCONniuZaOKCuzK8yi0/AqfgrPiNKM1IqY/oIzeHuuOO
         BVNtDsf/YUdO8vfnU7SsKPvpSeM/ziOEYoGvOSnOa92CFYjeeCtYAvTFIla1NacZUOUP
         xAtQFqwl6fz4FYWg1OrtjXLj+qjhIIYBwSeDi6qiQBlKMZFjanF58b6hr8nGgEpXHSYa
         d5OVdXKDJEHR6sR7O3S19v+kP0Nv8T5UoZYS9Ni6+aEXtSiRnkj+Yo1Y59vEotyH+/RR
         8QvQ==
X-Gm-Message-State: APjAAAVbcjCy+gM4VtsyGaJiACdOKtanZOzioj12dxLlZT2jF9ZrVkWK
        dSAe1S98Hof6n440nfK0pTcptA==
X-Google-Smtp-Source: APXvYqzcST9C+Gwl8FfR3pGgo1a/ClAEBtAiPLNyZuPithhFN+DiiyD1q11WoQix3UFPCREYue4UNw==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr26068073wmg.158.1566893672720;
        Tue, 27 Aug 2019 01:14:32 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f18sm11911792wrx.85.2019.08.27.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:14:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Tue, 27 Aug 2019 10:14:22 +0200
Message-Id: <20190827081425.15011-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827081425.15011-1-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
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
index 00aacad51e29..048409af13d2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3031,6 +3031,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
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
index cf528c289857..25a884523b45 100644
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

