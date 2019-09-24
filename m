Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C1C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604FF21841
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343571;
	bh=J1zur49gsnGltUJR6USs8KZFsOWEQRy5Y0FIf5lKH6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccypaxCK2mNbHjcioXYfkfog/z+SWCIi8jsjCg9ZNz26ubq/vtkdarRbcAtqvEGb2
	 3fw3Y6hFbkzgC2yJUa8z0+NSy2/j+RjrM2Z9f5bsqVGjy3F0qVZtqx334CjGKdMOgf
	 jBaDyZjPRIeez5RqQpGCqf969AJ1ywknQBpQIJIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbfIXQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404298AbfIXQqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7E421783;
        Tue, 24 Sep 2019 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343564;
        bh=J1zur49gsnGltUJR6USs8KZFsOWEQRy5Y0FIf5lKH6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oU2xfg2y2cB/gUBPjb9KzLFbY5FSnfpj/20O2rdAASQr0PJ8lLJRNLaUFOD8cMWrs
         pOoxrlPzg9MpNDvNK4KCxPrTKlOm7x4lMCw+IXYEVoPqtnusl1YOgF1INeaqO6zDw8
         Rw8oDxb2ysVluQVocSY/PZHm9/UEwfJv7wyo0xaU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Koo <anthony.koo@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 07/70] drm/amd/display: add monitor patch to add T7 delay
Date:   Tue, 24 Sep 2019 12:44:46 -0400
Message-Id: <20190924164549.27058-7-sashal@kernel.org>
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

From: Anthony Koo <anthony.koo@amd.com>

[ Upstream commit 88eac241a1fc500ce5274a09ddc4bd5fc2b5adb6 ]

[Why]
Specifically to one panel,
TCON is able to accept active video signal quickly, but
the Source Driver requires 2-3 frames of extra time.

It is a Panel issue since TCON needs to take care of
all Sink requirements including Source Driver. But in
this case it does not.

Customer is asking to add fixed T7 delay as panel
workaround.

[How]
Add monitor specific patch to add T7 delay

Signed-off-by: Anthony Koo <anthony.koo@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index b0dea759cd860..8aecf044e2ae8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -154,6 +154,10 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 			break;
 		udelay(25); //MAx T7 is 50ms
 	} while (++tries < 300);
+
+	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
+		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6c2a3d9a4c2e7..283082666be51 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -202,6 +202,7 @@ struct dc_panel_patch {
 	unsigned int dppowerup_delay;
 	unsigned int extra_t12_ms;
 	unsigned int extra_delay_backlight_off;
+	unsigned int extra_t7_ms;
 };
 
 struct dc_edid_caps {
-- 
2.20.1

