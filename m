Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2752082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fiFNoWlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfDDRWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49028 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190404172234epoutp019154d2fc719d617af26062fc0e585402~SVUAMOveP1973719737epoutp01o;
        Thu,  4 Apr 2019 17:22:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190404172234epoutp019154d2fc719d617af26062fc0e585402~SVUAMOveP1973719737epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398555;
        bh=W8DTg6qA6wx5700J5x+PkkOVM4sB5RSLmf3N0B6Mkp4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=fiFNoWloLkbK4vmDd9zBRNNDzcda9LOY4YuZhiworY/jLQC7I0E+9e+/ke7fr4EAI
         YnoXhirL8XI5evE0pR6Vb/Ruykjkb1quaOLu/vLOavprYx2ClyTi+fQq171O7AumNt
         TeicjCogpw15icM3Dt1q5YPYKIUhrN/YMQ9u11Ss=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190404172234epcas1p3452c89b264d0fae64fa9e5c3a41c6bf3~SVT-2Esvj0484904849epcas1p37;
        Thu,  4 Apr 2019 17:22:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.07.04108.A5D36AC5; Fri,  5 Apr 2019 02:22:34 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190404172234epcas1p37667ec0996000aff9297f13639908dfc~SVT-g5hm70262202622epcas1p3_;
        Thu,  4 Apr 2019 17:22:34 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-0d-5ca63d5ad0d2
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.B9.03598.A5D36AC5; Fri,  5 Apr 2019 02:22:34 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:34 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RFC 3/8] dt-bindings: exynos: Add ASV tables binding
 documentation
Date:   Thu, 04 Apr 2019 19:17:30 +0200
Message-id: <20190404171735.12815-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmgW6U7bIYg9Wd8hYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfuslssvX6RyeJ24wo2i0Vbv7Bb
        tO49wm5x+E07qwOfx5p5axg9Nq3qZPPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJO
        /+1iKvgkV7F7/SXmBsbpEl2MnBwSAiYSFz9eYOti5OIQEtjBKHFv+0VWCOc7o0TTmU42mKp5
        kxugErsZJSZdvcEE4fxklFi+YioLSBWbgKFE79E+RhBbREBY4t7S5ewgRcwC35kkTr1+ygqS
        EBYIkZj5awcTiM0ioCrR+WEnWJxXwFrizKztLBDr5CVWbzjADGJzCthIPF7yBuxACYEDbBIb
        3jxihihykdjweQLQNg4gW1ri0lFbiJpmRome3bfZIZwJjBL3jy9ghGiwljh8/CLYNmYBPol3
        X3tYIZp5JTrahCBKPCQ2XOtihHitn1FiWv9DNqARCxgZVjGKpRYU56anFhsWmOoVJ+YWl+al
        6yXn525iBMerluUOxmPnfA4xCnAwKvHwNrAsixFiTSwrrsw9xCjBwawkwhv8fWmMEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd71Ds4xQgLpiSWp2ampBalFMFkmDk6pBsYidcnfX+Y/O/19U0HP
        1LMqlVbs9g/Sz1bVlUdx6r++dkLq77W7f3ctOhxwxe1ia33cks36zlv5LRv9p8n1Gs0Vio5R
        st28xFiSz8T0/pSvMx9+va59ymTG1EkTI+Pdn05boBt8/0iG5OtAq5Or3uSeqjt3xEb4S9wz
        gWtteVuW/lv5dO4R7S9HlFiKMxINtZiLihMB5h868tMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVy+t9jAd0o22UxBnOncltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLvF4TftrA58HmvmrWH02LSqk81j85J6j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mo4
        /beLqeCTXMXu9ZeYGxinS3QxcnJICJhIzJvcwNrFyMUhJLCTUWJR8z4mCOcno8SW4z/ZQKrY
        BAwleo/2MYLYIgLCEveWLmcHsZkFvjNJzJ6XB2ILC4RIzPy1gwnEZhFQlej8sJMVxOYVsJY4
        M2s7C8Q2eYnVGw4wg9icAjYSj5e8AZrPAbTMWuL7loQJjDwLGBlWMUqmFhTnpucWGxUY5qWW
        6xUn5haX5qXrJefnbmIEBuK2w1p9OxjvL4k/xCjAwajEw6vBtCxGiDWxrLgy9xCjBAezkghv
        8PelMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwiuUw
        vwkMf9R282jthKdf/vQt1v6fWy1po5KmcaTnddayTPf5runuZ085uHcwV29XaxZWquPykZXw
        uFnf/SOk7VmNCtMDw2dvZEo5MgvqdK9yFUoc+Ogg3Cmr+2hbyvNywcZtfkucs9clci8ounwo
        8/yXN48WbveJTFBaGioqXSE8nbEh2FGJpTgj0VCLuag4EQCKp90/QAIAAA==
X-CMS-MailID: 20190404172234epcas1p37667ec0996000aff9297f13639908dfc
CMS-TYPE: 101P
X-CMS-RootMailID: 20190404172234epcas1p37667ec0996000aff9297f13639908dfc
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172234epcas1p37667ec0996000aff9297f13639908dfc@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of the Exynos ASV (Adaptive Voltage Supply)
tables DT binding.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/arm/samsung/asv.txt   | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/asv.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/asv.txt b/Documentation/devicetree/bindings/arm/samsung/asv.txt
new file mode 100644
index 000000000000..0db907263a91
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/asv.txt
@@ -0,0 +1,76 @@
+Exynos Adaptive Supply Voltage (ASV) tables
+-------------------------------------------
+
+The Adaptive Supply Voltage (ASV) on Exynos SoCs is a technique of adjusting
+operating points, i.e. the power supply voltage for given clock frequency,
+in order to better match actual capabilities of the hardware and optimize power
+consumption.  This applies to subsystem of the SoC like: CPU clusters, GPU,
+the memory controller or camera ISP.  During production process the SoC chip
+is assigned to one of several bins (ASV groups) and the group information
+is encoded in the SoC CHIPID block registers and/or OTP memory. This information
+is then used by the OS to select more finely matching operating points for
+devices.
+
+This binding describes data used to create actual operating points for the
+subsystems.  The data is in form of two-dimensional arrays of M x N cells,
+where the first column contains frequency values and subsequent columns
+associated with ASV groups contain corresponding voltage values.
+
+    frequency group0 group1 ...  group(N-1)
+       0        1      2    ...  N-1
+0    <f0      V00    V01    ...  V0n>,
+1    <f1      V10    V11    ...  V1n>,
+...  <        ...                 >,
+M-1  <fm      Vm0    Vm1    ...  Vmn>,
+
+In simplest form the actual operating points set may be created by selecting
+whole column for the voltage values, however also parts of multiple columns may
+be combined by the OS to create series of voltage values corresponding to
+frequencies in column 0.
+
+The ASV tables are defined as sub-nodes of parent node containing all tables.
+
+* Main node
+
+Required properties:
+ - compatible : should at least contain "samsung,exynos-asv-v1".
+
+* Table node
+
+Required properties:
+ - samsung,asv-table-size : specifies dimension of the table, the first cell is
+   total number of rows (M), the second cell is total number of columns (N),
+ - samsung,asv-table-id : ID of the table, lower 8-bits is an index (revision)
+   of the table, remaining bits (31...8) specify a subsystem the table applies
+   to:  0 - ARM/Eagle (big) CPU cluster, 1 - KFC (little) CPU cluster,
+ - samsung,asv-data : the ASV table data as described earlier in this document.
+   First cell is frequency value, then N-1 voltage values. Such sequence
+   is repeated M times.
+
+Optional properties:
+ - samsung,asv-common-data : a list of frequency, voltage pairs used to describe
+   operating points where voltage is same for all N-1 ASV groups. This allows
+   to avoid data duplication is the "samsung,asv-data" property.
+
+Example:
+
+&chipid {
+	asv {
+		compatible = "samsung,exynos-asv-v1";
+		asv-table-0 {
+			samsung,asv-table-size = <8 6>;
+			samsung,asv-table-id = <0x0>;
+			samsung,asv-data =
+				/*     ASV0    ASV1    ASV2    ASV3    ASV4  */
+				<1700 1187500 1175000 1162500 1150000 1137500 >,
+				<1500 1125000 1112500 1100000 1087500 1075000 >,
+				<1300 1075000 1062500 1050000 1037500 1025000 >,
+				<1000  987500  975000  962500  950000  937500 >,
+				< 900  950000  937500  925000  925000  925000 >,
+				< 700  925000  912500  912500  912500  912500 >;
+						     /* ASV0...15 */
+			samsung,asv-common-data = <600 900000>,
+						  <500 900000>;
+		};
+	};
+};
-- 
2.17.1

