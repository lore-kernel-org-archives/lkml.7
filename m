Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484CAC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2222A2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510365;
	bh=BOwvCVviHuS1yi7wXAMbRF92DV7o6/7cxfw9HudwqSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=utB+NTKxlR/kqwzqQ2lvF5UrCtk43sKqYWdKSB6A7ZirhT7Q1k9IB5eyyMl1ZiTId
	 NSEaAZeD3yTY6axxjWVR2qPuIpXFE8ukNLkRsK5r9Z0ndHIdlFp7w6HtC+Fl9oShR6
	 NX27ei8j26Jxr/TehYeAA2MJXEDagYEywqzYM0QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfGSEIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733105AbfGSEId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:08:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB40021872;
        Fri, 19 Jul 2019 04:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509312;
        bh=BOwvCVviHuS1yi7wXAMbRF92DV7o6/7cxfw9HudwqSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrlZaDpfkSMgF0j+QA7FisRrU4zRSe3XJMux3PlCwtOFJ2TgX6tQSzaOAVAjkSlJX
         i1J74jC3XjHFfFy1/ML0nOoMMsk/WKqWfsx9ZoxjseuR0pLf6xvZkFEd3x5YdWCkmw
         8BZ6zxDVHTw2rKbg30YTTjXQECJcb+8Z/eypZh7I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 028/101] phy: renesas: rcar-gen2: Fix memory leak at error paths
Date:   Fri, 19 Jul 2019 00:06:19 -0400
Message-Id: <20190719040732.17285-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit d4a36e82924d3305a17ac987a510f3902df5a4b2 ]

This patch fixes memory leak at error paths of the probe function.
In for_each_child_of_node, if the loop returns, the driver should
call of_put_node() before returns.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 1233f59f745b237 ("phy: Renesas R-Car Gen2 PHY driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 97d4dd6ea924..aa02b19b7e0e 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -288,6 +288,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 		error = of_property_read_u32(np, "reg", &channel_num);
 		if (error || channel_num > 2) {
 			dev_err(dev, "Invalid \"reg\" property\n");
+			of_node_put(np);
 			return error;
 		}
 		channel->select_mask = select_mask[channel_num];
@@ -303,6 +304,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 						   &rcar_gen2_phy_ops);
 			if (IS_ERR(phy->phy)) {
 				dev_err(dev, "Failed to create PHY\n");
+				of_node_put(np);
 				return PTR_ERR(phy->phy);
 			}
 			phy_set_drvdata(phy->phy, phy);
-- 
2.20.1

