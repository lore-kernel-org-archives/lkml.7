Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44203C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121EA20815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWDfpkNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfJBDqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:46:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35734 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJBDqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 23:46:21 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so53773671iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMiLu1nFfK7FMPb2g7QpUm4/s0CIGTuYLHYbn9DfaIs=;
        b=KWDfpkNW+DV7MjaClVF7N49DLsXJyF3RAT4b7pah37LslRcUv0Rcr2rXdfsgE/Ycm/
         xF3IskpJLJOkAcmNwVcD+p5yCLEgITeuIWiJye+83OJ0O67cSlDLUfYQOlgw2pppc4Gp
         DFmnAQLlxL5oJW3HwQxarNO5uyOfBS47AJ6LKj9CPtN5X8Vp+nhJRDb2zBfUzrP4vhNM
         81qsfDlhnEPKdG6QjkkHDl4D0/iE7FI/P3GD+H+6dOKgo1SG2je6TeOzGM1PB1AN/ifR
         4lAXRHKiGK53gg5hp82rMympyIWVjM61PUSoflF+t0WAWQdBnbbJyUuptHxFrUxzTZkF
         ntUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sMiLu1nFfK7FMPb2g7QpUm4/s0CIGTuYLHYbn9DfaIs=;
        b=TUoU4tYs/ecja7XEEcRr7aQImu4fepdKbdlArlFIgDlIuR+v3MBjLAY3Ru0hpzFoyq
         kYGRBVRrpukJ/okqROIXWipSWz4OA0tqyQXPjSUVn1hl6RX1qbdzEPuH3mZMUIihC6fE
         Gg4sF5B4z9NcxAQC4jzaEeVMTMndn6n3A688x8elQnMRvtwiRou1laf2+9Y97Uug9pUy
         bQxnj2/iEdhZfHJkaBClTaU1vw35updOIhxD1SQsOHj2/0EFYx/ZStOupuucIevnFs3m
         rpmey4wA3pvsKmHMQ+qnlx7vgJjhnD4CubmFcT9iiHYcA8aK8j4e5mVRL70a/BhtQUam
         Pn4w==
X-Gm-Message-State: APjAAAXtqRwqi2w1fqD4vtXBgSE/JDO+BeNAwrP5/OoYFiL1UejiNNky
        /N8xHgRyElQ5X7zaqX3hnKs=
X-Google-Smtp-Source: APXvYqxBSaRVO13ufXz4U6Ax3TS8H6IV1DY0yKgl9bb9DwQJ273pBwhSqWynoCXut9XmvjP3YaTsiQ==
X-Received: by 2002:a92:3951:: with SMTP id g78mr1716427ila.47.1569987980208;
        Tue, 01 Oct 2019 20:46:20 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id d20sm8878418ilk.83.2019.10.01.20.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 20:46:19 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Christian.Koenig@amd.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date:   Tue,  1 Oct 2019 22:46:07 -0500
Message-Id: <20191002034612.26607-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
References: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acp_hw_init there are some allocations that needs to be released in
case of failure:

1- adev->acp.acp_genpd should be released if any allocation attemp for
adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
2- all of those allocations should be released if
mfd_add_hotplug_devices or pm_genpd_add_device fail.
3- Release is needed in case of time out values expire.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 34 ++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eba42c752bca..82155ac3288a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -189,7 +189,7 @@ static int acp_hw_init(void *handle)
 	u32 val = 0;
 	u32 count = 0;
 	struct device *dev;
-	struct i2s_platform_data *i2s_pdata;
+	struct i2s_platform_data *i2s_pdata = NULL;
 
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
 							GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL)
-		return -ENOMEM;
+	if (adev->acp.acp_cell == NULL) {
+		r = -ENOMEM;
+		goto failure;
+	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
 	if (adev->acp.acp_res == NULL) {
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto failure;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
 	if (i2s_pdata == NULL) {
-		kfree(adev->acp.acp_res);
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto failure;
 	}
 
 	switch (adev->asic_type) {
@@ -341,14 +342,14 @@ static int acp_hw_init(void *handle)
 	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
 								ACP_DEVS);
 	if (r)
-		return r;
+		goto failure;
 
 	for (i = 0; i < ACP_DEVS ; i++) {
 		dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
 		r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
 		if (r) {
 			dev_err(dev, "Failed to add dev to genpd\n");
-			return r;
+			goto failure;
 		}
 	}
 
@@ -367,7 +368,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -384,7 +386,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -393,6 +396,13 @@ static int acp_hw_init(void *handle)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
+
+failure:
+	kfree(i2s_pdata);
+	kfree(adev->acp.acp_res);
+	kfree(adev->acp.acp_cell);
+	kfree(adev->acp.acp_genpd);
+	return r;
 }
 
 /**
-- 
2.17.1

