Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA76C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74492081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="frs4UW9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfGOMqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49868 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbfGOMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124459euoutp02593069a5d8e46a61609c2fd4f6f6a705~xlUv6KvgS0722707227euoutp02b
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124459euoutp02593069a5d8e46a61609c2fd4f6f6a705~xlUv6KvgS0722707227euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194699;
        bh=2v4hCpJVfQGiuvIX6+zHl3XxXt1PDpHhQhdwlTF9fno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frs4UW9eyzVbr0YcOZKWJivQcbIsdu1+UvF+ua/qy2Z65P4lDIifNsjBvw0I2uZN5
         SKardzQiZPbNfV50QEDyw3SuNeKaboPKXZYEC+/nhZuOOiI3y+XUeUWTjxTpcsbrha
         z3TqvpUBulyuy2Z5sa69cMfgmevsk8DtPXXeFKz0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124458eucas1p2972be3b4546dbf5c2e7efafa0405f708~xlUvTwIQ-2439624396eucas1p2c;
        Mon, 15 Jul 2019 12:44:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.25.04298.A457C2D5; Mon, 15
        Jul 2019 13:44:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124457eucas1p20401b92a7c0eb51af1e0910fbebaa0b5~xlUuamtKZ0800208002eucas1p2q;
        Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124457eusmtrp1fa3d160cd756dd38a0c75f605a17adf2~xlUuZ_WuE0488104881eusmtrp1l;
        Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-d5-5d2c754a815a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.17.04140.9457C2D5; Mon, 15
        Jul 2019 13:44:57 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124456eusmtip287178ee846cbaaae1932c94e43326c4a~xlUtnZ2bU0573605736eusmtip2M;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
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
Subject: [PATCH v1 29/50] ARM: dts: exynos: align OPPs of bus_gen in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:56 +0200
Message-Id: <20190715124417.4787-30-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvbN0BmLN0KJcBSQ20SgooPHhGhWRSFKXB/TBGA2BwY5ApKAd
        Ku4WQxHZl1gWFTWgkAoipTZl0QgUUYiURUUhECMYVFDCogkPJXYyRd++85//zznn5tK4rIVc
        Q8cnJnOaRDZBIXEnLK8WerYc0G6ODE6bkaOhJz0kqi+pI9Hg/ASJ7tmcZd7YJI7s9qcUent9
        ikJDOh9kGvtAopnsURINNN2RoBL7CwzV2kYo9HCwD0N9XeFoOLVagvTPbRRqn7pBosUP9USo
        XFlTXgOU0x/1lNJkvClRNlReU7b+asGUuWYjUM6Z1kZQx913qbiE+HOcJigk2j3u1Ww7dqae
        Pv/lfQahAy2STOBGQ2Y7LM90kJnAnZYx1QA225spsZgHMGvRgonFHIC1BUawFHkz98YVqQLw
        Vtpr/F9kYXKAyAQ0LWECodV4Vgh4MpUA2hZiBA/OfMJgy3gjKTTkzGE4/icVE5hg1sPptFJC
        YCmzBzqKjZg4zQ8+fvoSF9jNqS8Yel2L91PwdtkmkffB247PuMhy+KPTTInsA7uLsgmReajL
        eeC64DIcy7vr8uyE7Z19pLAzzmyCdU1BorwX3v1ShAkyZFbAjz89BBl3YqGlGBdlKcxIl4nu
        jdCc3etaeBWsqjFQokUJu/oPio9TCKB+VI/lA7+y/7PuA2AEXpyWV8dy/NZELiWQZ9W8NjE2
        8GSS2gScf6p7sXPWCn73x7QBhgaK5dJQVUCkjGTP8RfUbQDSuMJTuvu3U5Kq2AsXOU1SlEab
        wPFtwJsmFF7SS8s+n5AxsWwyd5rjznCapS5Gu63RgWZrNCGXBx8yl6jC2xpDpo9cdTwrXQzQ
        GtZVRHRnSYuDmZQO68pZ78JLFd8vDmzwPTVssoSV265sj8j5uv9bv+89/yyiKMhLbxs5VjAa
        RTzq7pBEv4susX71U3UoUkp16YaGozvsI6RFaphgM9R1rfUzScP5HtuK2OYDYYdX5yoIPo7d
        6o9rePYvp2442U8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7qepTqxBssmKVvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MY58OMxVs5Kh4dLWDpYFxD1sXIyeHhICJxMnPJ1m7GLk4hASWMkp8
        3XCDGSIhJjFp33Z2CFtY4s+1LjaIok+MEk/mLGfpYuTgYBPQk9ixqhCkRkRgBaPE5BPeIDXM
        Aq+ZJI4cfccKkhAW8JfYtnsG2CAWAVWJ9y0zWUBsXgF7ib/TVzFBLJCXWL3hANhiTqD4z2kX
        wK4TErCTWHz0J9MERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNn27GfW3Ywdr0L
        PsQowMGoxMPrkKIdK8SaWFZcmXuIUYKDWUmE1/YrUIg3JbGyKrUoP76oNCe1+BCjKdBRE5ml
        RJPzgXGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBUbfudqqQ
        TInizfhm6f9R+sFhro851/Rd0Pi+/j3D7X8fF1xYlsxl4yR+XU0/oiYnRVCBz1gz79LXHEN2
        9wNZNRb/xEoX+TB4q5Uyx9xjnvVm/gz7Fd3rzeNWGsbNEQo4W7vC4FaRuc3ytX/kpvjfun/9
        esHboB8ZD7d5tYr472GddXB9/719SizFGYmGWsxFxYkA8oLHOrMCAAA=
X-CMS-MailID: 20190715124457eucas1p20401b92a7c0eb51af1e0910fbebaa0b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124457eucas1p20401b92a7c0eb51af1e0910fbebaa0b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124457eucas1p20401b92a7c0eb51af1e0910fbebaa0b5
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124457eucas1p20401b92a7c0eb51af1e0910fbebaa0b5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the OPPs' frequencies to the master clock rate such that the values
are possible to set using only a clock divider. Set max OPP frequency equal
to the max possible for that bus (according to the documentation).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 3a128cd717e2..f2e2e77a86d6 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1191,16 +1191,16 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <89000000>;
+				opp-hz = /bits/ 64 <100000000>;
 			};
 			opp01 {
-				opp-hz = /bits/ 64 <133000000>;
+				opp-hz = /bits/ 64 <150000000>;
 			};
 			opp02 {
-				opp-hz = /bits/ 64 <178000000>;
+				opp-hz = /bits/ 64 <200000000>;
 			};
 			opp03 {
-				opp-hz = /bits/ 64 <267000000>;
+				opp-hz = /bits/ 64 <300000000>;
 			};
 		};
 
-- 
2.17.1

