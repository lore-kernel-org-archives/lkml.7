Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D12218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfIRGiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:38:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58463 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRGiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:38:52 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iATc2-0003Vb-Bq; Wed, 18 Sep 2019 08:38:50 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iATby-0003FW-Lw; Wed, 18 Sep 2019 08:38:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: restore old handling of cells_name=NULL in of_*_phandle_with_args()
Date:   Wed, 18 Sep 2019 08:38:37 +0200
Message-Id: <20190918063837.8196-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Before commit e42ee61017f5 ("of: Let of_for_each_phandle fallback to
non-negative cell_count") the iterator functions calling
of_for_each_phandle assumed a cell count of 0 if cells_name was NULL.
This corner case was missed when implementing the fallback logic in
e42ee61017f5 and resulted in an endless loop.

Restore the old behaviour of of_count_phandle_with_args() and
of_parse_phandle_with_args() and add a check to
of_phandle_iterator_init() to prevent a similar failure as a safety
precaution. of_parse_phandle_with_args_map() doesn't need a similar fix
as cells_name isn't NULL there.

Affected drivers are:
 - drivers/base/power/domain.c
 - drivers/base/power/domain.c
 - drivers/clk/ti/clk-dra7-atl.c
 - drivers/hwmon/ibmpowernv.c
 - drivers/i2c/muxes/i2c-demux-pinctrl.c
 - drivers/iommu/mtk_iommu.c
 - drivers/net/ethernet/freescale/fman/mac.c
 - drivers/opp/of.c
 - drivers/perf/arm_dsu_pmu.c
 - drivers/regulator/of_regulator.c
 - drivers/remoteproc/imx_rproc.c
 - drivers/soc/rockchip/pm_domains.c
 - sound/soc/fsl/imx-audmix.c
 - sound/soc/fsl/imx-audmix.c
 - sound/soc/meson/axg-card.c
 - sound/soc/samsung/tm2_wm5110.c
 - sound/soc/samsung/tm2_wm5110.c

Thanks to Geert Uytterhoeven for reporting the issue, Peter Rosin for
helping pinpoint the actual problem and the testers for confirming this
fix.

Fixes: e42ee61017f5 ("of: Let of_for_each_phandle fallback to non-negative cell_count")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to the untested patch I sent yesterday I also fixed
of_parse_phandle_with_args which has three users that pass
cells_name=NULL. (i.e. drivers/clk/ti/clk-dra7-atl.c,
sound/soc/fsl/imx-audmix.c, sound/soc/samsung/tm2_wm5110.c) I didn't
look closely, but maybe these could be converted to use of_parse_phandle
as there are no arguments to be processed with no cells_name?!

Best regards
Uwe

 drivers/of/base.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 2f25d2dfecfa..25ee07c0a3cd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1286,6 +1286,13 @@ int of_phandle_iterator_init(struct of_phandle_iterator *it,
 
 	memset(it, 0, sizeof(*it));
 
+	/*
+	 * one of cell_count or cells_name must be provided to determine the
+	 * argument length.
+	 */
+	if (cell_count < 0 && !cells_name)
+		return -EINVAL;
+
 	list = of_get_property(np, list_name, &size);
 	if (!list)
 		return -ENOENT;
@@ -1512,10 +1519,17 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 				const char *cells_name, int index,
 				struct of_phandle_args *out_args)
 {
+	int cell_count = -1;
+
 	if (index < 0)
 		return -EINVAL;
-	return __of_parse_phandle_with_args(np, list_name, cells_name, -1,
-					    index, out_args);
+
+	/* If cells_name if NULL we assume a cell count of 0 */
+	if (!cells_name)
+		cell_count = 0;
+
+	return __of_parse_phandle_with_args(np, list_name, cells_name,
+					    cell_count, index, out_args);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
@@ -1765,6 +1779,18 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
+	/* If cells_name is NULL we assume a cell count of 0 */
+	if (cells_name == NULL) {
+		const __be32 *list;
+		int size;
+
+		list = of_get_property(np, list_name, &size);
+		if (!list)
+			return -ENOENT;
+
+		return size / sizeof(*list);
+	}
+
 	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, -1);
 	if (rc)
 		return rc;
-- 
2.23.0

