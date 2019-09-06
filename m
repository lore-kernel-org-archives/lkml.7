Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0035208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iEbqIiTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404425AbfIFL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:56:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37392 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390079AbfIFL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:56:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so3380929pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGxlx3MKmlt/bKN9nc3Oi1GFJ80hfXJe1nLtjwmXCP4=;
        b=iEbqIiTQKpgiBJF2YBK8xmQsBjq8O99b4/SPFDO0jIo8BxTBQQxLeqtCJTy7afP6VL
         xebfwx3o9AaZdUGN4NhSNUU2ZMcKxhMoscCKUGZOCn+qv6ocWexd+MyP0rvFT/dSljXl
         YPgo7OG2X+xaFT8VF7yJ84DPifUCIe7J5A/so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGxlx3MKmlt/bKN9nc3Oi1GFJ80hfXJe1nLtjwmXCP4=;
        b=JO6ub2nQzl7sQKcMbdmsaRXwkvsbOOmZZSA6gpnmMWZSxokZp9w7ibGS4mM0QyDsQX
         fccIW7zDqZw3Ss7TAJ+eT54FqsD9vH42BMhE9BhIrdZ1D1S3sl6VF1S1mqiqGOS4nvT3
         R33xZux76ke18XTXbCAthjRTWXCNuo4ubwmfV+IVA6eoDAD+SZv1+4icaDC5PW3yBwyx
         JQarUIyXIDiGsnbkRrTaJ+uUUzjq9kooVxXmahrz4ptti96qXJ82wM54StwOEpVUn7+D
         rMpTSu1KNLeS0HIBX45udM2/f4khuwWEPUs9TQPFQVXn4qiqzTvySl7Ofhv4CLpE+zfB
         IZ7Q==
X-Gm-Message-State: APjAAAXf3Je1RVxarc4sDiO2Ixha85/WaVfo7sHFCFLOtp2uKPG7gwg6
        90/c9XJ75h9PEjO3tlLT/upW5w==
X-Google-Smtp-Source: APXvYqzL8UPBxmIuWjOxv5igGLxQuIVAl7t9p/BozL5Bqd19LANFyc9RLPLnp2L+3tE4UI1iLFGO0A==
X-Received: by 2002:a65:6546:: with SMTP id a6mr7868813pgw.220.1567770966375;
        Fri, 06 Sep 2019 04:56:06 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id o22sm3667394pjq.21.2019.09.06.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 04:56:05 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFC PATCH v2 13/13] media: mtk-vcodec: enable MT8183 decoder
Date:   Fri,  6 Sep 2019 20:55:13 +0900
Message-Id: <20190906115513.159705-14-acourbot@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906115513.159705-1-acourbot@chromium.org>
References: <20190906115513.159705-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Now that all the supporting blocks are present, enable decoder for
MT8183.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
[acourbot: refactor, cleanup and split]
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 7b4afac18297..cade24bfa555 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -393,6 +393,10 @@ static const struct of_device_id mtk_vcodec_match[] = {
 		.compatible = "mediatek,mt8173-vcodec-dec",
 		.data = &mtk_frame_8173_pdata,
 	},
+	{
+		.compatible = "mediatek,mt8183-vcodec-dec",
+		.data = &mtk_req_8183_pdata,
+	},
 	{},
 };
 
-- 
2.23.0.187.g17f5b7556c-goog

