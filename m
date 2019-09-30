Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095BC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D8C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD5o0cLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfI3V05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:26:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39678 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbfI3V05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:26:57 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so42282490ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtzmZPAVj6PcCAW/gCFtani94tf/hKkhMopNIaCQ7ds=;
        b=FD5o0cLnuDAFLJqEhrrC31vOT5SzTRN0LzNpf9asGEXan9ZkJpInwrIG+HJ5diLOfh
         oPJo4CiDaE7KPqS65fIQ1oc9f5z0ndEZeBMtRin2bG/cAKtF9KOZ8MlqTm98Zb3dVMxA
         k9e5B8X4gupvZ19gRf3hnYXBOUwnmMO/qnMYDHhf1ctHhPuAaiAux9EecsxF4hGGHIld
         sJIEk65xE2Q5ojHW5JpkDyVMda/d/p8VzeADkR+5G5Y/6k8SqMVltk/2WU/Nnw9CVkWe
         v04gDbT9a6iga3WfXrkcGleApgfuPEzx1j6YGgmkwPA1oSGNowzWIhDjV9CTr34IWwaT
         wMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtzmZPAVj6PcCAW/gCFtani94tf/hKkhMopNIaCQ7ds=;
        b=OTvcc/kiQ3yjarAYzfla6HwJMIFN5tRVLviLF2C5e83I69pBlVn3N+OY5RRKcAVb97
         zvpNSahTCzo+4ImQhC2lZDCXioYn/k3zyux7gNXrAiw9qeaEx+3PDjx0Z4z1yz2rXJKO
         MC81tJc1oRQkGIQSjYg4Ue2ONAjmESLVJfl9n46QDR5nd7d+YEj1JfoU2yQ079LNVSdB
         iYbdb5OZjRW+X7IlZAdT1RmkH46Zrjs1uHZU3kIwcbhs98XC/IReK6NVu3srDCRhqNo0
         jEbv66NXMZqE23y90Y/h//2nwFEMKq+HBNzaSzyUm38JxX58d9Vzn+RFRNO1TS3RdO1H
         c1yQ==
X-Gm-Message-State: APjAAAXmNV69Og4yNMcTSR0O8sKK83o+ogcz3b18kgd847KmigkXwZye
        NxBe3DZu/7krMuj71MFGTc0=
X-Google-Smtp-Source: APXvYqwqKrouifY+TUn3+EnzlbHCJts4Y8+G3uZGOt53gcb1+rRpxiIr456oNIBCAHqtJbFFdjFrag==
X-Received: by 2002:a92:91d0:: with SMTP id e77mr22402443ill.10.1569878814906;
        Mon, 30 Sep 2019 14:26:54 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i6sm6190116ile.60.2019.09.30.14.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 14:26:54 -0700 (PDT)
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
Subject: [PATCH v3] drm/amdgpu: fix multiple memory leaks in acp_hw_init
Date:   Mon, 30 Sep 2019 16:26:40 -0500
Message-Id: <20190930212644.9372-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
References: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
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
Changes in v2:
	-- moved the releases under goto

Changes in v3:
	-- fixed multiple goto issue
	-- added goto for 3 other failure cases: one when
mfd_add_hotplug_devices fails, and two when time out values expires.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 41 ++++++++++++++++---------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eba42c752bca..7809745ec0f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -184,12 +184,12 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
  */
 static int acp_hw_init(void *handle)
 {
-	int r, i;
+	int r, i, ret;
 	uint64_t acp_base;
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
+		ret = -ENOMEM;
+		goto failure;
+	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
 	if (adev->acp.acp_res == NULL) {
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto failure;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
 	if (i2s_pdata == NULL) {
-		kfree(adev->acp.acp_res);
-		kfree(adev->acp.acp_cell);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto failure;
 	}
 
 	switch (adev->asic_type) {
@@ -340,15 +341,18 @@ static int acp_hw_init(void *handle)
 
 	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
 								ACP_DEVS);
-	if (r)
-		return r;
+	if (r) {
+		ret = r;
+		goto failure;
+	}
 
 	for (i = 0; i < ACP_DEVS ; i++) {
 		dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
 		r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
 		if (r) {
 			dev_err(dev, "Failed to add dev to genpd\n");
-			return r;
+			ret = r;
+			goto failure;
 		}
 	}
 
@@ -367,7 +371,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -384,7 +389,8 @@ static int acp_hw_init(void *handle)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto failure;
 		}
 		udelay(100);
 	}
@@ -393,6 +399,13 @@ static int acp_hw_init(void *handle)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
+
+failure:
+	kfree(i2s_pdata);
+	kfree(adev->acp.acp_res);
+	kfree(adev->acp.acp_cell);
+	kfree(adev->acp.acp_genpd);
+	return ret;
 }
 
 /**
-- 
2.17.1

