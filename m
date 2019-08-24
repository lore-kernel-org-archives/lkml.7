Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D18C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 13:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD9B21670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 13:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfHXN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 09:29:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51991 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfHXN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 09:29:11 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1W6P-0006OD-5g; Sat, 24 Aug 2019 15:29:09 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1W6L-0002FP-2q; Sat, 24 Aug 2019 15:29:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to non-negative cell_count
Date:   Sat, 24 Aug 2019 15:28:46 +0200
Message-Id: <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referencing device tree nodes from a property allows to pass arguments.
This is for example used for referencing gpios. This looks as follows:

	gpio_ctrl: gpio-controller {
		#gpio-cells = <2>
		...
	}

	someothernode {
		gpios = <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
		...
	}

To know the number of arguments this must be either fixed, or the
referenced node is checked for a $cells_name (here: "#gpio-cells")
property and with this information the start of the second reference can
be determined.

Currently regulators are referenced with no additional arguments. To
allow some optional arguments without having to change all referenced
nodes this change introduces a way to specify a default cell_count. So
when a phandle is parsed we check for the $cells_name property and use
it as before if present. If it is not present we fall back to
cells_count if non-negative and only fail if cells_count is smaller than
zero.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/of/base.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 55e7f5bb0549..2f25d2dfecfa 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1335,11 +1335,20 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 
 			if (of_property_read_u32(it->node, it->cells_name,
 						 &count)) {
-				pr_err("%pOF: could not get %s for %pOF\n",
-				       it->parent,
-				       it->cells_name,
-				       it->node);
-				goto err;
+				/*
+				 * If both cell_count and cells_name is given,
+				 * fall back to cell_count in absence
+				 * of the cells_name property
+				 */
+				if (it->cell_count >= 0) {
+					count = it->cell_count;
+				} else {
+					pr_err("%pOF: could not get %s for %pOF\n",
+					       it->parent,
+					       it->cells_name,
+					       it->node);
+					goto err;
+				}
 			}
 		} else {
 			count = it->cell_count;
@@ -1505,7 +1514,7 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 {
 	if (index < 0)
 		return -EINVAL;
-	return __of_parse_phandle_with_args(np, list_name, cells_name, 0,
+	return __of_parse_phandle_with_args(np, list_name, cells_name, -1,
 					    index, out_args);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args);
@@ -1588,7 +1597,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	if (!pass_name)
 		goto free;
 
-	ret = __of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
+	ret = __of_parse_phandle_with_args(np, list_name, cells_name, -1, index,
 					   out_args);
 	if (ret)
 		goto free;
@@ -1756,7 +1765,7 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
-	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, 0);
+	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, -1);
 	if (rc)
 		return rc;
 
-- 
2.20.1

