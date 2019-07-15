Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D7C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C232067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fAWSqsl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfGOMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfGOMoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124452euoutp011fcd8d7d9ab3ced1fe61011f6eae8ab7~xlUp_a8181961119611euoutp01c
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124452euoutp011fcd8d7d9ab3ced1fe61011f6eae8ab7~xlUp_a8181961119611euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194692;
        bh=YC8dotW1I1wyLEkwf/U+c5ZFp3zTs1jZ5aE9LLN7rRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAWSqsl6Oz3dFJaektFlDztYti/81R3FalvwdUwcfTNdB7A3hEtWCvqLbyuNd/txE
         wZFGxBfoF+lDLushU+WaicrFlH0PtG3hOQyfm4y+tVBdhJHACCqwzF6cFQsNVitLJm
         ZIoczT57AUqRgqqL96czxF5RCVCyG1Q1TAN1H+lw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124451eucas1p236623bca6e1abdc8be994cd0c9c7a1c2~xlUpGtRJN2241922419eucas1p2k;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 56.B0.04325.3457C2D5; Mon, 15
        Jul 2019 13:44:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5~xlUoTuixg3211132111eucas1p2O;
        Mon, 15 Jul 2019 12:44:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124450eusmtrp1b72adaeb1ef0b6911e90305afc3e4084~xlUoFnJLO0488104881eusmtrp1C;
        Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d5-5d2c75438a88
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 57.07.04140.2457C2D5; Mon, 15
        Jul 2019 13:44:50 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124449eusmtip28b6ef71151b9f663ca27293d9c48a6ed~xlUnTGwSg1242312423eusmtip2S;
        Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v1 21/50] ARM: dts: exynos: add OPP into FSYS APB bus in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:48 +0200
Message-Id: <20190715124417.4787-22-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv3Lv7cLq8zaiDRsIicj3MyOBkLyOD0acsJFpFzbxMbZu22ywr
        aBbLEtMymMNMl+Rrzpprhb1W6lRo1FyJOiUNFiSmhmQfpCVt3lnffv/f4/wfHBoXO4lYOkdz
        jtVqFCoJKRQ865nzbNqn23giqb1uDRp+9IFAbabHBBqc/UagWlewLPd/x5HHY6PQ+6uTFBrW
        r0J2/wCBZkpHCfTpRTWJTB4nhlpdnylUP+jFkPfdfjRS1EQiw2sXhbomiwk0P9AmSI2RWWus
        QPZjyEDJ7JabpOzJwyuyjulXmKzMYQGyn/bVBym5cGcWq8opYLWbd58SZr8J2LB8N3nBaPhE
        6oGZKAERNGSSYYPbQJYAIS1mmgDsv3dHwBezAD41vQwrPwH0WMvAYqSuowvjhUYAJ6tKwb9I
        V/FMUKFpkkmE7ZazocBy5iGArrnMkAdnfBh89fX5QvMYJgO2PRjAQ1jArIXXJnwLvIjZA/t/
        j1J8t3jYYnu74IkI8nPGvoWRIPOBguavf8JbpMGnldU4j2PgRK8jHF4F3XdLBTzmoP7Wg/AK
        l6G//H7YswN29XqJ0NA4I4WPX2zm6b1waKyFDNGQWQqHppaFaDwIK55V4jwtgjeui3l3AnSU
        9mE8XgEbrcbw4zIY6B7E+fNUAFjsrsRvg/iq/83MAFjASlbHqZUst1XDnk/kFGpOp1Emns5T
        20HwV7nne3+1A2cgsxMwNJBEiVKzNpwQE4oCrlDdCSCNS5aLdv0KUqIsReFFVpt3UqtTsVwn
        iKMFkpWiS0u+HBMzSsU59gzL5rPaRRWjI2L1ICE3Z/xRrC/jW+xV1/jFQ2O5KTWRrLutqLvX
        bK7WLZPHKbcckXgiGu0zvo/Z/sjoEbdNeisphalXPffVOQOHp7wHLkeu2x7tKk5jvrQ0BMBo
        hvySfEXy21lNfFQzpR5ytMbkZ25zTjUcPxqVLpwmpXulRru4J53FHLUmX7NEwGUrtqzHtZzi
        LyzMh11RAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7pOpTqxBu+nGljcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M/X82MBWcZquY1nqZrYFxAWsXIyeHhICJxKKDh5m6GLk4hASWMkoc
        urCFESIhJjFp33Z2CFtY4s+1LjaIok+MEueOrAPq4OBgE9CT2LGqEKRGRGAFo8TkE94gNcwC
        r5kkjhx9B7ZBWCBY4tC9P2CDWARUJZpf3QSL8wrYS1z5fQ9qgbzE6g0HmEFsTqD4z2kX2EBs
        IQE7icVHfzJNYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB2th37uWUHY9e74EOM
        AhyMSjy8DinasUKsiWXFlbmHGCU4mJVEeG2/AoV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5
        HxjXeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGB15z4Z9kFyS
        duDuJKYXC2T3Oek4i1gybXpxw0W8yzU/tO//dsszxik/tF/tEbun3b9Hbsljfc/Vrde6eBZZ
        2WaUW7DMX+88RaOIQfYF86/vzut9c9q4Z5duaSl0ymVhYoufff9bTK/ryTebHqTdq9gesMPs
        4fGrgQezv/S/+t360lMsrvVrnRJLcUaioRZzUXEiAOIlzMGzAgAA
X-CMS-MailID: 20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OPP for FSYS APB which reflects the real possible frequency.
The bus will have a new parent clock which speed has 600MHz, thus
a new possible frequency provided by the clock divider is 150MHz.
According to the documentation max possible frequency for this bus is
200MHz.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c7fc4b829b2a..2b36c2f77a10 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1153,6 +1153,9 @@
 				opp-hz = /bits/ 64 <100000000>;
 			};
 			opp01 {
+				opp-hz = /bits/ 64 <150000000>;
+			};
+			opp02 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
 		};
-- 
2.17.1

