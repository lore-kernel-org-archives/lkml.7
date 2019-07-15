Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573C02067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oB8SLNOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfGOMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49648 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbfGOMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124445euoutp02b0f63273fe51d97f8797a97786cda4ab~xlUjMH76u0599405994euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124445euoutp02b0f63273fe51d97f8797a97786cda4ab~xlUjMH76u0599405994euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194685;
        bh=wvAn/Pd40QWaTn4Vruzx23GcrbKmatIE/03uKpdDkM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB8SLNOKZ8Hh5S+MrArKkECIWnsy25DGenfOsa5wVB2vY/wQQj3gqJjsvqgMKkvdx
         9ryAdZHDzp7Uz15o4NNsk2xIKYMG3ZD0PESf1cMwkrIODTF8X3uxYZ9rVwlK7mHfiR
         qGWxIbSS4nYvDUcC3fUXHhIoKyGw4l5IiUfwdT50=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124444eucas1p2f20893ae6c81a7b0612bdfb4a83822b3~xlUiYkEa23211132111eucas1p2F;
        Mon, 15 Jul 2019 12:44:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9C.D1.04377.C357C2D5; Mon, 15
        Jul 2019 13:44:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124443eucas1p1adf02a02bf77448f2277ddd5fe5e895b~xlUhYafL80571105711eucas1p1y;
        Mon, 15 Jul 2019 12:44:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124443eusmtrp1215e22c07e1e231f684ac87931560e45~xlUhKFCNU0462004620eusmtrp1I;
        Mon, 15 Jul 2019 12:44:43 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-e4-5d2c753cc344
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.40.04146.B357C2D5; Mon, 15
        Jul 2019 13:44:43 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124442eusmtip24c1b0a2ae870b0926918e355a950ed76~xlUgV_qEO1184611846eusmtip2W;
        Mon, 15 Jul 2019 12:44:42 +0000 (GMT)
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
Subject: [PATCH v1 12/50] clk: add ID to PWM MUX in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:39 +0200
Message-Id: <20190715124417.4787-13-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSezBUURzHO3v37l7GmtsyOSNRO9NEijL+OI1HTMqa/qg/NGMyJit3MCza
        a5Ue02qSMrTCoCjMMJ55LO2sTUZrPUqs1yDpIcJITCGjUHu7a/rve77fz/n+zjlzCEyoxW2J
        qNgEShYriRHxzLnqzvW+w57yQyFHxgds0HhtH44a8utwNLoyi6MivXGpnPqKIYOhno96by3w
        0bjCDqmmRnD0Pf0Djoa0hTyUb2jloKf693xUNjrAQQOvT6J3yRU8lPJCz0ftC6k42hpp4PpY
        iWue1ADx0lgKX6yquscTN5beFL9cbOGI7zdVAfGyyv4s/7y5ZzgVE5VIyVy9Q80jMwsKsHgV
        cWVjbRZXgGJ+GjAjIOkOe/40Y2nAnBCSFQCm5i0BJhCSKwAafgA2WAZQqe7nbu/Y+FjEZaFy
        AGvnDrCQcUO9Ws1JAwTBI12gpuoSw1iTpQDq18MYBiPfcmDLdDPOBFakN5zoWvs3jUvuh4Md
        TClBCMjjcLUwkZ3lAKvr2zBGmxnt9dx+HtMDyT4+zN8sAAwPST+41evB8lZwvqvJdDM72JOd
        bjozDRUZJYDV1+GU8rGJ8YDtXQM4U4ORTrBO68ravnCrMAdj2y3h2LedjI0ZZZY6z2QL4N07
        QpZ2hE3p/RxW74LlNbmmcjEcyXluesEsAFuWBnmZwOHR/2HFAFQBG0pOSyMo2i2WuuxCS6S0
        PDbC5WKcVAWMP6pnq2tFA7QbYTpAEkBkIfAJdw4R4pJEOkmqA5DARNYCr1WjJQiXJF2lZHEX
        ZPIYitaB3QRXZCO4tuNTsJCMkCRQ0RQVT8m2Uw5hZqsAjnNnLN5oHk46lk10o9Bgp6GgTSVp
        8Svqi32A4ETlaWWQZoZXuSzTBK6mtE1qSzJknvTMcFntKX+3+ZpzXtl7fwcu+i58fqVz79zT
        Ha+ftlaog/1b5UPV+yxxeRg+7OHsafnsxvqYn91Ex0+3YwnWRT3RAbc7N2obc9QxyQ9K4kVc
        OlJy9CAmoyV/Aft0QLpNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rWpTqxBpfviVjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MCbNnMxds4qj48/05awPjAvYuRk4OCQETiT/357N0MXJxCAksZZRY
        0PadESIhJjFp33aoImGJP9e62CCKPjFKdB2dxtTFyMHBJqAnsWNVIUiNiMAKRonJJ7xBapgF
        XjNJHDn6jhUkISxgJ3HnOMRQFgFViUtHQbZxcPAK2Et8nVMGMV9eYvWGA8wgNidQ+Oe0C2wg
        thBQ6+KjP5kmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERg524793LyD8dLG4EOM
        AhyMSjy8DinasUKsiWXFlbmHGCU4mJVEeG2/AoV4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5
        HxjVeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGOtvXT6fPFnJ
        nf1t/NK02pLIAzdPluucrDCNXpiVsUD3dqLhkxUX6sO2ypz6aOd0xsdQ+tc9pVirgET3qZdv
        iytfCXVjKT3AFctQOovv4cuyZOHVEgsYP2u4nV4SOOmeiNf52/r71rRWfpt9kC9sihT303dM
        +42NNsgxPVeMm9oUmhh8aKkPvxJLcUaioRZzUXEiAN3Zx0WyAgAA
X-CMS-MailID: 20190715124443eucas1p1adf02a02bf77448f2277ddd5fe5e895b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124443eucas1p1adf02a02bf77448f2277ddd5fe5e895b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124443eucas1p1adf02a02bf77448f2277ddd5fe5e895b
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124443eucas1p1adf02a02bf77448f2277ddd5fe5e895b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID to PWM MUX to manage it from DT to reflect proper topology.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 7bf74401c4e7..7f8221527633 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -772,7 +772,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_UART1, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
 	MUX(CLK_MOUT_UART2, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
 	MUX(CLK_MOUT_UART3, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
-	MUX(0, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
+	MUX(CLK_MOUT_PWM, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
 	MUX(0, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
 	MUX(0, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
 	MUX(0, "mout_audio1", mout_audio1_p, SRC_PERIC1, 12, 3),
-- 
2.17.1

