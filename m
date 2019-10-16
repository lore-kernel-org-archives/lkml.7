Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E511ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD821835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbfJPIzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:55:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46497 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389608AbfJPIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:55:17 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D3C15240006;
        Wed, 16 Oct 2019 08:55:14 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] drm: rcar-du: kms: Expand comment in vsps parsing routine
Date:   Wed, 16 Oct 2019 10:55:48 +0200
Message-Id: <20191016085548.105703-9-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016085548.105703-1-jacopo+renesas@jmondi.org>
References: <20191016085548.105703-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand comment in the 'vsps' parsing routine to specify the LIF
channel index defaults to 0 in case the second cell of the property
is not specified to remain compatible with older DT bindings.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 7c9fb5860e54..186422ac552b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -587,7 +587,11 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 
 		vsps[j].crtcs_mask |= BIT(i);
 
-		/* Store the VSP pointer and pipe index in the CRTC. */
+		/*
+		 * Store the VSP pointer and pipe index in the CRTC. If the
+		 * second cell of the 'vsps' specifier isn't present, default
+		 * to 0 to remain compatible with older DT bindings.
+		 */
 		rcdu->crtcs[i].vsp = &rcdu->vsps[j];
 		rcdu->crtcs[i].vsp_pipe = cells >= 1 ? args.args[0] : 0;
 	}
-- 
2.23.0

