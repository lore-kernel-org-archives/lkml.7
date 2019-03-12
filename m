Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC367C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7D821741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410830;
	bh=iu/rx8+smMhE6V1ipDV2sxibTpts0WimzCH18VioIx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yx0NdKcEZSFCv/WSsKMVrTP2LqWmvPwU1VmS66JIikfEgMMK8ZPRUqIJ41Twdw1K2
	 UPIs0MG5IjH6sEW+19kdj0pEcwXtN0Fpn+qWaqqezp/lI+z8cZuxd6jNIxHl7Z5gCT
	 jKjz21uIBbIZ2aOWYLMcBDp9fuYSUCU2cRxMlAAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfCLRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfCLRNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:13 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85EDE217D4;
        Tue, 12 Mar 2019 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410792;
        bh=iu/rx8+smMhE6V1ipDV2sxibTpts0WimzCH18VioIx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCX3VVGaXO5mGZajuNN1k2NiYJXjGjZBtzryX6b4Ysddoru7AWogDis1luHtVHqj/
         6U6ZDSKSHMkllp6QW/CpBTxT7518f9AIPuexxKF7W8IldlyhhpPPgbXLrND0hgP6HV
         Z8Uh2tR9OOAdqHGAkHjWkUVSPuu9C3hD7r9fUPuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 137/171] drm/omap: dsi: Fix OF platform depopulate
Date:   Tue, 12 Mar 2019 10:08:37 -0700
Message-Id: <20190312170359.482790895@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0940c52742de0d2f70ba687bfd5fe8aa38c5f27d ]

Commit edb715dffdee ("drm/omap: dss: dsi: Move initialization code from
bind to probe") moved the of_platform_populate() call from dsi_bind() to
dsi_probe(), but failed to move the corresponding
of_platform_depopulate() from dsi_unbind() to dsi_remove(). This results
in OF child devices being potentially removed multiple times. Fix it by
placing the of_platform_depopulate() call where it belongs.

Fixes: edb715dffdee ("drm/omap: dss: dsi: Move initialization code from bind to probe")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190111035120.20668-4-laurent.pinchart@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 277f9dd2ec8c..b5685018d830 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5104,8 +5104,6 @@ static void dsi_unbind(struct device *dev, struct device *master, void *data)
 	dss_debugfs_remove_file(dsi->debugfs.irqs);
 	dss_debugfs_remove_file(dsi->debugfs.regs);
 
-	of_platform_depopulate(dev);
-
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
 	dss_pll_unregister(&dsi->pll);
@@ -5457,6 +5455,8 @@ static int dsi_remove(struct platform_device *pdev)
 
 	dsi_uninit_output(dsi);
 
+	of_platform_depopulate(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
 
 	if (dsi->vdds_dsi_reg != NULL && dsi->vdds_dsi_enabled) {
-- 
2.19.1



