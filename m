Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18AAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D021841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DrUV0JXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCWVmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:42:25 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49818 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:42:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 36532D1E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 21:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bMWoVAnPoJLC for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 16:42:23 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 081C0D39
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 16:42:23 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id j127so5283700itj.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d39Cd4pxUKExwK0flasQCF8IpmEJ1bpJz5uElGN2CJI=;
        b=DrUV0JXLB7MqOZZgQm8fWCOjeq9dGINXRgPqOhC514CrXyXIFMRt2K18v+7TKGJZ+0
         SuSW7e42X4dYce7e/bJO7xHfQkTP2Wrp/FmyVMnmmzsMcZJKjWi+0bImjoM3XOLFeAl0
         MHawuG9/J1PxsR4ZmhWyrWDXnfiy5Ry3c761X+99mWBBEevIZO3jMQNMHhQFBOmMchJs
         skKrp5a0N/GUJiNd6ro044Jd5x+Dn3YWIC00438n2ogugzWXdy0952XZWYbojBvgkIPJ
         c8cUap8b33Z/Ak60q0og+PIdJ3J1HC45xTsdBYMNgYKIHKYumQGh5yzgBG9YQSLnQTd8
         vaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d39Cd4pxUKExwK0flasQCF8IpmEJ1bpJz5uElGN2CJI=;
        b=dbyXc2mMs+Ji05bv1IjSPtwzsuvuiuSKQBLTohJPalep9hO0iaVEBf2VOQyD8xN0P5
         03O+P5+wqw924nb+p0FGMH9BSS6yrvHm723Px6NwGccea2tmUQ3XCT+H4HtEHKYSy5qw
         wo+1++uWUSZajV1E3lrlf8eKyB0K1R1zA+3FLHZ6kChRzwUR+hN+sU9PkKc7wUJiGusK
         dFu20GOE0wsAuqUt6Mpgop1pRhTzbBjbMuVpX5TO9s0mP9/vC7TaRqeSWasmdXKGai6o
         poFQRdyVNcuTqtR4mUJdkZ385xdOkp0DzMvp8/kT+xiYSac9qUGa3vQKL86OBLZXkJJM
         ePlQ==
X-Gm-Message-State: APjAAAX7FhFnp2bILXfolJmcBf2tqf+z/yrsZ88Hp4ampyjxX9770Opl
        7nmpyjYKK76jPMC9NHkkI8E5dhDO362n69YLBQyeYdFZ+HKln0ESHtqIfGC1txVRz80rlKPGBlF
        zmJLfLakTnv6imLm+/3VHco3PnsD0
X-Received: by 2002:a6b:9045:: with SMTP id s66mr11390103iod.285.1553377342232;
        Sat, 23 Mar 2019 14:42:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycCCz+TRcm3B4BltQSfIIKHN4PA2daQ5ZxG/O17HrblkLucN/cW1ipzw7b32mgOtrgodwYVw==
X-Received: by 2002:a6b:9045:: with SMTP id s66mr11390092iod.285.1553377341996;
        Sat, 23 Mar 2019 14:42:21 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id q133sm3502382itb.19.2019.03.23.14.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:42:21 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: vkms: check status of alloc_ordered_workqueue
Date:   Sat, 23 Mar 2019 16:42:16 -0500
Message-Id: <20190323214216.10824-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <955fbabe-e5f2-cfff-8dfd-1730243b0fff@codeaurora.org>
References: <955fbabe-e5f2-cfff-8dfd-1730243b0fff@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_ordered_workqueue may fail and return NULL.
The fix cleans up drm plans and returns ENOMEM when it fails to
avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: clean up resources
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 8a9aeb0a9ea8..018b52dd953a 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -219,6 +219,17 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	spin_lock_init(&vkms_out->state_lock);
 
 	vkms_out->crc_workq = alloc_ordered_workqueue("vkms_crc_workq", 0);
+	if (!vkms_out->crc_workq) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	return ret;
 
+cleanup:
+	if (!IS_ERR_OR_NULL(cursor))
+		drm_plane_cleanup(cursor);
+	if (!IS_ERR(primary))
+		drm_plane_cleanup(primary);
 	return ret;
 }
-- 
2.17.1

