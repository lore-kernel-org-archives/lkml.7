Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FDC76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E22067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hCljCIs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfGOMpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:45:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50021 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfGOMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124509euoutp0236f6658880d4b328c6cc352eada1bd84~xlU5Krmu-0726607266euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124509euoutp0236f6658880d4b328c6cc352eada1bd84~xlU5Krmu-0726607266euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194709;
        bh=n9AhB7aGZTT5hZs6nEyn2FJO5PAlgdwzqj/W1h2+0R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCljCIs64yRKsA9M1QMt+M7eMsDpo0s+iJ4/RohzgJxrzak7rN6M5nlQX+hVjK+UM
         Yojkz1A+FG1Gfr95s0GTuFnnvmiPw3tJjAzAIQeBEl3ZUN5vG5foZG3moNGgyXTB8n
         0yofzg6erA8v8QelJUUFxI1qevRjaeP4qjuNA6Tw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124508eucas1p2369cd4871b6c009b9fd10d5e069341e7~xlU4ZGEXs2439124391eucas1p2q;
        Mon, 15 Jul 2019 12:45:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.C0.04325.4557C2D5; Mon, 15
        Jul 2019 13:45:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124507eucas1p17793ab35cd6a64fc5626b751e7f095ee~xlU3ahDBG3056930569eucas1p1t;
        Mon, 15 Jul 2019 12:45:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124507eusmtrp12da439c79e879c1ff5e5106b63bd73d2~xlU3MRUWP0488104881eusmtrp1Z;
        Mon, 15 Jul 2019 12:45:07 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-0e-5d2c75548359
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 00.27.04140.2557C2D5; Mon, 15
        Jul 2019 13:45:06 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124506eusmtip264234280107d475e0a174fa130039d34~xlU2WQx7a0528005280eusmtip23;
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
Subject: [PATCH v1 40/50] ARM: dts: exynos: change parent and rate of
 bus_gen in Exynos5422
Date:   Mon, 15 Jul 2019 14:44:07 +0200
Message-Id: <20190715124417.4787-41-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxVYRzHe865557DXJ0u8UyW7S5LFEmzp3fW21Gz1bTWMtXFGZa37nFF
        JbIpmZAapoTFiCtvNyGsuEuRtyxcjSnCykvyslTons6t/vv8vr/v7+X57aFwaT1hQQUEh7GK
        YHmgTGwoqnq52L7lhHKz19bedhz1P24nUHlGKYF658YIlK3RhcnDX3DU0VFGorbYCRL1x1ii
        iuEeAs0kDhKou/a+GGV0NGCoRDNAovzeLgx1tRxE768VilFcvYZETRM3CLTcUy5yMWFUD1SA
        me6LI5mKoptipjIvmnkxVYcxSeoiwMxWrD9Gnjbc7csGBoSzCoe95wz9W1ZyiNBnZERX8gIW
        A4rFCcCAgvR2qO0bAAnAkJLShQDOJ62QQjAHYErrgj6YBXBhXosnAOpPyfjSYUEvALDlaQP+
        r+K1Sk3yJjFtD6uLLvAjTOk8ADWL3rwHp7UYrBupIfiECe0FEwtVJM8i2hp+HK/BeJbQ+2Bm
        aSYQ9rOCxWXPcZ4NdPpiWqeYbwTptyScqRwVCaYDsGNoHBfYBH5uVpMCW8LWO4l6DwdjbuXq
        m16Bw8lZes8u2NTcRfBL4/QmWFrrIMiuMFdVQAgPNoZ9k2t4GddhalW6/g4SGH9dKrhtoDqx
        ExPYDBao0vTNGbg42K+/biqA43Gx4hRglfl/WA4ARcCcVXJBfiznFMxetOfkQZwy2M/eJySo
        Aug+Vety83w1aPjl3QhoCsiMJC6+dl5SQh7ORQY1AkjhMlPJnnmdJPGVR15iFSFnFcpAlmsE
        6yiRzFxyedWQp5T2k4ex51k2lFX8zWKUgUUMcP1R8jDpUbh7YCl51UOa7pYfnSZrX/1V+X3n
        IZIpW47q8Y22O7PD4tOROjMjELF0e5u7tfOb/f11oz4bp+eaHKa+oeMWG+5Nr+2cHY1vjaIz
        3Zw8lzG23PGutuyJ7cjkT2ebd21w7JQoRGqlfeVv2e1Ra2wffTQ/S16TfXLog4lSJuL85Y62
        uIKT/wZ6lp+mUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7pBpTqxBi2XrCxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7Gqf8LWAt2s1dc7P/G1MC4mq2LkYNDQsBE4sVf9y5GTg4hgaWMErOO
        64LYEgJiEpP2bWeHsIUl/lzrAirnAqr5xCixa+cSRpBeNgE9iR2rCkFqRARWMEpMPuENUsMs
        8JpJ4sjRd6wgCWGBaInP1/6B2SwCqhKPXuxkArF5BewlZq2fxQixQF5i9YYDzCA2J1D857QL
        bBAH2UksPvqTaQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBcbPt2M8tOxi73gUf
        YhTgYFTi4XVI0Y4VYk0sK67MPcQowcGsJMJr+xUoxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKi
        yfnAmM4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCoer8q/Vy+
        59RMXn69vHf6Ud4Llx+bbvCovTL8aL3PxtgrfTPSQ4/IN+yOybEzu3fv17MtXT7zXA+s1pkS
        /eCrUj5Px+Za3QLmZzo84dMsTu6r3Hfw/RqB39Ytvx9W/bxwwMJDVUNe9fqH15NfZh4LCuDj
        ODqlv0bE+2fG/RzJhx+XKdfO6tVUYinOSDTUYi4qTgQAwEnjorECAAA=
X-CMS-MailID: 20190715124507eucas1p17793ab35cd6a64fc5626b751e7f095ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124507eucas1p17793ab35cd6a64fc5626b751e7f095ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124507eucas1p17793ab35cd6a64fc5626b751e7f095ee
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124507eucas1p17793ab35cd6a64fc5626b751e7f095ee@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_gen OPP table has been aligned to the new parent rate. This patch
sets the proper parent and picks the init frequency before the devfreq
governor starts working. It sets also parent rate (MPLL to 600MHz).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 6225d044d01c..75664ff6d966 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -102,6 +102,10 @@
 
 &bus_gen {
 	devfreq = <&bus_wcore>;
+	assigned-clocks = <&clock CLK_MOUT_ACLK266>,
+			  <&clock CLK_DOUT_ACLK266>, <&clock CLK_FOUT_MPLL>;
+	assigned-clock-parents = <&clock CLK_MOUT_SCLK_MPLL>;
+	assigned-clock-rates = <0>, <300000000>,<600000000>;
 	status = "okay";
 };
 
-- 
2.17.1

