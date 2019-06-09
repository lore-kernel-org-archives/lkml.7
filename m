Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9FCC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3C20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100873;
	bh=NE4vb/M5WrZIBwi5PZw5SJBFBN/5bfVsl77whhDLC/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7JzH1DiLnWE+CDU01lkNf++nLiqFan6cIHhUNmNM6AI54q5kdGdRUmAp6NeEa0cU
	 i5YImRRXakahQm5+wtr33tNLzwiuewtlc+wvfPrHO7ly+4SLTTo7jcLEuQPXw7RSND
	 akXhNaf3i9h4Fzjo+3ofh10ceCTYpjiGJFpiGXLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfFIQqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfFIQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234582081C;
        Sun,  9 Jun 2019 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098776;
        bh=NE4vb/M5WrZIBwi5PZw5SJBFBN/5bfVsl77whhDLC/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIJCa8ONJ82uW4mcz1O92bHFyWkLRhi/JHIsfRAHGM750IJmVgvu5+FhS7OmaQIZ1
         gEa1oLnRH41VUGXwNac/usnKHShtmVgZ7GxKaxmhTRXSamr27Jo8PHbaVytT2nXJTJ
         rULBo2d1Qm6qDDrjfJ/oFjKf98bFwh4xC8sNe3qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.1 57/70] drm/amdgpu/psp: move psp version specific function pointers to early_init
Date:   Sun,  9 Jun 2019 18:42:08 +0200
Message-Id: <20190609164132.252410083@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 9d6fea5744d6798353f37ac42a8a653a2607ca69 upstream.

In case we need to use them for GPU reset prior initializing the
asic.  Fixes a crash if the driver attempts to reset the GPU at driver
load time.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,18 +38,10 @@ static void psp_set_funcs(struct amdgpu_
 static int psp_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct psp_context *psp = &adev->psp;
 
 	psp_set_funcs(adev);
 
-	return 0;
-}
-
-static int psp_sw_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct psp_context *psp = &adev->psp;
-	int ret;
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
@@ -67,6 +59,15 @@ static int psp_sw_init(void *handle)
 
 	psp->adev = adev;
 
+	return 0;
+}
+
+static int psp_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct psp_context *psp = &adev->psp;
+	int ret;
+
 	ret = psp_init_microcode(psp);
 	if (ret) {
 		DRM_ERROR("Failed to load psp firmware!\n");


