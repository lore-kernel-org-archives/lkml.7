Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DAC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53AC2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="anbVR87U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfGOMqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49870 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbfGOMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124501euoutp022e0585140a03e9711cc5aa89294580b4~xlUxwvd5n0731207312euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:45:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124501euoutp022e0585140a03e9711cc5aa89294580b4~xlUxwvd5n0731207312euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194701;
        bh=v5/Vyl30iwbBm0PUVMVAlvF6RXT28v4DXfcx78H2Kr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anbVR87UcoqS2nMkrrjm3mB+HgSzBu8iaGZEeb+J3qpVNmHmn1oqAmZwVwPSHgvj2
         ZXjQNVGjbEK7TuMaZmn0joWKDGRrJtMeo7wEiyrPLT88UlrZFJLCPDolvdEByZgh9O
         X/TgAmR0uw0DKEwD/J9iorJZypt82581Rib7mois=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124500eucas1p2052a36585d1e0b9da796ad5f58b9d083~xlUxAyOaE1849318493eucas1p2F;
        Mon, 15 Jul 2019 12:45:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.35.04298.C457C2D5; Mon, 15
        Jul 2019 13:45:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124459eucas1p2a1d8795e57a82704ff221567a8810485~xlUwNhcFj2439124391eucas1p2g;
        Mon, 15 Jul 2019 12:44:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124459eusmtrp134ba2a8ab3e870b6e2bb6b40db1d048c~xlUv-Z_EB0488104881eusmtrp1u;
        Mon, 15 Jul 2019 12:44:59 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-d9-5d2c754cd082
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.17.04140.B457C2D5; Mon, 15
        Jul 2019 13:44:59 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124458eusmtip2d770f1aa2bf9b413aa2efcf87f6b1ae2~xlUvMWjpX0573605736eusmtip2N;
        Mon, 15 Jul 2019 12:44:58 +0000 (GMT)
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
Subject: [PATCH v1 31/50] ARM: dts: exynos: align lowest OPP in bus_jpeg in
 Exynos5420
Date:   Mon, 15 Jul 2019 14:43:58 +0200
Message-Id: <20190715124417.4787-32-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTud+/u7tWc3abpD4uMQWBpUyvoV5kVVFxEKKjohdRsFxXntF1n
        aZHrtWouy2dRWrmKyTIfa4iKmfmEpOYc+FhPWpiYKaYSI6h2vav++853vu87h8OhcGkrEUal
        qbNZjVqhkon9RY09HvuaRG1UUkzlDIVcta8J1HCrjkBDs18IdK/LW153f8WR3V5PolfnJ0jk
        0i1DVvcggaaN7wnkbKkQo1v2Ngw96XpHokdDDgw5Xu5Eb85Vi9GlZ10k6py4TKBfgw2ibUFM
        zd0awEwNXyIZq+WqmHn6MJ95MdmKMYU2C2BmrMv3kIf945SsKi2H1UTHH/NPddfOgaw24lRZ
        W7dYBxpFBkBRkF4Pf45EGIAfJaWrAfxZdcgA/L14FkBb9SQhFDMAjo0aAa/iDY/qC30NM4DP
        XAbsn6XYNUHysWJaDpssJ3hDMP0QwC5PMq/B6REMtn5uJvhGEH0QeqyX57GIXgnflz6enyCh
        t0K9tZ0QpoXDx/XtOI/9vLynvF/MB0F6gITP24dIQbQDDnnKfOsFwfFem49fBvtKjCIBc1B3
        rcqnOQPd1yt9ms2ws9dB8Evj9CpY1xIt0Nuhy9YnFk4UCIe/LeZp3AuLG2/iAi2BV/RSQR0B
        bcZ+TMAh0FxT7gtn4PhHIy6cpxhAc90n4gYIv/1/2H0ALCCU1XIZKSwXq2ZPyjlFBqdVp8iP
        Z2ZYgfen+n71fm8CcwPJHYCmgCxAsk0ZmSQlFDlcbkYHgBQuC5ZsmfNSEqUiN4/VZB7VaFUs
        1wGWUiJZqOT0go9HpHSKIptNZ9ksVvO3i1F+YTpgMXTkxGk1K9yxm9CGqYknURtN0E9eUBTd
        d/j59xvx9Ji+qKypNK+wJ8HpNMmPjt45wFzYZYs0JWAPAhf+Np0NeJrG7W8s7S7nSqqcsnxJ
        c7zq7YeDuY6KytrhvTeXwOwCs2ntu94oxyKnMmQgMqYmXa+42L97X+K66ZSFPz6YZSIuVRG7
        Gtdwij9lJYjKTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7repTqxBj0nBSxurTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7G43VfGQv2sVZM3XeUrYFxG0sXIyeHhICJxNINfaxdjFwcQgJLGSXO
        r5vLBpEQk5i0bzs7hC0s8edaFxtE0SdGiQ+z7gMlODjYBPQkdqwqBKkREVjBKDH5hDdIDbPA
        ayaJI0ffsYLUCAuESVz4bAZSwyKgKnFvympGEJtXwF6ibdMBVoj58hKrNxxgBrE5geI/p10A
        u0FIwE5i8dGfTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJxtx35u2cHY9S74
        EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269AId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYS
        Tc4HRnVeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG3ds5ay4f
        iM0/ZCZ1WurV4grGHcY3wsodJzR5fT3bVlLasUhI5G77qrV17146zdi2VLHr7J6QFoVk5/NZ
        nEnLLkY2Of57/ltmhef2ibGvb6xwUv3qprs98vXU82fj5CRrhc/vOOAZtkxZUCRqSunqZY2u
        5kdK93eetw+9oqzazVD699/uu9OWKbEUZyQaajEXFScCADVPWvyyAgAA
X-CMS-MailID: 20190715124459eucas1p2a1d8795e57a82704ff221567a8810485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124459eucas1p2a1d8795e57a82704ff221567a8810485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124459eucas1p2a1d8795e57a82704ff221567a8810485
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124459eucas1p2a1d8795e57a82704ff221567a8810485@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the lowest OPP frequency possible to set using a clock divider keeping
in mind the master clock rate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f2e2e77a86d6..0be799f843dc 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1250,7 +1250,7 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <75000000>;
+				opp-hz = /bits/ 64 <100000000>;
 			};
 			opp01 {
 				opp-hz = /bits/ 64 <150000000>;
-- 
2.17.1

