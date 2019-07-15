Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB8CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4F206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zu5di3CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbfGOMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60154 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbfGOMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124442euoutp0193ab04aaca7bed8f06e71291119d4c60~xlUgvXAQC1961119611euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124442euoutp0193ab04aaca7bed8f06e71291119d4c60~xlUgvXAQC1961119611euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194682;
        bh=xyPVVgSZeAAl0W8N7v1spNbK/C37A4Mttfo7IbZ7n/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zu5di3CCoNhgRNrQNS9TiANUz9J2IOT0o34ZFTjFEN4ylN4deLgpNQFAAOGtJ3RU7
         db2fNA2bey5sC8rc97zay8UnzSQaWi5R4Q65Y5Bek5QIQBtm0/9nr79IrCKu2n/P/l
         HVTzpmS28pkoMeQKAH/5SIGQo7AIstTdmJHBPVKc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124442eucas1p27990fa89f07a54f5e2b55434ac7019aa~xlUf_TUQq1386513865eucas1p2B;
        Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4A.A0.04325.9357C2D5; Mon, 15
        Jul 2019 13:44:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124441eucas1p12e1f58587318219a5a2c695faa200b17~xlUfK8FhO0146601466eucas1p1B;
        Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124441eusmtrp14ee2327d0d20ba36d29035765359bfaa~xlUe815ik0462004620eusmtrp16;
        Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-b7-5d2c7539b1de
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.F6.04140.8357C2D5; Mon, 15
        Jul 2019 13:44:40 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124440eusmtip2ea673178038ddf8fc3568c924a8628f6~xlUeCoi8h1184611846eusmtip2U;
        Mon, 15 Jul 2019 12:44:40 +0000 (GMT)
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
Subject: [PATCH v1 09/50] clk: samsung: add IDs to FSYS clocks in Exynos5x
Date:   Mon, 15 Jul 2019 14:43:36 +0200
Message-Id: <20190715124417.4787-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2zln52y0OG5RH2Vag6CLza7w2dUo4SAEQdCPIuqYJ43csp2m
        WZEr0aWYmoGKXSVTmVY6zVsqpsuZw9SFWopdVLp5LRU5ZdZOZ9a/530u7/Py8VGYupZYQp00
        nOWMBjZCK1fi5U1C27oAk9+R9S5hI+p59JJAJVmPCdQ9+YlAd+3uMXVgCENtbcUkar0yTKIe
        szeyDXQR6FvyWwK9qr4lR1ltdTL00N5HogfdHTLU0RKEei8XyFF8rZ1EjcMWAs12leCBGqbo
        ThFgxl7Hk4zNmihnSnNjmWejNTImpcwKmAmbz37ykHJ7KBdxMooz+u88pgx3lOaByF+KcyXN
        WcAMnFQSUFCQ3gzTUgUiCSgpNV0AoLW+ApOGSQBb3lR5hgkAn8eNYnMR4eFLXBLyASyd6JT9
        i4z1tbsVipLTOlhpPSMGFtK5ANqFENGD0W9ksGawihAFDR0MXSk2XMQ4vRIOtnwBYlZF74JV
        iQelMl9YWFz/t1jhpoWMdrm4B9IuEl5/+k4umfbCTOGm5zoN/OooIyXsDZ03knEJ89B8LQdI
        +CIcSL3t8WyDjY4OQuzF6NXwcbW/RO+GCYV1pEhDegF8PeIl0pgbppdnYhKtglcT1JJ7FSxL
        bpdJeBHML8rwLGdg4bsGz+ukAziVYyPSgG/2/7J7AFjBYs7E68M4fpOBi9bxrJ43GcJ0x0/r
        bcD9qZyzjqlKUDcT0gBoCmjnqwJD1x5RE2wUH6NvAJDCtAtVO6bclCqUjTnPGU8fNZoiOL4B
        LKVw7WLVhXnvD6vpMPYsd4rjIjnjnCqjFEvM4Jiv+lZlZ58lJ+jSAiL1W78rVhnHOpdPf/g+
        4vSKCnV+UnYHz1T8yHSkNPv7jT75Xbb1oy/Kyu41Tb+ydBQ4ogci+4XP5p+KLec3jLOznV1D
        sSt0+87t6U+4v+lAnqEYb+0dmbWMf2+6E6eZPjH5YqjVhNV/WKTxm/FRZQRcNC/T4nw4u2EN
        ZuTZPwkbD49QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oWpTqxBi//WFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M45uXMRb85azYeGIGYwPjaY4uRk4OCQETiZ9rz7F0MXJxCAksZZTY
        vnUyG0RCTGLSvu3sELawxJ9rXWwQRZ8YJRZ9uQeU4OBgE9CT2LGqEKRGRGAFo8TkE94gNcwC
        r5kkjhx9xwqSEBbwkrjUt4kFxGYRUJV4cuolI0gvr4C9xM7OMIj58hKrNxxgBrE5gcI/p10A
        u0FIwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJxtx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYS
        Tc4HRnVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGSS9vXn+5
        7n9Ckgz7LPlXR18tFriWwvBy8rOvn7s3vCnPilJO0Ejg7txyK9cniaHRoOnD3Jt/Z/WrG1Vz
        tT1V3vtu00nup2UCz6f57xLbu50p7u1n9UDDVeHrp62uMsud3JV22pl1+/Sa6X/5KlinfHsm
        FsAUe9Xhm4Z2+pJf/7lMd86cvNv2qxJLcUaioRZzUXEiAGEcT5KyAgAA
X-CMS-MailID: 20190715124441eucas1p12e1f58587318219a5a2c695faa200b17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124441eucas1p12e1f58587318219a5a2c695faa200b17
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124441eucas1p12e1f58587318219a5a2c695faa200b17
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124441eucas1p12e1f58587318219a5a2c695faa200b17@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDs to MUXes of ACLK200_FSYS, ACLK_FSYS2, PCLK200_FSYS to manage them
from DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 5f251279b4c8..6164d0ca75e0 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -622,9 +622,12 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
-	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
-	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
-	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+	MUX(CLK_MOUT_ACLK200_FSYS2, "mout_aclk200_fsys2", mout_group1_p,
+			SRC_TOP0, 12, 2),
+	MUX(CLK_MOUT_PCLK200_FSYS, "mout_pclk200_fsys", mout_group1_p,
+			SRC_TOP0, 24, 2),
+	MUX(CLK_MOUT_ACLK200_FSYS, "mout_aclk200_fsys", mout_group1_p,
+			SRC_TOP0, 28, 2),
 
 	MUX(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
 	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
-- 
2.17.1

