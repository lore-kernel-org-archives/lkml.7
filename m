Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F5FC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C657A2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q3GUQR3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfGOMqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60430 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbfGOMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124500euoutp0187c906bd63cda56b13a8361df94076ab~xlUwyP3IJ1962419624euoutp01m
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124500euoutp0187c906bd63cda56b13a8361df94076ab~xlUwyP3IJ1962419624euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194700;
        bh=SeLY0HG9yaaAZHLgVuO21pV4NxGAllfMnu7a12xfvsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3GUQR3MSsTfybK6mCOccSZn9FG86+4v9GvDhYd/HAFhXDm62wy7XQsaQNKlHkayb
         JyfgNl157fn1kmG2URwn66kJRek5BTlF8wj5nFTcqZzQ7X+iABdHjl3M+f74WRKBbz
         q794RmU6WEROizht5zDzOMjS4mEx2h6MRmN/Eylo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124459eucas1p2686212b74cac35c4e757022c3d8d4170~xlUv8xaZM1386513865eucas1p2T;
        Mon, 15 Jul 2019 12:44:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 90.C0.04325.A457C2D5; Mon, 15
        Jul 2019 13:44:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9~xlUvNDqHS1544915449eucas1p2M;
        Mon, 15 Jul 2019 12:44:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124458eusmtrp150d2c2800a2eeb2195e069b3d6a26994~xlUvMdTUv0488104881eusmtrp1q;
        Mon, 15 Jul 2019 12:44:58 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-ef-5d2c754a8795
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.50.04146.A457C2D5; Mon, 15
        Jul 2019 13:44:58 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124457eusmtip2a9440eae66016e32fc1769bab1efecdb~xlUuZpbyO1115311153eusmtip2d;
        Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
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
Subject: [PATCH v1 30/50] ARM: dts: exynos: add bus_isp266 into Exynos5800
Date:   Mon, 15 Jul 2019 14:43:57 +0200
Message-Id: <20190715124417.4787-31-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87pepTqxBhuP21jcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MWV32BWvZK16u3sHawNjO1sXIySEh
        YCJxf/MkIJuLQ0hgBaPE/H0LWCCcL4wSG79tZYdwPjNKrF3czw7T0tA1C6plOaPE9gMPEFo+
        rzgAVMXBwSagJ7FjVSFIg4jAEkaJIz+TQGqYBW4ySex5spMVJCEs4CWxdeJdsENYBFQldr1a
        wwxi8wrYS3z938IEsU1eYvWGA2BxTqD4z2kXwDZLCJxilzi/cwMjRJGLxNyHMB8JS7w6vgXq
        VBmJ05N7WCDsYomG3oVQ9TUSj/vnQtVYSxw+fpEV5GhmAU2J9bv0IcKOEve7GxhBwhICfBI3
        3gqChJmBzEnbpjNDhHklOtqEIKo1JLb0XIC6WExi+ZppUMM9JGbfvcwECZ5JjBK7Py9gmcAo
        Pwth2QJGxlWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBier0v+NfdzDu+5N0iFGAg1GJ
        h9chRTtWiDWxrLgy9xCjBAezkgiv7VegEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLp
        iSWp2ampBalFMFkmDk6pBsbUhZxLXCQ3tHh9rNE+7fs01V6/z6Hzs/bJVIX0H16LnDjqZz1I
        rigrkeiSfymjlaVS/qhpU2T53Z9iqRNubnp74oZmo85kK3GDyt9WGneWR6q+7KrYufi1QJrf
        IlH7J0eUjj388/3H2Q+ac1I7ukyPVO5VsdDWyD2rPldvst0U5l3Ox2TLC5VYijMSDbWYi4oT
        ASX/krFQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7pepTqxBif3SVrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MWV32BWvZK16u3sHawNjO1sXIySEhYCLR0DULyObiEBJYyijx4Pd0
        RoiEmMSkfdvZIWxhiT/XuqCKPjFKLNr7Hsjh4GAT0JPYsaoQpEZEYAWjxOQT3iA1zAKvmSSO
        HH3HCpIQFvCS2DrxLtg2FgFViV2v1jCD2LwC9hJf/7cwQSyQl1i94QBYnBMo/nPaBbB6IQE7
        icVHfzJNYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzByth37uXkH46WNwYcYBTgY
        lXh4HVK0Y4VYE8uKK3MPMUpwMCuJ8Np+BQrxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjCq
        80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MGbO65b/PTXWzvKP
        cN/Gv8tfT5t89/6+yZPzvDfbPzLLZArlzf+e/Me9PobzuKJjQ8Tlno9OCfbNrJcO5EVsdsx7
        s1lT4I5KN0vSo7glbJMuChSYL9n2pkaCm2Xqj6UMFw+Jtr/Im3Nwx6wcvUmXm0S+5WwWYDGW
        NQjfHpd1kXNm7vzfTFfdipRYijMSDbWYi4oTAfBc6NWyAgAA
X-CMS-MailID: 20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos5420 SoC had one clock for two lines while Exynos5422/5800 have
dedicated clock tree for the ACLK266_ISP. The max frequency is 300MHz so
it shares the OPP table with bus_gen. The bus is added here and is enabled
in .dts file for proper board.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b319fd65..3b9200db43b6 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -131,3 +131,13 @@
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
+
+&soc {
+		bus_isp266: bus_isp266 {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DOUT_ACLK266_ISP>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_gen_opp_table>;
+			status = "disabled";
+		};
+};
-- 
2.17.1

