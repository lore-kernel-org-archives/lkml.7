Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA890C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4520651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L/jjE0Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHLMHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50955 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfHLMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so11926308wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBAKQK2TWb6YSZRcSfCJBhSpAFaSf3bVHWGaQNvZ07Y=;
        b=L/jjE0Z+uh9feCmkguYc7tOOBvXTJ2DTkbUR4kDzZ6isTnRr7TZDjGDEF6mDLN8STZ
         3GZGeVOI/dBYGZa6vyrOZB8Dj6VWwEAJR0uv1rxGJVEZvh9DW41NSo4aMra+MPz5b36A
         UFoTyytB4L/uzrZZdbjUV1mDHzMgHzpls39fSbcyuOrCahhcac5jv3fY+uyTA4nh4OXW
         qrzV7pQHNBFW3NqoZTG8Y1ns1WE5CEI7I5bgg+t2saPZdgk22y7ggPFf7dn3/HLwODVw
         PeX5EWRAKOrympN/IGlN4Qwt0NrARSKDvPGYJehhTQcksDpIWpcYJluUoUUbSfhndXbz
         dXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBAKQK2TWb6YSZRcSfCJBhSpAFaSf3bVHWGaQNvZ07Y=;
        b=KhswzfV0sBJub+o1pofpVrc1TDHoR7IX94Zr8PnhZoWUeSNKhKRtk9kebVxSsQ7eNk
         a0F0r8XXkGge2kVz7f6HDDQrifZyhF7s9iveP0fICGIdX6BUCjiMlOkMuGTnaYvATvCE
         INKgjbtvd3TZZG+cDZHnEgmgpwc+TnDW2ylQh0xPgI+CRV7smAUa/GSFBsZtAOaa3Eer
         FJpQYYczP8+nJLyEsyhEu6/7MIhU3AbkkPlE+KERP0bNJevTtj17KbLXKutcoB3gMKps
         Lw6qHci8gFJg2abNQl0a2aBYWcklbtYTZy0yJAx1wRLzGMrPD9QU8+nLj5l6UFoBD3UH
         X8rw==
X-Gm-Message-State: APjAAAV3ayjv3H4I5DwJC8B1hab76EzUj+B3fLAGBdTCpaZ9FCG5l5Yl
        Xj/rX8dK/q+Pmfbt1+TBEgzGPQ==
X-Google-Smtp-Source: APXvYqzfW3eeOX4MX+i/CqoB9uhQnpRtsA/vpMtmJNdTO6GoCfgbeP6QdCyPmPxK8IqalPIZIB0rSg==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr27445823wma.176.1565611654629;
        Mon, 12 Aug 2019 05:07:34 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/8] drm/bridge: dw-hdmi-i2s: set the channel allocation
Date:   Mon, 12 Aug 2019 14:07:23 +0200
Message-Id: <20190812120726.1528-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812120726.1528-1-jbrunet@baylibre.com>
References: <20190812120726.1528-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup the channel allocation provided by the generic hdmi-codec driver

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index caf8aed78fea..0864dee8d180 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -85,6 +85,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 
 	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
 	dw_hdmi_set_channel_count(hdmi, hparms->channels);
+	dw_hdmi_set_channel_allocation(hdmi, hparms->cea.channel_allocation);
 
 	hdmi_write(audio, inputclkfs, HDMI_AUD_INPUTCLKFS);
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
-- 
2.21.0

