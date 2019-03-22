Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A3AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66F2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255182;
	bh=31V7gweOq9EA8pHJlAKqYOD26MZUKcYwkg77+PTl7/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqbjaxUYUfDgBlpAddzpY8YROilFa/gurxSjEqyRbuatFzxMYknjkRM+kMm6x3/Sm
	 0nWdVWHPPbj3QxF/PVADs4J4yzy8WhGr/VDobq3R6QUnsG/BMfYGs2Wcup3vvupSmW
	 2589oM50TVCy7nln7tllGAg1BIMX2i9K/8EUO1K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfCVLqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbfCVLqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208C32075E;
        Fri, 22 Mar 2019 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255176;
        bh=31V7gweOq9EA8pHJlAKqYOD26MZUKcYwkg77+PTl7/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeAhVZWbF6MnCS4r3tJRhSmkxJtADWFdz5T9JPN4rgZYGFj+Qj8t5cIjTDOncLSl5
         b0u05T/QR8r9QhYNIwRMDdJjdH3acfMoepfIgSebFR1Swtxg38z4x6SAJ6c/NdZbnL
         955WdcH+xdx8K9KR0g5anMHaticWajAye1UMk6uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/183] drm/imx: ignore plane updates on disabled crtcs
Date:   Fri, 22 Mar 2019 12:13:58 +0100
Message-Id: <20190322111242.538900266@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4fb873c9648e383206e0a91cef9b03aa54066aca ]

This patch fixes backtraces like the following when sending SIGKILL to a
process with a currently pending plane update:

    [drm:ipu_plane_atomic_check] CRTC should be enabled
    [drm:drm_framebuffer_remove] *ERROR* failed to commit
    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 63 at drivers/gpu/drm/drm_framebuffer.c:926 drm_framebuffer_remove+0x47c/0x498
    atomic remove_fb failed with -22

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
index cf98596c7ce1..d0d7f6adbc89 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -348,9 +348,9 @@ static int ipu_plane_atomic_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	/* CRTC should be enabled */
+	/* nothing to check when disabling or disabled */
 	if (!crtc_state->enable)
-		return -EINVAL;
+		return 0;
 
 	switch (plane->type) {
 	case DRM_PLANE_TYPE_PRIMARY:
-- 
2.19.1



