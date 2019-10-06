Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9F2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383570;
	bh=NDBtYKgN3zzwF34NkX10fbsw48KNwYppKEDi5dL90zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpXw+ZrTTjkuSRIaZ3s4WMfgFqvqUPLZsMuJW1ydhJu6+UCnoBq9K2NlA4O5nghKj
	 2M1KopDTp2rQIoYhvNlueziEkbhyYAV0W1wvnqGB4pU7EUE6TOyendXY7RxtD+27zQ
	 bJ/xxn6q+W+fHZx5h5RUddaprc89R+AazKuhZj48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfJFRj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbfJFRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:39:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2C720700;
        Sun,  6 Oct 2019 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383562;
        bh=NDBtYKgN3zzwF34NkX10fbsw48KNwYppKEDi5dL90zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFc1fxR25pppZ63QUFJntLnSFNYHeFNKt1B03rVA+q7VPhtUqqN5p4SnbgnNgLAg8
         HgaS2vv27gTI7WDUFbMI8tMcS5Ke8MNXQqzVkTxik2jHubGUwMtvoV11B1UUr5v7T2
         GK+HegACV/u3fijTSyQ9pJ5UEzHa2FwWDDqOhsVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 013/166] drm/stm: attach gem fence to atomic state
Date:   Sun,  6 Oct 2019 19:19:39 +0200
Message-Id: <20191006171213.668040977@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



