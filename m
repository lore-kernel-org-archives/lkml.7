Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4454FECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F09A2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948592;
	bh=bUeR3G4ltMyhjy1E4Dp4Np7mZiJmRIOpqJtRyynAjLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aDVURwFSXZbrnxiRwHhweVLNmLy5EMvPFfI0GT25bHL5tPsiuQ3BTLI/o7GhtjS7v
	 4cdfjZTXfpZU2ReVFeF7mkN15tan+aYfJrqvBdx8aZmRnPKnaICv1l0gcukDxovmrx
	 8lN/nAHlY9X577G7lgFLQnhCwuxKvnTiN+D1jYzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfJAQor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfJAQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:44:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19ABE2168B;
        Tue,  1 Oct 2019 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948276;
        bh=bUeR3G4ltMyhjy1E4Dp4Np7mZiJmRIOpqJtRyynAjLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtPusCcLQhCZ4vTlDOngq1FZfPof4so9q3RMwlKZ9E7s3xIqVj6tpQRvZZ47diA5y
         auoUPpeOuQAUft/65egV2W7C5t4BIyLtQ8aIsKdVYbCsf78sWPgI1g5Sdy7q3CcawF
         +3ynske96KRseDnHlLz5zh/zLF9GVEyYsUK1GXx4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trek <trek00@inbox.ru>, Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 10/29] drm/amdgpu: Check for valid number of registers to read
Date:   Tue,  1 Oct 2019 12:44:04 -0400
Message-Id: <20191001164423.16406-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164423.16406-1-sashal@kernel.org>
References: <20191001164423.16406-1-sashal@kernel.org>
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
index e16229000a983..884ed359f2493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -540,6 +540,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
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

