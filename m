Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E3BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D35204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905517;
	bh=SQws7LQUsN35hj9MY23G6kH0kbXpCXwrL5tfbVE5b7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dBvNoUue8i7/j0pJYtdCwfA5/sCK4bA5nuRUn2/VMESj7Zm5yEHQf2JHCWKORjEdR
	 z5fiqx+PACpFt2yG7adOEz7XHcl+qjGAjyWwBTQVX7TFG1IzKMV7V4zhLcqiquzd+V
	 YQeJk5AOWpuQORUGFHioSTea6GO83cxoHYV5V1m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbfKDWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbfKDWLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:11:53 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F240214D8;
        Mon,  4 Nov 2019 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905513;
        bh=SQws7LQUsN35hj9MY23G6kH0kbXpCXwrL5tfbVE5b7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9DxKLOyfp8h/Niy2yNEsbqqAQjE5aG0tGBhW7u6jC4DN1Mnl+BqW7O3XOaNy8dih
         fujpVY64nEpTBw68K+Ue/6BCQt75rtsFmZC288zbW+W73EzdIOeUvYwHZZt3Yew/lH
         2VjeNIqzwW/gO1D2NbTePiQrlHTsVTGohLHeKGWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tianci Yin <tianci.yin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.3 137/163] drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE
Date:   Mon,  4 Nov 2019 22:45:27 +0100
Message-Id: <20191104212150.273916176@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 30ef5c7eaba0ddafc6c23eca65ebe52169dfcc60 upstream.

These were not aligned for optimal performance for GPUVM.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tianci Yin <tianci.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |    9 +++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  |    9 +++++++++
 2 files changed, 18 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -151,6 +151,15 @@ static void gfxhub_v2_0_init_cache_regs(
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, tmp);
 
 	tmp = mmGCVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, tmp);
 
 	tmp = mmGCVM_L2_CNTL4_DEFAULT;
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -137,6 +137,15 @@ static void mmhub_v2_0_init_cache_regs(s
 	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL2, tmp);
 
 	tmp = mmMMVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
 	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL3, tmp);
 
 	tmp = mmMMVM_L2_CNTL4_DEFAULT;


