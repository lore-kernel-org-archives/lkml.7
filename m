Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfH2Lav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:30:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49894 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbfH2Laa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:30:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 344F81A015C;
        Thu, 29 Aug 2019 13:30:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 318A31A0010;
        Thu, 29 Aug 2019 13:30:28 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 318D020613;
        Thu, 29 Aug 2019 13:30:27 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] drm/mxsfb: Clear OUTSTANDING_REQS bits
Date:   Thu, 29 Aug 2019 14:30:13 +0300
Message-Id: <1567078215-31601-13-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
References: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 21 can alter the CTRL2_OUTSTANDING_REQS value right after the eLCDIF
is enabled, since it comes up with default value of 1 (this behaviour
has been seen on some imx8 platforms).
In order to fix this, clear CTRL2_OUTSTANDING_REQS bits before setting
its value.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Tested-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index e727f5e..a12f53d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -225,6 +225,13 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	clk_prepare_enable(mxsfb->clk);
 
 	if (mxsfb->devdata->ipversion >= 4) {
+		/*
+		 * On some platforms, bit 21 is defaulted to 1, which may alter
+		 * the below setting. So, to make sure we have the right setting
+		 * clear all the bits for CTRL2_OUTSTANDING_REQS.
+		 */
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 		       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
 		/* Assert LCD Reset bit */
-- 
2.7.4

