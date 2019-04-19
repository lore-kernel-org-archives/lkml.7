Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A420C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE25120645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IT5z9/4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfDSTHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:07:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38831 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfDSTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141948euoutp015685cf4321539722593d3923c4d7ec4b~W5fs1WF_12266922669euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419141948euoutp015685cf4321539722593d3923c4d7ec4b~W5fs1WF_12266922669euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683588;
        bh=oHb4F/fKGbFRY5xWCPOlkGTrYwg8EXfU+YH+uaXa6CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IT5z9/4JHvkQtthj9SDzcT7akzMA7X7FnMCpXLQCDrr7me41MmjYlDGEVor3myiVv
         IGXZNKJJw447LRdPYJVYcTp+4wwYkl3QiRCWJUipDbapIamA/M9IoUZ6JTr1b67HkF
         0HeiDCo85TTJZ3OjVIIi/BfJxcRfRHM4xEOPr4gM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419141947eucas1p1c41c185f973307ecd7f9d7e56327975d~W5fsE3NOH0148801488eucas1p1h;
        Fri, 19 Apr 2019 14:19:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.B2.04325.309D9BC5; Fri, 19
        Apr 2019 15:19:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141946eucas1p2fffda29e18080fd3573f625f0cf2b7f8~W5frBkwuR3160331603eucas1p2L;
        Fri, 19 Apr 2019 14:19:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141946eusmtrp1ed6006b143e0bad42a9c36a38fe207b9~W5fqzeQRl1759317593eusmtrp1c;
        Fri, 19 Apr 2019 14:19:46 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-86-5cb9d9037b79
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.02.04146.209D9BC5; Fri, 19
        Apr 2019 15:19:46 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141945eusmtip2f462c742b4721ace8ec5e8e871f23cc9~W5fqC7q5J3242832428eusmtip2U;
        Fri, 19 Apr 2019 14:19:45 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 05/10] drivers: memory: extend of_memory by LPDDR3
 support
Date:   Fri, 19 Apr 2019 16:19:23 +0200
Message-Id: <1555683568-20882-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG/XbOzs5Ws9OMfLFhMQqyyO71VVJGBSf7o0goqIGuPGi0qe2k
        VkbNisrlJVRaWJZS4FqatZaoXSyvkemUWl7WRfSPaM5FeMk0I09n1X+/73ue531ePj6aUDVK
        Q+hDiUc5Y6JOr6EUZGXTD+cSortau2xweAZ+cLVCijuHP0vxzYY2Kb77rR/h/FdFEvz6kgHn
        9g8Q2Om8L8OtZ7wy3GNS4zc11yk8lN2A8FXnMwkub/ggw+4MK4XrvRekuPZtFHZPBOLRl30o
        MogdHckj2WumDpKtLvwgY+22TIrNPuuj2Be+JxI2x2FD7MOWdHbIHrpLvk8REcfpD6VyxqUb
        YxUJX8p9RHJ35LG2PgtlQplrzEhOA7MKzOceycxIQasYK4LWnkEkHoYRfCp46VeGEFhz7dTf
        iPtrDiUKpQgslizqX2SkqmAqQtMUEw5VtiNCYBaTDu87awnBQzBeCbSOj5GCEMTshNpsr0Rg
        klkAbYPDUoGVTBSYO9z+tlDobsskBJYzO6DmjuNPGTAfZTBe7CJE01Zwdtb7OQg8zQ6ZyGpo
        yc8iRebBlF2CRD4J/blFfs8GqG/ukApLE0wYVNQsFRCYzeCZiBYxELoGZwpmYgrzKi2EeK2E
        i+dV4oyF4Mhql4g8G0rLrvhnszDwvd7/oDcQtLy9jS6juYX/u4oRsqFgLoU3xHP8ykQuLZzX
        GfiUxPjwg0kGO5r6XC2/mkeq0LOfB+oQQyPNdOXzvGqtSqpL5Y8b6hDQhGaWcnOcQ6tSxumO
        n+CMSTHGFD3H16E5NKkJVqYH9O5XMfG6o9xhjkvmjH9VCS0PMaG9gRp9OJt/d70qZjueF6bq
        SoJX7oHKAEXJxO7V83voU0TvEu3ZpqEt+9e5YjOeRqWFJvXa7lU0le1VL8jaectXIo9ob/VM
        Pq3dU6Ze4eqK3NO+9qM+fZuh0LY6Z9rk4gfRn9c6rdqw8prk4ghbhOW0q+8CuanS07hm+Zgt
        9fHCdxqST9AtX0QYed1vPwl1bFgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7pMN3fGGMxZzWWxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsu175gLbjpUnHs0na2BsdOsi5GTQ0LAROL2+z62
        LkYuDiGBpYwSPc9eMkMkxCQm7dvODmELS/y51gVV9IlR4vmNaUxdjBwcbAJ6EjtWFYLUiAjU
        S/S/uQRWwyzQwCyxZvtVVpAaYQFfiSuNyiA1LAKqEufefmEFsXkFvCS6Lt5mg5gvJ3HzXCfY
        Xk4Bb4ldK7eAxYWAajZc28s0gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBI2nbs
        5+YdjJc2Bh9iFOBgVOLhPTBpZ4wQa2JZcWXuIUYJDmYlEV7HlC0xQrwpiZVVqUX58UWlOanF
        hxhNgY6ayCwlmpwPjPK8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TByc
        Ug2MielHljzaOK1ohV1PmMjpzeIzej9dnLrmVsiZ/hTvFx2N3+4r1N3trTmRlcCze/GJ/3lJ
        E7JtVALnCqRsUeTUFd2zdUPGUQPGFMZjHEysHEJXU0Wm1ft82Xn8iFCIvUfmuhNmD98+Vb6s
        1JF2gEHwVLX2lwn1Cl+68twMDDaU6a13nbcx5A2/EktxRqKhFnNRcSIA0dcLtboCAAA=
X-CMS-MailID: 20190419141946eucas1p2fffda29e18080fd3573f625f0cf2b7f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141946eucas1p2fffda29e18080fd3573f625f0cf2b7f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141946eucas1p2fffda29e18080fd3573f625f0cf2b7f8
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141946eucas1p2fffda29e18080fd3573f625f0cf2b7f8@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds AC timings information needed to support LPDDR3 and memory
controllers. The structure is used in of_memory and currently in Exynos
5422 DMC. Add parsing data needed for LPDDR3 support.
It is currently used in Exynos5422 Dynamic Memory Controller.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/memory/of_memory.c | 125 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |  20 +++++++-
 include/memory/jedec_ddr.h |  62 ++++++++++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 2f5ed73..7a77174 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -152,3 +152,128 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
 	return lpddr2_jedec_timings;
 }
 EXPORT_SYMBOL(of_get_ddr_timings);
+
+
+const struct lpddr3_min_tck *of_lpddr3_get_min_tck(struct device_node *np,
+						   struct device *dev)
+{
+	int			ret = 0;
+	struct lpddr3_min_tck	*min;
+
+	min = devm_kzalloc(dev, sizeof(*min), GFP_KERNEL);
+	if (!min)
+		goto default_min_tck;
+
+	ret |= of_property_read_u32(np, "tRFC-min-tck", &min->tRFC);
+	ret |= of_property_read_u32(np, "tRRD-min-tck", &min->tRRD);
+	ret |= of_property_read_u32(np, "tRPab-min-tck", &min->tRPab);
+	ret |= of_property_read_u32(np, "tRPpb-min-tck", &min->tRPpb);
+	ret |= of_property_read_u32(np, "tRCD-min-tck", &min->tRCD);
+	ret |= of_property_read_u32(np, "tRC-min-tck", &min->tRC);
+	ret |= of_property_read_u32(np, "tRAS-min-tck", &min->tRAS);
+	ret |= of_property_read_u32(np, "tWTR-min-tck", &min->tWTR);
+	ret |= of_property_read_u32(np, "tWR-min-tck", &min->tWR);
+	ret |= of_property_read_u32(np, "tRTP-min-tck", &min->tRTP);
+	ret |= of_property_read_u32(np, "tW2W-C2C-min-tck", &min->tW2W_C2C);
+	ret |= of_property_read_u32(np, "tR2R-C2C-min-tck", &min->tR2R_C2C);
+	ret |= of_property_read_u32(np, "tWL-min-tck", &min->tWL);
+	ret |= of_property_read_u32(np, "tDQSCK-min-tck", &min->tDQSCK);
+	ret |= of_property_read_u32(np, "tRL-min-tck", &min->tRL);
+	ret |= of_property_read_u32(np, "tFAW-min-tck", &min->tFAW);
+	ret |= of_property_read_u32(np, "tXSR-min-tck", &min->tXSR);
+	ret |= of_property_read_u32(np, "tXP-min-tck", &min->tXP);
+	ret |= of_property_read_u32(np, "tCKE-min-tck", &min->tCKE);
+	ret |= of_property_read_u32(np, "tCKESR-min-tck", &min->tCKESR);
+	ret |= of_property_read_u32(np, "tMRD-min-tck", &min->tMRD);
+
+	if (ret) {
+		dev_warn(dev, "%s: errors while parsing min-tck values\n",
+			 __func__);
+		devm_kfree(dev, min);
+		goto default_min_tck;
+	}
+
+	return min;
+
+default_min_tck:
+	dev_warn(dev, "%s: using default min-tck values\n", __func__);
+	return NULL;
+}
+EXPORT_SYMBOL(of_lpddr3_get_min_tck);
+
+static int of_lpddr3_do_get_timings(struct device_node *np,
+				    struct lpddr3_timings *tim)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "max-freq", &tim->max_freq);
+	ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
+	ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
+	ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
+	ret |= of_property_read_u32(np, "tRPab", &tim->tRPab);
+	ret |= of_property_read_u32(np, "tRPpb", &tim->tRPpb);
+	ret |= of_property_read_u32(np, "tRCD", &tim->tRCD);
+	ret |= of_property_read_u32(np, "tRC", &tim->tRC);
+	ret |= of_property_read_u32(np, "tRAS", &tim->tRAS);
+	ret |= of_property_read_u32(np, "tWTR", &tim->tWTR);
+	ret |= of_property_read_u32(np, "tWR", &tim->tWR);
+	ret |= of_property_read_u32(np, "tRTP", &tim->tRTP);
+	ret |= of_property_read_u32(np, "tW2W-C2C", &tim->tW2W_C2C);
+	ret |= of_property_read_u32(np, "tR2R-C2C", &tim->tR2R_C2C);
+	ret |= of_property_read_u32(np, "tFAW", &tim->tFAW);
+	ret |= of_property_read_u32(np, "tXSR", &tim->tXSR);
+	ret |= of_property_read_u32(np, "tXP", &tim->tXP);
+	ret |= of_property_read_u32(np, "tCKE", &tim->tCKE);
+	ret |= of_property_read_u32(np, "tCKESR", &tim->tCKESR);
+	ret |= of_property_read_u32(np, "tMRD", &tim->tMRD);
+
+	return ret;
+}
+
+const struct lpddr3_timings *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+		struct device *dev, u32 device_type, u32 *nr_frequencies)
+{
+	struct lpddr3_timings	*timings = NULL;
+	u32			arr_sz = 0, i = 0;
+	struct device_node	*np_tim;
+	char			*tim_compat = NULL;
+
+	switch (device_type) {
+	case DDR_TYPE_LPDDR3:
+		tim_compat = "jedec,lpddr3-timings";
+		break;
+	default:
+		dev_warn(dev, "%s: un-supported memory type\n", __func__);
+	}
+
+	for_each_child_of_node(np_ddr, np_tim)
+		if (of_device_is_compatible(np_tim, tim_compat))
+			arr_sz++;
+
+	if (arr_sz)
+		timings = devm_kcalloc(dev, arr_sz, sizeof(*timings),
+				       GFP_KERNEL);
+
+	if (!timings)
+		goto default_timings;
+
+	for_each_child_of_node(np_ddr, np_tim) {
+		if (of_device_is_compatible(np_tim, tim_compat)) {
+			if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
+				devm_kfree(dev, timings);
+				goto default_timings;
+			}
+			i++;
+		}
+	}
+
+	*nr_frequencies = arr_sz;
+
+	return timings;
+
+default_timings:
+	dev_warn(dev, "%s: using default timings\n", __func__);
+	*nr_frequencies = 0;
+	return NULL;
+}
+EXPORT_SYMBOL(of_lpddr3_get_ddr_timings);
diff --git a/drivers/memory/of_memory.h b/drivers/memory/of_memory.h
index ef2514f..8cf2ce6 100644
--- a/drivers/memory/of_memory.h
+++ b/drivers/memory/of_memory.h
@@ -18,6 +18,11 @@ extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
 extern const struct lpddr2_timings
 	*of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
 	u32 device_type, u32 *nr_frequencies);
+extern const struct lpddr3_min_tck
+	*of_lpddr3_get_min_tck(struct device_node *np, struct device *dev);
+extern const struct lpddr3_timings
+	*of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+	struct device *dev, u32 device_type, u32 *nr_frequencies);
 #else
 static inline const struct lpddr2_min_tck
 	*of_get_min_tck(struct device_node *np, struct device *dev)
@@ -31,6 +36,19 @@ static inline const struct lpddr2_timings
 {
 	return NULL;
 }
-#endif /* CONFIG_OF && CONFIG_DDR */
+
+static inline const struct lpddr3_min_tck
+	*of_lpddr3_get_min_tck(struct device_node *np, struct device *dev)
+{
+	return NULL;
+}
+
+static inline const struct lpddr3_timings
+	*of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+	struct device *dev, u32 device_type, u32 *nr_frequencies)
+{
+	return NULL;
+}
+#endif
 
 #endif /* __LINUX_MEMORY_OF_REG_ */
diff --git a/include/memory/jedec_ddr.h b/include/memory/jedec_ddr.h
index ddad0f8..3601825 100644
--- a/include/memory/jedec_ddr.h
+++ b/include/memory/jedec_ddr.h
@@ -32,6 +32,7 @@
 #define DDR_TYPE_LPDDR2_S4	3
 #define DDR_TYPE_LPDDR2_S2	4
 #define DDR_TYPE_LPDDR2_NVM	5
+#define DDR_TYPE_LPDDR3		6
 
 /* DDR IO width */
 #define DDR_IO_WIDTH_4		1
@@ -172,4 +173,65 @@ extern const struct lpddr2_timings
 	lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
 extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
 
+
+/*
+ * Structure for timings for LPDDR3 based on LPDDR2 plus additional fields.
+ * All parameters are in pico seconds(ps) unless explicitly indicated
+ * with a suffix like tRAS_max_ns below
+ */
+struct lpddr3_timings {
+	u32 max_freq;
+	u32 min_freq;
+	u32 tRFC;
+	u32 tRRD;
+	u32 tRPab;
+	u32 tRPpb;
+	u32 tRCD;
+	u32 tRC;
+	u32 tRAS;
+	u32 tWTR;
+	u32 tWR;
+	u32 tRTP;
+	u32 tW2W_C2C;
+	u32 tR2R_C2C;
+	u32 tWL;
+	u32 tDQSCK;
+	u32 tRL;
+	u32 tFAW;
+	u32 tXSR;
+	u32 tXP;
+	u32 tCKE;
+	u32 tCKESR;
+	u32 tMRD;
+};
+
+/*
+ * Min value for some parameters in terms of number of tCK cycles(nCK)
+ * Please set to zero parameters that are not valid for a given memory
+ * type
+ */
+struct lpddr3_min_tck {
+	u32 tRFC;
+	u32 tRRD;
+	u32 tRPab;
+	u32 tRPpb;
+	u32 tRCD;
+	u32 tRC;
+	u32 tRAS;
+	u32 tWTR;
+	u32 tWR;
+	u32 tRTP;
+	u32 tW2W_C2C;
+	u32 tR2R_C2C;
+	u32 tWL;
+	u32 tDQSCK;
+	u32 tRL;
+	u32 tFAW;
+	u32 tXSR;
+	u32 tXP;
+	u32 tCKE;
+	u32 tCKESR;
+	u32 tMRD;
+};
+
 #endif /* __LINUX_JEDEC_DDR_H */
-- 
2.7.4

