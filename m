Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016DF22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OJBz3zUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfHUPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:39:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57814 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHUPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:39:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821153937euoutp027b885684c861967cec2c7dcf99f70f4d~8_ky4g60u0737007370euoutp02A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821153937euoutp027b885684c861967cec2c7dcf99f70f4d~8_ky4g60u0737007370euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566401977;
        bh=vl9eeLzvbk1o5YyBvdLkkw/r624gziAnAOA5EeDC/C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJBz3zUn3JTFvtdIi98ThEJuc2009ab28/ZnAeMjOZi9IdpI31cr6PyduT5VNW8N8
         f00FYwFCIlfC19albLJhtZFJDgjX0T6ub1iT409k1gVOScX5zXc20o7AqnyLv6QtWt
         0hWhIxQnrNHYSTE9H1/qhFsGyYrptc3hb3tMa+iQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821153937eucas1p16714ac390b5c31100b9dff2a51b476cf~8_kyKcICu1998619986eucas1p1p;
        Wed, 21 Aug 2019 15:39:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.50.04469.8B56D5D5; Wed, 21
        Aug 2019 16:39:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821153936eucas1p22cd1a6105806cb5ad7b43252852fec05~8_kxSIdoF2217422174eucas1p2e;
        Wed, 21 Aug 2019 15:39:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821153935eusmtrp23caa3591e86f9cb41173542d1d732cee~8_kxEBkA31715517155eusmtrp2H;
        Wed, 21 Aug 2019 15:39:35 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-a2-5d5d65b87058
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.2B.04166.7B56D5D5; Wed, 21
        Aug 2019 16:39:35 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821153935eusmtip222d51bebca59adb50083fb20061c5e17~8_kwh5lPE0822808228eusmtip2Q;
        Wed, 21 Aug 2019 15:39:35 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2] soc: samsung: Select missing dependency for
 EXYNOS_CHIPID
Date:   Wed, 21 Aug 2019 17:39:26 +0200
Message-Id: <20190821153926.12297-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821150711.31398-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOd0dqbGxBksm6FtsnLGe1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xaKtX9gtDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKeLC0n62gmbXi1sVulgbGaSxdjJwcEgImEjMfHmHqYuTi
        EBJYwShx8OVdRgjnC6PEm13PmCGcz4wS06bsgWtpn3ufHSKxnFFiwamt7HAtK5deYAOpYhMw
        lOg92scIYosICEvcW7ocrIhZ4A+jRPO9vawgCWEBf4njB68xgdgsAqoSZ96cBGvgFbCW6D/Z
        wwyxTl5i9YYDYDangI3Euy1roM74zCbx/4IChO0isfDaaah6YYlXx7ewQ9gyEv93zgf7TkKg
        mVGiZ/dtdghnAqPE/eMLGCGqrCUOH78IdBEH0HmaEut36UOEHSXO7v8NFpYQ4JO48VYQJMwM
        ZE7aNp0ZIswr0dEmBFGtIvF71XQmCFtKovvJfxaIEg+Jw794IOHTzyjxdvpspgmM8rMQdi1g
        ZFzFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmC5O/zv+aQfj10tJhxgFOBiVeHgn6MbG
        CrEmlhVX5h5ilOBgVhLhrZgTFSvEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2
        ampBahFMlomDU6qBcavysy3Rtxviezr/2bvycFcLZJ16sEfnn1xHrI7Ej4IpbjdnrRNdHun0
        YVGayoW83x53VSI9ZUOzr9zlVekMWVwqn8Q7R0e+51iIu0aVa/cSSbWDP+7JzrquvPp7VbDb
        b8WrC41m1sTd1vHfMOXnBGu5hsNiLm99z0q5fixyb4oIVPmxzGenEktxRqKhFnNRcSIAn4Cg
        zRMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7rbU2NjDR6/MLLYOGM9q0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i0Vbv7BbHH7TzurA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CX8WBpP1tBM2vFrYvdLA2M01i6GDk5JARMJNrn3mfvYuTiEBJYyihxY8sVIIcDKCElMb9F
        CaJGWOLPtS42iJpPjBIbp69gBEmwCRhK9B7tA7NFgIruLV0ONohZoIVJYuWvJWwgCWEBX4lz
        p94xg9gsAqoSZ96cBGvgFbCW6D/ZwwyxQV5i9YYDYDangI3Euy1rwK4TAqq5/uoh2wRGvgWM
        DKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECg3fbsZ+bdzBe2hh8iFGAg1GJh3eCbmysEGti
        WXFl7iFGCQ5mJRHeijlRsUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4ysvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjM139qxlvCBh9/FozOzCjZVTViyP
        DL3fXhj+dFZPRrWbg83SJmdd+e6nj2zE7eteML3u42dRNbpx5Wd6zz9ZLcHAvYLvVVKP3NQ0
        en3r0JTwp+f3PWd/YzvllUPi4etnlgQvC+T8ktW+/oqaQ2HA1FM3pxhMPSjg8LZhrmJNeNy0
        FQw+qtdNxZRYijMSDbWYi4oTAf7DBVx0AgAA
X-CMS-MailID: 20190821153936eucas1p22cd1a6105806cb5ad7b43252852fec05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821153936eucas1p22cd1a6105806cb5ad7b43252852fec05
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821153936eucas1p22cd1a6105806cb5ad7b43252852fec05
References: <20190821150711.31398-1-s.nawrocki@samsung.com>
        <CGME20190821153936eucas1p22cd1a6105806cb5ad7b43252852fec05@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chipid driver uses the MFD syscon API but it was not covered
properly in Kconfig.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2905f5262197..33ad0de2de3c 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -10,6 +10,7 @@ if SOC_SAMSUNG
 config EXYNOS_CHIPID
 	bool "Exynos Chipid controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	select MFD_SYSCON
 	select SOC_BUS
 
 config EXYNOS_PMU
-- 
2.17.1

