Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2942C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FE32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZZd5Ns67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfCYOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCYOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so2410176wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52hJFpx6eea8OG1nyjqevGtis1G8l6iyh9Mvzmr0/WY=;
        b=ZZd5Ns675Fv7SdJvWPaG+nkFLB2qG19pTCqrUmN9Jxk3tnH41x+ixgP+zSAyKAsAvh
         15E1gu1hZ1S2P61LZ3KO5SNr40sI83/YhN5R2VYBnj4a9BuReS3zA2h3TWi9OUnBKAKN
         9acAdQRbl/JUWBCWRYdeMCbVn/eUgbAMPLIdY1yp3FortWoR8BxRSCNNLj9oOQlIYdd2
         I6OJfcvZhSOgA+8KTj/dgvx0hifNnl+8LlPyGDBK+gFctxwLc6sMQN21RnFR8M+u/ocl
         SORKNC1Pw/aMyHyVCmOAsQ97wWO0JBf5/1vAbDkaXwoCEpSNKPUc3w+t8aAl3zlD40ma
         g4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52hJFpx6eea8OG1nyjqevGtis1G8l6iyh9Mvzmr0/WY=;
        b=WnJG5/J/ZXBCP6ZoDC7NlLY5uc8BZSrI1DD0cFQy2tF3Ic8aHOpyY7qZRvUEQcGpvU
         plw5bub73NuD13YcwuENS16GGOMi6moN6RLb7xh7pYfW2AFqFPNzbDUjynas6ZRTPTGd
         4qtA2kIiKwCOo6Q2p1legdJikGHgxAuLB76O8lcc3AcmwYrIZJ+K4fVSFD8iuk//srAo
         TB+uJyBxsraRM04Wibjb5m+dzypHECO9JBMM9GBBzuvfvMlSJBNa00KY9iwSUB0M6Y78
         Fi9tyRcOUaVhFmEA12cRpEh9LM3cFCC4evY+sBNVySQD6bsuMHdvlV03PV2Lt6J7owAA
         /u+Q==
X-Gm-Message-State: APjAAAUtHsbPUkWKn0DAuS6OY1mSacadZgxR1htsZuEVgAzSzbyCX384
        m00JGthg1Jo0U/WF+O9sKRe1cw==
X-Google-Smtp-Source: APXvYqy+TZCnTHBwrMnEw0i+HlNS+c2Blf1SSeOJiBn4jfPP8LPPlJdLeO6T4Z4xb0lJugstgJelCg==
X-Received: by 2002:adf:e443:: with SMTP id t3mr16880535wrm.257.1553523508828;
        Mon, 25 Mar 2019 07:18:28 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] drm/meson: Switch PLL to 5.94GHz base for 297Mhz pixel clock
Date:   Mon, 25 Mar 2019 15:18:14 +0100
Message-Id: <20190325141824.21259-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic G12A SoC, the 2,97GHz PLL frequency is not stable enough
to provide a correct 297MHz pixel clock, so switch the PLL base
frequency with a /2 OD when the 297MHz pixel clock is requested.

This solves the issue on G12A and also works fine on GXBB, GXL & GXM.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index f6ba35a405f8..c15a5a5df633 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -396,8 +396,8 @@ struct meson_vclk_params {
 	},
 	[MESON_VCLK_HDMI_297000] = {
 		.pixel_freq = 297000,
-		.pll_base_freq = 2970000,
-		.pll_od1 = 1,
+		.pll_base_freq = 5940000,
+		.pll_od1 = 2,
 		.pll_od2 = 1,
 		.pll_od3 = 1,
 		.vid_pll_div = VID_PLL_DIV_5,
-- 
2.21.0

