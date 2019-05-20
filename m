Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6620856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qkqIZ4ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfETNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:38:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46831 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfETNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:37:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so14610211wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e74Rqo2cklBC/UlaNKx3JTEybiBIRYYjSOkJeHcPVk=;
        b=qkqIZ4ym2VLSeHeslEAQCyUm6bVeVsFSUNQ2LvtHrY3C2fCv4b8b0jbIveo4LIdqiD
         6TkCPtclY3durJ4MYJ/XTFZYf0Ty2iOJgWlx0zP0jcAg10vChIwUxV8hw4fkasbGVUgo
         97ILwguLgX/uDsC16i4vczuxKAtB0eTL3uM5X6Y1CW6VW7A2UrjU7+PCoeOl9dio5YT8
         D0TqkTINRjw5Nbz40cuoU/Rx3qz2+qTRUGTKn3UMPqWa700L3ygRZ8FlBqRETtBouxAz
         YiBQ6yoLl0bIjHfo8np0hdwmc+Fk3NJnlGjEVUi2DxSmB+B4+4Ng9zgmORZo+HqIEaxM
         C4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e74Rqo2cklBC/UlaNKx3JTEybiBIRYYjSOkJeHcPVk=;
        b=Yp6UIdZg57vabV0BqIuHSZBZVOXjKzofLWqBHLCr8sQ1cKdExobyx4JYhoIweMMSNU
         nRlY2wtvqop9LwLLoUdTPd/dd/ATMg2pMP7RopxegfGu27wPsrO1CW+g7jPNunX3Th2Y
         RPqR+RL1n2qzn2P7xfkutTSpn7D/FxXlRTaytxF8HrNrYrjCZeWLcY4gPCOZol4qGN40
         slzVIiEh8Os4NdRx11mVIXK1sr5PmY16h58M1JdAUCzDo3Ho9jRjZcsXnkIj/YCwGW2R
         9dbRLI28Z7U7K7mLAgcsNah+y0/xcWpHLLQ5OJOm5nUWHxrdO5dXb2RNC/xxghgimXKS
         yQEA==
X-Gm-Message-State: APjAAAX4pSq877Xsa1lMDTXEM5qCb8Q8gip0HewieUTRjx0/4xc0EDyR
        38/4FZl6rEd2fXpvkhmZgQJxWg==
X-Google-Smtp-Source: APXvYqzgpOdOwP/k89kTM8MajUx9gbr5leJDAK8P0GnnsntE0Gkyw8ycffQn9JpPsd5utxc0Gc2bzw==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr18108351wri.69.1558359477807;
        Mon, 20 May 2019 06:37:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t19sm12167059wmi.42.2019.05.20.06.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:37:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Mon, 20 May 2019 15:37:49 +0200
Message-Id: <20190520133753.23871-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520133753.23871-1-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com>
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
index ab7968c8f6a2..b50c49caf7ae 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2629,6 +2629,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
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

