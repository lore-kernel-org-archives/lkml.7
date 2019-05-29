Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D44C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFF62070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cuhppf15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE2K0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:26:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41308 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfE2K0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:26:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so1339285pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcCSMOQNkzGaXhDk0okGAy0XqAbQi4G2u6aLWlPaPBw=;
        b=Cuhppf15fgs+ro5fQzou91thI1XLxU4KioJr8st6A+3rShMcYV8fSqZOp424wsNyS7
         Yjt8ZDWKI8t5jY8/w/olvN9NejpmeXI58p0vNnxcpidO9I9OYs9PLq5hcAy2JUfwloW/
         0z63BUjUnVKb52ngcrkoQKYOWPV2zpLSKFZpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcCSMOQNkzGaXhDk0okGAy0XqAbQi4G2u6aLWlPaPBw=;
        b=GA1pfKPoZwowsehaq6GCEmF3pqmtFXMxKahPkfZhzUGPMHx6GfQs5qY8Q+C+PwYVFN
         TkbgP+r2qrmL7tjFGySP1PNa4Va2jcRkLAwmQKN3LuSxhbeENCnsknibA4jGfp45NM/C
         RahWXZvBzj7NOSAnVq+/yY+kNGF+gsLIi7j6sJa3pnWTSED8fIVCUXHdUKUVuXfsZ7km
         WgMiEVnw5woHS0c8GrscAyz3qqB4KRMonATqmj+BwbdxUlmGbHxNMo744ADAAKeJms3I
         kJxxNTiLKI0EXClbEd3IjlfOPzPXzViItzOD04Ew95NKCkxrMLjOoxUogXV6UUtD09Lb
         Dplg==
X-Gm-Message-State: APjAAAXZrVXfUI5E1suJzxd3Ivqz+3RZh4y8vuJl12257Ni0/0nbx0K1
        6t9Egd0YJkpw+z+joOv6yfUipA==
X-Google-Smtp-Source: APXvYqyyaROmC37HXAcccgz51No+HwGj0nRGT99eAspxv1IL1mnTD2gRQ1iaLO7Rvi00xcw+ddOyEQ==
X-Received: by 2002:a17:90a:ac0d:: with SMTP id o13mr11037075pjq.139.1559125611164;
        Wed, 29 May 2019 03:26:51 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e12sm18992183pfl.122.2019.05.29.03.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 03:26:50 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm: mediatek: clear num_pipes when unbind driver
Date:   Wed, 29 May 2019 18:25:55 +0800
Message-Id: <20190529102555.251579-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529102555.251579-1-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_pipes is used for mutex created in mtk_drm_crtc_create(). If we
don't clear num_pipes count, when rebinding driver, the count will
be accumulated. From mtk_disp_mutex_get(), there can only be at most
10 mutex id. Clear this number so it starts from 0 in every rebind.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8718d123ccaa..bbfe3a464aea 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -400,6 +400,7 @@ static void mtk_drm_unbind(struct device *dev)
 	drm_dev_unregister(private->drm);
 	mtk_drm_kms_deinit(private->drm);
 	drm_dev_put(private->drm);
+	private->num_pipes = 0;
 	private->drm = NULL;
 }
 
-- 
2.20.1

