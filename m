Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E097C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFC42067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nDdNPZRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfGOMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60104 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfGOMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124436euoutp017c4a862cd652c8cad75dc9de90c19fb8~xlUaXx90k1961119611euoutp01D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124436euoutp017c4a862cd652c8cad75dc9de90c19fb8~xlUaXx90k1961119611euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194676;
        bh=YkxyQcPd7jAqlU+w/9184ePjjwebQte/K3v31Q58EAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDdNPZRXjz7fIp56nsIgc0gwsne0Hsvemfa0NSxek2AYJ4+r/BemQiwt7HblqB3VC
         KUJjBkVkiEA/cmJxNn0uRHOXUES4cVQvpQ+A//rEtPW5hrdCHfzzrMuzHttYZ/sd+a
         vOqMlTHpx94fgzAWybVOfcC3IFvy+hiwjJ/A5Xww=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124435eucas1p1d4e613edd6c7e288e8ad0137b7e07ea5~xlUZme7SU0147201472eucas1p1y;
        Mon, 15 Jul 2019 12:44:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.A0.04325.2357C2D5; Mon, 15
        Jul 2019 13:44:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c~xlUY5NUb80800208002eucas1p2P;
        Mon, 15 Jul 2019 12:44:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124434eusmtrp18f3e71b8cbe4efad9eda6f5fad5aa9f3~xlUYrJsed0462004620eusmtrp1n;
        Mon, 15 Jul 2019 12:44:34 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-a5-5d2c7532909b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.30.04146.2357C2D5; Mon, 15
        Jul 2019 13:44:34 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124433eusmtip231659ca0cbb0d01f23d43e343d67655e~xlUX6kOz71101111011eusmtip2F;
        Mon, 15 Jul 2019 12:44:33 +0000 (GMT)
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
Subject: [PATCH v1 01/50] clk: samsung: add new IDs for Exynos5420 clocks
Date:   Mon, 15 Jul 2019 14:43:28 +0200
Message-Id: <20190715124417.4787-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfyzUYRzHPfe97w/m6uk0nhDrWq3ICaVnq8SqddXWWv+0aaaT705x6L6I
        ajlFxYhUokXkGrsoJDu/86POSn5kcUllu7a2/Ap3NZspX1/Vf+/P+/P6vD+fPXsYQmognZnT
        0XGsJloZJaPsxHWv5nq8/OK3hGwt2IyHn/SQuDr/KYmHLN9I/KBzscw2jxG4t7eKxm8vj9N4
        WOuKa8yDJJ7O/EzigYb7FM7vbRHhys5PNH401C/C/a/3448p5RROa+6kccf4NRIvDFaLAx0U
        FUUVQDFlSqMVNfp0SvFMl6xom2wSKW7U6oFitsbtKB1styucjTqdwGq8A07aRRQaG+nYLysT
        p5730lrQLMkAtgyC21DHgI7IAHaMFJYDNPLwNykUFoBy8lMAT0nhLEANJTEZgFmayHmpFuwy
        gH7MMf/46pwSMc9QUI4M+rM8sxrqAOqcC+MZAn4Qoaav9STfcIAHUcXA2FK+GG5Apu40itcS
        GIA6Gidp4Tp39LjqBcFrW7gHzeX1UYL/jkb3LNuFe/Yhs9ZTsB3Qd2Pt8qgrenMrUyxoDmmz
        SoCgLyJzduEysxN1GPtJPoaAm9HTBm/BDkJpqQ20kL4CmSZW8TaxKHPr7hKCLUHXr0oFehOq
        zewTCdoRlVXkLYcrUJHOSgmPkwuQ7uYVkAPc7/1fVgyAHjix8ZxaxXJ+0ew5OadUc/HRKvmp
        GHUNWPxPbxaMVgNomQ9rB5ABMntJYLhniJRUJnBJ6naAGEK2WrLbumhJwpVJ51lNTKgmPorl
        2oELI5Y5SS7YjJ6QQpUyjo1k2VhW87crYmydtaCVue1LkjbJbmsmg0SqjQWmc5Fk99SOdLh3
        yP9QRleph1Xre6Vq2vfw/kujvgb5+zuh1mCzrPiY3J5q/ekWI0/3oVwCVIb5iXLv8MS4emwp
        mH99BGYNzZTq21xStXln1o8cSjj+a5tTv6MJru2yFBzwj53pg03rWC+jdlclJRNzEUofD0LD
        Kf8Aiv/+40sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7pGpTqxBgsm8FncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mucd3sxfc5694v/U8ewPjXt4uRg4OCQETiQlHc7sYuTiEBJYySlw9
        eY6pi5ETKC4mMWnfdnYIW1jiz7UuNhBbSOATo8STRzIgvWwCehI7VhWChEUEVjBKTD7hDTKH
        WeA1k8SRo+9YQRLCAp4Say6/ZgSxWQRUJW6caQWbwytgJ3F49zuo+fISqzccYAaxOQXsJX5O
        uwC1y05i8dGfTBMY+RYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjJttx35u3sF4aWPw
        IUYBDkYlHl6HFO1YIdbEsuLK3EOMEhzMSiK8tl+BQrwpiZVVqUX58UWlOanFhxhNgY6ayCwl
        mpwPjOm8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MRWd6Sqdc
        mHnmf+ZSnrnKm05yVfGk2TEmTJfo5/57c70Xi/vcukrX6e3fJzH4GTjJiYXMSjr4VETVP+h/
        xLc7K5Z96N92aXGq0jnznE2azK+zdjlzpu7lWnbTwn1+8OQGaZlE/9+njweIv/dy2Fm7c/dr
        Drf6yy6/V9TaLPlV95U/R6Z9404lJZbijERDLeai4kQA1OpPBLECAAA=
X-CMS-MailID: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need of new IDs which will be used for modeling proper hierarchy
in the Exynos54xx SoCs. Previous implementation rely on bootloader
settings, which are not configuring properly some clocks.
These IDs provide interface to set proper parents.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 02d5ac469a3d..c37a28eeaf7e 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -230,6 +230,30 @@
 #define CLK_MOUT_USER_MAU_EPLL	659
 #define CLK_MOUT_SCLK_SPLL	660
 #define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
+#define CLK_MOUT_ACLK400_WCORE		662
+#define CLK_MOUT_SCLK_DPLL	663
+#define CLK_MOUT_ACLK100_NOC	664
+#define CLK_MOUT_ACLK200_FSYS2	665
+#define CLK_MOUT_PCLK200_FSYS	666
+#define CLK_MOUT_ACLK200_FSYS	667
+#define CLK_MOUT_ACLK400_ISP	668
+#define CLK_MOUT_ACLK400_MSCL	669
+#define CLK_MOUT_SCLK_MPLL	700
+#define CLK_MOUT_ACLK266	701
+#define CLK_MOUT_UART0		702
+#define CLK_MOUT_UART1		703
+#define CLK_MOUT_UART2		704
+#define CLK_MOUT_UART3		705
+#define CLK_MOUT_SCLK_CPLL	706
+#define CLK_MOUT_PWM		707
+#define CLK_MOUT_ACLK266_G2D		708
+#define CLK_MOUT_SW_ACLK400_WCORE	709
+#define CLK_MOUT_SW_ACLK400_MSCL	710
+#define CLK_MOUT_SW_ACLK400_ISP		711
+#define CLK_MOUT_SW_ACLK266_ISP		712
+#define CLK_MOUT_USER_ACLK266_ISP	713
+#define CLK_MOUT_ACLK266_ISP	714
+#define CLK_MOUT_MMC0		715
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -264,8 +288,9 @@
 #define CLK_FF_DOUT_SPLL2	797
 #define CLK_DOUT_PCLK_DREX0	798
 #define CLK_DOUT_PCLK_DREX1	799
+#define CLK_DOUT_ACLK266_ISP	800
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		800
+#define CLK_NR_CLKS		801
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.17.1

