Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C61C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5F20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439635AbfIWMwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:52:37 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:59210 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439605AbfIWMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:36 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.128])
        by regular1.263xmail.com (Postfix) with ESMTP id 907B23E4;
        Mon, 23 Sep 2019 20:52:27 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15436T140160991741696S1569243121384240_;
        Mon, 23 Sep 2019 20:52:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e6bfbf9941a2acc204e22cd8bc1ef476>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/36] drm/hisilicon: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:51:47 +0800
Message-Id: <1569243119-183293-4-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
References: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index cc4c417..6bfb327 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -122,11 +122,11 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 
 	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
 
-	reg = state->fb->width * (state->fb->format->cpp[0]);
+	reg = state->fb->width * (state->fb->format->bpp[0] / 8);
 	/* now line_pad is 16 */
 	reg = PADDING(16, reg);
 
-	line_l = state->fb->width * state->fb->format->cpp[0];
+	line_l = state->fb->width * state->fb->format->bpp[0] / 8;
 	line_l = PADDING(16, line_l);
 	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
 	       HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
@@ -136,7 +136,7 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 	reg = readl(priv->mmio + HIBMC_CRT_DISP_CTL);
 	reg &= ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
 	reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT,
-			   state->fb->format->cpp[0] * 8 / 16);
+			   state->fb->format->bpp[0] / 16);
 	writel(reg, priv->mmio + HIBMC_CRT_DISP_CTL);
 }
 
-- 
2.7.4



