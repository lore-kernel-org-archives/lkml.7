Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53381C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137720868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hGJgJeaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfGOMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:48:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49597 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfGOMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124441euoutp0286cf5f15ff6f99e5bdf93f0ecc1f18d0~xlUfEVXS60715707157euoutp02H
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124441euoutp0286cf5f15ff6f99e5bdf93f0ecc1f18d0~xlUfEVXS60715707157euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194681;
        bh=ondmxPhh+Fxnd5s3n9tmk8yHO5V0bGcYkkE6AtEC9vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGJgJeajijiW2X8ct1OrRdv26MaryBvaBd8et+4GCy0LRCxQAGKk1NcmWhbFQjtlg
         7AwCVVabaxMMhbFDwedsO5RgueYQiUam6EB2BJ1EPP/Og/DVbDPQkPQlmRsRp7enIM
         XdwlUQP+SkZxGXNJNTPD1xEU8vRmKZhKLK5ahLBo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124440eucas1p1e3f7f5869fa71941b7f6e250a55d51c6~xlUeSFr7c0154701547eucas1p19;
        Mon, 15 Jul 2019 12:44:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 98.D1.04377.7357C2D5; Mon, 15
        Jul 2019 13:44:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124439eucas1p18c4f512d2647717d77666d94dca867a6~xlUdjzo_P0154701547eucas1p18;
        Mon, 15 Jul 2019 12:44:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124439eusmtrp16e36cc3810052fd6b715c1b906b353a9~xlUdVlXPj0462004620eusmtrp11;
        Mon, 15 Jul 2019 12:44:39 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-d6-5d2c75376117
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 83.40.04146.7357C2D5; Mon, 15
        Jul 2019 13:44:39 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124438eusmtip2d4e140a64781153b3011323f5d9c60cc~xlUcgTSjc1115211152eusmtip2F;
        Mon, 15 Jul 2019 12:44:38 +0000 (GMT)
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
Subject: [PATCH v1 07/50] clk: samsung: add IDs to ACLK266_G2D clocks in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:34 +0200
Message-Id: <20190715124417.4787-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGuZ1OOyA1Y9muSMQ0cYfi9nCjrAmaPokxISQK6iATQFY7lEUk
        FggqhEWqAhpAjWxWpFALIiKyNDRhbzCAGFGDihFESIuKUZBhSnj7zn///55zTy6BiVtwZyIy
        NoGWx1LREoENv6l7ccAdKdxC9pVL0HjdAI4aSjQ4GjVP4eiefqUsmJzG0OBgvRD1Z8wI0bjS
        BWknR3A0nzuBo+GWUgEqGWzjoSf6d0JUOWrkIWPPUfQ2vUaAsl7qhahr5hqOlkYa+L52stry
        WiD7MZYllGnV2QLZ04orso7ZVp4sX6cGMpN26wnhKRvPMDo6MpGWe3ifs4noz7CLn7BNrs/7
        IlAC5YYcYE1A8hBsVumEOcCGEJM1AA4qXwCuMAM4WzeOcYUJwM/tmfhapEfdbolUA/iwu2o9
        crtjQpADCEJASmGz+iIbsCcrANQvhrIejHzDg62fnuOsx44MhMU6f9bDJ7fDj48Mqw1EpDf8
        t9BtaeYKH9e3Yyxbkz5wsWhIwOkDQlg9tZljf5hfWMbn2A5+M7DvYdkF9t7MtegMVOY9ABxf
        hpMFZRbPEdhlMK6Og5G7oabFg5P9oGm6BGNlSG6EY983sTK2gqqmYossgtevijn3LqjLHeJx
        7Aira4ssl8tgVSO7NXY5KgC/Vv7m3QCud9eb3QdADZxoBRMTTjMHYukkKUPFMIrYcOn5uBgt
        WPlRvUsGczNo+RvaCUgCSGxFvmF7Q8Q4lcikxHQCSGASe5HXwookCqNSLtHyuLNyRTTNdIIt
        BF/iJEq1+nBaTIZTCXQUTcfT8rVTHmHtrAS3FIrybGmqfbDj67I5vS+cDbXa5rAc1e1zRhtS
        pwk8mPa+qe8wodK4FRPzpjTJBal7NDqOpccPZJx89cfF3Bo0a9QpDFWRbea5nX6ecz3Usztu
        1K/m5J+ujV5JkX2l2xw0O5Z9TAGqcDQcNH4sQB3s4aRP0mc2SPWFxgSnVAmfiaD278HkDPUf
        BxEQTU0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7rmpTqxBke/cFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Ms03CBfd4Kjb0PmNrYGzg7mLk5JAQMJE4teoAexcjF4eQwFJGieZZ
        05kgEmISk/ZtZ4ewhSX+XOtiA7GFBD4xSty9D2RzcLAJ6EnsWFUIEhYRWMEoMfmEN8gcZoHX
        TBJHjr5jBUkICwRLbL8yBWwmi4CqxMOVx8HivAJ2En+/HmOFmC8vsXrDAWYQm1PAXuLntAtQ
        u+wkFh/9yTSBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwLjZduzn5h2MlzYGH2IU
        4GBU4uF1SNGOFWJNLCuuzD3EKMHBrCTCa/sVKMSbklhZlVqUH19UmpNafIjRFOioicxSosn5
        wJjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqHO86YrRPnaF
        d4v/NM3b9iqg0uDohYRzsU9f/6iOXKgd/f2sdYJHkFDRSu/CbYfuCOZPul3RebHvxhaZztp/
        LPt75hQFfF9Y4MCbZe9tXyp0/e8E1Ylzz8iXz+hu9lQwP/dDWPpxVucvxodCtlknDbZbvHyw
        v6m3kafSl3fPfJdv/eEbja9aKrEUZyQaajEXFScCAAFoBlexAgAA
X-CMS-MailID: 20190715124439eucas1p18c4f512d2647717d77666d94dca867a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124439eucas1p18c4f512d2647717d77666d94dca867a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124439eucas1p18c4f512d2647717d77666d94dca867a6
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124439eucas1p18c4f512d2647717d77666d94dca867a6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDs to MUXes of ACLK266_G2D to manage them from DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9b4a1d81f708..9d54856dbcda 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -478,7 +478,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 
 	MUX(0, "mout_aclk400_disp1", mout_group7_5800_p, SRC_TOP2, 4, 3),
 	MUX(0, "mout_aclk333_g2d", mout_group5_5800_p, SRC_TOP2, 8, 2),
-	MUX(0, "mout_aclk266_g2d", mout_group5_5800_p, SRC_TOP2, 12, 2),
+	MUX(CLK_MOUT_ACLK266_G2D, "mout_aclk266_g2d", mout_group5_5800_p,
+			SRC_TOP2, 12, 2),
 	MUX(0, "mout_aclk300_jpeg", mout_group5_5800_p, SRC_TOP2, 20, 2),
 	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
@@ -567,7 +568,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 
 	MUX(0, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
 	MUX(0, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
-	MUX(0, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
+	MUX(CLK_MOUT_ACLK266_G2D, "mout_aclk266_g2d", mout_group1_p,
+			SRC_TOP2, 12, 2),
 	MUX(0, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
 	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
-- 
2.17.1

