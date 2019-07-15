Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95702067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OEf4HAPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfGOMrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:47:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60279 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfGOMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124449euoutp0156062fa25a6dfeef5eb280b87f5ba5d5~xlUm2yNKu1837218372euoutp01f
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124449euoutp0156062fa25a6dfeef5eb280b87f5ba5d5~xlUm2yNKu1837218372euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194689;
        bh=e/bI+49CIyftwGTc+xwcAyP9bm184Xpd/85SSnUhakk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEf4HAPw5CMhyHIn1QKZXceSv9vYjh6o6FOVojXdUEHbJ5EO8n9wtAKdiXJX+XMsX
         ygU9tJxV+ZhIlL36VU4vAsT588mq2JtfoWGdnkLSZoDZS1a8tFHifBhztOaeyu4U0O
         Ebvdj4EHw95Af/FBdM21kO9OE5s+G+DmZSLsm808=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124448eucas1p25eda46e4b1c2f49f1c38cd5f9bdbc911~xlUmBqDMv1544915449eucas1p28;
        Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A0.B0.04325.0457C2D5; Mon, 15
        Jul 2019 13:44:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124447eucas1p143a857f619f48b9b87437ec3b13dfb3f~xlUlNvQ4c3191231912eucas1p1Z;
        Mon, 15 Jul 2019 12:44:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124447eusmtrp16f1daa55d99a5d7e0e9d4d828e2b5580~xlUk-pGZn0462004620eusmtrp1Z;
        Mon, 15 Jul 2019 12:44:47 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-cc-5d2c7540edc4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.07.04140.F357C2D5; Mon, 15
        Jul 2019 13:44:47 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124446eusmtip2508c7ab371e3cb515ec4d9541fa125a0~xlUkOKj190518605186eusmtip2j;
        Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
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
Subject: [PATCH v1 17/50] clk: samsung: add CLK_MOUT_MMC0 in the Exynos5420
Date:   Mon, 15 Jul 2019 14:43:44 +0200
Message-Id: <20190715124417.4787-18-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxbYRTGvb339l6yyl0Jb0wmaSL7xBYWb2YzxJYmkpl/JLPIVtwgU6xX
        bWyJWpiPWA2J2TIzG0N9lwiGrTQEUZqJj2IhXSLBSFci9mFr3dr++53nnOc5J29eChP2EW5U
        YnIaI0uWJIn4DnjX8J7OK0h+NvqcqtgFGVp0BGqvaCXQ7PYqgaq0lrLYuI6hyck2Ek083iCR
        QeGO1MYZApmKvhDoc+8rPqqYHOChZu0SiWpn9TykH7uKFrLr+Si3X0uioY08Au3PtONBTuKm
        101AvDWXS4rVqgK+uKMmS6zZ7OOJlZ0qIDarj98goxwuxTFJiemMzCfwjkOCvt+MpzaQD0Z0
        Gr4CVPELgT0FaT+oLighrCyk6wFceBFYCBwsvA1g2/IuyRVmABc7FolDR+GWgs816gBUVv/G
        /1k075YtBUXxaW/YrbpnNTjTNQBq92KsMxg9z4N9X3sOkpzoMDg92gCsjNOesNn45+AmAX0F
        NtWbcG6bB2xs+4RZ2d6i75VP2e7WkbDFJOA4FObkmTCOneDaSCfJsTscLyuy5bBQ8bQacPwI
        GosrbTMBcGhET1hvxuhTsLXXh5ODYY55BbPKkHaEc9+OWmXMgqVdz22yAOY/EXLTJ2Fn0RSP
        YxdY11RuCxfDmrV+gnudUgA3DPvEM+Dx8v+yNwCogCsjZ6XxDOubzNz3ZiVSVp4c7x2bIlUD
        y58a3x/Z6QYDv2IGAU0B0RFBUNyZaCEhSWczpIMAUpjIWXB5xyIJ4iQZmYws5bZMnsSwg+AY
        hYtcBQ/tlm8J6XhJGnOXYVIZ2WGXR9m7KcDAV15Xrzx6rM5fVZwdaDQG2EnD03eKHL1GY8Mn
        vi/+xMta/ZE5ZNZ3+Joyazf6JqFaD1taSWx0ipjOD1H5hJQr7dLeqyt7YeuswRwf/CFy0aB5
        2xPh2axLkPlFjivDTBeNJ6672nuFXZCH6ud/RCkGastXNxtD0kNLdHTmRxHOJkjOn8ZkrOQv
        I8r3FU8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7r2pTqxBstOyVrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Mi3s/sxSsZK84fu4gWwPjfLYuRk4OCQETia73DUA2F4eQwFJGiZMT
        vzNDJMQkJu3bzg5hC0v8udYFVfSJUWLHi8lACQ4ONgE9iR2rCkFqRARWMEpMPuENUsMs8JpJ
        4sjRd6wgCWEBb4krJ1cygtgsAqoSax//B9vMK2AvsWbFRxaIBfISqzccAFvMCRT/Oe0CWI2Q
        gJ3E4qM/mSYw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGDvbjv3csoOx613wIUYB
        DkYlHl6HFO1YIdbEsuLK3EOMEhzMSiK8tl+BQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwP
        jOu8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MveWV1QV9k0XX
        NjOlXfQr1jiTPblHY9vCiGs/r1zu277nxWq3d9Zb7BLDEnua6+ZuX2YU89Nhf7vX3a9x/KnZ
        DT9XtEhU7WnRbCy982LrnjWnplit2hJqfyU9YN+0kisrOB7+t1evi/zizFFyZGuctoLsH5Wj
        Rg8MpjuazpJfdGjBrnvrGe3/KrEUZyQaajEXFScCAGXYNO+zAgAA
X-CMS-MailID: 20190715124447eucas1p143a857f619f48b9b87437ec3b13dfb3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124447eucas1p143a857f619f48b9b87437ec3b13dfb3f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124447eucas1p143a857f619f48b9b87437ec3b13dfb3f
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124447eucas1p143a857f619f48b9b87437ec3b13dfb3f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID to mout_mmc0 MUX to make possible children connection in
the DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index ead569a164cf..8d58801baf2c 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -763,7 +763,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	/* FSYS Block */
 	MUX(0, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
-	MUX(0, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
+	MUX(CLK_MOUT_MMC0, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
 	MUX(0, "mout_mmc1", mout_group2_p, SRC_FSYS, 12, 3),
 	MUX(0, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
 	MUX(0, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
-- 
2.17.1

