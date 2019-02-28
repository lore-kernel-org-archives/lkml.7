Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719B20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367553;
	bh=p/xBKNBBZIxW8er1ymUGAgDsWJ4N8dOLTY6vkEwEl+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=boS2+nk3J9xPKjcqvhtVZVWmIZtx4VkH7G/BeZm0X4Xwuv7bN90gq2WjRarmO4Co6
	 /HPX6rl1lYpdyIhjuEzcKE1ETbViMOuQE/w0Dv49QDhF//EA57+WHVV8IpRFEpAC0e
	 ky8yU2sVv59E4uX+a0goeS6DomiryCy5on1bZBWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfB1PZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbfB1PLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADD52171F;
        Thu, 28 Feb 2019 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366712;
        bh=p/xBKNBBZIxW8er1ymUGAgDsWJ4N8dOLTY6vkEwEl+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vn3H8rmMdsbokIJ1VFO0VlRcCa89SocBME1fvebyb6IBraRtVdlNBNJAvf24ghaeR
         0fU4U8PY5pT25jL67FWjIH+cPH/eVf9P36zAFbry2PK4tdG3mawfmuI9i+PDfiyLrD
         JWcRFiKRgoB02CcH0t5+q/K74jHL8E0cjxJRzyHI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 24/64] drm/amdgpu: Add missing power attribute to APU check
Date:   Thu, 28 Feb 2019 10:10:25 -0500
Message-Id: <20190228151105.11277-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit dc14eb12f6bb3e779c5461429c1889a339c67aab ]

Add missing power_average to visible check for power
attributes for APUs.  Was missed before.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 7b4e657a95c70..c3df75a9f65d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1443,7 +1443,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		effective_mode &= ~S_IWUSR;
 
 	if ((adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
 		return 0;
-- 
2.19.1

