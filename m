Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D311C76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1872067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NA4xPVQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfGOMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60585 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbfGOMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124513euoutp01189ad65644d38a5784700fa29114850b~xlU8_axEE1984619846euoutp01V
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124513euoutp01189ad65644d38a5784700fa29114850b~xlU8_axEE1984619846euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194713;
        bh=o6Z1zLp+glL4NXfMdLJGkavR2ugnNQVpXq1paUuAP3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA4xPVQjmiDtYrHIe0AazN67WG5BuRYT+x7FzwvHMTNmbGmk8Ygtlczo++PPTBnZI
         1rGWet4ATE2vSR7RhFZGFL4dsQf8NEGQJ1cn0jopGRrF1mFW6Zc00GObhBIfSmV5yG
         6OGqN3ovkQaTEM2gM3luiJXxsM8OmXtD1o1XnAFI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715124512eucas1p17531bb76d9ba80ee553432a7ab274e79~xlU8B6cwP3092130921eucas1p1A;
        Mon, 15 Jul 2019 12:45:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.F1.04377.7557C2D5; Mon, 15
        Jul 2019 13:45:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124511eucas1p2b11ef3a5bc093e686ae5450d16785225~xlU7QAtye0273902739eucas1p2H;
        Mon, 15 Jul 2019 12:45:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124511eusmtrp1aee1a22a77edcdbc09abbe8fc0e2f1df~xlU7B2QlZ0524305243eusmtrp1T;
        Mon, 15 Jul 2019 12:45:11 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-40-5d2c7557b057
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.60.04146.7557C2D5; Mon, 15
        Jul 2019 13:45:11 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124510eusmtip2d955fbabd17b1a22867a36be84bdff71~xlU6PrUmA1099510995eusmtip23;
        Mon, 15 Jul 2019 12:45:10 +0000 (GMT)
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
Subject: [PATCH v1 45/50] ARM: dts: exynos: change rate of bus_disp1_fimd in
 Exynos5422
Date:   Mon, 15 Jul 2019 14:44:12 +0200
Message-Id: <20190715124417.4787-46-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87rhpTqxBgveW1vcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MibdmMBY0sVX0d09gamCcyNrFyMkh
        IWAi8ffCIbYuRi4OIYEVjBKtSx6xQzhfGCX+tH9lBKkSEvjMKDFxZRVMx+7dT5ghipYzSlxo
        2ckC13Fry3Wgdg4ONgE9iR2rCkEaRASWMEoc+ZkEUsMscJNJYs+TnWC7hQUiJZZ/+8IOYrMI
        qEp83LwWbBuvgL3E9qMXmCC2yUus3nCAGcTmBIr/nHYB7FYJgXPsEpsvPoZ6wkWi4eJGRghb
        WOLV8S3sELaMxOnJPSwQdrFEQ+9CqJoaicf9c6FqrCUOH7/ICnI0s4CmxPpd+hBhR4m1G1vA
        fpEQ4JO48VYQJMwMZE7aNp0ZIswr0dEmBFGtIbGlB+ZiMYnla6ZBDfeQ6Lu+Fxqgkxgllh/c
        wDqBUX4WwrIFjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPV6X/Hv+xg3PUn6RCj
        AAejEg+vQ4p2rBBrYllxZe4hRgkOZiURXtuvQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwP
        ooUE0hNLUrNTUwtSi2CyTBycUg2MK58obBZqmN7yUGTlrIvGQf93KrM9MXM7GT9JY1HKRKv1
        FYfrmD8evxX3wi3qu6b3Y43Vt7rz5M4d/cf46Ry/zKHms3zSkst89pnPnv9E703x9b0rQ98v
        q2hf5vHlctivmNB8d0+VeS/mul9uz/q/69fCD+cnt+xYc3n7xorni16pzQ35vEZiooISS3FG
        oqEWc1FxIgDOYTn8UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rhpTqxBuc+sVvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5veAJU0yFhsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG7
        7BZLr19ksrh4ytXiduMKNovWvUfYLQ6/aWe1+HdtI4uDsMeaeWsYPd7faGX32LSqk81j85J6
        j4Pv9jB59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+
        nU1Kak5mWWqRvl2CXsbEWzMYC5rYKvq7JzA1ME5k7WLk5JAQMJHYvfsJM4gtJLCUUWLDrEiI
        uJjEpH3b2SFsYYk/17rYuhi5gGo+MUpsXfWZqYuRg4NNQE9ix6pCkBoRgRWMEpNPeIPUMAu8
        ZpI4cvQd2AJhgXCJ9qPvwAaxCKhKfNy8lhHE5hWwl9h+9AITxAJ5idUbDoAdwQkU/zntAhvE
        QXYSi4/+ZJrAyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYORsO/Zz8w7GSxuDDzEK
        cDAq8fA6pGjHCrEmlhVX5h5ilOBgVhLhtf0KFOJNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8
        YFTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgjPJU+qidECwq
        cqDpXYm0SeP1zUmB3/0V8yQdzJ5yX9zL6Oq2ZzHHdxbHWZXdTb9r/1YcmLHH9eLuyVXbfkyS
        3iKwV/u98g/tdzniHz+d+qT9YfuMglcPT7IGHp5lU3qqI6J7qliUxtaZr9wStf8//Hrw/9Kt
        l7wWNS9nuD7bK6P11G0u25Ko6UosxRmJhlrMRcWJAI30x4uyAgAA
X-CMS-MailID: 20190715124511eucas1p2b11ef3a5bc093e686ae5450d16785225
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124511eucas1p2b11ef3a5bc093e686ae5450d16785225
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124511eucas1p2b11ef3a5bc093e686ae5450d16785225
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124511eucas1p2b11ef3a5bc093e686ae5450d16785225@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_disp1_fimd OPP table has been aligned to the new parent rate. This
patch sets the proper frequency before the devfreq governor starts working.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 27f6ed323ba1..2cfe1effe290 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -143,6 +143,8 @@
 
 &bus_disp1_fimd {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
+	assigned-clock-rates = <300000000>;
 	status = "okay";
 };
 
-- 
2.17.1

