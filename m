Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ECCC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CF620449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GxcdP2ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfDSSiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:38:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52244 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfDSShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419134825euoutp02df201ba62635f860136563a3a3452bd9~W5ETdMHO90662906629euoutp02F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419134825euoutp02df201ba62635f860136563a3a3452bd9~W5ETdMHO90662906629euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555681705;
        bh=HLV8RfTTYMJHCpoVzMgMpnDdAuBIjRTs2a5rElTq130=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxcdP2urj0OQVvsCtdplP9b0GvSrKZ1UdCQWrNAAInXO+f4Ge71GNkvSxaxPNDYh0
         utCX8JcUNgu5ZsBWF9jnIBXAPL7QyF6c3SQnHseKCNTbitpE0Xzxq5T32Plqn+sArV
         h/syhVv/jqkdbUe2WykezieIxvkuFB+roJn8w14g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419134824eucas1p2a552ccb05f8c0f47ea9d4b24e3642b0d~W5EScF4m80964809648eucas1p2M;
        Fri, 19 Apr 2019 13:48:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.69.04377.8A1D9BC5; Fri, 19
        Apr 2019 14:48:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6~W5ERw4Eg_2483224832eucas1p1g;
        Fri, 19 Apr 2019 13:48:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419134823eusmtrp10782bb81d2f0505051df40fa19f44671~W5ERi479W2847828478eusmtrp1L;
        Fri, 19 Apr 2019 13:48:23 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-74-5cb9d1a8ad7a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.BE.04140.7A1D9BC5; Fri, 19
        Apr 2019 14:48:23 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134822eusmtip207d2af356ac28d0544c4c92fb930a231~W5EQ2JVYL0862908629eusmtip2i;
        Fri, 19 Apr 2019 13:48:22 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v3 4/4] DT: arm: exynos4412: add event data type which is
 monitored
Date:   Fri, 19 Apr 2019 15:48:08 +0200
Message-Id: <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/fu7t6NVrdp+kPDYiC97R0H01BSuBRF/0RQhq28mbSp7apZ
        Sa3M1DEfGD1mzh5W6jLNOUQtxXRkJc5GqKmtUougfEBbQhGSt2v03+d8z+d8f4fDYUi1nQpi
        kpLTeEOyVqeRK2WNz3+61la5m+PW3y8LwPU36ig84PtC4VtOF4WLxr6RuLf3MY17Lo7TeMi4
        BNvH+in8pqVMjr0FToRv9LYR+JHTQ+P7A24CD1+okuOcVieNO8dzKTz9YhRFLeJqymsQ11zq
        oTm7LV/ONdw7zz2bfEpwhQ4b4rz2kL30AWVEAq9LyuAN67YfVh6vqHZRqbWqzCejlZQRvVKY
        kIIBdjN4anOQCSkZNVuF4GVJIy0tfAjMzWZCtNSsF8E1c+S/E/Udd0lJqkRQZH1IStLsiW/9
        C02IYeRsGDTZToqxP1uBYLrzgOiT7AMC2rK//y31Y/dBu8VHiyxjQ2HIXEyJrGJ3woh7iJCG
        hcCgK58UOxXsLqicyBB7gH1Fw7i1QCY5MdDjq5BL7Adfuxy0xEug+4p5zhHAWHAHSZwFY0XW
        OWcbdHa5KbGfZFdCXcs6KY6G1h/tSIyBXQBvJxaJMTmLJY3XSSlWQd5ltWSvAIf59dyFA6Cy
        5tpcOQfWq1/l0kuVI7j+y4OK0dLS/8NuI2RDgXy6oE/khY3J/KkwQasX0pMTw46m6O1o9id1
        z3T5mlDL7yMdiGWQZr6qvaQ5Tk1pM4TT+g4EDKnxV0UnOOLUqgTt6TO8ISXekK7jhQ4UzMg0
        gaqz8z4eVLOJ2jT+BM+n8oZ/uwSjCDKiGEuuJUc3/CFoOTZt3fPBM7qUjw+uoxSmT5diRxps
        fWP5nxt2WGOn8m72DWg2lbx8MPjeN+GYBGJxdzgXsZue2Z95LjvO4g7YMq96jTcpPooPrw1d
        Vu0fOHWohiqdog/yeeH3vnx6N5n7kajP351lSgwKOXTMs9qxrHAycoYu1ciE49oNq0iDoP0D
        GJTDK0UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rLL+6MMVh8VtVi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0MhavPMdasI63Yvej5awNjKc4uxg5OSQETCQ2HlrE3MXIxSEksJRR4vOHA4wQCTGJ
        Sfu2s0PYwhJ/rnWxQRR9YpR4cGw9UBEHB5uAnsSOVYUgcRGB5YwSx1a9BZvELLCNSWLPld1g
        k4QFgiUa37eygdgsAqoSt3omsILYvAJeEg8v3mKC2CAncfNcJzPIUE4Bb4nlb8tAwkJAJdef
        n2GewMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCkbDv2c8sOxq53wYcYBTgYlXh4
        D0zaGSPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVValF+fFFpTmrxIUZToJsmMkuJJucDoziv
        JN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAPjzNVrg9ouXtZ5bmyf
        tFq+Kux+jNXMNOmGNMkjTGembrQ/wvKua+OLtf/SgiZOObrdbyOXAo/E36Vnf7DPySl4f7w2
        xzp998Zdm+85T+gz+Vs2Vd7QpTEqOyMria/MwWaht5z8giXqr/59DkxdxqBvu+dk3HzNDsdv
        GeJTNVpzbi88af/oyrf3SizFGYmGWsxFxYkAx9wTmqoCAAA=
X-CMS-MailID: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds new field in the PPMU event which shows explicitly
what kind of data the event is monitoring. It is possible to change it
using defined values in exynos_ppmu.h file.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 3a3b2fa..549faba 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -6,12 +6,16 @@
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
  */
 
+#include <dt-bindings/pmu/exynos_ppmu.h>
+
 &ppmu_dmc0 {
        status = "okay";
 
        events {
 	       ppmu_dmc0_3: ppmu-event3-dmc0 {
 		       event-name = "ppmu-event3-dmc0";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -22,6 +26,8 @@
        events {
 	       ppmu_dmc1_3: ppmu-event3-dmc1 {
 		       event-name = "ppmu-event3-dmc1";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -32,6 +38,8 @@
        events {
 	       ppmu_leftbus_3: ppmu-event3-leftbus {
 		       event-name = "ppmu-event3-leftbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -42,6 +50,8 @@
        events {
 	       ppmu_rightbus_3: ppmu-event3-rightbus {
 		       event-name = "ppmu-event3-rightbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
-- 
2.7.4

