Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562FFC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF5206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329798;
	bh=ieGh2GH9KJAGVH6l0lHgLbKL+x65MK5xcFbTnBnSKU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yz8SN1M/hqcty5JTJ54UJF+8yGlMFDwNk7+UShOuLAkVQPVX/OGMFomSNI0uA2sdR
	 B/03CZA/domDbc1yrumNnUMruXWL1HnYmAiAbDku9CZE4cx5hUDaF6A9ELIrN6a/18
	 4cAtbMK0d45mLcl4/ZTMIapKicWRYGCy9Mz02f0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfD0Blu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfD0Blo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDC1216FD;
        Sat, 27 Apr 2019 01:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329303;
        bh=ieGh2GH9KJAGVH6l0lHgLbKL+x65MK5xcFbTnBnSKU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7WFg2yaBCyPNCNpyZtyzA2uw8fAjSvixE79Z+KnMw2yEU3QHqEHzi3dktHhbpNm2
         5Hu5VmkSWQ9aJcEvCq1HiJdinjZ9Mu5Y5upE/qhqdNWQROeHQs8Mt4SteY7eQzpeLB
         YqkV93o0K2ZjOXcIh/eoOnpZ4MwcX+R9YGF4Iie8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     tiancyin <tianci.yin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 30/53] drm/amd/display: fix cursor black issue
Date:   Fri, 26 Apr 2019 21:40:27 -0400
Message-Id: <20190427014051.7522-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tiancyin <tianci.yin@amd.com>

[ Upstream commit c1cefe115d1cdc460014483319d440b2f0d07c68 ]

[Why]
the member sdr_white_level of struct dc_cursor_attributes was not
initialized, then the random value result that
dcn10_set_cursor_sdr_white_level() set error hw_scale value 0x20D9(normal
value is 0x3c00), this cause the black cursor issue.

[how]
just initilize the obj of struct dc_cursor_attributes to zero to avoid
the random value.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tianci Yin <tianci.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b8b892eb846..76ee2de43ea6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4028,6 +4028,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	amdgpu_crtc->cursor_width = plane->state->crtc_w;
 	amdgpu_crtc->cursor_height = plane->state->crtc_h;
 
+	memset(&attributes, 0, sizeof(attributes));
 	attributes.address.high_part = upper_32_bits(address);
 	attributes.address.low_part  = lower_32_bits(address);
 	attributes.width             = plane->state->crtc_w;
-- 
2.19.1

