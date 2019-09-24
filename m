Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC36C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A739E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343621;
	bh=8RTrsxUPtiQV8fJJjQUR1PBXXKK19v9iUcCIGPA+was=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KS/ZslXUZTGY2kchoxw9debrb+m1F3Lrnu7CYKDTqUGH3lLZ0r21aJKqHwYc4ZQAN
	 NawOgq5oJe6oehDe6nvVR9eBOiGM3OPUcYyT+Y/MHQkbZBv9CUuE2YRIIHB7jLPaOV
	 H6cWOMNr3qA7nDz9IHbgVTTMe5UdLATL88G4HOyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410247AbfIXQrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410093AbfIXQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B100421906;
        Tue, 24 Sep 2019 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343614;
        bh=8RTrsxUPtiQV8fJJjQUR1PBXXKK19v9iUcCIGPA+was=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjwmaz+s1EUtmFpZmrOMXaNSM6UC/mxE3xVcN7buvVZiAUUIAxPeHf9hNXm7OgTTs
         bWz6X32QY3IFVfkq/pdk3IsP0xlbTv8Kf1O6+XW+O3kUdI7drQEGJR32iGU7ycvRb+
         WbXSIveolWJJZIUprNLw4+Ps4NdS6PO7AmqDR/Jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ahzo <Ahzo@tutanota.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 26/70] drm/amd/powerplay/smu7: enforce minimal VBITimeout (v2)
Date:   Tue, 24 Sep 2019 12:45:05 -0400
Message-Id: <20190924164549.27058-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahzo <Ahzo@tutanota.com>

[ Upstream commit f659bb6dae58c113805f92822e4c16ddd3156b79 ]

This fixes screen corruption/flickering on 75 Hz displays.

v2: make print statement debug only (Alex)

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=102646
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Ahzo <Ahzo@tutanota.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 048757e8f4949..d1919d343cce4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4064,6 +4064,11 @@ static int smu7_program_display_gap(struct pp_hwmgr *hwmgr)
 
 	data->frame_time_x2 = frame_time_in_us * 2 / 100;
 
+	if (data->frame_time_x2 < 280) {
+		pr_debug("%s: enforce minimal VBITimeout: %d -> 280\n", __func__, data->frame_time_x2);
+		data->frame_time_x2 = 280;
+	}
+
 	display_gap2 = pre_vbi_time_in_us * (ref_clock / 100);
 
 	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_DISPLAY_GAP_CNTL2, display_gap2);
-- 
2.20.1

