Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2486220835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfJFQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:04:51 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47405 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJFQEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:04:51 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 1475B8289D;
        Sun,  6 Oct 2019 16:04:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 3/3] drm/sun4i: sun6i_mipi_dsi: fix DCS long write packet length
Date:   Mon,  7 Oct 2019 00:03:02 +0800
Message-Id: <20191006160303.24413-4-icenowy@aosc.io>
In-Reply-To: <20191006160303.24413-1-icenowy@aosc.io>
References: <20191006160303.24413-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The packet length of DCS long write packet should not be added with 1
when constructing long write packet.

Fix this.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8fe8051c34e6..c958ca9bae63 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -832,8 +832,8 @@ static u32 sun6i_dsi_dcs_build_pkt_hdr(struct sun6i_dsi *dsi,
 	u32 pkt = msg->type;
 
 	if (msg->type == MIPI_DSI_DCS_LONG_WRITE) {
-		pkt |= ((msg->tx_len + 1) & 0xffff) << 8;
-		pkt |= (((msg->tx_len + 1) >> 8) & 0xffff) << 16;
+		pkt |= ((msg->tx_len) & 0xffff) << 8;
+		pkt |= (((msg->tx_len) >> 8) & 0xffff) << 16;
 	} else {
 		pkt |= (((u8 *)msg->tx_buf)[0] << 8);
 		if (msg->tx_len > 1)
-- 
2.21.0

