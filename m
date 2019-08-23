Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59519C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3031B21726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsLTQ6Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392123AbfHWKHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54331 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391998AbfHWKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so8365892wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txsHPtmH/4H2/WnX6EiFrXzeHkL+qrKcHt+2DoU5kzQ=;
        b=zsLTQ6OcR9Dk0Qa39F2DDnmWFcluUGtQg+KpRb+bwLN1VIK3mhupCJbjkodp3dI4Fe
         iqWh9+beI2fEZPtXQqBILn5x5It/sxsv7zun4Zt7NVFJsPhAfH/gGhkWLaF7nzV25Hc0
         Y6hQwhCfGnfnrHTNZljsbuzWLq9L02poSqq/DJOxzCk4+RvvBqiV2Z/5YZzof/Ut4PgM
         rSlB1fo+5JK7gqGVKFIa3UWXy2A+xNE3hLhLeLjzdhmTLmP4MXsdi7osPx/D/EFFnDwM
         ztznERXTlzizlp25hDlJ4CRX4E7X4+QrQsYOYPrtn6xK68tfMik0P0I788C2hxA69/YK
         MX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txsHPtmH/4H2/WnX6EiFrXzeHkL+qrKcHt+2DoU5kzQ=;
        b=eZxAw5J23RpPuP8joEyXEyTHYs9orshBXU7YAm5Va+3HWlNJvlziw9kvBAbexFuhRe
         bao2UuTwcX8l8/glbiMKQQHBe+1WxADSGgv+KS4hRPTKipaZwJuChLWWxl9j++3nbK7N
         dHjfAWuTrK3UxdH+QxriGSR5ns0MbNQYjU+uAA/LofGX3g7pnxENoTPEwt1kkrUhZiJY
         n3wf+BW3hwvNpAwh8YTOStW+6yCtMALg8/zfYzmhnqMDRbd5y3Sv4/m6kFCkVmsbQrRF
         BApniqLk7lIRAbAoV4E/czJw6QhAwhEiVjVkiXG/8B0XRVZZvnWia7M4nLMPM8if5Svs
         wlOw==
X-Gm-Message-State: APjAAAWgJAsrH2OvIijSaGaYoeVJp/ZXGAGpgz2hsK9wcFrSylM3xo0/
        lPSDpDfpL9hhrY1+poNANCzI/DNKwBg=
X-Google-Smtp-Source: APXvYqwl1Fa7hd6dx3UhLaTaNR2R/23JKahB21Ecq5hVeBT4VSAziAuQCdksN46+5xAra8IOI9h+wA==
X-Received: by 2002:a1c:a80a:: with SMTP id r10mr4148894wme.103.1566554821626;
        Fri, 23 Aug 2019 03:07:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q124sm2058048wma.33.2019.08.23.03.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:07:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
Subject: [PATCH 5/5] misc: fastrpc: free dma buf scatter list
Date:   Fri, 23 Aug 2019 11:06:22 +0100
Message-Id: <20190823100622.3892-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
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

