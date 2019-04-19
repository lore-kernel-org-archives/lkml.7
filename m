Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAECC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6381220449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qBdldqja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfDSShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36467 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfDSSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419134823euoutp0154f32a08071631fbf579362f7a503111~W5EQ_bprG0633206332euoutp019
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:48:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419134823euoutp0154f32a08071631fbf579362f7a503111~W5EQ_bprG0633206332euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555681703;
        bh=dGaYu8X2y/0BQdi0aG6wuFp9zS+Rp1PwxA/Fpq9KCS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBdldqjabVfPIKOOW+qwjpnzZ1PE5JjgHS9AbMuKdccM+E2SvKJMs28+UPYSYwJmF
         N5wI2skmCWx6M03B2w/H6iDHaHxrsC5sg8+HrC/FIeb6s11+PlAW54FhJ0ZOTzy1wp
         e4JS9ES6qoVjKQ4OmHRiyd/ZJGZHBBC1Z4nLuCqY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419134822eucas1p2939a45a95386db8696404e5e1d82c626~W5EQRpM-Q0970609706eucas1p2G;
        Fri, 19 Apr 2019 13:48:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.60.04298.5A1D9BC5; Fri, 19
        Apr 2019 14:48:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0~W5EPhuiNW0957509575eucas1p2D;
        Fri, 19 Apr 2019 13:48:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419134821eusmtrp19cac7275df6ec2c6e7fde2a5490d50d4~W5EPTsgcQ2843728437eusmtrp1P;
        Fri, 19 Apr 2019 13:48:21 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-b0-5cb9d1a50f3f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.BE.04140.5A1D9BC5; Fri, 19
        Apr 2019 14:48:21 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134820eusmtip2427e2fcb8de8b406fd269d152577e26c~W5EOoiKIk0862908629eusmtip2f;
        Fri, 19 Apr 2019 13:48:20 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v3 2/4] drivers: devfreq: events: extend events by type of
 counted data
Date:   Fri, 19 Apr 2019 15:48:06 +0200
Message-Id: <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURjHO/fu7l6Hq+sUfbClsAgq1GkEHejFxIhVX/JLpAl1y4tKTnNX
        7cWi2YvlsCwTs1GWpGlirebwDZPS5SzL99Q1JE0osRTUFBeSebuG337P//k//+ecw2FIVTXl
        zyQmp/GGZC5JI1fIalrdncFl3fWxodM92/HLIguFB359p/BDeweF80Z/kLiz8wWNP176SePP
        RjW2jvZTuLfhvhzP3LAjXNTZROBn9iEalw10E9iVVSHHV1/Zadzy8xqF59q+ot1euqriKqSr
        Nw/ROmtljlxXXXpR92aykdDdtFUi3Yw14CAdo9gRxyclZvAG7a5jioSs8Xn61OL6MwumbMKI
        LGoT8mCA3Qrtb9/LTEjBqNgKBFPPZymp+IXg9x03kooZBK3uPsKEmH8jzm+xkl6OwDr4cWXi
        SnEjEk1yNgTqKlPFFT7sYwRzLTGih2SfENB0eZoQG95sNBTYbHKRZewGaFuwkyIr2f2Q5S4h
        pfMFgLMjhxQzPdgDUD6RIeYA20HD3fwxmeTZA59cTrnE3jDusNESq6H9Tu6yRwDjjRIk8XkY
        zXuw7NkOLY5uSswn2U1gadBKcgRMWOaX77saBie8RJlcwvyau6QkK+F6tkpybwRbbhchsS+U
        VxUuh+vA3F5KSK9TjGC4uEV+CwWaV5Y9QqgS+fHpgj6eF8KS+dMhAqcX0pPjQ06k6K1o6Su1
        /3FM16HZnuPNiGWQxlP5Or8+VkVxGcJZfTMChtT4KCPibLEqZRx39hxvSDlqSE/ihWa0lpFp
        /JSZq4aPqNh4Lo0/yfOneMP/LsF4+BvR4W3hk7Br6sPtIE5bmxm8Res7ElgwPrtGO9ZWyE5O
        1OYVOdR90Rn79t6iFQXcCPg3R52s6dsYuberNjQiYjronmu/q9o88iVdfWgIf9M3hn81v+t1
        /pjZGekwprr9ZAPr0p6qnynb8lOjZIWaC5aUC84wyuTpGTC12B84XO/SyIQELmwzaRC4v8w5
        JFBGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pLL+6MMeg/wmexccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GY2vfrAX/Feu+NPVxtTAuF6mi5GDQ0LAROLms5guRi4OIYGljBJfL05j7GLkBIqL
        SUzat50dwhaW+HOtiw2i6BOjxNWOL0wgzWwCehI7VhWCxEUEljNKHFv1lhnEYRbYxiSx58pu
        sEnCAuESL7t2sIHYLAKqEif+HGEGsXkFvCQafy5khtggJ3HzXCczyFBOAW+J5W/LQMJCQCXX
        n59hnsDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgnGw79nPLDsaud8GHGAU4GJV4
        eA9M2hkjxJpYVlyZe4hRgoNZSYTXMWVLjBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnA2M4
        ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDYynzodj/TxWko9b7
        MuS13qn/yucue3zpqqIT5R3ckQcOqP79+PFpWjOH1vYQjtRdui8LzU5xnzLeuy5758aNu52P
        3Y+5tm3pIi6pn+GNMtOraxb4pF29GMGVkph3wzjqto/gq6Y7F20+Mh69rbTm9Xf3AKtVMQkX
        ljzdcIrH5fTbTdfKK3KETyixFGckGmoxFxUnAgBLvBDkqQIAAA==
X-CMS-MailID: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
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
index c61de0b..073bf2c 100644
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
+		if (ret) {
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

