Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A840EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E2B2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739229;
	bh=gcPTCB6UpU4DCzvcOK0j830FQAAPxgXOUQAdiBKoRKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CR3GCV0S5lbXrUIz4KvNOPxZO7a80PVYysesl71evas75XfEsf3IyFYpxQQhxRaqv
	 YsaqgPAiDqmy6dK4J7103oxPKI+JO9+5zL5WPrNvKCDRc/Tm1FLV6s4g2eQLPPXDvm
	 m6k3N3kOt0rxtaMFP7uIRPEYo3XF8UorGnz6vOd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405638AbfHBJrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392087AbfHBJrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:47:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D4120880;
        Fri,  2 Aug 2019 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739225;
        bh=gcPTCB6UpU4DCzvcOK0j830FQAAPxgXOUQAdiBKoRKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sm4OrvxaeDZC2h9/7F5iiZCa95cS/zgsxDYRu3x1SXtTFQXdt39UJLHh3UKB2UsCh
         R52z/m7Fqdih5NCjzgBoTgy7w35X2lG2ZbVSdZx5M1dsflfnrz5FF2doELQQ2g8Ej/
         K2fuKI/EV/5n/S/BW1yWBBrWJt1V+Up2weDRYq/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 159/223] drm/panel: simple: Fix panel_simple_dsi_probe
Date:   Fri,  2 Aug 2019 11:36:24 +0200
Message-Id: <20190802092248.550530661@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
index 5b2a9f97ff04..68a2b25deb50 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1944,7 +1944,14 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
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



