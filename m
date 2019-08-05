Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52592C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25684214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XY6BtsEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfHENlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56082 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbfHENlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so74795131wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2grGK+7b0cBByVRRUu0+TFl4ki5jcSq2t6fD2bzIBcg=;
        b=XY6BtsEB1h0Gtg+bL5p1xMMozbLebyArx8o4E98A64UfAQwGnp5hTTSwxO3wBSrqNs
         sjtDhqO4sss6ywReivGGAP6VbBnP2qbrBZ5RDcxsWDX2P+Q9CaAIWgOrJZQHEH+twJPE
         C/kxG+bLpg59JjLS7HcM/K2Pehm7/j8fiXU6UnxOoJr101ja8u28RuDLs8CT+zvN5Rvg
         2Ns0saVhFskKwefkeTaCx8x6mDEL08r4MclXBIMcTbDgbjKDJp0E1Nz+mXzDNqVCTsRy
         fUbTPcQbKGuYauyamy2q/FlnfnOy4z8lWR0PNpP7fonXJu8qTymVLyzDNFJJVjFG2kGu
         yZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2grGK+7b0cBByVRRUu0+TFl4ki5jcSq2t6fD2bzIBcg=;
        b=ZMu/g/4uZ2JYXJIfDViAxZb/BwUkW8niLhJwWH1zKsta+B20aQ2LIUyBHZrdm704/5
         2jElQZrb18QBpKQqYaFWeDI3mJPs/bPVYEuCCKiclI5cpgL5lJNUNAvqsfqMZPCmR5ei
         AUQwvryRoSTbiWEz5Ply8Mgold41lEY1yqNRNfewiEIUW3Jwx1w0H77cTxODVSqI3s4U
         1aw0rUm60O+Q0QzoP5KZXmw0GHDdOBtvdrd23WDLdABQ/28Y3eeAbNM2c1oPeU6hMxiS
         aTEtNZq/g0mROYUlby7HbVHtJ1L+k/Cn3pKe80Y1DnY34RnbKcmr5fR+ODEcRQA3dErC
         rV6g==
X-Gm-Message-State: APjAAAU7pi1IEmSECNEA8X7zJG8vPOwWiZ8xENAgB/4Tj+epCv/D6xuN
        gF1lSaBnDJzzQJ1PXBsFTdVsfQ==
X-Google-Smtp-Source: APXvYqxCpcovHfHjK57i7gHO5E0iPm5URGttLvaapaIyenpv0N3qiZvBMVpLedY5JPKCE562WeBNtg==
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr19275733wme.146.1565012471772;
        Mon, 05 Aug 2019 06:41:11 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.10
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
Subject: [PATCH 5/8] drm/bridge: dw-hdmi-i2s: set the channel allocation
Date:   Mon,  5 Aug 2019 15:40:59 +0200
Message-Id: <20190805134102.24173-6-jbrunet@baylibre.com>
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

setup the channel allocation provided by the generic hdmi-codec driver

Cc: Jonas Karlman <jonas@kwiboo.se>
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

