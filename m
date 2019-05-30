Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B1625405
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190315;
	bh=+eG4+jN2nVIVe5KO5WvYRWfEWqDk7gTXjD3mJXYIlW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZnk3rcl9yoRYd40rKv63JwS8YpCMuu9C33LUxl74K+mqqNq71ES+FrB6oWoNfKxn
	 NOWrr2xcVRFY58yAmJKek6kS5vkVrncpRk5j+pdYr7TD6aHjsS1S7Z0Nc23FVx2sh+
	 W3soVMreIc6gUZuzdrDTM5mT0/AlkJOIEogmjwSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfE3EZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbfE3DOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:46 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AF224557;
        Thu, 30 May 2019 03:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186086;
        bh=+eG4+jN2nVIVe5KO5WvYRWfEWqDk7gTXjD3mJXYIlW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sR+dpKralKuZwZ/4e3tBpf8LxhGDmUIhMQNSGuPw/Rp7T7bEr9GY5OqQMt35yPQv
         DGsH2TjTmrFfX5bAGWN1t3voKyWEcOxYurqJevzjlV+ipchpmgjw2Q51KPcDoOiu1E
         DJqFZS0pFNo4VqBRCiXZHJPNVwneJDIrI59NuyCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 157/346] drm/msm/dpu: release resources on modeset failure
Date:   Wed, 29 May 2019 20:03:50 -0700
Message-Id: <20190530030549.137323459@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a7fcc3237f31a4e206953bb73cf41bd429442f09 ]

release resources allocated in mode_set if any of
the hw check fails. Most of these checks are not
necessary and they will be removed in the follow up
patches with state based resource allocations.

Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1550107156-17625-4-git-send-email-jsanka@codeaurora.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 36158b7d99cdb..57ac94d80bde1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1034,13 +1034,13 @@ static void dpu_encoder_virt_mode_set(struct drm_encoder *drm_enc,
 			if (!dpu_enc->hw_pp[i]) {
 				DPU_ERROR_ENC(dpu_enc, "no pp block assigned"
 					     "at idx: %d\n", i);
-				return;
+				goto error;
 			}
 
 			if (!hw_ctl[i]) {
 				DPU_ERROR_ENC(dpu_enc, "no ctl block assigned"
 					     "at idx: %d\n", i);
-				return;
+				goto error;
 			}
 
 			phys->hw_pp = dpu_enc->hw_pp[i];
@@ -1053,6 +1053,9 @@ static void dpu_encoder_virt_mode_set(struct drm_encoder *drm_enc,
 	}
 
 	dpu_enc->mode_set_complete = true;
+
+error:
+	dpu_rm_release(&dpu_kms->rm, drm_enc);
 }
 
 static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
-- 
2.20.1



