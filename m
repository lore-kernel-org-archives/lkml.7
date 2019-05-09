Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2420656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428385;
	bh=PF621POxl96TvW8L1WHZrw/qawrY+87wek/Aifqu8ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtiKemdjwaSoby1/XelbjlUXEzaN/MedRCh+5olhj9RnYMAD42zUe93g+gc+3VVrg
	 NdtzWUIu84xvJdjDXtHSgnD3yoKCh+0y8ibYYrU0+kbUIPEVb2NhAnknQvyQB8j6HP
	 diD3yuSliVxjlQXrN4y+UWDktKfOaS3Q0OD9BX7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfEISwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfEISwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:52:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F73B2182B;
        Thu,  9 May 2019 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427927;
        bh=PF621POxl96TvW8L1WHZrw/qawrY+87wek/Aifqu8ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaYvIY4HKf2RBK6K2qXPcp6lhptw1M1dBNcMe32D8REPjEFPqUsh4O1/0wY3mH9NW
         7Uxcr/0G4sg6nwGp6T9Z9DVud1iDn47dVl34yu652mABxEYxprlOwqfd18dLZ1WJ/F
         Om5tHI+/pObbcY2UH11vFXhK0iotNWbJQqPkaqK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wangyan Wang <wangyan.wang@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 56/95] drm/mediatek: fix the rate and divder of hdmi phy for MT2701
Date:   Thu,  9 May 2019 20:42:13 +0200
Message-Id: <20190509181313.421305339@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index fcc42dc6ea7fb..0746fc8877069 100644
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
2.20.1



