Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849F920675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611211;
	bh=EbRltLgt24jtA3OsQnBzek7YLCLP46q2X5ONOuX8KQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/UsWqMWytOmIIGEUCKqIm8DPMQLPNBddiFXwA7qGrDOL8Y0MFNrL9/zeH6txQnK2
	 V2PYYmG/HeKE1h23ISzvYSnINwntXrOruNWpeOGW/LiNOQ7R2+uILSL8UDkWGeUk+y
	 q1PPXlC6rShY4odf0rEyNhU0Mz23Z66Mvoqk/KPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404452AbfDRSNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404072AbfDRSN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2EB20652;
        Thu, 18 Apr 2019 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611206;
        bh=EbRltLgt24jtA3OsQnBzek7YLCLP46q2X5ONOuX8KQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et7C2O3LXIbLlU3DKDRjZiKh8S6Wg4B4rBYw0AH1RbIq4N2MNBjLgWnBPIa/gLxmw
         o+lY1hBPbUVs3wUuYqtOo6nseDERUhMgcKSf+cSDCf6ureRCDj0vGLWPOK0ZgSzm6x
         3grbDNhHDG6gzedotIBAYQsBSIoVcI8Ah7HkxF8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiangliang Yu <Xiangliang.Yu@amd.com>,
        Wentao Lou <Wentao.Lou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 70/93] drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL
Date:   Thu, 18 Apr 2019 19:57:48 +0200
Message-Id: <20190418160444.295980911@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 14d20ec7f31ef96a2e7dcf7880b13dde1d473b56 ]

psp_ring_destroy inside psp_load_fw cause psp->km_ring.ring_mem NULL.
Call Trace occurred when psp_cmd_submit.
should be psp_ring_stop instead.

Reviewed-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3a9b48b227ac..a7208ca0bfe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -546,7 +546,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 
 	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset) {
-		psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+		psp_ring_stop(psp, PSP_RING_TYPE__KM); /* should not destroy ring, only stop */
 		goto skip_memalloc;
 	}
 
-- 
2.19.1



