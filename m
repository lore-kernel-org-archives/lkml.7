Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC157C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2486206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642530;
	bh=hZhc5CmV4Tv/Xploa8M6cvpJUjCAijh9hbYQXaFjQ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4agZHtcZpOPvAF1U4EO1n5bS+XKRQWR14kzpNl4YxRIlIvtMNutdk6XJBlQtlIPC
	 QPEHuAv0z9W8mK4MvTZ/j+H+Ca+11d8Bmidkg/GVEItknlKB6Vyuyk8rvtYcJ0vwuV
	 BOdqu1dGmJHa/a8kR+SVEQr6y5PsCGuNp1CZxffk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbfL2RzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732569AbfL2RzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599DF21744;
        Sun, 29 Dec 2019 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642117;
        bh=hZhc5CmV4Tv/Xploa8M6cvpJUjCAijh9hbYQXaFjQ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3vgA0dnkCwgJx+JwnlKWyoZzn9zLr+jj3unluMrbBGHTxARnio2V+jc8iwFNTy9I
         v0JGSQuLaRqB+axRMwsm0yKUbaIDS2s6HlyF8lWICoPpAPJGVo5z19qi7aUrtJX3/H
         eu4MeuWejZxVwFQGNG40Y2x9Jo6y6WReYCLze4PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 349/434] drm/amdgpu: fix bad DMA from INTERRUPT_CNTL2
Date:   Sun, 29 Dec 2019 18:26:42 +0100
Message-Id: <20191229172725.154079749@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 3d0e3ce52ce3eb4b9de3caf9c38dbb5a4d3e13c3 ]

The INTERRUPT_CNTL2 register expects a valid DMA address, but is
currently set with a GPU MC address.  This can cause problems on
systems that detect the resulting DMA read from an invalid address
(found on a Power8 guest).

Instead, use the DMA address of the dummy page because it will always
be safe.

Fixes: 27ae10641e9c ("drm/amdgpu: add interupt handler implementation for si v3")
Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si_ih.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 57bb5f9e08b2..88ae27a5a03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -64,7 +64,8 @@ static int si_ih_irq_init(struct amdgpu_device *adev)
 	u32 interrupt_cntl, ih_cntl, ih_rb_cntl;
 
 	si_ih_disable_interrupts(adev);
-	WREG32(INTERRUPT_CNTL2, adev->irq.ih.gpu_addr >> 8);
+	/* set dummy read address to dummy page address */
+	WREG32(INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
 	interrupt_cntl = RREG32(INTERRUPT_CNTL);
 	interrupt_cntl &= ~IH_DUMMY_RD_OVERRIDE;
 	interrupt_cntl &= ~IH_REQ_NONSNOOP_EN;
-- 
2.20.1



