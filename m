Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F9721736
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889613;
	bh=5yemM2jPWun0Szk6nsZE3AnqlsD35Qi3e+oCLqnavF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DqzwBcojTsbzY5JY75/g7Tlm02Gb2B557WIvC7j7p/p6qcAodYh8NnGHaHZ+8UuWh
	 w6Sn/e0Qu+TSvHkmjY2NBi/H5f3BJ2eNRi+JdGnUyYXd9joBb02ywwGCc+TcPk4E6N
	 Bodwp9xoWhh6re1ebzkJ49b9atIVQViI0y3KhEi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfK0VUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfK0VJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:09:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7CE21555;
        Wed, 27 Nov 2019 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888965;
        bh=5yemM2jPWun0Szk6nsZE3AnqlsD35Qi3e+oCLqnavF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdcbYrHF9BpZxeEjw3IGL65OsB67E89KM7vLnEG7eNcCxGMP6o1visEEOqSOYSOPy
         0JBVLCDMkZmKwN39igWe/tBIxwP7kjz0Q3NZmV4JLlnxzixPuMaRp/dp7sbOZ0CFNJ
         r2jO0UVS2uQGu6PuMEtibFNJzwPs6GZB6e80wiP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.3 30/95] drm/amdgpu: disable gfxoff when using register read interface
Date:   Wed, 27 Nov 2019 21:31:47 +0100
Message-Id: <20191127202856.736039714@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit c57040d333c6729ce99c2cb95061045ff84c89ea upstream.

When gfxoff is enabled, accessing gfx registers via MMIO
can lead to a hang.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=205497
Acked-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -635,15 +635,19 @@ static int amdgpu_info_ioctl(struct drm_
 			return -ENOMEM;
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
-		for (i = 0; i < info->read_mmr_reg.count; i++)
+		amdgpu_gfx_off_ctrl(adev, false);
+		for (i = 0; i < info->read_mmr_reg.count; i++) {
 			if (amdgpu_asic_read_register(adev, se_num, sh_num,
 						      info->read_mmr_reg.dword_offset + i,
 						      &regs[i])) {
 				DRM_DEBUG_KMS("unallowed offset %#x\n",
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
+				amdgpu_gfx_off_ctrl(adev, true);
 				return -EFAULT;
 			}
+		}
+		amdgpu_gfx_off_ctrl(adev, true);
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
 		return n ? -EFAULT : 0;


