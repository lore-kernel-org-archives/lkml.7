Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E036CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70622070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mNMl2dhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2K0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:26:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2K0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:26:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so1115138pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GljBVRDvAaH/DkyFnuPUvDqT8RdA5gdVzG7vblp3VSs=;
        b=mNMl2dhA55pEBfDmm0KYY9HDhLUN9zY4R63Yol5LQp+MwaFD7w2xzRvbqvz1bFmf+u
         DMMZb+kETeAeYx2gPM9SRZ7DPKmUaheDn/YR7VfsXKXG2lpbc40nBCMhX7A6Ohts1pn+
         kQiTIf76xeLlGk7d20NTCAZHzJA0ahlyXY/oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GljBVRDvAaH/DkyFnuPUvDqT8RdA5gdVzG7vblp3VSs=;
        b=F9CJ0eXw5Ny2P6TUbbFF603blt+76xI+vA+5qm764pQBzns+A2zkxWd9FS+HRo6no3
         KKhf/79iegy7b8yJljApiCCNvErtpFlL6RwGMQY+wRkl/lUUvgX3XG2e7oHITcmzvOQF
         SweGHVckA081Pl95dIdqt1S9/6bohHXDfT4Pw4b/LDi6hTI8XTsfFQKWSZt2RJMn5Dct
         pYfv1YBikMDg5v4uMHAlTxsKoVFE36laVvq0T25ex4PFShYJWH3R1DHBdLtz738OK8bu
         gcyKvzMSyqPq5M/pL4e88C7Nvm5jIL1XScwdn7iG1FqZss+DLd+zipQVivJZdDw4p7lb
         XNUg==
X-Gm-Message-State: APjAAAXi2JwYUtp4/s01pabdV9+NYma0Pul6yBjTgzXJzxvk4ybf8FW0
        X1zsu3E7dhSE+7UhhIDVbe0kFQ==
X-Google-Smtp-Source: APXvYqz6GR4WNNXNVVY8FlZIz1QqWpoMlEteFKEd2dOX/waMt4VxWQVOVp9NyvwarqjmG8cnhKaspw==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr57398728pfi.135.1559125601694;
        Wed, 29 May 2019 03:26:41 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e12sm18992183pfl.122.2019.05.29.03.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 03:26:41 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm: mediatek: fix unbind functions
Date:   Wed, 29 May 2019 18:25:52 +0800
Message-Id: <20190529102555.251579-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529102555.251579-1-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

detatch panel in mtk_dsi_destroy_conn_enc(), since .bind will try to
attach it again.

Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change log v1->v2:
* mipi_dsi_host_unregister() should be fixed in another patch on the list.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..1ae3be99e0ff 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -844,6 +844,8 @@ static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
 	/* Skip connector cleanup if creation was delegated to the bridge */
 	if (dsi->conn.dev)
 		drm_connector_cleanup(&dsi->conn);
+	if (dsi->panel)
+		drm_panel_detach(dsi->panel);
 }
 
 static void mtk_dsi_ddp_start(struct mtk_ddp_comp *comp)
-- 
2.20.1

