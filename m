Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322C4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C520693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F8B0g407"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfDQHsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:48:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53893 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbfDQHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:48:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190417074835euoutp01615e8d3febb714ff137b39d5cf5d63e6~WM3jqce9S0045300453euoutp01P
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:48:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190417074835euoutp01615e8d3febb714ff137b39d5cf5d63e6~WM3jqce9S0045300453euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555487315;
        bh=ErJOmCzTuD7nzlZeYXUh/Pn43TEfgPouP54oeuht6kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8B0g407Z6/RhLHNjduJ+aQ1gYLH/QdJyHayDNxUNHPznxCRb6P1/KhFkP3fuMhcm
         7FE3wWyLaJj2L0FBXT6ip7NhWj5sGNzjXZ7U3XJzns3Cn9mDKpFJ5/ZiKqKlk9MKNG
         EFoyLZc9no9zhKEhk4mlBhBUFQXCS1fvVf0/9GxA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417074834eucas1p27bf9296a2524bab2d6cdaed24fc3a668~WM3i2ryFk0857108571eucas1p2e;
        Wed, 17 Apr 2019 07:48:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 63.38.04325.25AD6BC5; Wed, 17
        Apr 2019 08:48:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda~WM3iGh7vM1306513065eucas1p10;
        Wed, 17 Apr 2019 07:48:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417074833eusmtrp2b01ec003d9f34a32ffdca4e5710d17b7~WM3h24Ret2697626976eusmtrp2F;
        Wed, 17 Apr 2019 07:48:33 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-4d-5cb6da52eac8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.57.04140.15AD6BC5; Wed, 17
        Apr 2019 08:48:33 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074833eusmtip176aa797b4ed4d95001a5bfe996041b06~WM3hOnzjZ3091330913eusmtip1f;
        Wed, 17 Apr 2019 07:48:33 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com
Subject: [PATCH 2/3] drivers: devfreq: events: extend events by type of
 counted data
Date:   Wed, 17 Apr 2019 09:48:07 +0200
Message-Id: <1555487288-4777-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0iTYRTGe79v32Wj1du0PGnMHAmVpUUFL1SSVLCCQgr6w+yy9Eslb+1T
        u1IWmSmZ5bqY6KZmKcuylpmJCptXjFxWZprGwC5UdlMrZKk5v1X//c5znnOew8vL0yoz483H
        xCcJ+nhdrIZVyKqaR+yLt/RUhS/5Nu5H7uZWMKRr+D1DTI3tDMnu/0QTu/0ORx6fHOBIT+oc
        Yul/wZBnNfksGcpqRCTXXk+RW419HLne1UGRVyfKWJJW18iRhoF0Zg3WlhvLkdZizmC190qO
        a61faintuUoz0g5Z1KFsmGJVpBAbkyLog4J3K6ILTxVyiTb/g8XD+XQquqDORHIe8HIwNZmo
        TKTgVbgMQX73D5lUDCOw5DtYqRhCkJPVz/wdsY5coF2swqUIbtat/zcxntE9sYvnWRwI1eb9
        Lo8nvobgZ0OYy0PjDAq+GGpZV8MDb4PbrQWUi2XYHzqfvptkJd4AZT/P01KYGrrbMyZZjjeC
        0dE2eSvgGg5ar9bJJNM6SKvoQhJ7wMeWSk7iOTD+0ERJLEJqVpHbcxT6swvcnpXQ0NLBuI6m
        8QKoqAmS5BD49f0B7ZIBT4OXn2e4ZHoCc6quuGUlnDmtktzzofLsE3fQLCgtv+xeroW2M+84
        6XkKELzJzaTOI9+8/2GFCJmRl5AsxkUJ4rJ44UCgqIsTk+OjAiMS4ixo4gc9Gmv5UY3qf++x
        IcwjzVRl2cj9cBWjSxEPxdkQ8LTGUxkSWRmuUkbqDh0W9Am79MmxgmhDPrxM46U8MsWxXYWj
        dEnCPkFIFPR/uxQv905Fc3eoAwY7E52a0cFjON2285Yf3Ch6b425GrBXeB1ILpXkvbqfvcJ3
        9npDevHo9/oQeBvQFznfPyIzYfVlx1m5wRnwwW6IWPus+aJTXW+bqXSiJZuMrKH95sCiGUaf
        dU0pnl+b74xtPbD56fPO3qSeXmtwj9Pa6xtqmF4un8dwORqZGK1bupDWi7o/GLre0T0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Xd3AW9tiDH7/0bPYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIWtCxg
        LzikWrHoyxzmBsaJcl2MnBwSAiYSB39OZO5i5OIQEljKKNF2ZTozREJMYtK+7ewQtrDEn2td
        bBBFnxgl3kxeBZTg4GAT0JPYsaoQJC4isJxR4tiqt2CTmAWmM0nceXeFBaRbWCBEYv+LVrBJ
        LAKqElcvPWMCsXkFPCVWfJsAtU1O4ua5TjCbU8BLYt6DU2A1QkA1Ww8sYJnAyLeAkWEVo0hq
        aXFuem6xkV5xYm5xaV66XnJ+7iZGYFxsO/Zzyw7GrnfBhxgFOBiVeHhX/NwaI8SaWFZcmXuI
        UYKDWUmE1zFlS4wQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wNjNq8k3tDU0NzC0tDc2NzY
        zEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUAyNz8LWtLdwCCj/0+Qudduk9vxLp8qVltc/E
        fw33I5klHbVUJqQ2T9aR2jL7hrdSyvZMX4OLczM9lvRLMKjNuJTaFbzgiZLXOqPrS96v7/qb
        /CVHLPWibumjFjZvs54g8xOq+ZNqP/DoXPn213zyws+Lnl9ZeZSD+Wr3vNCPQfXsPPwW2/yv
        lCuxFGckGmoxFxUnAgCUODAuoQIAAA==
X-CMS-MailID: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda@eucas1p1.samsung.com>
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
 drivers/devfreq/event/exynos-ppmu.c | 38 +++++++++++++++++++++++++------------
 include/linux/devfreq-event.h       |  6 ++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..e5f81a5 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -140,6 +140,7 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
 	int id = exynos_ppmu_find_ppmu_id(edev);
 	int ret;
 	u32 pmnc, cntens;
+	u32 evt_sel = edev->desc->data_type;
 
 	if (id < 0)
 		return id;
@@ -154,9 +155,12 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
-	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
-				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
+	/* Check if the data type has been defined in DT, use default if not */
+	if (evt_sel == UINT_MAX)
+		evt_sel = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
+
+	/* Set the event of Read or Write or both (RDWR) data count  */
+	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id), evt_sel);
 	if (ret < 0)
 		return ret;
 
@@ -357,6 +361,7 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
 	unsigned int pmnc, cntens;
 	int id = exynos_ppmu_find_ppmu_id(edev);
 	int ret;
+	u32 evt_sel = edev->desc->data_type;
 
 	/* Enable all counters */
 	ret = regmap_read(info->regmap, PPMU_V2_CNTENS, &cntens);
@@ -368,24 +373,28 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
+
+	/* Set the event of proper data type counting.
+	 * Check if the data type has been defined in DT,
+	 * use default if not.
+	 */
 	switch (id) {
 	case PPMU_PMNCNT0:
 	case PPMU_PMNCNT1:
 	case PPMU_PMNCNT2:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
-		if (ret < 0)
-			return ret;
+		if (evt_sel == UINT_MAX)
+			evt_sel = PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT;
 		break;
 	case PPMU_PMNCNT3:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_EVT3_RW_DATA_CNT);
-		if (ret < 0)
-			return ret;
+		if (evt_sel == UINT_MAX)
+			evt_sel = PPMU_V2_EVT3_RW_DATA_CNT;
 		break;
 	}
 
+	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id), evt_sel);
+	if (ret < 0)
+		return ret;
+
 	/* Reset cycle counter/performance counter and enable PPMU */
 	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
 	if (ret < 0)
@@ -508,6 +517,7 @@ static int of_get_devfreq_events(struct device_node *np,
 	struct device *dev = info->dev;
 	struct device_node *events_np, *node;
 	int i, j, count;
+	int ret;
 
 	events_np = of_get_child_by_name(np, "events");
 	if (!events_np) {
@@ -544,6 +554,10 @@ static int of_get_devfreq_events(struct device_node *np,
 		desc[j].driver_data = info;
 
 		of_property_read_string(node, "event-name", &desc[j].name);
+		ret = of_property_read_u32(node, "event-data-type",
+					   &desc[j].data_type);
+		if (!ret)
+			desc[i].data_type = UINT_MAX;
 
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

