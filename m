Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB0C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E965214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562771122;
	bh=QzqRLxUrMt/XIMjeh+78/kYmz9p+wcue4i1iYRIpMgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eL1WT8xTu2KpBxzHtQPI3KyPJ8J/RAs+gW7/B38EPV+YyE5p/g446KOW/k8t7BMIt
	 8SjhEJMjNjYynVscD3egJvIkUZqmHM1oOH/gDBuXDBC2U5Uo3KjxCknSsYPconpngH
	 446pCexAnTkV4E/V6UfmfbilP0wXjYd7sIzM4iBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfGJPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfGJPC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:02:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426D621473;
        Wed, 10 Jul 2019 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562770977;
        bh=QzqRLxUrMt/XIMjeh+78/kYmz9p+wcue4i1iYRIpMgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vedO+czNjDl+bg6EZc2WttdC38S4iBewAI6SCndQnFvfgvTzMUUG4jzAl7xX+6I6x
         2UrmEtJNr05YLZdUb9d++HQpD+dcGztm332FF8P2qcyw9Yd9qaLmDsXUA8I0sbYa43
         lmHIeUuCcyd5jHi3FK+b3PMeup1dZFLcqw7Fytss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 09/11] drm/imx: only send event on crtc disable if kept disabled
Date:   Wed, 10 Jul 2019 11:02:36 -0400
Message-Id: <20190710150240.6984-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710150240.6984-1-sashal@kernel.org>
References: <20190710150240.6984-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

[ Upstream commit 5aeab2bfc9ffa72d3ca73416635cb3785dfc076f ]

The event will be sent as part of the vblank enable during the modeset
if the crtc is not being kept disabled.

Fixes: 5f2f911578fb ("drm/imx: atomic phase 3 step 1: Use atomic configuration")

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 13d49002642b..a42288b8c7a4 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -94,7 +94,7 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
 	drm_crtc_vblank_off(crtc);
 
 	spin_lock_irq(&crtc->dev->event_lock);
-	if (crtc->state->event) {
+	if (crtc->state->event && !crtc->state->active) {
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		crtc->state->event = NULL;
 	}
-- 
2.20.1

