Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E25C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED7B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfILJEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:04:22 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17493 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730571AbfILJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:04:20 -0400
X-UUID: 8c39693336454b4b99f520b792409639-20190912
X-UUID: 8c39693336454b4b99f520b792409639-20190912
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 541960630; Thu, 12 Sep 2019 17:04:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Sep
 2019 17:04:09 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 12 Sep 2019 17:04:09 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 3/3] drm/panel: panel-innolux: Add support for P097PFZ behind SSD2858
Date:   Thu, 12 Sep 2019 17:04:04 +0800
Message-ID: <20190912090404.89822-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912090404.89822-1-jitao.shi@mediatek.com>
References: <20190912090404.89822-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 8277112D4DE284E7189B77DFE9C77F681CBCBFC38380D94183C83199343503D02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver to setup P097PFZ behing SSD2858 (4 to 8 lanes bridge).

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 8db404fb5eeb..a658ccba30a0 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -138,7 +138,7 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 		if (!innolux->enable_gpio[i])
 			break;
 
-		/* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
+		/* p079zca: t2 (20ms), p097pfg: t4 (15ms); ssd2858: 20ms */
 		usleep_range(20000, 21000);
 		gpiod_set_value_cansleep(innolux->enable_gpio[i], 1);
 	}
@@ -162,6 +162,18 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 				goto poweroff;
 			}
 
+			/*
+			 * If the command list contains exit sleep mode or set
+			 * display on, wait the appropriate time (needed for
+			 * displays behind a bridge).
+			 */
+			/* T6: 120ms - 1000ms*/
+			if (cmd->data[0] == MIPI_DCS_EXIT_SLEEP_MODE)
+				msleep(120);
+			 /* T7: 5ms */
+			if (cmd->data[0] == MIPI_DCS_SET_DISPLAY_ON)
+				usleep_range(5000, 6000);
+
 			/*
 			 * Included by random guessing, because without this
 			 * (or at least, some delay), the panel sometimes
@@ -410,6 +422,92 @@ static const struct panel_desc innolux_p097pfg_panel_desc = {
 	.sleep_mode_delay = 100, /* T15 */
 };
 
+static const char * const innolux_p097pfg_ssd2858_supply_names[] = {
+	"avdd",
+	"avee",
+	"pp1800",
+	"pp3300",
+	"pp1200-bridge",
+	"vddio-bridge",
+};
+
+static const struct drm_display_mode innolux_p097pfg_ssd2858_mode = {
+	.clock = 211660,
+	.hdisplay = 1536,
+	.hsync_start = 1536 + 140,
+	.hsync_end = 1536 + 140 + 10,
+	.htotal = 1536 + 140 + 10 + 10,
+	.vdisplay = 2048,
+	.vsync_start = 2048 + 20,
+	.vsync_end = 2048 + 20 + 2,
+	.vtotal = 2048 + 20 + 2 + 10,
+	.vrefresh = 60,
+};
+
+static const struct panel_init_cmd innolux_p097pfg_ssd2858_init_cmds[] = {
+	/* SSD2858 config */
+	_INIT_CMD(0xff, 0x00),
+	/* LOCKCNT=0x1f4, MRX=0, POSTDIV=1 (/2), MULT=0x49
+	 * 27 Mhz => 985.5 Mhz
+	 */
+	_INIT_CMD(0x00, 0x08, 0x01, 0xf4, 0x01, 0x49),
+	/* MTXDIV=1, SYSDIV=3 (=> 4) */
+	_INIT_CMD(0x00, 0x0c, 0x00, 0x00, 0x00, 0x03),
+	/* MTXVPF=24bpp, MRXLS=4 lanes, MRXVB=bypass, MRXECC=1, MRXEOT=1
+	 * MRXEE=1
+	 */
+	_INIT_CMD(0x00, 0x14, 0x0c, 0x3d, 0x80, 0x0f),
+	_INIT_CMD(0x00, 0x20, 0x15, 0x92, 0x56, 0x7d),
+	_INIT_CMD(0x00, 0x24, 0x00, 0x00, 0x30, 0x00),
+
+	_INIT_CMD(0x10, 0x08, 0x01, 0x20, 0x08, 0x45),
+	_INIT_CMD(0x10, 0x1c, 0x00, 0x00, 0x00, 0x00),
+	_INIT_CMD(0x20, 0x0c, 0x00, 0x00, 0x00, 0x04),
+	/* Pixel clock 985.5 Mhz * 0x49/0x4b = 959 Mhz */
+	_INIT_CMD(0x20, 0x10, 0x00, 0x4b, 0x00, 0x49),
+	_INIT_CMD(0x20, 0xa0, 0x00, 0x00, 0x00, 0x00),
+	/* EOT=1, LPE = 0, LSOUT=4 lanes, LPD=25 */
+	_INIT_CMD(0x60, 0x08, 0x00, 0xd9, 0x00, 0x08),
+	_INIT_CMD(0x60, 0x14, 0x01, 0x00, 0x01, 0x06),
+	/* DSI0 enable (default: probably not needed) */
+	_INIT_CMD(0x60, 0x80, 0x00, 0x00, 0x00, 0x0f),
+	/* DSI1 enable */
+	_INIT_CMD(0x60, 0xa0, 0x00, 0x00, 0x00, 0x0f),
+
+	/* HSA=0x18, VSA=0x02, HBP=0x50, VBP=0x0c */
+	_INIT_CMD(0x60, 0x0c, 0x0c, 0x50, 0x02, 0x18),
+	/* VACT= 0x800 (2048), VFP= 0x14, HFP=0x50 */
+	_INIT_CMD(0x60, 0x10, 0x08, 0x00, 0x14, 0x50),
+	/* HACT=0x300 (768) */
+	_INIT_CMD(0x60, 0x84, 0x00, 0x00, 0x03, 0x00),
+	_INIT_CMD(0x60, 0xa4, 0x00, 0x00, 0x03, 0x00),
+
+	/* Take panel out of sleep. */
+	_INIT_CMD(0xff, 0x01),
+	_INIT_CMD(0x11),
+	_INIT_CMD(0x29),
+	_INIT_CMD(0xff, 0x00),
+
+	{},
+};
+
+static const struct panel_desc innolux_p097pfg_ssd2858_panel_desc = {
+	.mode = &innolux_p097pfg_ssd2858_mode,
+	.bpc = 8,
+	.size = {
+		.width = 147,
+		.height = 196,
+	},
+	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		 MIPI_DSI_MODE_LPM,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_cmds = innolux_p097pfg_ssd2858_init_cmds,
+	.lanes = 4,
+	.supply_names = innolux_p097pfg_ssd2858_supply_names,
+	.num_supplies = ARRAY_SIZE(innolux_p097pfg_ssd2858_supply_names),
+	.sleep_mode_delay = 100, /* T15 */
+};
+
 static int innolux_panel_get_modes(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
@@ -451,6 +549,9 @@ static const struct of_device_id innolux_of_match[] = {
 	{ .compatible = "innolux,p097pfg",
 	  .data = &innolux_p097pfg_panel_desc
 	},
+	{ .compatible = "innolux,p097pfg_ssd2858",
+	  .data = &innolux_p097pfg_ssd2858_panel_desc
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, innolux_of_match);
-- 
2.21.0

