Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05602C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA31F218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRR/Qo5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfDWXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfDWXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so8260333pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZpIv+9XMJ9csXRza8KzL21yNgQLvZSyCbypyWHMOUw=;
        b=zRR/Qo5bYroXdXojCw8cu739K44KjE9a9FCvieFsAEgn4wA0iSXY4E8KlxyzBr8AIJ
         fCkc8zhwYkRj0wRJW8zO36ltNNXsH9tcC21c6owPLKQFGSkZKulPoh1WRMhBRS/eWtFn
         sOI6NTCzAIp6hHrRq3P/3wGZzWanOAdARjN/4k+fg1urddAfw2v+hVRXIBLFTpucRKrg
         x1WRMiNoLMX84V+RXhiMXCtAMAKYzjh3ZxijaOz8noszCMRJOy8Q9dF5XDGmI6LLfgsr
         skSZfAHFC6wCQaOKfFo1S4g6IgobfFVbt+SVllr/v31fxbi9yDQMkvOd48y+mZuilEP5
         hy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZpIv+9XMJ9csXRza8KzL21yNgQLvZSyCbypyWHMOUw=;
        b=W9U8Kqw8B6GgAsxC4OW9P6mGViI1FoxjVtfv+GoH7Hi+YIStyvnlZk8tm41xOYjslm
         KLFYRQQqhRRddnp2+KgFjXmKud10ReO4pOWfSfaVMgwkdOxN2rJnNO65CnYHAI25YRgJ
         LkjhZxuaKMAB0qVr/zmtLSpIZ4jatQjMA4+Mls7t0vC6r9Tk51SyWiXfMKm9hj+4xQnL
         YF92si5rZ2wLowyMBtVRptgpdb7NxY6qoBbqxHSV/ES2jRAyNRTBdh1ZnAHD1U/W9onL
         P/zuzwueJ1v989h3jseT1vYEnJAiXtWZ7x8FEM7iX67ecH5/v9O5QyIzXKxKyS6g/ysG
         T7KA==
X-Gm-Message-State: APjAAAWKWhtuHk5e08Et/Q6crZkEQm9naBMdpFxKvos8bCsB1Cqy5pe8
        /+nvKc3PtCBaVkmGF9ea6sRCcbBci6o=
X-Google-Smtp-Source: APXvYqz9MfY/qTz0PFUH+681l2VpDr/fJck5yp7tggLJ7C4wLYYD1x3aIj8pRAQAd8EMBRUTP09Qdg==
X-Received: by 2002:aa7:8458:: with SMTP id r24mr10796538pfn.231.1556061690322;
        Tue, 23 Apr 2019 16:21:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:29 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 21/25] drm: kirin: Fix dev->driver_data setting
Date:   Tue, 23 Apr 2019 16:20:52 -0700
Message-Id: <1556061656-1733-22-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the
dev->driver_data to point to a drm_device, not ade_data.

Thus we set the driver data to drm device after alloc.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 21965ee..3d5bd3a 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -998,7 +998,6 @@ static int ade_drm_init(struct platform_device *pdev)
 		DRM_ERROR("failed to alloc ade_data\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, ade);
 
 	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 5ee90d7..a2938d4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -45,8 +45,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
 
-	dev_set_drvdata(dev->dev, dev);
-
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	dev->mode_config.min_width = 0;
@@ -141,6 +139,7 @@ static int kirin_drm_bind(struct device *dev)
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
+	dev_set_drvdata(dev, drm_dev);
 
 	ret = kirin_drm_kms_init(drm_dev);
 	if (ret)
-- 
2.7.4

