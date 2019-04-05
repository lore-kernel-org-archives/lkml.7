Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33189C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62AD21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="hGM5kXEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDEXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:31:03 -0400
Received: from vps.xff.cz ([195.181.215.36]:52628 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfDEXbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554507059; bh=5FBBWDSpPtZMdhBDFsBPV22g8KeWvr/wPWjm6s61Oow=;
        h=From:To:Cc:Subject:Date:From;
        b=hGM5kXEOuATeYK5LJtWwc85HVTo5yIY0BxLXlvoBsTxLJzXygRnCNBGVaYx0WdE3l
         m3YRs/1Lkuln6lpTwhfs43Lrd4Y80ukCKOK/4bEx+nLRd/bSWS6NHC2KLhKIO9ba9u
         idYFR9ehU0h9HWAM4g5DSosTT5dem/rndjOvJavE=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: sun4i: Fix NULL/invalid pointer dereference in sun8i_tcon_top_un/bind
Date:   Sat,  6 Apr 2019 01:30:48 +0200
Message-Id: <20190405233048.3823-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

There are two problems here:

1. Not all clk_data->hws[] need to be initialized, depending on various
   configured quirks. This leads to NULL ptr deref in
   clk_hw_unregister_gate() in sun8i_tcon_top_unbind()
2. If there is error when registering the clk_data->hws[],
   err_unregister_gates error path will try to unregister
   IS_ERR()=true (invalid) pointer.

For problem (1) I have this stack trace:

Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000008
Call trace:
 clk_hw_unregister+0x8/0x18
 clk_hw_unregister_gate+0x14/0x28
 sun8i_tcon_top_unbind+0x2c/0x60
 component_unbind.isra.4+0x2c/0x50
 component_bind_all+0x1d4/0x230
 sun4i_drv_bind+0xc4/0x1a0
 try_to_bring_up_master+0x164/0x1c0
 __component_add+0xa0/0x168
 component_add+0x10/0x18
 sun8i_dw_hdmi_probe+0x18/0x20
 platform_drv_probe+0x3c/0x70
 really_probe+0xcc/0x278
 driver_probe_device+0x34/0xa8

Problem (2) was identified by head scratching.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index fc36e0c10a37..b1e7c76e9c17 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -227,7 +227,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 
 err_unregister_gates:
 	for (i = 0; i < CLK_NUM; i++)
-		if (clk_data->hws[i])
+		if (!IS_ERR_OR_NULL(clk_data->hws[i]))
 			clk_hw_unregister_gate(clk_data->hws[i]);
 	clk_disable_unprepare(tcon_top->bus);
 err_assert_reset:
@@ -245,7 +245,8 @@ static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
 
 	of_clk_del_provider(dev->of_node);
 	for (i = 0; i < CLK_NUM; i++)
-		clk_hw_unregister_gate(clk_data->hws[i]);
+		if (clk_data->hws[i])
+			clk_hw_unregister_gate(clk_data->hws[i]);
 
 	clk_disable_unprepare(tcon_top->bus);
 	reset_control_assert(tcon_top->rst);
-- 
2.21.0

