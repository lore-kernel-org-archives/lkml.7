Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBFE20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ldW7LNjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfDRNi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:38:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49714 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbfDRNi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190418133855euoutp0205466bfb4b3994d338b8cfe4121b2c31~WlStxo85l0788107881euoutp02H
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190418133855euoutp0205466bfb4b3994d338b8cfe4121b2c31~WlStxo85l0788107881euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555594735;
        bh=LrbUWDzhuJDtHdKSva67o1iOv3VtXmTRaWWQwUjY1pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldW7LNjwdx1Kqvc/j/ukyoqrNK8RMgc8+0i9sCEspxFI5q/GFhajEjC2oviONS/ac
         0raY05TlsoZMrb/VwxdV2itiGo8hYdwTiG+ThsKymhV6XWgLawRpSEjQ6jVjW1Vs/x
         DVGBhMM9NFngVNNFpDyUJWU8HRQZdSBsMVB7E0gg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418133854eucas1p2d5463cd3b63b6f93c21bd90db022a7d2~WlSs_5OPt0537305373eucas1p2i;
        Thu, 18 Apr 2019 13:38:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.C2.04298.DED78BC5; Thu, 18
        Apr 2019 14:38:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133853eucas1p21ff5f58f5446b8452698910923524524~WlSr9o19I0331003310eucas1p22;
        Thu, 18 Apr 2019 13:38:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418133852eusmtrp21704a2739ef7553b7df6dfa3bfd8fe81~WlSrvlX_v2812628126eusmtrp29;
        Thu, 18 Apr 2019 13:38:52 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-8c-5cb87dedccc7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.55.04140.CED78BC5; Thu, 18
        Apr 2019 14:38:52 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133852eusmtip2ad8f4ab232e5b7c5094bd18437997a6a~WlSrCI27N1989619896eusmtip2S;
        Thu, 18 Apr 2019 13:38:52 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v2 2/4] drivers: devfreq: events: extend events by type of
 counted data
Date:   Thu, 18 Apr 2019 15:38:30 +0200
Message-Id: <1555594712-18341-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7pva3fEGPz/ZWGxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGZf/vmYtaFCpWHi9g62BcYNMFyMHh4SAicSJD8Jd
        jFwcQgIrGCVWHrjD3MXICeR8YZTYdrYcIvGZUaJj8kxWkARIw9Lr55kgEssZJWa3P2WEcIA6
        zv05wggylk1AT2LHqkKQBhGBxYwS3w5HgdQwCyxjktjX/IkJJCEsECkx6cYTFhCbRUBVYsuB
        e2AbeAW8JJ6f2c4EsU1O4ua5TrCTOAW8Jb7s2scKMkhC4BS7xLFF09ghilwkes7eZ4SwhSVe
        Hd8CFZeR+L9zPtSgYomG3oVQNTUSj/vnQtVYSxw+fpEV5GhmAU2J9bv0IcKOEvuXbWeBBBGf
        xI23giBhZiBz0rbpzBBhXomONiGIag2JLT0XoBaJSSxfA3OYh8Tqe93MkOCZxygx4Vsb+wRG
        +VkIyxYwMq5iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITEqn/x3/tIPx66WkQ4wCHIxK
        PLwSmTtihFgTy4orcw8xSnAwK4nwOqZsiRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpI
        ID2xJDU7NbUgtQgmy8TBKdXAmHqs4+nPf04CklZX3gY9LdGc6F+RdutrHou/bPuypa/eCO16
        Y3DkZD+3ZfbhTo8+J/EjOycun/jr6o6406xyBxwfucqKTX2uttxj00xmf92HcSfPnHiXpXPX
        Zo7YChczxoUBzNeZ/4aLfv75X9ru+auXWbvf9NbZzF6w6aVyoqllU6TmlO65/5VYijMSDbWY
        i4oTASjOemFGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pvanfEGHyba2axccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GZf/vmYtaFCpWHi9g62BcYNMFyMnh4SAicTS6+eZQGwhgaWMEms+20LExSQm7dvO
        DmELS/y51sUGUfOJUeLStMguRg4ONgE9iR2rCrsYuThEBJYzShxb9ZYZxGEW2MYksefKbkaQ
        BmGBcInFP5exgNgsAqoSWw7cYwWxeQW8JJ6f2c4EsUBO4ua5TmYQm1PAW+LLrn2sEMu8JPbt
        +MEygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42Xbs55YdjF3vgg8xCnAwKvHw
        SmTuiBFiTSwrrsw9xCjBwawkwuuYsiVGiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OBMZxX
        Em9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFx49TQHZ+2Xcn5WPVw
        brL11qrrK/wF5lQ84jb+Jp75798sXZHkpjzD4O+z3Fqcpk3un+fO037sXJIvJ9d/z1tlHnwe
        iqcCe7lkcwqrVBJn+0g2rNrwVrRCzni5xrILLALO+3tbD+gULTgoe8yi3SD5gcGeingLx7cT
        jaZ+Oji96cO7pTEKUaxKLMUZiYZazEXFiQC1UeXtqQIAAA==
X-CMS-MailID: 20190418133853eucas1p21ff5f58f5446b8452698910923524524
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133853eucas1p21ff5f58f5446b8452698910923524524
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133853eucas1p21ff5f58f5446b8452698910923524524
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133853eucas1p21ff5f58f5446b8452698910923524524@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds posibility to choose what type of data should be counted
by the PPMU counter. Now the type comes from DT where the event has been
defined. When there is no 'event-data-type' the default value is used,
which is 'read data in bytes'.
It is needed when you want to know not only read+write data bytes but
i.e. only write data in byte, or number of read requests, etc.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
 include/linux/devfreq-event.h       |  6 ++++
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..9f12201 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
+	/* Set the event of proper data type monitoring */
 	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
-				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
+			   edev->desc->data_type);
 	if (ret < 0)
 		return ret;
 
@@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
-	switch (id) {
-	case PPMU_PMNCNT0:
-	case PPMU_PMNCNT1:
-	case PPMU_PMNCNT2:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	case PPMU_PMNCNT3:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_EVT3_RW_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	}
+	/* Set the event of proper data type monitoring */
+	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
+			   edev->desc->data_type);
+	if (ret < 0)
+		return ret;
 
 	/* Reset cycle counter/performance counter and enable PPMU */
 	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
@@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
 	struct device *dev = info->dev;
 	struct device_node *events_np, *node;
 	int i, j, count;
+	int ret;
 
 	events_np = of_get_child_by_name(np, "events");
 	if (!events_np) {
@@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
 		desc[j].driver_data = info;
 
 		of_property_read_string(node, "event-name", &desc[j].name);
+		ret = of_property_read_u32(node, "event-data-type",
+					   &desc[j].data_type);
+		if (!ret) {
+			/* Set the event of proper data type counting.
+			 * Check if the data type has been defined in DT,
+			 * use default if not.
+			 */
+			if (of_device_is_compatible(np,
+					"samsung,exynos-ppmu-v2")) {
+				struct devfreq_event_dev edev;
+				int id;
+				/* Not all registers take the same value for
+				 * read+write data count.
+				 */
+				edev.desc = &desc[j];
+				id = exynos_ppmu_find_ppmu_id(&edev);
+
+				switch (id) {
+				case PPMU_PMNCNT0:
+				case PPMU_PMNCNT1:
+				case PPMU_PMNCNT2:
+					desc[j].data_type = PPMU_V2_RO_DATA_CNT
+						| PPMU_V2_WO_DATA_CNT;
+					break;
+				case PPMU_PMNCNT3:
+					desc[j].data_type =
+						PPMU_V2_EVT3_RW_DATA_CNT;
+					break;
+				}
+			} else {
+				desc[j].data_type = PPMU_RO_DATA_CNT |
+					PPMU_WO_DATA_CNT;
+			}
+		}
 
 		j++;
 	}
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4db00b0..cc160b1 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -81,14 +81,20 @@ struct devfreq_event_ops {
  * struct devfreq_event_desc - the descriptor of devfreq-event device
  *
  * @name	: the name of devfreq-event device.
+ * @data_type	: the data type which is going to be counted in the register.
  * @driver_data	: the private data for devfreq-event driver.
  * @ops		: the operation to control devfreq-event device.
  *
  * Each devfreq-event device is described with a this structure.
  * This structure contains the various data for devfreq-event device.
+ * The data_type describes what is going to be counted in the register.
+ * It might choose to count e.g. read requests, write data in bytes, etc.
+ * The full supported list of types is present in specyfic header in:
+ * include/dt-bindings/pmu/.
  */
 struct devfreq_event_desc {
 	const char *name;
+	u32 data_type;
 	void *driver_data;
 
 	const struct devfreq_event_ops *ops;
-- 
2.7.4

