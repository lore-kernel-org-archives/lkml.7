Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A70AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DABF205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208998;
	bh=cPZo9AmpcZJ5rukK0yocOfPyUIQc/OAjyydpmRqxFf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0WJKNqL7SjJnPsyElnAI07CgnV1FzSKzlvpDneX2V3X6W/KsxN9S0lxxM/Vj2Rb7
	 vovADzJg64Pz++mOE2CuziWXGJh1LrUcKXixA+uN7MXnxjfmU9gPjYkWWfeFlArZCp
	 Le5MwFABOh+lE1nzu2Esh5aUAtYc+RSclDevuWUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEGGDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfEGFfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:35:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF8821726;
        Tue,  7 May 2019 05:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207310;
        bh=cPZo9AmpcZJ5rukK0yocOfPyUIQc/OAjyydpmRqxFf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2ye/7gbELg8KEuF43Z6q4gtdla6VcKepFP0VJ2F1bFLX373KiN0Oq390rnz82E1s
         aMHu/5yYkCC3srBA9ECIhQCw/oskiTMW8K22bxKvP+XO0/vldYhCfJZZJXwG9xiYgV
         ewX2u4GW5LdBsyP8haOUhTdu8WIVPddgS07YVsUw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 79/99] drm/imx: don't skip DP channel disable for background plane
Date:   Tue,  7 May 2019 01:32:13 -0400
Message-Id: <20190507053235.29900-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 7bcde275eb1d0ac8793c77c7e666a886eb16633d ]

In order to make sure that the plane color space gets reset correctly.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 058b53c0aa7e..1bb3e598cb84 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -70,7 +70,7 @@ static void ipu_crtc_disable_planes(struct ipu_crtc *ipu_crtc,
 	if (disable_partial)
 		ipu_plane_disable(ipu_crtc->plane[1], true);
 	if (disable_full)
-		ipu_plane_disable(ipu_crtc->plane[0], false);
+		ipu_plane_disable(ipu_crtc->plane[0], true);
 }
 
 static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
-- 
2.20.1

