Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA3FC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430836;
	bh=CQWzI7qtMVxhWNj/HKj6OxlBAtm6dzDS5xrpQ4IVqeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+jsTRPf2H/oCWUVFmj6brwVW0WjRo+8L9dmScskToINg9BTHMCLrMzFZdGQP325n
	 MWpgFxjf5rZw6jT7xg1TA6CRuBkclGQhP61WvPBW7BICSAdc+lKiHmNVw1p+g6CCzm
	 RqEzyZiAiIEO9g+7LLZtvhzAi9QOS3dpw4z+M7Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfG2UHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbfG2Tjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:39:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E65217D4;
        Mon, 29 Jul 2019 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429189;
        bh=CQWzI7qtMVxhWNj/HKj6OxlBAtm6dzDS5xrpQ4IVqeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0va2aWA8/zGNGFbj1PdBLTQeG3YmEy/+R2YjJXN0YXeQWksrE3+JwpZZL1/NmzVz
         l//EvusDZKV9Qx+BklAwS4roawbmEemSAlq4ja0jkLJwa0Owz0Zlu4uhjOuRNWNFKJ
         WxDhUk7GkwJcWaTlUFo3y7BYlSbkMI6E1Ir05Xrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/113] drm/panel: simple: Fix panel_simple_dsi_probe
Date:   Mon, 29 Jul 2019 21:21:29 +0200
Message-Id: <20190729190656.234251785@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7ad9db66fafb0f0ad53fd2a66217105da5ddeffe ]

In case mipi_dsi_attach() fails remove the registered panel to avoid added
panel without corresponding device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190226081153.31334-1-peter.ujfalusi@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..b1d41c4921dd 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2803,7 +2803,14 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err) {
+		struct panel_simple *panel = dev_get_drvdata(&dsi->dev);
+
+		drm_panel_remove(&panel->base);
+	}
+
+	return err;
 }
 
 static int panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.20.1



