Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C874C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE852067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfHEJNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:13:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62353 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728043AbfHEJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:12:13 -0400
X-UUID: fe19b9b578884a7a87e4e5a1674b2092-20190805
X-UUID: fe19b9b578884a7a87e4e5a1674b2092-20190805
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 2007482889; Mon, 05 Aug 2019 17:12:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 5 Aug 2019 17:12:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Aug 2019 17:12:06 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH 07/11] pinctrl: mediatek: add mt6779 eint support
Date:   Mon, 5 Aug 2019 17:11:56 +0800
Message-ID: <1564996320-10897-8-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
References: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add driver setting to support mt6779 eint

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt6779.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
index 145bf22..49ff3cc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6779.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
@@ -731,11 +731,19 @@
 	"iocfg_rt", "iocfg_lt", "iocfg_tl",
 };
 
+static const struct mtk_eint_hw mt6779_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 209,
+	.db_cnt    = 16,
+};
+
 static const struct mtk_pin_soc mt6779_data = {
 	.reg_cal = mt6779_reg_cals,
 	.pins = mtk_pins_mt6779,
 	.npins = ARRAY_SIZE(mtk_pins_mt6779),
 	.ngrps = ARRAY_SIZE(mtk_pins_mt6779),
+	.eint_hw = &mt6779_eint_hw,
 	.gpio_m = 0,
 	.ies_present = true,
 	.base_names = mt6779_pinctrl_register_base_names,
-- 
1.7.9.5

