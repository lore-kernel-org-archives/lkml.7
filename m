Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41809205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712398;
	bh=XP+bIxLAo41mLZUAhJRRDDSeY9GAnxuJx39CNxX5AWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9jcE5RL9kw4Ur/5uIyD6mFSbydHGc391mNLudeqQTeW0dIgTNkfkAyF/nIXCxCQa
	 HBGKvfsElzj+Ezf6YMSIdJwieAyzDseGzGYbaHKZREzdD0Ci5f3iFRlEQ7R2DM0/Os
	 MnmS/GRrHSYwTrqd51ln8hfMKjhy7Ba3TFKDcTls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbfC0Sqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390898AbfC0SUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163C92147C;
        Wed, 27 Mar 2019 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710821;
        bh=XP+bIxLAo41mLZUAhJRRDDSeY9GAnxuJx39CNxX5AWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvlkznfJoJ0d2t6FEGTQHpcH/o0mXvrA++xRMTlwjrwwQj1Uy1xI8jzzH1hHslXxG
         ymne1/GQfPgMO5+q79uh30warsjrLili1dl5cOETFl7iPWu9jUuQ3jD3CoHQDmMvvT
         QrT49BG2sE2ccuo2ClnjKtOVBpz5xibWYGKratVI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 114/123] drm/nouveau: Stop using drm_crtc_force_disable
Date:   Wed, 27 Mar 2019 14:16:18 -0400
Message-Id: <20190327181628.15899-114-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 934c5b32a5e43d8de2ab4f1566f91d7c3bf8cb64 ]

The correct way for legacy drivers to update properties that need to
do a full modeset, is to do a full modeset.

Note that we don't need to call the drm_mode_config_internal helper
because we're not changing any of the refcounted paramters.

v2: Fixup error handling (Ville). Since the old code didn't bother
I decided to just delete it instead of adding even more code for just
error handling.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181217194303.14397-2-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 6d99f11fee4e..4bc8e9fe3095 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -750,7 +750,9 @@ static int nv17_tv_set_property(struct drm_encoder *encoder,
 		/* Disable the crtc to ensure a full modeset is
 		 * performed whenever it's turned on again. */
 		if (crtc)
-			drm_crtc_force_disable(crtc);
+			drm_crtc_helper_set_mode(crtc, &crtc->mode,
+						 crtc->x, crtc->y,
+						 crtc->primary->fb);
 	}
 
 	return 0;
-- 
2.19.1

