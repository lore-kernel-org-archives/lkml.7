Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66262171F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334317;
	bh=aE8kV+3qO4IwFD/P6BD6Enrd3mzB4JoFCp9Eep4TdcI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wtuMbd4AdID06OLfkXLoLxhZqrHPLRRIMbtUVl/YAIeP3nQNqP3z3Bzgap3k7D/Qk
	 hiJTB3mTwNOWOCHCtd9DcnRgOFy2T0xvjp+tfS9m5SXWz5R9ex1btcz1gxhegljVO9
	 +MxGzhdQ3Sts2L7g1Fwaxna4hiQa6s4RBrt0uqUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfCKT6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbfCKT61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC86C214D8;
        Mon, 11 Mar 2019 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334306;
        bh=aE8kV+3qO4IwFD/P6BD6Enrd3mzB4JoFCp9Eep4TdcI=;
        h=From:To:Cc:Subject:Date:From;
        b=XtIWpuoGPTZgEFYKPdXV2dYq55FWMKEJZwzhqXzTIJda4gyVToAnPoecFL0uy7ISB
         1wo/7O7cYy1A5w2m6R0lJmyrzsUeiCUHvRDC6D7Al3EBEjl8M48s0wiY4CjyuDF+te
         DsbONmjnPWId6+brImu1g626w11w538nTL+T56m8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 01/27] drm/imx: ignore plane updates on disabled crtcs
Date:   Mon, 11 Mar 2019 15:57:58 -0400
Message-Id: <20190311195824.139043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

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

