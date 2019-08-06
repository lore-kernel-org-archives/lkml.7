Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC16C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F1C216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127837;
	bh=gK56fSYyRsg25NtN0vMOBKtrbqwKisNofmHMCKKZoVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqTx7cU5Et3e3qcizyDILDfg1itDXlW4+jjZN/FbLe5EoNoSRbnp8K0CnJELLoT/C
	 5mr7brl0PUAxiAY9MErbnkr7wGuZk73BaLccJtCT/oIrk+1Q1Z6Zay2lPQ3355Qibm
	 9r0r20yropBNArNzEoa4ZXBBz29dj7jGmL0Gd4Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHFVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfHFVeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:34:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1693216F4;
        Tue,  6 Aug 2019 21:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127255;
        bh=gK56fSYyRsg25NtN0vMOBKtrbqwKisNofmHMCKKZoVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SI55ORxq7BAI2m1E0CxdQhDfnXfuSCb6uaW6K20z+/pwHx8jxHoA9FqaHO5XQTtj/
         id9C8LDNqRD2dGW2zotDZr1zmpmVIwiwlYVh5EyfiHUl+xUyqKG1oDyeFfNF/iS0Jz
         mH2yUkP5Y2vTGSxryfxk7f8XHsAwY7W02c8J0HkU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 29/59] drm/amdkfd: Fix byte align on VegaM
Date:   Tue,  6 Aug 2019 17:32:49 -0400
Message-Id: <20190806213319.19203-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Russell <kent.russell@amd.com>

[ Upstream commit d65848657c3da5c0d4b685f823d0230f151ab34e ]

This was missed during the addition of VegaM support

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4b192e0ce92f4..ed7977d0dd018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1148,7 +1148,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			adev->asic_type != CHIP_FIJI &&
 			adev->asic_type != CHIP_POLARIS10 &&
 			adev->asic_type != CHIP_POLARIS11 &&
-			adev->asic_type != CHIP_POLARIS12) ?
+			adev->asic_type != CHIP_POLARIS12 &&
+			adev->asic_type != CHIP_VEGAM) ?
 			VI_BO_SIZE_ALIGN : 1;
 
 	mapping_flags = AMDGPU_VM_PAGE_READABLE;
-- 
2.20.1

