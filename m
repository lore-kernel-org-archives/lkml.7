Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F96C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7F208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329285;
	bh=9wxgPu0ztq6m1YVb/9c8SpBgLiynpp40Xv953t4reww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dsXAXuw1ra7CGblVa1aWZyQTKYgrmYGphe6JV3xpQ9IdcElOQcu/bgHBGNdoxA9j
	 uggDG0lSy08t34LzCiP7qsv0ntt99jbfkha0dYu5BjzFHkwYqPe/P+uPspMkWeiitN
	 4eCvVIOtEti/Twh9RdG46fsBzrD+QX0qOfXZsQ7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfD0BlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfD0BlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B48208CB;
        Sat, 27 Apr 2019 01:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329278;
        bh=9wxgPu0ztq6m1YVb/9c8SpBgLiynpp40Xv953t4reww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwydyf5bEXcQNs+Sf6BVOGfHjZ/nEuHED1fg1lb90XuJY3URFkFtPG6UmBDB1uC2g
         STiOnekVvkWRTaxR6fDQ/HFUFt368hKqfk432L/H0VvJmzmbmXMrmajOBCLiEEYjD3
         zBvUXFFqPyss+NVQPVkLfSPsY+5QAlwMlkSvXkU0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 18/53] drm/omap: hdmi4_cec: Fix CEC clock handling for PM
Date:   Fri, 26 Apr 2019 21:40:15 -0400
Message-Id: <20190427014051.7522-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 36a1da15b5df493241b0011d2185fdd724ac1ed1 ]

If CONFIG_OMAP4_DSS_HDMI_CEC is enabled in .config, deeper SoC idle
states are blocked because the CEC clock gets always enabled on init.

Let's fix the issue by moving the CEC clock handling to happen later in
hdmi_cec_adap_enable() as suggested by Hans Verkuil <hverkuil@xs4all.nl>.
This way the CEC clock gets only enabled when needed. This can be tested
by doing cec-ctl --playback to enable the CEC, and doing cec-ctl --clear
to disable it.

Let's also fix the typo for "divider" in the comments while at it.

Fixes: 8d7f934df8d8 ("omapdrm: hdmi4_cec: add OMAP4 HDMI CEC support")
Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190326151438.32414-1-tony@atomide.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
index 340383150fb9..ebf9c96d43ee 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
@@ -175,6 +175,7 @@ static int hdmi_cec_adap_enable(struct cec_adapter *adap, bool enable)
 		REG_FLD_MOD(core->base, HDMI_CORE_SYS_INTR_UNMASK4, 0, 3, 3);
 		hdmi_wp_clear_irqenable(core->wp, HDMI_IRQ_CORE);
 		hdmi_wp_set_irqstatus(core->wp, HDMI_IRQ_CORE);
+		REG_FLD_MOD(core->wp->base, HDMI_WP_CLK, 0, 5, 0);
 		hdmi4_core_disable(core);
 		return 0;
 	}
@@ -182,16 +183,24 @@ static int hdmi_cec_adap_enable(struct cec_adapter *adap, bool enable)
 	if (err)
 		return err;
 
+	/*
+	 * Initialize CEC clock divider: CEC needs 2MHz clock hence
+	 * set the divider to 24 to get 48/24=2MHz clock
+	 */
+	REG_FLD_MOD(core->wp->base, HDMI_WP_CLK, 0x18, 5, 0);
+
 	/* Clear TX FIFO */
 	if (!hdmi_cec_clear_tx_fifo(adap)) {
 		pr_err("cec-%s: could not clear TX FIFO\n", adap->name);
-		return -EIO;
+		err = -EIO;
+		goto err_disable_clk;
 	}
 
 	/* Clear RX FIFO */
 	if (!hdmi_cec_clear_rx_fifo(adap)) {
 		pr_err("cec-%s: could not clear RX FIFO\n", adap->name);
-		return -EIO;
+		err = -EIO;
+		goto err_disable_clk;
 	}
 
 	/* Clear CEC interrupts */
@@ -236,6 +245,12 @@ static int hdmi_cec_adap_enable(struct cec_adapter *adap, bool enable)
 		hdmi_write_reg(core->base, HDMI_CEC_INT_STATUS_1, temp);
 	}
 	return 0;
+
+err_disable_clk:
+	REG_FLD_MOD(core->wp->base, HDMI_WP_CLK, 0, 5, 0);
+	hdmi4_core_disable(core);
+
+	return err;
 }
 
 static int hdmi_cec_adap_log_addr(struct cec_adapter *adap, u8 log_addr)
@@ -333,11 +348,8 @@ int hdmi4_cec_init(struct platform_device *pdev, struct hdmi_core_data *core,
 		return ret;
 	core->wp = wp;
 
-	/*
-	 * Initialize CEC clock divider: CEC needs 2MHz clock hence
-	 * set the devider to 24 to get 48/24=2MHz clock
-	 */
-	REG_FLD_MOD(core->wp->base, HDMI_WP_CLK, 0x18, 5, 0);
+	/* Disable clock initially, hdmi_cec_adap_enable() manages it */
+	REG_FLD_MOD(core->wp->base, HDMI_WP_CLK, 0, 5, 0);
 
 	ret = cec_register_adapter(core->adap, &pdev->dev);
 	if (ret < 0) {
-- 
2.19.1

