Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6AAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98502067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vjKTvLFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfGOMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60572 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfGOMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124510euoutp018f48c22b5c0d577eb0561622eed13438~xlU6C4FmA1962419624euoutp010
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124510euoutp018f48c22b5c0d577eb0561622eed13438~xlU6C4FmA1962419624euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194710;
        bh=ee94+F6hORuAwwelQIZmpY2Tr7I1P2DDKGnneocnmZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjKTvLFn6GqEQxOspRJKSj7VEqcIhD16QPycA7NQ0lCq1s0HZMBZYnpP2WcWNbVCA
         IAZfLxCcGpi6daUH1RSfuA/N39IpvSVWdrzznezYyGIBahtdaNoUPMEbLG7mWT6xtE
         eCP79dFATsYRRmqcPJwj/0z8JSoIsznpfyee6ffE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124509eucas1p1f4d73f22c13ee965bb69f7ab7c72be04~xlU5GIJya0572305723eucas1p1a;
        Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C8.35.04298.4557C2D5; Mon, 15
        Jul 2019 13:45:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124508eucas1p2b66d72b7eadd7428063387c6881aca64~xlU4J31kV0273902739eucas1p2F;
        Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124507eusmtrp14d0d8bfc478c8b562f2d47e11c62b013~xlU37s3AU0488104881eusmtrp1d;
        Mon, 15 Jul 2019 12:45:07 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-f5-5d2c755400fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.60.04146.3557C2D5; Mon, 15
        Jul 2019 13:45:07 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124507eusmtip21a316748be85eea85af46ae8c63c8679~xlU3JlWVg1172811728eusmtip2o;
        Mon, 15 Jul 2019 12:45:06 +0000 (GMT)
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
Subject: [PATCH v1 41/50] ARM: dts: exynos: change parent and rate of
 bus_g2d in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:08 +0200
Message-Id: <20190715124417.4787-42-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7ohpTqxBp3XDSxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGv933mAoOs1csvHOfvYFxM1sXIyeH
        hICJRF/LS/YuRi4OIYEVjBL/f71mhHC+MErs3PiXFcL5zCix9/9eJpiW2yteMkEkljNK3J2/
        hxmuZcOxs0AtHBxsAnoSO1YVgjSICCxhlDjyMwmkhlngJpPEnic7WUESwgKxEpfe3QI7hEVA
        VWL+0gYWEJtXwF7i+f97jBDb5CVWbzjADGJzAsV/TrvABjJIQuASu8SrUxuhilwkFm76DmUL
        S7w6voUdwpaROD25hwXCLpZo6F0IVVMj8bh/LlSNtcTh4xfBjmYW0JRYv0sfIuwocfHOcmaQ
        sIQAn8SNt4IgYWYgc9K26VBhXomONiGIag2JLT0XoOEjJrF8zTR2iBIPiS3NLpDQmQQM3XXb
        mCYwys9C2LWAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYKI6/e/4px2MXy8lHWIU
        4GBU4uF1SNGOFWJNLCuuzD3EKMHBrCTCa/sVKMSbklhZlVqUH19UmpNafIhRmoNFSZy3muFB
        tJBAemJJanZqakFqEUyWiYNTqoGRS9v+yPNld222f2w/4Lvs9abq+ZMXhckoLX91zFOmVbab
        642fvbyyzDzZsB/l2/98bJlx+8iV9VYr82yNVrdEugV8We9/8e4eyakzOi7MuKdcr5fzptT3
        dJ/CJpFMr7t3Gu5pBzQnnJ2ZH95xjf1/52a+gGk7Aw6H/H2++3Ps0261PW9/7Jseq8RSnJFo
        qMVcVJwIAP3F2vpQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rBpTqxBsu6jSxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7Gv933mAoOs1csvHOfvYFxM1sXIyeHhICJxO0VL5m6GLk4hASWMko8
        e/qUCSIhJjFp33Z2CFtY4s+1LjaIok+MEpdvTWTsYuTgYBPQk9ixqhCkRkRgBaPE5BPeIDXM
        Aq+ZJI4cfccKUiMsEC2x/o09SA2LgKrE/KUNLCA2r4C9xPP/9xgh5stLrN5wgBnE5gSK/5x2
        Aew4IQE7icVHfzJNYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzByth37uXkH46WN
        wYcYBTgYlXh4HVK0Y4VYE8uKK3MPMUpwMCuJ8Np+BQrxpiRWVqUW5ccXleakFh9iNAU6aiKz
        lGhyPjCq80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MIb6qD3x
        2ZGatcntstu/1zUy0a7ei8oubljEbdI+k7Ujau2+yOJHVe7LRApMoyW3NclEtGuV9T3rXFt0
        zzH3Tc7DkFfPkp3TWDzcGjbfS7fcsFA7NkV900/D5oR5h+/fZQpb03Wp5Y1/i+a5Niv/EquZ
        Hbv5ymN9w6zcTpz+yn1t4tGzedOKlFiKMxINtZiLihMBZh5OOLICAAA=
X-CMS-MailID: 20190715124508eucas1p2b66d72b7eadd7428063387c6881aca64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124508eucas1p2b66d72b7eadd7428063387c6881aca64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124508eucas1p2b66d72b7eadd7428063387c6881aca64
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124508eucas1p2b66d72b7eadd7428063387c6881aca64@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_g2d OPP table has been aligned to the new parent rate. This patch
sets the proper parent and picks the init frequency before the devfreq
governor starts working. It sets also parent rate (MPLL to 600MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 75664ff6d966..198e33cf115f 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -116,6 +116,10 @@
 
 &bus_g2d {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK266_G2D>,
+			  <&clock CLK_DOUT_ACLK266_G2D>, <&clock CLK_FOUT_MPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_MPLL>;
+	assigned-clock-rates = <0>, <300000000>,<600000000>;
 	status = "okay";
 };
 
-- 
2.17.1

