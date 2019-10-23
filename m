Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEFCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E420640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWe4Gxxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391194AbfJWMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:10:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53137 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfJWMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:10:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so20977437wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCCFnxfgctiR7ujkuq6S73RHOtLBZpaj2MQBUfolKvQ=;
        b=uWe4GxxaDPldHT/awU5IWmMXWiJX9zobzCZrqq+ZyDgb8jfdBUOR+PX5YFHdwI5/lC
         wNpaXg392Vm9jbCkVRfCu90EPUw3QQyy2Ow8C+AlRv+LtV+WVRkv6x/6LrOJr3mL/p8i
         k+O5wtlrs7XawlVq/0CbZKOc2Csr/QHg9ZqoZzPmac1Moazeg85zhHVWOpabc5VYPTpS
         R0weZTve0KM/FeioqgXhcJSzVojaVzAWoWKNRSZzVKSS2QdDbHNbaTC9wRwa+vDjDy4b
         J/vkMN7tTgDu/j6WkExePmXeAWgMxXVGkYUH7BMapWPdxflWaLJ8pBMUvMUmk7ZxTVuJ
         eRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GCCFnxfgctiR7ujkuq6S73RHOtLBZpaj2MQBUfolKvQ=;
        b=hGCiBqABuzpB6Wwf1dXEDrbF9dIT0GhjwWYCKwKNq1e7mHSaOwSag7C6QGf4hWD9Wz
         31uXMqNBKsXKLtkyIgw8bRxn/oegbKSJUjWQ/uWL2CNe0m05+FbnW7PpW0papkbv7CDw
         Mozu4LdzBBtKLAuJDy1uzHKtxBr0JE5pdILVi+emLkujN2532OUstxGjhyIiOtzOv7Rr
         ZGKlLriKP0t5uZZighh5Av5BLrwXuXlvOiJ5u7KT/+zS6h4E8iokLQiTIFZP77k99z45
         vAQoKB+dVk2d+0/fwThY2e8nVpuup4oPI/NPWZFetBz73UGxehV6BJ+j+5rZ6ioImwrP
         SXEg==
X-Gm-Message-State: APjAAAWZ+nzepaUlJODiNdIWRXUao3th0Kpv9Rhatdt+JMNGz3ruTfKP
        belo322y0M8nYK4n80zB8MxNeKBbDCI=
X-Google-Smtp-Source: APXvYqwnT1P5lpTKGC9oq14j3EyMYmkpka1Vii05lwYOx5CHpyeTJMni1eoCxD3yrgrjTtag5l7jhA==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr7709573wmg.89.1571832600353;
        Wed, 23 Oct 2019 05:10:00 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.196])
        by smtp.gmail.com with ESMTPSA id r81sm15016575wme.16.2019.10.23.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:09:59 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] panfrost: Properly undo pm_runtime_enable when deferring a probe
Date:   Wed, 23 Oct 2019 14:09:25 +0200
Message-Id: <20191023120925.30668-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deferring the probe because of a missing regulator, we were calling
pm_runtime_disable even if pm_runtime_enable wasn't called.

Move the call to pm_runtime_disable to the right place.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Fixes: f4a3c6a44b35 ("drm/panfrost: Disable PM on probe failure")
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index bc2ddeb55f5d..f21bc8a7ee3a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -556,11 +556,11 @@ static int panfrost_probe(struct platform_device *pdev)
 	return 0;
 
 err_out2:
+	pm_runtime_disable(pfdev->dev);
 	panfrost_devfreq_fini(pfdev);
 err_out1:
 	panfrost_device_fini(pfdev);
 err_out0:
-	pm_runtime_disable(pfdev->dev);
 	drm_dev_put(ddev);
 	return err;
 }
-- 
2.20.1

