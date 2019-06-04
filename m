Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815A2085A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690593;
	bh=FohrENoaCq01zdcKab6dNJUVnveTwmm7geo9AeQqun0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAJS/hsug+ELjHlisy1UZnkPP0YiD/7m22eAqUlOhHvXdwW35L8NMWnuzKvHyYFZS
	 zrFzN8sfH9nqCE7rUTgVIo8z7ZcC+oQ2QmNfcv053KEUz0gWDLo5v7rq0KVRyh9P9W
	 Q+2WOfEakjz9SUC0Fa0eJfyLxaYvRVPS/aDk0now=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFDXXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfFDXXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:23:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4A420859;
        Tue,  4 Jun 2019 23:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690591;
        bh=FohrENoaCq01zdcKab6dNJUVnveTwmm7geo9AeQqun0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIjD3D3vqz9OHatI2bSHdKm07oJuBbf4ul8788HCXV+8YI6ROxXAOfWjh4tQDlZfX
         YFxcJKAvUf5MW/el6ivoLfKwUrd4uDaoR5yv/fS4nvm7JVTRc8tLBRplM2bC6lWqo3
         96S+lCS6zrSCe8WjX2nR5/5oPchg18Z+gTCC2RfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Flora Cui <flora.cui@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 38/60] drm/amdgpu: keep stolen memory on picasso
Date:   Tue,  4 Jun 2019 19:21:48 -0400
Message-Id: <20190604232212.6753-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Flora Cui <flora.cui@amd.com>

[ Upstream commit 379109351f4f6f2405cf54e7a296055f589c3ad1 ]

otherwise screen corrupts during modprobe.

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2fe8397241ea..1611bef19a2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -715,6 +715,7 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 		return true;
 	case CHIP_RAVEN:
+		return (adev->pdev->device == 0x15d8);
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 	default:
-- 
2.20.1

