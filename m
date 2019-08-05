Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47663C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177D620880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z4GCLa3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHENlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfHENlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so84466077wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcxCUBbmcFwMvFJ+lzmbbweMssQIyjYeLgMmBVzMwco=;
        b=Z4GCLa3Qh6Rov0aWhoMvXszTGWjElSstDzL3OKiiBUS0AOCza+chFFm6WBkjsSUjF2
         m7xOnP1W7oEWspJ28voCXaybtNQT7tTsqqFEx7HvTKUAU3fYoR5vFmub4pqLSkJuo3oj
         mBEKL2w8yl024pYq1sCrC4thtkyQj4cTSdS8GOVPllKzjIeuRMOggkUldGnwUXF6GpcE
         iIi51y/TCARESONkSgnKt7lcAmDGBYh9N3T7XxaRVjeyf/XpaYzK2Aou97XfpPsfE5C8
         7aMp3MHGEMwqTxBVSR/K8yqp3Iha6fOWk47mwTZNgm/mf5wWXhqrJXwWnoQZaOfGuF7o
         qNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcxCUBbmcFwMvFJ+lzmbbweMssQIyjYeLgMmBVzMwco=;
        b=TDjKQSdzXQy89QHVafZ+sgr7IMWvAc/xc4MjwQT+0//zbyT/s6xF4rYHN9mUbI8j/J
         WZHpil8LzgDnWqHfQVaZc70k/1YqUO/EtZQQknvo3ZboMviigJ0OCsDQk2vVPHN+E0cd
         8yDuTACFu+U45FR5p1DoTE00ljkLA+5DMs5VnTxpA059uak4gSrLSFxJTfYZreLuRnTp
         p7gQRaDWE5+SvRNMmXdKpZ+c25Dg2rM3OO6QJJlDQ00lFWUbLaeGM3/6Op4ghKwWroQQ
         5DEiMK/Lnb6ug/o1/YZopQqdATyJyq5mhH5lhHzM/CQGplR2p5xc7Bf88vp4kIxDoLwP
         mWVw==
X-Gm-Message-State: APjAAAXsT1lQ3Mf5k9eKOAacSCEDanHB/D6LLOUvwNY7f9HMJx6kSpc7
        VBL4Z635A1HW12PkCScxcslE4Q==
X-Google-Smtp-Source: APXvYqyIqNSpPNxgzAYWIGhNEn2TMUn6UT0Sy9FMytw7EErfFGJd/kNAO6/hg23/W2fym0jSst7kqw==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr157062902wro.60.1565012470500;
        Mon, 05 Aug 2019 06:41:10 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/8] drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
Date:   Mon,  5 Aug 2019 15:40:58 +0200
Message-Id: <20190805134102.24173-5-jbrunet@baylibre.com>
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

Properly setup the channel count and layout in dw-hdmi i2s driver so
we are not limited to 2 channels.

Also correct the maximum channel reported by the DAI from 6 to 8 ch

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 2b624cff541d..caf8aed78fea 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -84,6 +84,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	}
 
 	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
+	dw_hdmi_set_channel_count(hdmi, hparms->channels);
 
 	hdmi_write(audio, inputclkfs, HDMI_AUD_INPUTCLKFS);
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
@@ -139,7 +140,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 
 	pdata.ops		= &dw_hdmi_i2s_ops;
 	pdata.i2s		= 1;
-	pdata.max_i2s_channels	= 6;
+	pdata.max_i2s_channels	= 8;
 	pdata.data		= audio;
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
-- 
2.21.0

