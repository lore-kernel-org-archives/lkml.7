Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F3120657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922706;
	bh=fzEzy8z1nNA01mTDYGij1Szd2Ct45Wg92K9Ox1KP368=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mkGPoaZtus/ZsJhNorY6FjiTGORWjPt4gJXeAlm1IOVyyprB5Ny63R5iCBv8VF+dI
	 v5yxE5fS34AWsmrqF/r7CAp+hT2j3lsxzJJMYGgwuJuK9uPc2jtwXQGqHvcSiXlEPj
	 jCTAeoCBTq9E6c+uVPJ+BjVODsFaU5lbwqvA672A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfFGPvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731294AbfFGPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81FA2147A;
        Fri,  7 Jun 2019 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922615;
        bh=fzEzy8z1nNA01mTDYGij1Szd2Ct45Wg92K9Ox1KP368=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJ7RJHGolvLitOnXxVqFFLS5N3KcLY5/SYYseKiiBJrqmj4zYai+SIiG3Gcjp8K+z
         pXJPGg/SH5j9zHgWn3j1uIXKMbs6Ks1e4oeNMDGaeNyG0eYMRsK97wpYMBm06zltzC
         zGfDQMBeiTN2+mGX2AHPSfxiwbLQbXLjlXGUWd0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 5.1 77/85] drm/imx: ipuv3-plane: fix atomic update status query for non-plus i.MX6Q
Date:   Fri,  7 Jun 2019 17:40:02 +0200
Message-Id: <20190607153857.545955797@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

commit 137caa702f2308f7ef03876e164b0d0f3300712a upstream.

The current buffer check halves the frame rate on non-plus i.MX6Q,
as the IDMAC current buffer pointer is not yet updated when
ipu_plane_atomic_update_pending is called from the EOF irq handler.

Fixes: 70e8a0c71e9 ("drm/imx: ipuv3-plane: add function to query atomic update status")
Tested-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/imx/ipuv3-plane.c |   13 ++++++++-----
 drivers/gpu/drm/imx/ipuv3-plane.h |    1 -
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -605,7 +605,6 @@ static void ipu_plane_atomic_update(stru
 		active = ipu_idmac_get_current_buffer(ipu_plane->ipu_ch);
 		ipu_cpmem_set_buffer(ipu_plane->ipu_ch, !active, eba);
 		ipu_idmac_select_buffer(ipu_plane->ipu_ch, !active);
-		ipu_plane->next_buf = !active;
 		if (ipu_plane_separate_alpha(ipu_plane)) {
 			active = ipu_idmac_get_current_buffer(ipu_plane->alpha_ch);
 			ipu_cpmem_set_buffer(ipu_plane->alpha_ch, !active,
@@ -710,7 +709,6 @@ static void ipu_plane_atomic_update(stru
 	ipu_cpmem_set_buffer(ipu_plane->ipu_ch, 1, eba);
 	ipu_idmac_lock_enable(ipu_plane->ipu_ch, num_bursts);
 	ipu_plane_enable(ipu_plane);
-	ipu_plane->next_buf = -1;
 }
 
 static const struct drm_plane_helper_funcs ipu_plane_helper_funcs = {
@@ -732,10 +730,15 @@ bool ipu_plane_atomic_update_pending(str
 
 	if (ipu_state->use_pre)
 		return ipu_prg_channel_configure_pending(ipu_plane->ipu_ch);
-	else if (ipu_plane->next_buf >= 0)
-		return ipu_idmac_get_current_buffer(ipu_plane->ipu_ch) !=
-		       ipu_plane->next_buf;
 
+	/*
+	 * Pretend no update is pending in the non-PRE/PRG case. For this to
+	 * happen, an atomic update would have to be deferred until after the
+	 * start of the next frame and simultaneously interrupt latency would
+	 * have to be high enough to let the atomic update finish and issue an
+	 * event before the previous end of frame interrupt handler can be
+	 * executed.
+	 */
 	return false;
 }
 int ipu_planes_assign_pre(struct drm_device *dev,
--- a/drivers/gpu/drm/imx/ipuv3-plane.h
+++ b/drivers/gpu/drm/imx/ipuv3-plane.h
@@ -27,7 +27,6 @@ struct ipu_plane {
 	int			dp_flow;
 
 	bool			disabling;
-	int			next_buf;
 };
 
 struct ipu_plane *ipu_plane_init(struct drm_device *dev, struct ipu_soc *ipu,


