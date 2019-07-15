Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF0C76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68442081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eA2tEJoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfGOMq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfGOMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124501euoutp017a18ed81c44ff8a95332f29060bf22e0~xlUyWNcnK1961119611euoutp01p
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124501euoutp017a18ed81c44ff8a95332f29060bf22e0~xlUyWNcnK1961119611euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194701;
        bh=81fCMMNKhM4b6YHz9B0/lpvfP3ePnpoi35A/mfij7Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eA2tEJoIxJ6mYpS2YrnZmYuYYDj3vYCTdW7hul6wkK4RjsUEC9+vJL61BXON0lcG4
         BVp/lKSU1fssYAIa7isrQnnV7LArNMnsWamYgnFfbkBmENHTxz/aXw3b/ZHOgxS0Fi
         aBJ1sr1YQIaYSHM3x2Mun8Jjg7g/PmO6JjNGoYhE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124501eucas1p25187f7f6dd0070b4e8d6a9574e8b5dd2~xlUxySWoH0850908509eucas1p2u;
        Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.C0.04325.C457C2D5; Mon, 15
        Jul 2019 13:45:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124500eucas1p114c6cbbbb4efa421b2e24d49a6d3d603~xlUxDN3WM3125231252eucas1p1_;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124500eusmtrp139374356e6388c5eb902db633e2b2ec7~xlUw1ImQL0488104881eusmtrp10;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-f6-5d2c754cb67a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.17.04140.C457C2D5; Mon, 15
        Jul 2019 13:45:00 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124459eusmtip2dd3d2a181aaa74fe5283a5f9a8e36789~xlUv_rbj31100811008eusmtip2f;
        Mon, 15 Jul 2019 12:44:59 +0000 (GMT)
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
Subject: [PATCH v1 32/50] ARM: dts: exynos: remove lowest OPP from bus_mfc
 in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:59 +0200
Message-Id: <20190715124417.4787-33-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7tPxcVtVh4sWqyEyjLLkgNp2QsuJpR/FYbl1NusdOquj9TA
        mVgp06WVimQaGI5lLc2G2tLSldTQaZb5ICuUStNe2kMKbdc767/P73c+39/vcDg0JrMQnvRx
        dRKnUStjFaQrbn483bkhJHl9uO+HngA0cKuTQLWlJgK9nHpPoAqro9QPf8SQ3X6bQh1nxik0
        oF2O6oZ7CfRVN0SgnqYrJCq1N0vQTesrCl1/2S1B3U/3osEsA4ly7lsp1DZ+jkAzvbV4kDtb
        c7UGsJ/7cii2zphLsneqMtmHnywStqDeCNjJuhUHqDDXgGgu9ngKp9m4PcI1ZtYwCBL01KnL
        LSWkFpiIPOBCQ2YLfHepgsoDrrSMMQD4wpwLxGIKwNHfpZRgyZhJAAdbVs4ntJ9ycVGqBrBG
        9476lxgrGHXEaZpkfGCDMVEILGaqALRORwoOxvRLoGWkcW63OxMGq2/ewwXGGS84cvfJHEuZ
        HdCUMwnEbXJ44/YDTGAXR3+6uIsUBkHmGQVtbSantAfqs+cD7nCsvZ4SeTm0XdThIvNQm3/N
        6ZyGw/pyp7MNtrV3E8KlMWYtNDVtFBAyO2F9/j4RF8K+iUWCjDmwyFyCiW0pPH9WJs5YA+t1
        XRKRl8LqmmLnbBYazP3O9ywCsLmskrwA5GX/d1UCYAQeXDIfp+J4PzWX6sMr4/hktconKj6u
        Djj+lG2m/XsDaP4T2QoYGijcpEHR3uEyQpnCp8W1AkhjisXSwO+OljRamZbOaeKPapJjOb4V
        LKNxhYc0Y8GbwzJGpUziTnJcAqeZP5XQLp5aUGT0vORm3NmYP4Ty3CyN23u61ResIxWKByXB
        KtOkn323rzki9e23VVNBhcHYxLEiyhDawbZ8ebHkZ3nK562PvE8c6ZwgvNL3V2XL7M+1m/1H
        uT0+oa+zfkhDeoEqzbjkoIe8cFdURqDtkPssnfm0S+6y6meFbfWvhJmYwtJE//cKnI9RblqH
        aXjlXyoyQDlPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7o+pTqxBq8+s1ncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M/ytuMxb0s1dM3T+drYFxPWsXIyeHhICJRMO7TpYuRi4OIYGljBL7
        16xlh0iISUzatx3KFpb4c62LDaLoE6PEun+/gTo4ONgE9CR2rCoEqRERWMEoMfmEN0gNs8Br
        JokjR9+BbRAWiJCYePEIG4jNIqAq8WTrSRYQm1fAXmJ962dGiAXyEqs3HGAGsTmB4j+nXQCr
        FxKwk1h89CfTBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjZ9uxn1t2MHa9Cz7E
        KMDBqMTD65CiHSvEmlhWXJl7iFGCg1lJhNf2K1CINyWxsiq1KD++qDQntfgQoynQUROZpUST
        84FxnVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTFr5iOTuxsu
        uMe3bkmMWaJta3L20cfelN0yb6KDJvz0zy9wz3NZLGFrkiYRnG7xgO/iZ6n+XNZFC6NUJSd+
        /Xp3+cwuGxPz51LloZP+HF5U+PvrPmN51W3nr6qLF4l1LC1Yuzdl+8HVzhfOSl5efym5PPPy
        ua+LCkKXGHAGL5umnOH/rUY4ykyJpTgj0VCLuag4EQAb4UQkswIAAA==
X-CMS-MailID: 20190715124500eucas1p114c6cbbbb4efa421b2e24d49a6d3d603
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124500eucas1p114c6cbbbb4efa421b2e24d49a6d3d603
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124500eucas1p114c6cbbbb4efa421b2e24d49a6d3d603
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124500eucas1p114c6cbbbb4efa421b2e24d49a6d3d603@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align number of OPPs with the number in bus_wcore OPP table.
The higher OPPs would not be set, thus clean them.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0be799f843dc..18c5273091bd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1171,18 +1171,15 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <96000000>;
-			};
-			opp01 {
 				opp-hz = /bits/ 64 <111000000>;
 			};
-			opp02 {
+			opp01 {
 				opp-hz = /bits/ 64 <167000000>;
 			};
-			opp03 {
+			opp02 {
 				opp-hz = /bits/ 64 <222000000>;
 			};
-			opp04 {
+			opp03 {
 				opp-hz = /bits/ 64 <333000000>;
 			};
 		};
-- 
2.17.1

