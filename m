Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC68C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E562021743
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329192;
	bh=whvNBmCkh1AiI3XA2AqIodVoRylYI+nMH65IWUwafBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fquVOaPQUfgNWgpcAwN0xTxhfbpBq0KyVwLaRCLFjJGc7lVh2hRa7fpZEQZNjMtRU
	 ctyF6c0gZpZSdhBu+Ck2r0wNFlENUT0tH2Dr/y4MPYllNCPmSID3W2Gz2fBZdLewt5
	 SNtTpC7d3e7szJo2rY4Qo7ICMO9Bwj4nm11wOPF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfD0Bju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfD0Bjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73EC20873;
        Sat, 27 Apr 2019 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329184;
        bh=whvNBmCkh1AiI3XA2AqIodVoRylYI+nMH65IWUwafBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8WeO0v5x6RNWjiudrNy7tSeMxIg7i2IJl8rUf3qRyjl0zjUtaLhXpy8qFEuEBxXf
         Nr5HfQg5C5u0aWnHpkR/tyG1sNhP9w5yPtLFrkFnh4QPJJfTBSvDx5YInapaiQaM4C
         d3zU3WHSQhOHPREru2sCDkDk5/XAEPZwHCAkjGf4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     tiancyin <tianci.yin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 41/79] drm/amd/display: fix cursor black issue
Date:   Fri, 26 Apr 2019 21:38:00 -0400
Message-Id: <20190427013838.6596-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 83c8a0407537..84ee77786944 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4455,6 +4455,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	amdgpu_crtc->cursor_width = plane->state->crtc_w;
 	amdgpu_crtc->cursor_height = plane->state->crtc_h;
 
+	memset(&attributes, 0, sizeof(attributes));
 	attributes.address.high_part = upper_32_bits(address);
 	attributes.address.low_part  = lower_32_bits(address);
 	attributes.width             = plane->state->crtc_w;
-- 
2.19.1

