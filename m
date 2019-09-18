Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13F021897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfIRIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:47:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40225 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbfIRIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:47:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAVcr-0001B8-T8; Wed, 18 Sep 2019 10:47:49 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAVcq-0007mf-Bu; Wed, 18 Sep 2019 10:47:48 +0200
Date:   Wed, 18 Sep 2019 10:47:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] of: restore old handling of cells_name=NULL in
 of_*_phandle_with_args()
Message-ID: <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
References: <20190918063837.8196-1-u.kleine-koenig@pengutronix.de>
 <b00ca30f-2c06-7722-96b2-123d15751cb6@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00ca30f-2c06-7722-96b2-123d15751cb6@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

On Wed, Sep 18, 2019 at 08:01:05AM +0000, Peter Rosin wrote:
> On 2019-09-18 08:38, Uwe Kleine-König wrote:
> >  EXPORT_SYMBOL(of_parse_phandle_with_args);
> >  
> > @@ -1765,6 +1779,18 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
> >  	struct of_phandle_iterator it;
> >  	int rc, cur_index = 0;
> >  
> > +	/* If cells_name is NULL we assume a cell count of 0 */
> > +	if (cells_name == NULL) {
> 
> A couple of nits.
> 
> I don't know if there are other considerations, but in the previous two
> hunks you use !cells_name instead of comparing explicitly with NULL.
> Personally, I find the shorter form more readable, and in the name of
> consistency bla bla...

Ack, changed to !cells_name here, too.

> 
> Also, the comment explaining this NULL-check didn't really make sense
> to me until I realized that knowing the cell count to be zero makes
> counting trivial. Something along those lines should perhaps be in the
> comment?

You're right, I extended the comment a bit.
 
> But as I said, these are nits. Feel free to ignore.

I considered resending already anyhow as I fatfingerd my email address.
this is fixed now, too. Additionally I fixed a typo in one of the
comments.

Thanks for your feedback.

Best regards
Uwe

 drivers/of/base.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 2f25d2dfecfa..1d667eb730e1 100644
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
+	/* If cells_name is NULL we assume a cell count of 0 */
+	if (!cells_name)
+		cell_count = 0;
+
+	return __of_parse_phandle_with_args(np, list_name, cells_name,
+					    cell_count, index, out_args);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
@@ -1765,6 +1779,23 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
+	/*
+	 * If cells_name is NULL we assume a cell count of 0. This makes
+	 * counting the phandles trivial as each 32bit word in the list is a
+	 * phandle and no arguments are to consider. So we don't iterate through
+	 * the list but just use the length to determine the phandle count.
+	 */
+	if (!cells_name) {
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


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
