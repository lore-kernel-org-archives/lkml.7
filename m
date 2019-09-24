Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE4C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9F9217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343368;
	bh=NDBtYKgN3zzwF34NkX10fbsw48KNwYppKEDi5dL90zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKbL/AYRxIiZtVMglaBEQgL3YgjE2fYlfgdOTNt4H2hYmAOy+weGThBS3nceSQgnB
	 hIMsnlk0JKq36YK6IeltWzKAzCLcJY4jXtWIZ6lrSpaZCRncWhzHBCS1x/S+hiqRp5
	 Cvid41A+hENIUNWy09w7krSfN812jdgVT96OIVl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505067AbfIXQmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409810AbfIXQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:42:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E442121850;
        Tue, 24 Sep 2019 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343352;
        bh=NDBtYKgN3zzwF34NkX10fbsw48KNwYppKEDi5dL90zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Th9PVXcwK9SWn5RsaGP3X0CDN/iskb+laqek0elG++JJ3nHrrhTcZE0Bn0XMrcOjw
         oUQYKSr4mTPNXuZ74uG3imQbmhSWH5BUaD4czFAdTsk3AQF+ow67XXj1JUaTaGCglg
         v53Xka4xRVe5XOLUhJ77SfhFU1m/bAnvEcKk2Or0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.3 15/87] drm/stm: attach gem fence to atomic state
Date:   Tue, 24 Sep 2019 12:40:31 -0400
Message-Id: <20190924164144.25591-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 8fabc9c3109a71b3577959a05408153ae69ccd8d ]

To properly synchronize with other devices the fence from the GEM
object backing the framebuffer needs to be attached to the atomic
state, so the commit work can wait on fence signaling.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Philippe Cornu <philippe.cornu@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190712084228.8338-1-l.stach@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 2fe6c4a8d9155..3ab4fbf8eb0d1 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -26,6 +26,7 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -922,6 +923,7 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
 };
 
 static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
+	.prepare_fb = drm_gem_fb_prepare_fb,
 	.atomic_check = ltdc_plane_atomic_check,
 	.atomic_update = ltdc_plane_atomic_update,
 	.atomic_disable = ltdc_plane_atomic_disable,
-- 
2.20.1

