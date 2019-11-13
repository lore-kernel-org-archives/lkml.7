Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80752245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKMKEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:04:34 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53069 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfKMKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:04:31 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.lan (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41675C0002;
        Wed, 13 Nov 2019 10:04:27 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/7] drm: rcar-du: kms: Expand comment in vsps parsing routine
Date:   Wed, 13 Nov 2019 11:05:56 +0100
Message-Id: <20191113100556.15616-8-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191113100556.15616-1-jacopo+renesas@jmondi.org>
References: <20191113100556.15616-1-jacopo+renesas@jmondi.org>
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

