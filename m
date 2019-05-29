Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACBF2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nTovKIIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfE2K0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:26:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2K0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:26:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so1124477pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qfu+lCX+mg4CHoSzn6sx71PO1L0xmj8Ng2bghmWxVtM=;
        b=nTovKIIjyeNQQu+BPV60MWd+6ikmDz5CTYIk7CO5q1I9JxYa/Y2hi1UEa7N1uc53tJ
         0Ml03crB3KYobulpw2zmaJAB4YPE4Y1W1VCWvM74IWI/JBAFlblmjKqTrMCg0ajk1wD7
         xGj5Gl5TJoDwlMuNXDh+oCwzMlUvgpwT9stYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qfu+lCX+mg4CHoSzn6sx71PO1L0xmj8Ng2bghmWxVtM=;
        b=K2zqFql4xN8WoDZdUr/99IldWOVKVwp5vasCYVpq48aMjeQ2JUaFOZJ2p/fodZIZ1i
         iOUb7gE1OIv8OLgviX+iFJF/wjFPbS3IwFrJdHPWRRk88Eo1nySOFcB3hm+Ke+fl0ku2
         2EeagVAs1Ug/yU/94aUTOvo4ailZHE3pPDiquBwSt57qELCSUNk+B3DKGRer00h7oqh1
         xiWXnR1w2AvPtt3go6RvzSCduNC5eBnCze4e2c9Lf2OamWLNZhbniKp/HTOvsUPgV4IH
         FCsQNObbMzM6OjoW7VLHCaCueWJhFe+iEh/sPP3/3uptRk9nJVCfRNcBc94l6naarmal
         ePKQ==
X-Gm-Message-State: APjAAAWKEn7OFzCDJJV2+Ikp5M5qYyz+btiozGgoSNf6njfw4ODfwIWJ
        W6Ytys3UisILXrjJvSyzWnZ9mg==
X-Google-Smtp-Source: APXvYqwsCTf8MIeFhkI7oHCKHu8V4WhT0bsggX6aKGiM/Kq0hphXwbIVOk7WcOZTuamgoCEOW8/5cQ==
X-Received: by 2002:aa7:83d4:: with SMTP id j20mr129161356pfn.90.1559125605031;
        Wed, 29 May 2019 03:26:45 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e12sm18992183pfl.122.2019.05.29.03.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 03:26:44 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm: mediatek: unbind components in mtk_drm_unbind()
Date:   Wed, 29 May 2019 18:25:53 +0800
Message-Id: <20190529102555.251579-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529102555.251579-1-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
change log v1->v2:
* separate another 2 fixes to other patches.
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 57ce4708ef1b..e7362bdafa82 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -397,6 +397,7 @@ static void mtk_drm_unbind(struct device *dev)
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 
 	drm_dev_unregister(private->drm);
+	mtk_drm_kms_deinit(private->drm);
 	drm_dev_put(private->drm);
 	private->drm = NULL;
 }
@@ -568,13 +569,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
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

