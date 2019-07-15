Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F213C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561242081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gjtsFfN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfGOMqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60124 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfGOMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124504euoutp011707cc9ed95242879fa8862c6603d80b~xlU0beFzZ1984619846euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124504euoutp011707cc9ed95242879fa8862c6603d80b~xlU0beFzZ1984619846euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194704;
        bh=p4qyGCRC9XXm9VFzmGgechQEw2giiytvt4FcZQzQVAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjtsFfN1RvXuru5lXlxXkZPOxECT08+bWOhLAJjfGIIOkpsouzAdv5xBuByJ2kmTh
         jHGi0TSQ70lmCGJ7BIqRQVONsayDdtWBxKJvMpt1QNoWloas0Bti4lMHS7a5rtDd36
         2x8MHoRZAWyOq5bAQVJUPxg/M5B7CeWWKE2XOtYI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124503eucas1p22011b9f08900e383e756f60f956546d1~xlUzis5Fc1386513865eucas1p2d;
        Mon, 15 Jul 2019 12:45:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C6.C0.04325.E457C2D5; Mon, 15
        Jul 2019 13:45:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124502eucas1p20a35f8c0f426878e50583fa3402de988~xlUylg3hL2439624396eucas1p2j;
        Mon, 15 Jul 2019 12:45:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124501eusmtrp126b9a2a8c516b3fd9d5584a0468e16f0~xlUyXZUou0488104881eusmtrp19;
        Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-fd-5d2c754e0f03
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.50.04146.D457C2D5; Mon, 15
        Jul 2019 13:45:01 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124500eusmtip2265d3553c7d052165984db886d68cfc7~xlUxgytJP1101111011eusmtip2T;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
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
Subject: [PATCH v1 34/50] ARM: dts: exynos: set parent clocks to PWM in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:44:01 +0200
Message-Id: <20190715124417.4787-35-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHfXd2tuNwcpySL+YFFoqVqZHBC+UlSlhE5QdJKMRmHlTyurOZ
        VtIqNBszzUJF0jJNZXnfEJvOckoDZ84b6kyzMlO8JKaCYkibO9a3//N7nv/7XHgJTKDD3YjE
        FCklSREnCTk8dtvH7YFjl2R+0YH9q0FosnEARy2lTTga35jH0cteS1gwu4Qhk6mZiz49WOai
        Sbk7ap0dw9Ga8guORrQvOKjU1MVCDb3TXPRmfIiFhvrC0ef7dRyUo+vlop7lRzjaHWthhzmL
        6ivqgWh1IocralU95ojU1fdE3b86WaInGhUQrbd6RnCv8k7HUUmJGZQkIOQ6L8GQ181Ja8Qz
        Sxu85KCTrQD2BCSDYOFOOUcBeISArANwe3qLCTYAXOt+zrIF6wDqdN/AvmVF/5BJ1AI4t7AF
        /llMOzO4AhAEh/SH7ap0q8GFrAawdzvWWoORZhbs/PEOtyacyUi4mK9mWTWb9IbvR2s4Vs0n
        Q2Fb+QrX1s0Lvm3+gFm1vYVvFw/uzQfJYS7syxtltjgHNUuFjHaGiwYNY3aHxmdKhtNQnl/J
        rHAXzhaUMzWnYI9haG9ojDwMm7QBNnwGjqwr9jAkHeHEipMVYxZZ1FaC2TAf5uUKbNW+UKMc
        ZNn0AVhbX8w8LoJbu0bmokUAmr8vsAuBV9n/Zq8AUAFXSkYnx1P0iRTqlj8tTqZlKfH+N1KT
        W4HlUxl3DZvtoOtPrB6QBBA68MPijkYLcHEGnZWsB5DAhC784E0L4seJs25TktQYiSyJovXg
        IMEWuvLv2H29JiDjxVLqJkWlUZL9LIuwd5MDxyvKbFlI+axf3wDpnQarmtRVHWrz+RlNVGko
        tnPS6UJlZoWTvvCia9lUdX5njPT3vLxJ4t6n6xgyZke5eeTaNRo7gi9jmf0Oh8L81D68EsOU
        xHMifd43bFiZEF6ZtJNYo9W3P30dMVd9NrLB+DNwXRWulZodIn1STX4Bkx5CNp0gPn4Ek9Di
        v2EE9l5QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7q+pTqxBgfu6VncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M4x0H2QrWsVbMWCvfwLiHpYuRk0NCwETi7aFmpi5GLg4hgaWMEsdW
        nIVKiElM2redHcIWlvhzrYsNougTo8Tdm3cYuxg5ONgE9CR2rCoEqRERWMEoMfmEN0gNs8Br
        JokjR9+xgiSEBYIkJh7pYAKxWQRUJfZfWcYGYvMK2Etsm/sWaoG8xOoNB5hBbE6g+M9pF8Bq
        hATsJBYf/ck0gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDI2Xbs5+YdjJc2Bh9i
        FOBgVOLhdUjRjhViTSwrrsw9xCjBwawkwmv7FSjEm5JYWZValB9fVJqTWnyI0RToqInMUqLJ
        +cCoziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKiXdWnGQh9t
        LrkExmNfb26R1fN8xN5478NGiVVL+k7dz/5vt+V8eEXUvUspS79oC9klLPy56uILl/acWxM+
        e15yEVF6VvhTbes7HleFHH57o7UnzOpMVtmXx6udVK9arujOfU5xSdLUEudnlp9TD3rM3Db3
        0HF/7XcB8xb7psXvq1a6/dSicbsSS3FGoqEWc1FxIgA8xyiLsgIAAA==
X-CMS-MailID: 20190715124502eucas1p20a35f8c0f426878e50583fa3402de988
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124502eucas1p20a35f8c0f426878e50583fa3402de988
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124502eucas1p20a35f8c0f426878e50583fa3402de988
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124502eucas1p20a35f8c0f426878e50583fa3402de988@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the parent of PWM clock to the CPLL which has 666MHz.
The PWM's divider uses /10 rate so it would set 66.6MHz.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 79f635043247..a361dd5a6036 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1473,6 +1473,8 @@
 
 &pwm {
 	clocks = <&clock CLK_PWM>;
+	assigned-clocks = <&clock CLK_MOUT_PWM>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_CPLL>;
 	clock-names = "timers";
 };
 
-- 
2.17.1

