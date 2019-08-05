Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3258C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79D220880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f2kDgP14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfHENlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbfHENlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so73084874wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVzaYwLQ0IyryucLyxiH/odxXJQTMSx5Nh4LY6yGL/I=;
        b=f2kDgP143d0HrJANosipnWVMoq01I+69xpPIahSbB00o59IrM6ocWRY8N8/9bj7/r/
         7Uk7JljTqjtYeSAgptE9vL/QG3qBzfbzMUwGvWDITSnZ5bS/CFvai/L1kZl3KAgNUydc
         wfQRJzatabV0duadNUeHxb5UbJ/L+g3hbd3XvyesDOHOYBnEflfp5ZYTY2bBRxmw1d9c
         kAvctaIY0WFROtJ3UZs2ChJ1EwKa/fgxo3taxsCN4XaadvYsE1qia05ZI/KlLnLBGpjF
         AuM13Dt6JP/0YB+USV+ZRAnP+tS3fouv2TTRnf1QxrelQhADnQPvu6ut5QpSdBSV7BJa
         NHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVzaYwLQ0IyryucLyxiH/odxXJQTMSx5Nh4LY6yGL/I=;
        b=PhHaYdULOubzAnujOJ5ttc9mWGSDxF2+5Y1YhpDtsV/HCoP1P0hy0emFLVppGHbQd1
         n6YX4kseMbCfNFulcYwVi3WapGaPhNKTm09BT2D3TOIyS5fyxezADEcnzbW6P4E+EMUx
         y+YWVpUPcxMbnoRKkCi045oZZ72AWA7GmSkSbG/kEsR+MMf2Na1BmTbJD6KfaK2nU+PE
         g/8yFw3wBVLnqDnkfgRFxOQd2iYi0b6RfnBkfv3Ag0Aaezl0MvZwHGda6H1D1XyH7zMA
         V1ClENolHpyDYYKAZVGISpPhIcPKSdcaP6UM5TuLlU4dGzJEwPMOf5lOYa96CFomt1sk
         W9XQ==
X-Gm-Message-State: APjAAAXqI2UunfDfn0emdCHJgBfPNvMJuu+NRjWqhMk0MyNrhN6Y1hc9
        FwDKcjW2oHVm48VxscdtKa3Ukw==
X-Google-Smtp-Source: APXvYqzIdxmXDup/BxNDb6FeOvbs8087+YAEORHVdQ2WCPN0OwAzp/Wh/rJXlQk484ET/UdwuJ5/Qw==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr19116418wme.47.1565012472683;
        Mon, 05 Aug 2019 06:41:12 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:12 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 6/8] drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
Date:   Mon,  5 Aug 2019 15:41:00 +0200
Message-Id: <20190805134102.24173-7-jbrunet@baylibre.com>
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

When changing the audio hw params, reset the audio fifo to make sure
any old remaining data is flushed.

The databook mentions that such reset should be followed by a reset of
the i2s block to make sure the samples stay aligned

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 6 ++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h           | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 0864dee8d180..41bee0099578 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -49,6 +49,10 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Reset the FIFOs before applying new params */
+	hdmi_write(audio, HDMI_AUD_CONF0_SW_RESET, HDMI_AUD_CONF0);
+	hdmi_write(audio, (u8)~HDMI_MC_SWRSTZ_I2SSWRST_REQ, HDMI_MC_SWRSTZ);
+
 	inputclkfs	= HDMI_AUD_INPUTCLKFS_64FS;
 	conf0		= HDMI_AUD_CONF0_I2S_ALL_ENABLE;
 
@@ -102,8 +106,6 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
 	struct dw_hdmi *hdmi = audio->hdmi;
 
 	dw_hdmi_audio_disable(hdmi);
-
-	hdmi_write(audio, HDMI_AUD_CONF0_SW_RESET, HDMI_AUD_CONF0);
 }
 
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 091d7c28aa17..a272fa393ae6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -940,6 +940,7 @@ enum {
 	HDMI_MC_CLKDIS_PIXELCLK_DISABLE = 0x1,
 
 /* MC_SWRSTZ field values */
+	HDMI_MC_SWRSTZ_I2SSWRST_REQ = 0x08,
 	HDMI_MC_SWRSTZ_TMDSSWRST_REQ = 0x02,
 
 /* MC_FLOWCTRL field values */
-- 
2.21.0

