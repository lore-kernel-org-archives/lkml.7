Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A45C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457A021773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429571;
	bh=jL6soxADRzGMY10b5XUC2QT0RohrDKfEA6oRGfMtswo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTKLjfHLHAXJp+PkfQGmbZ21aKnP9jZ0WDc/4H7TvDNgAphQItRmFY1dC5NC0uEeT
	 rIoSxn7PJ6RHJF2tgM1L/B1ncvNoMe446WaowDdn2iLdqL1RWo5rNEbX36U/GGwqBk
	 pgJwwhkvNAgP4gpUdWh5WzMee6RQd9I992NXAafg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbfG2TqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390067AbfG2TqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C28021773;
        Mon, 29 Jul 2019 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429565;
        bh=jL6soxADRzGMY10b5XUC2QT0RohrDKfEA6oRGfMtswo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vadi5+i824bC8P9w3w/xPw0SB0yo4D4Fji+zBxs7l1JlR2BuHm4LBtZcbzX+nE/YL
         wN0PQSS9kmxSNPnHjDGssFhI26pCC+jdOuCJ/Rc7wcQnGvu3Y+yC/cVkO0tnyGXfC3
         tLYf0TjzktbQBHEUSr9cp1KPR8AwAfQ5mazU0Vd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Li <Roman.Li@amd.com>,
        David Francis <David.Francis@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 024/215] drm/amd/display: Fill plane attrs only for valid pxl format
Date:   Mon, 29 Jul 2019 21:20:20 +0200
Message-Id: <20190729190744.105634175@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1894478ad1f8fd7366edc5cee49ee9caea0e3d52 ]

[Why]
In fill_plane_buffer_attributes() we calculate chroma/luma
assuming that the surface_pixel_format is always valid.
If it's not the case, there's a risk of divide by zero error.

[How]
Check if format valid before calculating pixel format attributes

Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: David Francis <David.Francis@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fa268dd736f4..31530bfd002a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2592,7 +2592,7 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		address->type = PLN_ADDR_TYPE_GRAPHICS;
 		address->grph.addr.low_part = lower_32_bits(afb->address);
 		address->grph.addr.high_part = upper_32_bits(afb->address);
-	} else {
+	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
 		uint64_t chroma_addr = afb->address + fb->offsets[1];
 
 		plane_size->video.luma_size.x = 0;
-- 
2.20.1



