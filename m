Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E04C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3801A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZP95B7Kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfDRNjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:39:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34225 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389120AbfDRNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190418133857euoutp01f5fcc28e79a54914cda21ce51669c5da~WlSwNYpx50378803788euoutp01N
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190418133857euoutp01f5fcc28e79a54914cda21ce51669c5da~WlSwNYpx50378803788euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555594737;
        bh=HLV8RfTTYMJHCpoVzMgMpnDdAuBIjRTs2a5rElTq130=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZP95B7Kq2OhdrD+IOB1OVcIXt4sgsgRwrXs5Ekccd+5PyEFoScMNLlB2Qaucp5J5s
         ue9sBs0VZZXjmBSkHfKbCOw87Ksjq9sE1IJvJUug6XumXrbCP4PQ28TNqKxO0oc3KM
         fkwJzbCgzG7OFVya9jNeF7rwHaQWVMEI9eKyGx5I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418133856eucas1p2eeda585b068536cdbbc766367c0b1780~WlSvf-CXB0537305373eucas1p2m;
        Thu, 18 Apr 2019 13:38:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 12.D2.04298.0FD78BC5; Thu, 18
        Apr 2019 14:38:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190418133855eucas1p1db74567290fce23da354ab09d69741e6~WlSuesWtG2247222472eucas1p1_;
        Thu, 18 Apr 2019 13:38:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418133855eusmtrp2447dce42e5066c5bd8d1a5fa7c7cdc13~WlSuQrpWF2812628126eusmtrp2C;
        Thu, 18 Apr 2019 13:38:55 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-94-5cb87df0a06d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.55.04140.FED78BC5; Thu, 18
        Apr 2019 14:38:55 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133854eusmtip2e617380c23a9387f6e6b8d92b32c051b~WlSthc5--2312923129eusmtip2E;
        Thu, 18 Apr 2019 13:38:54 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v2 4/4] DT: arm: exynos4412: add event data type which is
 monitored
Date:   Thu, 18 Apr 2019 15:38:32 +0200
Message-Id: <1555594712-18341-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87ofanfEGMy6oG6xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGYtXnmMtWMdbsfvRctYGxlOcXYycHBICJhKdZ7sZ
        uxi5OIQEVjBKfD/QzArhfGGU+Lf2CjOE85lRYv7hDqAyDrCWF5cFIeLLGSWetU5nh+s4f3IR
        K0gRm4CexI5VhSArRAQWM0p8OxwFUsMssIxJYl/zJyaQhLBAqET37zesIDaLgKrEljlnmEFs
        XgEvievTZrND3CcncfNcJ1icU8Bb4suufWDnSQicYpeY1z+FEaLIRaJnxWFWCFtY4tXxLVDN
        MhL/d85ngrCLJRp6F0LV10g87p8LVWMtcfj4RbCjmQU0Jdbv0ocIO0rce/aHDeJhPokbbwVB
        wsxA5qRt05khwrwSHW1CENUaElt6LkAtEpNYvmYa1HAPiZ0HFkLDcB6jxK1fn9knMMrPQli2
        gJFxFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmBaOv3v+KcdjF8vJR1iFOBgVOLhlcjc
        ESPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp
        2ampBalFMFkmDk6pBkaJw+qf9SYWthcwdX7bOVOwVzlIdAcPpxOfd1Zb+vllnYw9RYE/7u75
        H9udctRkOmdhacVN2fpMVb56vz96FrEt1rOKUv1NV7gmsZUy+N/Qll+zUi309eeun48SODVt
        IhZs9hA+Me9nDHe3jofYx4OVCmXKmz6dlueR3pd5zdhSOFK32PSXEktxRqKhFnNRcSIAK+yv
        oEcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rva3fEGCybrWSxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GYtXnmMtWMdbsfvRctYGxlOcXYwcHBICJhIvLgt2MXJxCAksZZT4vv89cxcjJ1Bc
        TGLSvu3sELawxJ9rXWwQRZ8YJe7vncYG0swmoCexY1UhSFxEYDmjxLFVb5lBHGaBbUwSe67s
        ZgTpFhYIllgzbS0biM0ioCqxZc4ZsA28Al4S16fNhtogJ3HzXCdYnFPAW+LLrn2sILYQUM2+
        HT9YJjDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYKduO/dyyg7HrXfAhRgEORiUe
        XonMHTFCrIllxZW5hxglOJiVRHgdU7bECPGmJFZWpRblxxeV5qQWH2I0BTpqIrOUaHI+MIrz
        SuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUw6ipWHyz9u8NVUHP3
        NxcL464re9iq3Bj7BY5fYlaf8E/1xpdL92NXvJPNdTp/XXb6TKWKW4c/fHjBllby6clZBcsk
        TnP2wkqZvB0X0jau4XEq1t9zbqV7tWxlz8YOrZlRbddCm2+fnbGVMf61fEVQ/xXjx6G+Haf7
        kvwtFuV/dbQ6a/bE/Ms/JZbijERDLeai4kQAMTMN4qoCAAA=
X-CMS-MailID: 20190418133855eucas1p1db74567290fce23da354ab09d69741e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133855eucas1p1db74567290fce23da354ab09d69741e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133855eucas1p1db74567290fce23da354ab09d69741e6
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133855eucas1p1db74567290fce23da354ab09d69741e6@eucas1p1.samsung.com>
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

