Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C172186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n3HGNJYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfCNWEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:04:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58550 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:04:29 -0400
Received: from Q.home (cpc85428-aztw29-2-0-cust223.18-1.cable.virginm.net [82.38.144.224])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5C219C1;
        Thu, 14 Mar 2019 23:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552601067;
        bh=tFZzDQSiins0z+FbCXBBMZ3NrS/K7HgO0KGJYiv0tQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3HGNJYmi+TvIYrOtdPB2E8yXCE53GwuMSUdmm7QrTOqf4cpl+uPFYajnD0TpeoFr
         3rX6Yul9U0D5oEjgL2EsiQmmrSUBdUs9xyGL+SV3o46RNjBPSSf6aW5L38I7Vwb+7j
         BLBbf9MF0Trtf1EtvfwbbRr79WODtuJoVKH6FAPY=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/3] drm: rcar-du: crtc: make local functions static
Date:   Thu, 14 Mar 2019 22:04:19 +0000
Message-Id: <20190314220420.32487-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcar_du_crtc_mode_valid() and rcar_du_crtc_get_crc_sources()
functions are accessed only through a function pointer table.

Convert the function definitions to be static to the module.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 4cdea14d552f..57fd5c00494b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -761,8 +761,9 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
 		rcar_du_vsp_atomic_flush(rcrtc);
 }
 
-enum drm_mode_status rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
-				   const struct drm_display_mode *mode)
+static enum drm_mode_status
+rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
+			const struct drm_display_mode *mode)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_du_device *rcdu = rcrtc->group->dev;
@@ -981,8 +982,8 @@ static int rcar_du_crtc_verify_crc_source(struct drm_crtc *crtc,
 	return 0;
 }
 
-const char *const *rcar_du_crtc_get_crc_sources(struct drm_crtc *crtc,
-						size_t *count)
+static const char *const *
+rcar_du_crtc_get_crc_sources(struct drm_crtc *crtc, size_t *count)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-- 
2.19.1

