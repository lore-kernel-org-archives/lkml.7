Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D660C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7412067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fePyTli9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfGOMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60182 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbfGOMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124450euoutp0115dfd9610a731dc5529b16c0456e8d5f~xlUoCfgop1950319503euoutp01r
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124450euoutp0115dfd9610a731dc5529b16c0456e8d5f~xlUoCfgop1950319503euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194690;
        bh=0yu/GCB186G2/MeW65t6RpIaAjApTjN5ldP7+MRyAec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fePyTli9lSNfJmDL7oQZ2G8IfWQrrl4p85tw3rIFibxJlr4+WyFtzmRoUza6+Gf3W
         Ciflg8NrbCJNmbalxtomFT+QQE0py4FedSaARl1FSOStnvUAmewZKEsIkU5w4694Si
         c8frt9p50auwvUog88Fqzil1BHH9CLd1wo1NkVUk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124450eucas1p10da85ce7eb3932c2a505b59f530fe67a~xlUnhKuab3144231442eucas1p1a;
        Mon, 15 Jul 2019 12:44:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.B0.04325.1457C2D5; Mon, 15
        Jul 2019 13:44:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124449eucas1p130d853368cb8bf02bef337da2d513fff~xlUm0VlnW0146601466eucas1p1M;
        Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124449eusmtrp13f4b90687480b813d224e6ca59358bbd~xlUmmNrMm0462004620eusmtrp1e;
        Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d1-5d2c7541a773
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.07.04140.1457C2D5; Mon, 15
        Jul 2019 13:44:49 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124448eusmtip2dfd3a98ece2d652667f4b63a1902fc46~xlUlwfXYH1242312423eusmtip2Q;
        Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
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
Subject: [PATCH v1 19/50] ARM: dts: exynos: change OPPs values for FSYS2 in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:46 +0200
Message-Id: <20190715124417.4787-20-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87qOpTqxBl8PWFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6M/Yca2Au6OCu2XyxqYJzC3sXIySEh
        YCLR0N7P2sXIxSEksIJR4lJzAyOE84VR4v3Ra+wQzmdGiWlr/jPCtCy5cggqsZxRYm5/CxNI
        Aqzl0/H0LkYODjYBPYkdqwpBwiICSxgljvxMAqlnFrjJJLHnyU5WkISwQITEr9ltYL0sAqoS
        S37tAovzCthLHJu6ghlimbzE6g0HwGxOoPjPaRfYQAZJCJxilzi7t50ZZJmEgItE64pKiHph
        iVfHt0D9JiNxenIPC4RdLNHQuxDqgRqJx/1zoWqsJQ4fv8gKMoZZQFNi/S59iImOEneaBSFM
        PokbbwVBipmBzEnbpkPt5JXoaBOCmKEhsaXnAhOELSaxfM00qNkeEl82tDJBAmoSo0TTqknM
        ExjlZyHsWsDIuIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwRZ3+d/zrDsZ9f5IOMQpw
        MCrx8DqkaMcKsSaWFVfmHmKU4GBWEuG1/QoU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBa
        SCA9sSQ1OzW1ILUIJsvEwSnVwBh1Rfqlgrz7SflumUOxr/6HLXexsdh03FFy9y7PbX12Nn5l
        Bg8dFru9vTVBVjMike1tJd/5w1Pme1w2eK5n9Z3nBJdvw2Jxi3SeOTtUJwnw/F1QlZdx58Pd
        829ljlh67DV+fzNivtjFah7PzVt/pbC/a+pNU626cnqNzyxdgx+1W0R0Tt1Z/U+JpTgj0VCL
        uag4EQDGG/coTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7qOpTqxBk3rOSxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7G/kMN7AVdnBXbLxY1ME5h72Lk5JAQMJFYcuUQkM3FISSwlFFi7dyp
        LBAJMYlJ+7ZDFQlL/LnWxQZR9IlRYu7Jf0AOBwebgJ7EjlWFIDUiAisYJSaf8AapYRZ4zSRx
        5Og7VpCEsECYxI/7h9lAbBYBVYklv3aBxXkF7CWOTV3BDLFAXmL1hgNgNidQ/Oe0C2D1QgJ2
        EouP/mSawMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmDkbDv2c8sOxq53wYcYBTgY
        lXh4HVK0Y4VYE8uKK3MPMUpwMCuJ8Np+BQrxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjCq
        80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MLJae5ofXfx7t96X
        9Bla3/5tuJGxaNGEMw0OK53nrjzJbZj8XGlPn9QOx+UaVQWhW1zvKnOf2Mn7+t/d/51zf6YL
        xaunCJ5o4M6omR8q833VMqPYRq4t09+Xfd6gq+7FGSKXeKU2OS50hcOm943TerINa8oC1mm6
        +V29xizGdeisdZ7eaot0ByWW4oxEQy3mouJEAE9pPsyyAgAA
X-CMS-MailID: 20190715124449eucas1p130d853368cb8bf02bef337da2d513fff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124449eucas1p130d853368cb8bf02bef337da2d513fff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124449eucas1p130d853368cb8bf02bef337da2d513fff
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124449eucas1p130d853368cb8bf02bef337da2d513fff@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPPs values for FSYS2 does not reflect the real possible frequencies.
According to the documentation the maximum frequency is 240MHz. This clock
is important to MMC controller controlling the AXI data bus speed and
internal buses. The new OPP values are aligned to parent PLL rate so that
there is no need of reprogramming PLL and the integer values are possible
to get using only a clock divider.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1b717c5c3b1a..941c58bdd809 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1161,13 +1161,13 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <75000000>;
+				opp-hz = /bits/ 64 <150000000>;
 			};
 			opp01 {
-				opp-hz = /bits/ 64 <100000000>;
+				opp-hz = /bits/ 64 <200000000>;
 			};
 			opp02 {
-				opp-hz = /bits/ 64 <150000000>;
+				opp-hz = /bits/ 64 <240000000>;
 			};
 		};
 
-- 
2.17.1

