Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1635C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BD92087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qJD4gdHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfHENlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHENlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so68952475wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuuMX+kd4A8dEfG3qDO6RvK4XQjF8g/kyhgS9BKn3r0=;
        b=qJD4gdHbnAzeFnPvKM+8j1gE58vTH+WCsmheK6fZFJnnrjUDw3nFKihaYFnoE5elar
         VG/+rWF3g2A+JcgymCXaFsEXgyJnIDT+hsLYwH+ybejdUeXdVh+RW4+FCuhzOoHzFNhg
         xOrmmMM+mhlrnr8Uw1NRZC6uFoFHjrKT5BQwTbPRiu4nacBAy5VNHoh+jSh40BsBm18T
         6OL8lWqJbAd4NDQsli32/MMIb20OPlIijh/jr1av7S2+rO1NNzTVkNTHRxzTR5WkVK8J
         RuYhO1fRZtrG7pz38v4Jr4FGft+lJR8YOPshh9Z5oJG31mIsgetJj3pEQPHxeyf37eWK
         h4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuuMX+kd4A8dEfG3qDO6RvK4XQjF8g/kyhgS9BKn3r0=;
        b=W3P2tKk9j+ti8vd5fEfG3CN15hBOv4kXSR4E+Fs9ZcXPAYSgidZew7GeOx4EsSMbc+
         TeZPKDHkJbvP4Cz8qNDJJ3mlMIPIiS9q26+RfFAG0a3OE9QuM15Pm0F/aKY4CTf1nPv4
         m7hqEMT8cTq0k+jBg6K4F26VExXnG6T47KVynIL0BxfNDI/gThhpoZY0B+0fowFJo5Gi
         dQj07TV5exQgMI/eCDpuDRweR6wORewKtrwOJrQm56SF3Upq7/zcXygXKxixJPSqqBUn
         baKazH1Fv1utgnasDSsvlcZXsgMoxNc763xXlzDI+h0OPmi4Ozs5NiJyxZ28oNpPUrnu
         aKmw==
X-Gm-Message-State: APjAAAXOcR1chCAa+jCrLgWXJnBWxHdvHgUaUPy/xD6CK2SpeK7CeL92
        V8emaWODTe+Kx+CqUIa1PyeNUQ==
X-Google-Smtp-Source: APXvYqwVoqHDa33wnfWrybOC8mjRHHCSuKqmhCrAqI5Gxpc/QXp+sgQF1g1sasCcuASz2XJytrrO5g==
X-Received: by 2002:a1c:630a:: with SMTP id x10mr19986559wmb.113.1565012469416;
        Mon, 05 Aug 2019 06:41:09 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:08 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/8] drm/bridge: dw-hdmi: set channel count in the infoframes
Date:   Mon,  5 Aug 2019 15:40:57 +0200
Message-Id: <20190805134102.24173-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805134102.24173-1-jbrunet@baylibre.com>
References: <20190805134102.24173-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the number of channel in the infoframes

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index be6d6819bef4..bed4bb017afd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -663,6 +663,10 @@ void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt)
 	hdmi_modb(hdmi, layout, HDMI_FC_AUDSCONF_AUD_PACKET_LAYOUT_MASK,
 		  HDMI_FC_AUDSCONF);
 
+	/* Set the audio infoframes channel count */
+	hdmi_modb(hdmi, (cnt - 1) << HDMI_FC_AUDICONF0_CC_OFFSET,
+		  HDMI_FC_AUDICONF0_CC_MASK, HDMI_FC_AUDICONF0);
+
 	mutex_unlock(&hdmi->audio_mutex);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_count);
-- 
2.21.0

