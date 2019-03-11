Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A08217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334226;
	bh=eHAmPnAwcSsbv89EtT4YjXVaeQbfQE51gGAhor6VdjE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LIGkPHaVzG+HAvugXCU0XWu/pDzQbGp9U9NTZateuTQ+4ESX+UQ5AtUmEVFQOKJ/o
	 VfVQhhQzbVb0YqRL/0b+Z8ywkvmAic0Z7EfMfN3bF7yfYA0gKXIDoc01NDclbnAhEc
	 85KK9V0vlzcrUdqDsEvGc33dlOnU4xCBatLx5WrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfCKT5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfCKT5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0D3214AE;
        Mon, 11 Mar 2019 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334222;
        bh=eHAmPnAwcSsbv89EtT4YjXVaeQbfQE51gGAhor6VdjE=;
        h=From:To:Cc:Subject:Date:From;
        b=0qRwYV4uwthOsoV02a4DG94ofudnDv/OyCW0eEzPHNnKfp3syFn0EVLBCFfvNQDlw
         e3EG4l4SuP7LzWB8HAUs29Gz6klUPHb6OtrEguEJP+38NCB4Ta7u7pcfLydb9O/kn4
         cXkWIgWW3Wq5yq3tuDjrRILvlVCkSa82VQMBxdmg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/44] drm/imx: ignore plane updates on disabled crtcs
Date:   Mon, 11 Mar 2019 15:56:17 -0400
Message-Id: <20190311195700.138462-1-sashal@kernel.org>
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
index 203f247d4854..a323a0db2fc1 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -375,9 +375,9 @@ static int ipu_plane_atomic_check(struct drm_plane *plane,
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

