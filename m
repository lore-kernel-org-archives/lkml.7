Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF76C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965F0206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NzS+TRkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfGOMrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49748 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfGOMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124456euoutp02d9e764c9534182e827870f63e0f5b123~xlUtMBQSx0715707157euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124456euoutp02d9e764c9534182e827870f63e0f5b123~xlUtMBQSx0715707157euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194696;
        bh=1FbxRMR/J2d1fJmmubphL3VmOgAMnSNbd+ERLGAret4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzS+TRkrjzK71HQGeO2R3IT4qBEGeso4d8hC4zJXWjaRjp9JXU1/NnatHQT/0G+4e
         qckNIWjRrxOYqlpdmUDytdFxFlKFpuO+aeZv1qH96OPGPDIAEKYvK2Bnxkb18T18S0
         dckDiqt5S2e+RTHB4zNqiLOpTNHHlmMdO9UENuhc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124455eucas1p1238f8c5e167902c4113b857feef1fb91~xlUsWj9Re0153501535eucas1p1B;
        Mon, 15 Jul 2019 12:44:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.E1.04377.7457C2D5; Mon, 15
        Jul 2019 13:44:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124454eucas1p1cd37552b222539b02629cb52e646ae29~xlUrkfwOt0154701547eucas1p1P;
        Mon, 15 Jul 2019 12:44:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124454eusmtrp1fc58db158ec4abd8999c07dcb1ba908b~xlUrWYf790488104881eusmtrp1T;
        Mon, 15 Jul 2019 12:44:54 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-04-5d2c7547f768
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.07.04140.6457C2D5; Mon, 15
        Jul 2019 13:44:54 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124453eusmtip29d8f9f4e271156d19cb92d2b1172ec37~xlUqeQ_AA1115211152eusmtip2Q;
        Mon, 15 Jul 2019 12:44:53 +0000 (GMT)
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
Subject: [PATCH v1 25/50] ARM: dts: exynos: add 300MHz to bus_disp1_fimd in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:52 +0200
Message-Id: <20190715124417.4787-26-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjuO2dn56gtTtP0w0RhUGSXqSHx0cUUyg4FoQTRBauZBy+5aTtq
        WkFmaXkpxWSpmKZoylrp1hLvmK6UzFuRt7RMpUwtjblIDWvzTPr3vM/zvu/zvB8fhYvrCWcq
        XBHDKhWySInQVlD9aqFrx6HY7UGeZYsEGnraRSBtbiWB+ue/EqjIYC4zx6dx1N1dRaLOpBkS
        DSW6IN14H4F+Znwk0Lu6AiHK7W7C0BPDCInK+nsx1Pv6IPpwvUKIkhsNJGqduUWg5T6twNee
        0RRqADM7kEwyOnWqkHlWeo158aMBY+7q1YAx6lwDyFO2e0PYyPA4Vunhc842LOuRlog2EPHp
        JmUiqBekARsK0t7wt+a9GdtSYroCwGrjMmkRxPQ8gJ+zAnnBCGBpU75wdeJmZyPJC+UATs0V
        YHxhnuhR94M0QFFCWgpr1BctAw50KYCGhWBLD04PYrBhopawCPb0CagbzFnZKqA3waWciRVr
        Eb0f6ma0gHdzg4+rmnELtjHzC6oea4q3JNT3+fD4AJwqz8R4bA+n2vQkj11gx70M650cTLxT
        bN15FY5nPrD27IGtbb2EJTNOu8PKOg+e9oNzowOYhYb0Ojjwfb2Fxs0wu/o+ztMieDtFzHdv
        gfqMHmsAR1iuUVmXM7C58Yb1qbIBrDUNCrOAW/5/s4cAqIETG8vJQ1lup4K9JOVkci5WESo9
        HyXXAfOX6lhum68BdX+CWwBNAclakW/ItiAxIYvjEuQtAFK4xEG0z2SmRCGyhMusMuqsMjaS
        5VrARkogcRJdWTN6WkyHymLYCywbzSpXVYyycU4EXu3ztRNxf4+oJmfsPNFSQ++G1OF+aY62
        KNlYOK46MzRZNfx8qti3lNqdrBfRLw+bmnYdnXUdrveflkeo4rVD2En/gEJmc0RhYIof8i4R
        vOnLKGk/Jg33SK9oHMsbdXT5MqZOkhs67YjA0eNZI57ufopPeXOuJZ6tXuH6xV/fJAIuTOa1
        FVdysn9egNEdTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7pupTqxBlte8lrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MCcs2shYcYa3o/lrUwLibpYuRk0NCwESi5exe9i5GLg4hgaWMEh3P
        vrBCJMQkJu3bzg5hC0v8udbFBlH0iVHi6YbDzF2MHBxsAnoSO1YVgtSICKxglJh8whukhlng
        NZPEkaPvwAYJC4RJ/Nq6iQnEZhFQlfg95QnYUF4Be4lNbzYyQiyQl1i94QAziM0JFP857QIb
        iC0kYCex+OhPpgmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERs62Yz+37GDsehd8
        iFGAg1GJh9chRTtWiDWxrLgy9xCjBAezkgiv7VegEG9KYmVValF+fFFpTmrxIUZToKMmMkuJ
        JucDozqvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjZyfXoZU1
        fa7887fcuumVYOuz/ZNCE//fqY8Fp/mzMcbzpHAuV6vPbUxSN7nZdfGhulGDR8L0vH/M90Jm
        Hq5Pm8hsU/P42aLj3zobbMq3PAqfc+2ktN1srzCuv4+aLfI/nvonvYDF0i30lfb79vWfH08O
        3H2kv8l0tuu+RWbN3w0rVF/UTXJSYinOSDTUYi4qTgQAbYpV/rICAAA=
X-CMS-MailID: 20190715124454eucas1p1cd37552b222539b02629cb52e646ae29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124454eucas1p1cd37552b222539b02629cb52e646ae29
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124454eucas1p1cd37552b222539b02629cb52e646ae29
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124454eucas1p1cd37552b222539b02629cb52e646ae29@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation max frequency for ACLK300_DISP1 is 300MHz.
Add an OPP which makes it possible to use the full performance when needed.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 74d014f3eaa6..1097fa758d9e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1299,6 +1299,9 @@
 			opp01 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
+			opp02 {
+				opp-hz = /bits/ 64 <300000000>;
+			};
 		};
 
 		bus_disp1_opp_table: opp_table14 {
-- 
2.17.1

