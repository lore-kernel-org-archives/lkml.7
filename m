Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE42C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2752178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfKFIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:18:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730205AbfKFIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:18:26 -0500
X-UUID: 25253dab0afd47488c94f4ba8422e5a9-20191106
X-UUID: 25253dab0afd47488c94f4ba8422e5a9-20191106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1504382312; Wed, 06 Nov 2019 16:18:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Nov
 2019 16:17:58 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 6 Nov 2019 16:17:57 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 1/1] drm/panel: boe-tv101wum-n16 seperate the panel power control
Date:   Wed, 6 Nov 2019 16:17:52 +0800
Message-ID: <20191106081752.12944-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106081752.12944-1-jitao.shi@mediatek.com>
References: <20191106081752.12944-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 7250D2CDEDEBC5411FF78CEBCF2F72549F4795A771E1D586B2B3B5E503F1CC012000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seperate the panel power control from prepare/unprepare.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 69 +++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index e2496a334ab6..5b1b285a2194 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -50,6 +50,7 @@ struct boe_panel {
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
 
+	bool prepared_power;
 	bool prepared;
 	bool enabled;
 
@@ -501,12 +502,11 @@ static int boe_panel_disable(struct drm_panel *panel)
 	return 0;
 }
 
-static int boe_panel_unprepare(struct drm_panel *panel)
+static int boe_panel_unprepare_power(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
-	int ret;
 
-	if (!boe->prepared)
+	if (!boe->prepared_power)
 		return 0;
 
 	if (boe->desc->discharge_on_disable) {
@@ -518,12 +518,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
 	} else {
-		ret = boe_panel_off(boe);
-		if (ret < 0) {
-			dev_err(panel->dev, "failed to set panel off: %d\n",
-				ret);
-			return ret;
-		}
 		msleep(150);
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(500, 1000);
@@ -533,17 +527,39 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->pp1800);
 	}
 
+	boe->prepared_power = false;
+
+	return 0;
+}
+
+static int boe_panel_unprepare(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+	int ret;
+
+	if (!boe->prepared)
+		return 0;
+
+	if (!boe->desc->discharge_on_disable) {
+		ret = boe_panel_off(boe);
+		if (ret < 0) {
+			dev_err(panel->dev, "failed to set panel off: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	boe->prepared = false;
 
 	return 0;
 }
 
-static int boe_panel_prepare(struct drm_panel *panel)
+static int boe_panel_prepare_power(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (boe->prepared)
+	if (boe->prepared_power)
 		return 0;
 
 	gpiod_set_value(boe->enable_gpio, 0);
@@ -571,18 +587,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(boe->enable_gpio, 1);
 	usleep_range(6000, 10000);
 
-	ret = boe_panel_init(boe);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to init panel: %d\n", ret);
-		goto poweroff;
-	}
-
-	boe->prepared = true;
+	boe->prepared_power = true;
 
 	return 0;
 
-poweroff:
-	regulator_disable(boe->avee);
 poweroffavdd:
 	regulator_disable(boe->avdd);
 poweroff1v8:
@@ -593,6 +601,25 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	return ret;
 }
 
+static int boe_panel_prepare(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+	int ret;
+
+	if (boe->prepared)
+		return 0;
+
+	ret = boe_panel_init(boe);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to init panel: %d\n", ret);
+		return ret;
+	}
+
+	boe->prepared = true;
+
+	return 0;
+}
+
 static int boe_panel_enable(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
@@ -754,7 +781,9 @@ static int boe_panel_get_modes(struct drm_panel *panel)
 static const struct drm_panel_funcs boe_panel_funcs = {
 	.disable = boe_panel_disable,
 	.unprepare = boe_panel_unprepare,
+	.unprepare_power = boe_panel_unprepare_power,
 	.prepare = boe_panel_prepare,
+	.prepare_power = boe_panel_prepare_power,
 	.enable = boe_panel_enable,
 	.get_modes = boe_panel_get_modes,
 };
-- 
2.21.0

