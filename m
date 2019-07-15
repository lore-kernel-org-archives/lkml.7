Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FAC2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TQS4Xy5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfGOMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfGOMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124505euoutp01bd66016bb80c44f64f6dcc463476c1e4~xlU2FoVVp1984619846euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124505euoutp01bd66016bb80c44f64f6dcc463476c1e4~xlU2FoVVp1984619846euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194705;
        bh=VjUehVjlqV4d9i1WqvKnygKijts5Agt7n2omeK3swGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQS4Xy5PhIGpRPpsar9x1gOsLZWRp/VWhx+a7fcpsOwf4BITvyhEY+AJqGDA29ImJ
         IOgPN83/wPpIdtzQTXokYq6RD8OoLaGVzWeqQgPdppzOWnUSwpN6FxBOkccbgW6lK6
         n/3+Fz3QSkK2XFw7roV8w9eet3UYe6j7Te5RT7QY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124505eucas1p1ee22ecc2c0e3ea0839f3ce1fb19d70b7~xlU1jSh8u0147201472eucas1p1Z;
        Mon, 15 Jul 2019 12:45:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.35.04298.0557C2D5; Mon, 15
        Jul 2019 13:45:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf~xlU0wR_Db0154701547eucas1p1b;
        Mon, 15 Jul 2019 12:45:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124504eusmtrp1cfb09b312f9156b6b18b4e2b7be4d23d~xlU0vrhCg0488104881eusmtrp1I;
        Mon, 15 Jul 2019 12:45:04 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-e7-5d2c75503d53
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.17.04140.0557C2D5; Mon, 15
        Jul 2019 13:45:04 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124503eusmtip231c903003c4068ed5360f3f7a9e6f719~xlUz5PmBq0528005280eusmtip21;
        Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
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
Subject: [PATCH v1 37/50] ARM: dts: exynos: change parent and rate of
 bus_fsys in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:04 +0200
Message-Id: <20190715124417.4787-38-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUYRSG++auihPXUfSgWTRROC2aEvRhaQZZ91fYX6Ny0ouJjstcrVyo
        KcoNyzArW63QrNEyzdRWRxuSMh21csUKFyRTJxslTJTmdqf6957nvO974ONjCdUzyouNTUgR
        9AnaeDXtTNa9nmvfEJ66ft/GnsdBuP9BO4Wri6so3DMzRuESs30sGP5GYIvlIYPbTk4wuN+w
        DNcMd1N4Ov8Thd8/vUbjYstLBb5vHmRwWU+nAne+DcMDJ+7S+PQLM4NfTWRTeLG7mgx14ytv
        VCLe2nua4WuMuTT/qPQ43zT1XMGfrTUi3lazPJyJcN4aLcTHHhb0/iGRzoduZOXTSRbmaM5t
        CzKgBjoPObHAbYL6+nEiDzmzKu4ugrLxClIeZhC8sVoVkkvF2RBUjWr+Jj6P9joS5Qje9WQT
        /xIluVftCZalOT9oMCZLAXeuFIF57qDkIbg+BTwfeUJJCzduP5gWbaTkJ7nVUNToImEltw1+
        WptI+dgKqHhoIiTtZOdzFztoqQe4LgaKbB8oKQvcDig3ecp+NxhvqWVkvQxaz+c7ekQwnLmF
        ZJ0JwwXXHZ4t8Kql808NwWmg6qm/jLfDhY4xR/tS6J10lTBhl4V1lwgZKyEnSyW7faE2v0Mh
        aw8or7zoKOfB2leM5McpRLDQ9oA+h1Zc+X/sJkJG5CmkiroYQQxIEI74iVqdmJoQ4xeVqKtB
        9i/VutjyowHNdh1sRhyL1C7K0Oh1+1SU9rCYpmtGwBJqd2XwrB0po7Vp6YI+8YA+NV4Qm5E3
        S6o9lRlLvuxVcTHaFCFOEJIE/d+tgnXyMqA14QOwedr8sSku40XsXOCu6csjrgdWVUcAGfus
        mMy5Z5g0WQr7jqu6jlo8cnYGRg0c81yu6/cuWRr8YybSV0zXNOYlPyk0Zv/0mOK/7mkrsGnG
        Egc18z5DvYZy97Nh8+3V1zODVg6F7I46dX/lne7AX9+9fQwm49fAhW/zmptvhtWkeEgbsJbQ
        i9rfl/no+E4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oBpTqxBtuuCFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MeW09bAXn2Ss6Fp1nbGDcwdbFyMkhIWAicf/pDeYuRi4OIYGljBKr
        rmxihEiISUzat50dwhaW+HOtiw2i6BOjxPcfDUAdHBxsAnoSO1YVgtSICKxglJh8whukhlng
        NZPEkaPvWEESwgIxEr+/zGICqWcRUJWYsp8HJMwrYC/x/f1BFoj58hKrNxxgBrE5geI/p10A
        O05IwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJxtx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYS
        Tc4HRnVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG+SmZYUc5
        HDoK5li+r+fwtzxav0tD0K91aYogl4DPLj0D37/7HCZuj+HZtSku8XngYbO2/67fFISWWPE6
        ivbp6s4+nzOd16Zp59XfnB9bvxhdP1ww22xlXsjLFcuYVDTdVZJnaHezlclXRRYdfSHKbHcz
        KvHLP8ce7spZTxw//Qz4c2S7zQElluKMREMt5qLiRACNe08esgIAAA==
X-CMS-MailID: 20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSYS bus OPP table has been aligned to the new parent rate. This patch
sets the proper parent and picks the init frequency before the devfreq
governor starts working. It sets also parent rate (DPLL to 1200MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index d460041f716c..6a82dd175b8a 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -72,6 +72,11 @@
 
 &bus_fsys {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
+			  <&clock CLK_DOUT_ACLK200_FSYS>,
+			  <&clock CLK_FOUT_DPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
+	assigned-clock-rates = <0>, <240000000>,<1200000000>;
 	status = "okay";
 };
 
-- 
2.17.1

