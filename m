Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27553C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDB1204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599605;
	bh=sPVPPiEdBs8cIFFYOwY35V18E/lKu/yk89gJo3EqV5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akORocHTNMdQtyv4GzE7zIeRWKs9KBqHRFlUFwovz2UwnqzAzkhnpLQ2YbSV4HI/1
	 gMKI5gvdQHRO1AIM8h/KMKv4njU/0CDYrqK6aeR3KRuwVuHZrFbhmHyzCbQC4lg0wy
	 RwPCa5k6vMX2NcmtfaeHsChOGEnpnvAFq1emEZmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfGHP0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388881AbfGHP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:26:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283C521707;
        Mon,  8 Jul 2019 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599599;
        bh=sPVPPiEdBs8cIFFYOwY35V18E/lKu/yk89gJo3EqV5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBeN0TxmnpvUprTCt5GlqFOEsvSOSdoqTno/3dzgwriqBAi8kQDuNzQ6bJXTSqKF0
         VWSIUOQfelltLRgiV0ENgBKosqlrlrxqrDmIs/P8tf84yEo2eHvxtO7YHjfCQvqSXU
         C+N4RM2ad8MP75rS1vz77NK5DNQs0pz4droK+SFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/90] drm/mediatek: unbind components in mtk_drm_unbind()
Date:   Mon,  8 Jul 2019 17:12:41 +0200
Message-Id: <20190708150523.324776117@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f0fd848342802bc0f74620d387eead53e8905804 ]

Unbinding components (i.e. mtk_dsi and mtk_disp_ovl/rdma/color) will
trigger master(mtk_drm)'s .unbind(), and currently mtk_drm's unbind
won't actually unbind components. During the next bind,
mtk_drm_kms_init() is called, and the components are added back.

.unbind() should call mtk_drm_kms_deinit() to unbind components.

And since component_master_del() in .remove() will trigger .unbind(),
which will also unregister device, it's fine to remove original functions
called here.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 47ec604289b7..bbe57ad9acf1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -390,6 +390,7 @@ static void mtk_drm_unbind(struct device *dev)
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 
 	drm_dev_unregister(private->drm);
+	mtk_drm_kms_deinit(private->drm);
 	drm_dev_put(private->drm);
 	private->drm = NULL;
 }
@@ -559,13 +560,8 @@ err_node:
 static int mtk_drm_remove(struct platform_device *pdev)
 {
 	struct mtk_drm_private *private = platform_get_drvdata(pdev);
-	struct drm_device *drm = private->drm;
 	int i;
 
-	drm_dev_unregister(drm);
-	mtk_drm_kms_deinit(drm);
-	drm_dev_put(drm);
-
 	component_master_del(&pdev->dev, &mtk_drm_ops);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
-- 
2.20.1



