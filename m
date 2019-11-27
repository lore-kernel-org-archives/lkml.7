Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3699CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3072176D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888976;
	bh=M9GKwNLHZtXJNq1pdD7iJyD2YRJIDFWFLNFDUjgg61U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XAxhVR9PbhXQK9+Xw/hI4cOzDwBDMAFv3VJpFKsQodl9v5w+CnREoeinQwUfcPSaj
	 2foJ95ZzsW9wcS0QRCH8xD1dSn/F4i/ZXjjIjIzpc+XTCJscjs9MqTKkRFxhkj4FxI
	 yVb6J5yxRpgzZhsG4adef43gXY1fdyvwCeoxYyz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbfK0VJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbfK0VJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:09:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8F621555;
        Wed, 27 Nov 2019 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888970;
        bh=M9GKwNLHZtXJNq1pdD7iJyD2YRJIDFWFLNFDUjgg61U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DA7uxBDbQE7zl76M6kW8WoHdUkEZ835fSH71w9/I7PuL7bRPpOVYDc4QSDV9oD+S
         IRwz1s22CVyQX7GRh0xfFlhY/UGC2TzUgCTaTXgJW+8Jro+n8PS3qBVRc439T46RG8
         qg9jAcsCdvvdzAwdcCmDuZVVaNFXcLhvgTFD0j5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.3 32/95] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on unsupported ASICs
Date:   Wed, 27 Nov 2019 21:31:49 +0100
Message-Id: <20191127202857.546558732@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit 355d991cb6ff6ae76b5e28b8edae144124c730e4 upstream.

Otherwise, the error message prompted will confuse user.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3477,18 +3477,31 @@ static int smu7_get_pp_table_entry(struc
 
 static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	int i;
 	u32 tmp = 0;
 
 	if (!query)
 		return -EINVAL;
 
-	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurrPkgPwr, 0);
-	tmp = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
-	*query = tmp;
+	/*
+	 * PPSMC_MSG_GetCurrPkgPwr is not supported on:
+	 *  - Hawaii
+	 *  - Bonaire
+	 *  - Fiji
+	 *  - Tonga
+	 */
+	if ((adev->asic_type != CHIP_HAWAII) &&
+	    (adev->asic_type != CHIP_BONAIRE) &&
+	    (adev->asic_type != CHIP_FIJI) &&
+	    (adev->asic_type != CHIP_TONGA)) {
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurrPkgPwr, 0);
+		tmp = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		*query = tmp;
 
-	if (tmp != 0)
-		return 0;
+		if (tmp != 0)
+			return 0;
+	}
 
 	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);
 	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,


