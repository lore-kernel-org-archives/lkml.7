Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD629C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfILJER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:04:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:49104 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730175AbfILJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:04:15 -0400
X-UUID: 0abdc5f495c342769c8ae9b057f1da33-20190912
X-UUID: 0abdc5f495c342769c8ae9b057f1da33-20190912
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2122001776; Thu, 12 Sep 2019 17:04:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Sep
 2019 17:04:07 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 12 Sep 2019 17:04:06 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, "Jitao Shi" <jitao.shi@mediatek.com>
Subject: [PATCH 1/3] drm/panel: panel-innolux: Allow 2 reset pins for panel
Date:   Thu, 12 Sep 2019 17:04:02 +0800
Message-ID: <20190912090404.89822-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912090404.89822-1-jitao.shi@mediatek.com>
References: <20190912090404.89822-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24906.005
X-TM-AS-Result: No-3.482500-8.000000-10
X-TMASE-MatchedRID: ddD75cirPhHnC5LyYJwD3+w8wbnnSw8bE1YUt4FjGjGOUV82NDH4AkAc
        6DyoS2rIR3nAM7y+sxETtSzome9IZ7CiYRGPyK4M8pRHzcG+oi3YuVu0X/rOkEjINjnv2/BMaeB
        VQN/hzxi+9mDuGGWszp+Jh3xpp8VmhHuyNMgLmzZuh7qwx+D6T215iJF8eE6rEcWQUCNHW2cqEb
        nPD99jLOLzNWBegCW2xl8lw85EaVQLbigRnpKlKZx+7GyJjhAUHVoP4CnZRLgKlej7lZNBBZnY9
        iocmdMNe2YXCayCdjwmnmSLDgNB1oXzGOuEat/KMrIruREPgvSMLZHCmHrIk/tVq5MU5p/aP3dL
        jnWr1vEPbJpLSCH/cqQVCHnxhZ/op8zfhMu4/LNfCOKFKuVYGg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.482500-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24906.005
X-TM-SNTS-SMTP: E4F648F69210E4E188561AB3D0B1E5421CA2CF56404EA44D23DA6D017FC8E07B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful when there is a bridge between the SoC and the
panel.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index d92d1c98878c..8db404fb5eeb 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -54,7 +54,7 @@ struct innolux_panel {
 
 	struct backlight_device *backlight;
 	struct regulator_bulk_data *supplies;
-	struct gpio_desc *enable_gpio;
+	struct gpio_desc *enable_gpio[2];
 
 	bool prepared;
 	bool enabled;
@@ -82,7 +82,7 @@ static int innolux_panel_disable(struct drm_panel *panel)
 static int innolux_panel_unprepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
+	int err, i;
 
 	if (!innolux->prepared)
 		return 0;
@@ -102,7 +102,8 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (innolux->desc->sleep_mode_delay)
 		msleep(innolux->desc->sleep_mode_delay);
 
-	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
+	for (i = 0; i < ARRAY_SIZE(innolux->enable_gpio); i++)
+		gpiod_set_value_cansleep(innolux->enable_gpio[i], 0);
 
 	if (innolux->desc->power_down_delay)
 		msleep(innolux->desc->power_down_delay);
@@ -120,22 +121,27 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 static int innolux_panel_prepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
+	int err, i;
 
 	if (innolux->prepared)
 		return 0;
 
-	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
+	for (i = 0; i < ARRAY_SIZE(innolux->enable_gpio); i++)
+		gpiod_set_value_cansleep(innolux->enable_gpio[i], 0);
 
 	err = regulator_bulk_enable(innolux->desc->num_supplies,
 				    innolux->supplies);
 	if (err < 0)
 		return err;
 
-	/* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
-	usleep_range(20000, 21000);
+	for (i = 0; i < ARRAY_SIZE(innolux->enable_gpio); i++) {
+		if (!innolux->enable_gpio[i])
+			break;
 
-	gpiod_set_value_cansleep(innolux->enable_gpio, 1);
+		/* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
+		usleep_range(20000, 21000);
+		gpiod_set_value_cansleep(innolux->enable_gpio[i], 1);
+	}
 
 	/* p079zca: t4, p097pfg: t5 */
 	usleep_range(20000, 21000);
@@ -195,7 +201,8 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
-	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
+	for (i = 0; i < ARRAY_SIZE(innolux->enable_gpio); i++)
+		gpiod_set_value_cansleep(innolux->enable_gpio[i], 0);
 	regulator_bulk_disable(innolux->desc->num_supplies, innolux->supplies);
 
 	return err;
@@ -475,12 +482,14 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 	if (err < 0)
 		return err;
 
-	innolux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
-						       GPIOD_OUT_HIGH);
-	if (IS_ERR(innolux->enable_gpio)) {
-		err = PTR_ERR(innolux->enable_gpio);
-		dev_dbg(dev, "failed to get enable gpio: %d\n", err);
-		innolux->enable_gpio = NULL;
+	for (i = 0; i < ARRAY_SIZE(innolux->enable_gpio); i++) {
+		innolux->enable_gpio[i] = devm_gpiod_get_index_optional(dev,
+						"enable", i, GPIOD_OUT_HIGH);
+		if (IS_ERR(innolux->enable_gpio[i])) {
+			err = PTR_ERR(innolux->enable_gpio[i]);
+			dev_err(dev, "failed to get enable gpio: %d\n", err);
+			innolux->enable_gpio[i] = NULL;
+		}
 	}
 
 	innolux->backlight = devm_of_find_backlight(dev);
-- 
2.21.0

