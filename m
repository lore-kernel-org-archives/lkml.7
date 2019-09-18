Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D081DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E518208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMq37Kxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfIRQJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:09:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35078 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbfIRQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:09:55 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so557593iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BvDGB+V/nASMvCed6TT+EuLlfHR1McV76EsCinnwHUM=;
        b=mMq37Kxp6hZGxxEC+mrqEpd1jfQB1ImzvHtC/zMAstwJSIbX3JTRi+bT22WKwoTVxd
         KFg63MlhFSGijX0KcBtWq7KvYTJLqlxqkHnIlUkfuIU1TNy9LGvijm6SiN/GP7n67f2A
         tzX/BYacuvkTywgrzIPM+MWHqLtxxN7LzCRGDjjtSjIISpxg5OdCCswju0QRub64Z/LY
         O9VSIbn24x0c9ajNW0VoiVjfveHwqVPUU37K5A68IC8jNHa9W3L6naZcIcE5Mjl5J61C
         GAlZDWiGkgiaWhRDL4XEqjnysdXHPlGJc5gSNHocB5wD+m051xHNehw7azQ/6MvwA/KB
         wU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BvDGB+V/nASMvCed6TT+EuLlfHR1McV76EsCinnwHUM=;
        b=fGhNksvnIqO33T70ZH/6gKm8bLdpFk7UStPOe3LjnU+wio6HvSQ1qEp45YPlEUbb2D
         lRnlMWD+yA++soA052Ll8mKJydMkCfb+G7uz57oUZQvgp6IG0P4jxR334EANhR6s/+Bl
         mFZC/rWRHIH4tIFYlVgppBGUaIf8W1Qe4bX03JROGNPvKU/NFTQBQetvaU5lrAH5ZTyC
         qlJtno1hWneXETxeIU8qhxYRmgw75KxhUmuqKKBthAhaJaEzrsTIjKB/l9SyfPJLD1y8
         EAvqzYtCRcM5S/3u/EV9yydZuxTjkLcfGuztfLOOLgUuzA5L2qT1+4xBTUzvtOSojjQB
         O+kQ==
X-Gm-Message-State: APjAAAU9IKAttVt42btE0qwbv/PKgznXXv0edKtz4XWHnKJqTBRCUrOY
        xwZFoks2Zjmq1h+WD9S4xZ8=
X-Google-Smtp-Source: APXvYqynC081DIdUE2EUfE3EbXiFoYcTxuO3RtA0A+9tw6YudCla7BwKQcLYgARe+NwO3SzQR4X5sg==
X-Received: by 2002:a05:6638:294:: with SMTP id c20mr5705640jaq.77.1568822994587;
        Wed, 18 Sep 2019 09:09:54 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id j8sm4315160iog.9.2019.09.18.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 09:09:53 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix multiple memory leaks
Date:   Wed, 18 Sep 2019 11:09:41 -0500
Message-Id: <20190918160943.14105-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acp_hw_init there are some allocations that needs to be released in
case of failure:

1- adev->acp.acp_genpd should be released if any allocation attemp for
adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
2- all of those allocations should be released if pm_genpd_add_device
fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eba42c752bca..dd3fa85b11c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -231,17 +231,21 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
 							GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL)
+	if (adev->acp.acp_cell == NULL) {
+		kfree(adev->acp.acp_genpd);
 		return -ENOMEM;
+	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
 	if (adev->acp.acp_res == NULL) {
+		kfree(adev->acp.acp_genpd);
 		kfree(adev->acp.acp_cell);
 		return -ENOMEM;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
 	if (i2s_pdata == NULL) {
+		kfree(adev->acp.acp_genpd);
 		kfree(adev->acp.acp_res);
 		kfree(adev->acp.acp_cell);
 		return -ENOMEM;
@@ -348,6 +352,10 @@ static int acp_hw_init(void *handle)
 		r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
 		if (r) {
 			dev_err(dev, "Failed to add dev to genpd\n");
+			kfree(adev->acp.acp_genpd);
+			kfree(adev->acp.acp_res);
+			kfree(adev->acp.acp_cell);
+			kfree(i2s_pdata);
 			return r;
 		}
 	}
-- 
2.17.1

