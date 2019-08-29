Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D0F2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRwJYrUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfH2J3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:29:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37251 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfH2J3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so2681132wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txsHPtmH/4H2/WnX6EiFrXzeHkL+qrKcHt+2DoU5kzQ=;
        b=xRwJYrUXbrpjGAWB4+R5fH7G0mRDkrSB5nnGWG4+zYs587hY8Cesq2JqG0vUTu0shm
         5pkphlWZMXlMveg2S4oPS4BdCQp2Mnchh4Ih0wV4GdImugyPNv/ZM0MA3she+V9WXGWU
         BIretLX6+0BXSa3pOq9OZv9oxXVx8pLDf9VNglZBXBTOuIjqJQ63fAQnH8yB/WoV8lxJ
         Q7aWiOA/e79K4dnGQJ0uBooFrp4oD2jiMo/YosYL+IqpZRMk9m18+GjoTP70snfB5NND
         zZadvljCyol2fsr5UIoZl+vVT1xk+csmPx3MmyUoosgeuNBmiciKo4MlvIDgOc+ntJ54
         g+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txsHPtmH/4H2/WnX6EiFrXzeHkL+qrKcHt+2DoU5kzQ=;
        b=JoOMD5mvQWjDODTM1P6b747gH9+OquTU/qIXlMu3pStd/NorkFIdv53U7u6p+5YZ2D
         oZFmBE8RlZtyPfXPktW5h1rFr5zW6tTYFu+65nFPx3cDmQx1Xwy7WF2KYpC9cs1EJyKH
         VlXS/K1MiAnbP76YMcmqXJSZQTJI/tTY1//MLJocnI36SZqpQzbzL0AE3QUy2Av44PRE
         F5pEcj/NXguwzFQvm0ufTIQLOMHiMzn4xn5Vc3PHSLuOO0QMtp/yyiOIbregdUeSrxLf
         vfdhm8kkusTFmZEA7zQgk1a7KV9bTp3MMZgtWwU2Kk1Z1fPrzoSDGmc0fbxu09FbwnDK
         r4uw==
X-Gm-Message-State: APjAAAXTzFb1B2sr3jR3DUOjsm+TkspjZZPA4aVZxsRSSXVT5Qn4KKhG
        Dq6+Y6PhHxu3NHSdo4g7jswIVA==
X-Google-Smtp-Source: APXvYqwa7mal8tlwEcN4Id08ifjWX6FoVuVJXnw0+CZOqbxdmTAIG4v5DwpyXEOi1YCHISMEsJCWnw==
X-Received: by 2002:adf:a55d:: with SMTP id j29mr9662074wrb.275.1567070980206;
        Thu, 29 Aug 2019 02:29:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f197sm3609512wme.22.2019.08.29.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
Subject: [PATCH v2 5/5] misc: fastrpc: free dma buf scatter list
Date:   Thu, 29 Aug 2019 10:29:26 +0100
Message-Id: <20190829092926.12037-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma buf scatter list is never freed, free it!

Orignally detected by kmemleak:
  backtrace:
    [<ffffff80088b7658>] kmemleak_alloc+0x50/0x84
    [<ffffff8008373284>] sg_kmalloc+0x38/0x60
    [<ffffff8008373144>] __sg_alloc_table+0x60/0x110
    [<ffffff800837321c>] sg_alloc_table+0x28/0x58
    [<ffffff800837336c>] __sg_alloc_table_from_pages+0xc0/0x1ac
    [<ffffff800837346c>] sg_alloc_table_from_pages+0x14/0x1c
    [<ffffff8008097a3c>] __iommu_get_sgtable+0x5c/0x8c
    [<ffffff800850a1d0>] fastrpc_dma_buf_attach+0x84/0xf8
    [<ffffff80085114bc>] dma_buf_attach+0x70/0xc8
    [<ffffff8008509efc>] fastrpc_map_create+0xf8/0x1e8
    [<ffffff80085086f4>] fastrpc_device_ioctl+0x508/0x900
    [<ffffff80082428c8>] compat_SyS_ioctl+0x128/0x200
    [<ffffff80080832c4>] el0_svc_naked+0x34/0x38
    [<ffffffffffffffff>] 0xffffffffffffffff

Reported-by: Mayank Chopra <mak.chopra@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index eee2bb398947..47ae84afac2e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -550,6 +550,7 @@ static void fastrpc_dma_buf_detatch(struct dma_buf *dmabuf,
 	mutex_lock(&buffer->lock);
 	list_del(&a->node);
 	mutex_unlock(&buffer->lock);
+	sg_free_table(&a->sgt);
 	kfree(a);
 }
 
-- 
2.21.0

