Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD117C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A0205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330017;
	bh=NCwoF7RpMP3K9FDSLeQAjDNsqLvFiV9zOfLGm7HZl1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AShB/9565whXLWNXqI2wF/Va+G6NU0baw0zaoQ7C6RIZipZLqKuI3u+PbW9Yc7yj0
	 Bm8m1MlKzxinPKi/30GpjXpdrP8gyNoPj/WAdoDdiMVfGJ1OKt07DD4z01+7GRKCnT
	 NgXYuOSFZD3drQSpnSbhTDc+iz4RHzYNrS6FVZyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfD0Bxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbfD0BkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1297B20C01;
        Sat, 27 Apr 2019 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329203;
        bh=NCwoF7RpMP3K9FDSLeQAjDNsqLvFiV9zOfLGm7HZl1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XA2bgg3GR/C0/1nAAhwp2rsgwwFP75wnCwM+OzqEB80NctcdR5qg/D3vEiUK04s3J
         yCke2SicXkXX5GfB7hgbFPL9cVCCUsUC1TtTnfhmX576fixh/2WZayZO0D7Q4dn8nd
         7RlHK5uPLBAMvVS55TCSq2gr0C31jQJ1frCcHMOo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wangyan Wang <wangyan.wang@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 55/79] drm/mediatek: fix the rate and divder of hdmi phy for MT2701
Date:   Fri, 26 Apr 2019 21:38:14 -0400
Message-Id: <20190427013838.6596-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

[ Upstream commit 0c24613cda163dedfa229afc8eff6072e57fac8d ]

Due to a clerical error,there is one zero less for 12800000.
Fix it for 128000000
Fixes: 0fc721b2968e ("drm/mediatek: add hdmi driver for MT2701 and MT7623")

Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index fcc42dc6ea7f..0746fc887706 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -116,8 +116,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (rate <= 64000000)
 		pos_div = 3;
-	else if (rate <= 12800000)
-		pos_div = 1;
+	else if (rate <= 128000000)
+		pos_div = 2;
 	else
 		pos_div = 1;
 
-- 
2.19.1

