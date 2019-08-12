Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D026C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60420214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mj7VPqoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfHLMHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35450 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfHLMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so11550234wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wxGGO+eJqHNHPL320ZApEdBEJuHkt1WmWaw3TLqcWg=;
        b=mj7VPqoP3QaypYZk5wdhlVro9KJGAVFvrtL+ktS1443PAbjOUKqGny5CD/pIW5bwl3
         By1MKtNas4S3X0b1lwcmcLVPc6255JAMYCn2iAraSMcyV4K1BbTH0G1SSb5cO4QVt+hD
         7bo0J0Rjcv/ydPYjs+WmXR64f7gXNpqVUx/3b6/+ynaviRLMmGPtlmvf6dyKfzSU3KPx
         yca4gQRCBh1PJ6440JPgr8bKQwOzWTbTmuRNmO1rdoCENmZzHLT6Wp2piNEN5PPokr0Q
         Kv9ujN38fe+RAP8cys4QHft3PyKqgD//+9PLkzVbz8jj/GxP+gsIN4pIpWPsAdxDKmtn
         WG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wxGGO+eJqHNHPL320ZApEdBEJuHkt1WmWaw3TLqcWg=;
        b=NnC9xqOA3ndXd6Eoru89fHZjHaKK5SEy2h9DADWR06c0goCBlf8+zu76mElyl9MEWG
         XWVCSC/yIYouSOMTdxoGU2ndEMu6Xa8EfwNKHwUrYt5F49lLtdJ/tnicMcSkzpJtzs9W
         yY+JKu63Fq7sdzM5/5wEjjrsyyFhO+MaIcSfxSS9Udtp0V32JdlMTN0dfUlIbTRG0RC3
         AEjTBJr/yg02rVmf4rehUgqOdod67ASVUaYkh9oWm+gDRXAMHIVkXDsPSOXw6UfDYg2r
         nw4QOeD5RHVlWFI6WwepBtUaxk/9A23ORJc8Qd/yHHjuvOmw9jBops4pd/mCNKuEF9Gq
         DPCQ==
X-Gm-Message-State: APjAAAW+HelS3h4HGO+tsOX2hbxx45HPVQOTtkryszSx/JuFRHvJm3Ub
        cCsaUvRhQduudBFpqrWjZh5bhcjgUds=
X-Google-Smtp-Source: APXvYqx9z2jQLFkDizV87BtrLYpHzdRxjWMpEtJKKyo9UUrpvSaOAgtLfuCnUIKtDmf5rpfXp8NLWA==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr7473128wme.174.1565611653536;
        Mon, 12 Aug 2019 05:07:33 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.32
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
Subject: [PATCH v2 4/8] drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
Date:   Mon, 12 Aug 2019 14:07:22 +0200
Message-Id: <20190812120726.1528-5-jbrunet@baylibre.com>
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

Properly setup the channel count and layout in dw-hdmi i2s driver so
we are not limited to 2 channels.

Also correct the maximum channel reported by the DAI from 6 to 8 ch

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
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

