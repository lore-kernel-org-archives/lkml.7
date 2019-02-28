Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AAB206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367241;
	bh=zyq62L1mryRzzM1DQy918E6cRZ6DJBVlu61IPLSzpCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HzNXnYW6eEZHivEIE5uX2h9bXGoMz1zdksyxJDJLspv+oDtxH2PEoYerU0GKfl3sd
	 2J60JYWjhKmY1Ge6rGSLzXPRKInwi/4qmPo29PajDwaE2+AZmXRdCxARXAwvJOseCe
	 p5Kj4LemKK6yq5Nb/JyiclFPHQZaU5x0rbEoKDF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfB1PUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387496AbfB1POO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D718E218D3;
        Thu, 28 Feb 2019 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366853;
        bh=zyq62L1mryRzzM1DQy918E6cRZ6DJBVlu61IPLSzpCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmbSVr7TPCNco0CrBVofexQ9b76fRTQ7UPzikC95SVdvbvtXmhIPOH47r8wQk7O6E
         YYJ6Cqd5C20JblH2U9ATJ/4cHr8P6glbmYV1Z+Qdq3ROtHfnDu8w/vZI7FM3hPY6K8
         3qho/9fVixOc5GnjWGEtZPWnWBhe+JSRILSlJnH4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 20/36] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init
Date:   Thu, 28 Feb 2019 10:13:21 -0500
Message-Id: <20190228151337.12176-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit b14e945bda8ae227d1bf2b1837c0c4a61721cd1a ]

When initializing clocks, a reference to the TCON channel 0 clock is
obtained. However, the clock is never prepared and enabled later.
Switching from simplefb to DRM actually disables the clock (that was
usually configured by U-Boot) because of that.

On the V3s, this results in a hang when writing to some mixer registers
when switching over to DRM from simplefb.

Fix this by preparing and enabling the clock when initializing other
clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
apparently too late and results in the same mixer register access hang.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190131132550.26355-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7b909d814d38c..095bd6b4ae80d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -371,6 +371,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 		return PTR_ERR(tcon->sclk0);
 	}
+	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -385,6 +386,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
+	clk_disable_unprepare(tcon->sclk0);
 	clk_disable_unprepare(tcon->clk);
 }
 
-- 
2.19.1

