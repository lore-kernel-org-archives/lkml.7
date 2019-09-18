Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A0C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725C222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH/W/byt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbfIRTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:05:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38196 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:05:44 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so1780857iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQSilxjATPMpO7L5/vQnnBs3bEydxYma+YlB5QOJU8U=;
        b=fH/W/bytl72c1yo6ic3T73JClM0RD1+zcOzWusW39nEfIWb98Dy3nNh3bOpnmbyzNa
         Al+0Daj4pGv5Afco5DgNHMs8kQzM/+h7nEO+osniYUb+SZBHyh5IiSHLuWHEk0aT6LxK
         miTw/aYX3jHNGdAoVioD+ZqsdsejgaGe34TjP1VzeB2y9DtwDfFc8kVx7G8bqRas86GU
         91UIUblXCVULGGT4UkQf1klgMQ0aDyHzQ60Se/d10nnJiDYgjQjiWHFcS4Tb/OSZC65U
         zcCCYoFMLYWcUdb4QoL0SP6Is/f+VOGot/NF+/qLDiTvp1PZinTc4bkAgllrYGORdB0X
         RD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RQSilxjATPMpO7L5/vQnnBs3bEydxYma+YlB5QOJU8U=;
        b=QvBdFPvA0TTWaTLjnMK9n5Dw87MIPJfhKoVcGr5vT70Haf4ik+cS7TekrA3Z0G/vGW
         KrkzOLY9ECKhjHoSrm3c+AhoA6a7I5JlhR31zh8oYYYkvrJor7dZY8yGz04wP7dMn8LX
         C3WYg+q23z6fClrYnKtIA498iVnhxnUFmImQ0xK/0GwzwKgtdU3GyYo2n7uWKWpt6CvC
         1Ft8ckJxT+X/7vbuVGwiJ/3NXgGpQX/weTvz2FAoS5dYVvnS/n/7hyQh6Sjo87mbKRVC
         s4VD8KjnzObdp4rluksHqgVwQ45Xjo9r5B8iPqnjGhm8nfy6HCvsl/YWMG5WmN75KPoa
         E5Ig==
X-Gm-Message-State: APjAAAWD5VE10i46sVraqY8YmxrU8B5IbMmMbT79WBblhgVzV1LLTs05
        vnRo3FBooF4TGe4ei0zW1jdmEagfU6I=
X-Google-Smtp-Source: APXvYqzH8knGmzCb/BchfhU8WwYcB8gmZa9Y2tl3gP0Y2rEpGV7ELb7EsudkOS7JRk2eK3EFfvKVxQ==
X-Received: by 2002:a5d:9f4e:: with SMTP id u14mr7060740iot.106.1568833542230;
        Wed, 18 Sep 2019 12:05:42 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s201sm8446830ios.83.2019.09.18.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 12:05:41 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Christian.Koenig@amd.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Date:   Wed, 18 Sep 2019 14:05:26 -0500
Message-Id: <20190918190529.17298-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com>
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

v2: moved the released into goto error handlings

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eba42c752bca..c0db75b71859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -184,7 +184,7 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
  */
 static int acp_hw_init(void *handle)
 {
-	int r, i;
+	int r, i, ret;
 	uint64_t acp_base;
 	u32 val = 0;
 	u32 count = 0;
@@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
 							GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL)
-		return -ENOMEM;
+	if (adev->acp.acp_cell == NULL) {
+		ret = -ENOMEM;
+		goto out1;
+	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
 	if (adev->acp.acp_res == NULL) {
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out2;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
 	if (i2s_pdata == NULL) {
-		kfree(adev->acp.acp_res);
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out3;
 	}
 
 	switch (adev->asic_type) {
@@ -348,7 +349,8 @@ static int acp_hw_init(void *handle)
 		r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
 		if (r) {
 			dev_err(dev, "Failed to add dev to genpd\n");
-			return r;
+			ret = r;
+			goto out4;
 		}
 	}
 
@@ -393,6 +395,16 @@ static int acp_hw_init(void *handle)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
+
+out4:
+	kfree(i2s_pdata);
+out3:
+	kfree(adev->acp.acp_res);
+out2:
+	kfree(adev->acp.acp_cell);
+out1:
+	kfree(adev->acp.acp_genpd);
+	return ret;
 }
 
 /**
-- 
2.17.1

