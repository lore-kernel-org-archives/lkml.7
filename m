Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D9ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23E72190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948328;
	bh=f6t4c88a69fuHzhV8io9AVBJIcK7SkSDMOV9GaanKkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZsjdG0ougmif1cF8IniLNsXZxmMpc1EmeC9ON6BOnb41+Ouoocx/0QyJgDhmkAiL
	 +fhfBdR0rjcEIU19htaRJMGOqdzASGgvGANkXqMDnjn4xguzTeJKV+Lsx0FWhi0gp2
	 mQI1i/3rnXW0bHUVodWHziNEyFPELU7MOubfWlaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbfJAQp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390216AbfJAQpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:45:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7604D205C9;
        Tue,  1 Oct 2019 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948315;
        bh=f6t4c88a69fuHzhV8io9AVBJIcK7SkSDMOV9GaanKkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCr5BI4/PyRq2UnhfkFRY0el25iumOSZ0PnG5Vq0Wu/znwic8lbD0fssxzAiM0nW/
         iDurK91CJwhIa2BzWY8bIo4237l0Z8BwNLBBKh6MlHFuIRXYIgsiMnhjd/+qvGrRo8
         OnLBAuWMRoUmLzQtR+ePouRhRT8wi3ZUnf22LWBE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trek <trek00@inbox.ru>, Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 07/19] drm/amdgpu: Check for valid number of registers to read
Date:   Tue,  1 Oct 2019 12:44:53 -0400
Message-Id: <20191001164505.16708-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164505.16708-1-sashal@kernel.org>
References: <20191001164505.16708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trek <trek00@inbox.ru>

[ Upstream commit 73d8e6c7b841d9bf298c8928f228fb433676635c ]

Do not try to allocate any amount of memory requested by the user.
Instead limit it to 128 registers. Actually the longest series of
consecutive allowed registers are 48, mmGB_TILE_MODE0-31 and
mmGB_MACROTILE_MODE0-15 (0x2644-0x2673).

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=111273
Signed-off-by: Trek <trek00@inbox.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3938fca1ea8e5..24941a7b659f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -430,6 +430,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
 			sh_num = 0xffffffff;
 
+		if (info->read_mmr_reg.count > 128)
+			return -EINVAL;
+
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
 		if (!regs)
 			return -ENOMEM;
-- 
2.20.1

