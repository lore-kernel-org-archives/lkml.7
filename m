Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DBC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0750D208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329198;
	bh=ZcKA9maUs8wPxK/DeGl7T69bgCwW57FiMCoL99ilaTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHxkToO0R6D6qlOtnf2oepsH1ZAdk7rxS61+dG0x7y0/ZXsZ/2+YFEblut4tlmvmU
	 DJ7uII/X5Ff+rpoJ9fib72k4HcwJyPJ1cO+CeVrgRLiko1zbmNGcL6bRcH+WOJKOI9
	 wGGdIB2ihz0YMgeW+EVBofbT02fILals1/uQhCvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfD0Bj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfD0Bjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2F52173E;
        Sat, 27 Apr 2019 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329192;
        bh=ZcKA9maUs8wPxK/DeGl7T69bgCwW57FiMCoL99ilaTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsISPIFmJT1mdGn+Lf/WvXHkuxMzY1sZInBwBSB3OZuAdZllJAGUXN+/xLrKgf2vq
         JZ9+A8KXQp5Rgv5+mbiwPqXgz0OUI+emhQFQDlSji51ZUs49SLzI5nQOUAN7KqmtD8
         yuHRtVAHGuAI+zLLOSa9Dx4lQeIIub3pAqFcY6V0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 47/79] drm/sun4i: tcon top: Fix NULL/invalid pointer dereference in sun8i_tcon_top_un/bind
Date:   Fri, 26 Apr 2019 21:38:06 -0400
Message-Id: <20190427013838.6596-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit 1a07a94b47b1f528f39c3e6187b5eaf02efe44ea ]

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
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190405233048.3823-1-megous@megous.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

