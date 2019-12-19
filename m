Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BEE222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781813;
	bh=gOi7u9rc+UXnnYd5TwfviUxd/m0EHjwX8sMAo87ysqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zb8nGBE2yDRO/y072SixT/K14eo50CgU/Z8MS/kxoiRJeRSg4PUfYX9nJ9V0KMpB1
	 Ayuh2GjdC+ZMTOyXeT8hRHqakbsee/1/ErWtV/l+lWB2cSIjeHvERJrrtqR8crcjKr
	 NQN8ALv1/DtsdMk6BlIC8odV1CbJ4LMYlhmCZCc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfLSS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfLSS4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:56:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239372465E;
        Thu, 19 Dec 2019 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781805;
        bh=gOi7u9rc+UXnnYd5TwfviUxd/m0EHjwX8sMAo87ysqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PITiFeG4dlgZaxXbpwpPqsH/fwvSOZoq+WQc/JZzw3zPTn0uaQ3r3y6gojIi+aZ/C
         CBAoFkEfOQkJVQJxbf37JBedInXfiid0tRuGqsKnSuhAS4GSnxGPeBzWYNFeNXNZr+
         h0BbCqPB+u3ozn3m/jF6wBKZ2Al5/osVI+TFXFyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, changzhu <Changfeng.Zhu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 74/80] drm/amdgpu: initialize vm_inv_eng0_sem for gfxhub and mmhub
Date:   Thu, 19 Dec 2019 19:35:06 +0100
Message-Id: <20191219183144.562791406@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: changzhu <Changfeng.Zhu@amd.com>

commit 6c2c8972374ac5c35078d36d7559f64c368f7b33 upstream.

SW must acquire/release one of the vm_invalidate_eng*_sem around the
invalidation req/ack. Through this way,it can avoid losing invalidate
acknowledge state across power-gating off cycle.
To use vm_invalidate_eng*_sem, it needs to initialize
vm_invalidate_eng*_sem firstly.

Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |    1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |    2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |    2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |    2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  |    2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |    4 ++++
 6 files changed, 13 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -77,6 +77,7 @@ struct amdgpu_gmc_fault {
 struct amdgpu_vmhub {
 	uint32_t	ctx0_ptb_addr_lo32;
 	uint32_t	ctx0_ptb_addr_hi32;
+	uint32_t	vm_inv_eng0_sem;
 	uint32_t	vm_inv_eng0_req;
 	uint32_t	vm_inv_eng0_ack;
 	uint32_t	vm_context0_cntl;
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -365,6 +365,8 @@ void gfxhub_v1_0_init(struct amdgpu_devi
 	hub->ctx0_ptb_addr_hi32 =
 		SOC15_REG_OFFSET(GC, 0,
 				 mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_SEM);
 	hub->vm_inv_eng0_req =
 		SOC15_REG_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_REQ);
 	hub->vm_inv_eng0_ack =
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -350,6 +350,8 @@ void gfxhub_v2_0_init(struct amdgpu_devi
 	hub->ctx0_ptb_addr_hi32 =
 		SOC15_REG_OFFSET(GC, 0,
 				 mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_SEM);
 	hub->vm_inv_eng0_req =
 		SOC15_REG_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_REQ);
 	hub->vm_inv_eng0_ack =
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -418,6 +418,8 @@ void mmhub_v1_0_init(struct amdgpu_devic
 	hub->ctx0_ptb_addr_hi32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
 				 mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(MMHUB, 0, mmVM_INVALIDATE_ENG0_SEM);
 	hub->vm_inv_eng0_req =
 		SOC15_REG_OFFSET(MMHUB, 0, mmVM_INVALIDATE_ENG0_REQ);
 	hub->vm_inv_eng0_ack =
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -341,6 +341,8 @@ void mmhub_v2_0_init(struct amdgpu_devic
 	hub->ctx0_ptb_addr_hi32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
 				 mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_SEM);
 	hub->vm_inv_eng0_req =
 		SOC15_REG_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_REQ);
 	hub->vm_inv_eng0_ack =
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -502,6 +502,10 @@ void mmhub_v9_4_init(struct amdgpu_devic
 			SOC15_REG_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32) +
 			    i * MMHUB_INSTANCE_REGISTER_OFFSET;
+		hub[i]->vm_inv_eng0_sem =
+			SOC15_REG_OFFSET(MMHUB, 0,
+					 mmVML2VC0_VM_INVALIDATE_ENG0_SEM) +
+					 i * MMHUB_INSTANCE_REGISTER_OFFSET;
 		hub[i]->vm_inv_eng0_req =
 			SOC15_REG_OFFSET(MMHUB, 0,
 					 mmVML2VC0_VM_INVALIDATE_ENG0_REQ) +


