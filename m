Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919120870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ufFd0bhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfHUPFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:05:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37931 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfHUPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:05:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190821150549euoutp0188c41e8b2e558ad29977ca83ccd3e04d~8_HSBjgGb1146911469euoutp01M
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:05:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190821150549euoutp0188c41e8b2e558ad29977ca83ccd3e04d~8_HSBjgGb1146911469euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566399949;
        bh=TapZ50bINgSULFfnU/4MVBjZqPhc/IXiiaEUktjqsEE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ufFd0bhwAz8ob5XrL1qeAXe4tayQuapLAfw19Pc4SO40R2/Z+y0fesKNGp8kmebB2
         24KgnEvBCG2VUi34IZwTAfXxET/Gp5dstEr5mmWhdNrwsuHKoZYFGbyMIGXCp43jtB
         4fZtezbm/9svdGTE9OGqxve7MyedFpsOqzjQ5U9c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821150549eucas1p1a472ee908256a42b5d07673d4f48f5dc~8_HRcbJOw1287612876eucas1p1c;
        Wed, 21 Aug 2019 15:05:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.0D.04469.CCD5D5D5; Wed, 21
        Aug 2019 16:05:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9~8_HQyGgsO2357223572eucas1p1w;
        Wed, 21 Aug 2019 15:05:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821150548eusmtrp29d9a9fd5759502b1257cb1e2dbb025d8~8_HQj_TcL3237532375eusmtrp2x;
        Wed, 21 Aug 2019 15:05:48 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-d5-5d5d5dcc9c23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.48.04166.CCD5D5D5; Wed, 21
        Aug 2019 16:05:48 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821150547eusmtip2964ecbfa743a4ea2c7438188a225e546~8_HQB7Cx52516525165eusmtip2a;
        Wed, 21 Aug 2019 15:05:47 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     jonathanh@nvidia.com, kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] soc: samsung: chipid: Remove the regmap lookup error log
Date:   Wed, 21 Aug 2019 17:05:39 +0200
Message-Id: <20190821150539.31207-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djP87pnYmNjDV41GlpsnLGe1aJl1iIW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWi7Z+Ybc4/Kad1YHLY9OqTjaPzUvq
        PXqb37F59G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8b6y4eZCuZwVZx/vJmtgfEuRxcjJ4eE
        gInE1K+z2LsYuTiEBFYwSkzZOoEZJCEk8IVRYvVzdwj7M6NE3w4fmIYr+xeyQ8SXM0osfVsB
        0QxU3/h5PytIgk3AUKL3aB8jiC0iICxxb+lysAZmgUlMEjv61LsYOTiEBTwl2icGgoRZBFQl
        bn87wgRi8wpYS/Q8m88KsUteYvWGA8wg8yUE3rNJTOqCWCwh4CLR/72BGcIWlnh1fAtUXEbi
        /875TBANzYwSPbtvs0M4Exgl7h9fwAhRZS1x+PhFVpArmAU0Jdbv0ocIO0rMuf+AESQsIcAn
        ceOtIMTNfBKTtk1nhgjzSnS0CUFUq0j8XjWdCcKWkuh+8p8FwvaQmDf9OxMkfGIlTj1YxD6B
        UW4Wwq4FjIyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPE6X/HP+1g/Hop6RCjAAej
        Eg/vBN3YWCHWxLLiytxDjBIczEoivBVzomKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgW
        EkhPLEnNTk0tSC2CyTJxcEo1MGYeLQtUK3ufblfMKH50uf4zrZnLSmOfKG4Ka+Zcd7amK6bW
        4Bjrgf+rtmZKT1dKa+RKsWoT1ajfn5JcuMLFk/9Yb3ez0oEF+8+widopqqxn8cjRivvdkxvY
        lFAYtqHY8Iz+Xoc7N/jrpR59Dfb8L3Rx02PeVq6JTB7nOi8bXGDv8Ap2XGKmxFKckWioxVxU
        nAgAt6K0Dw0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t/xe7pnYmNjDV4dYrHYOGM9q0XLrEUs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktFm39wm5x+E07qwOXx6ZVnWwem5fU
        e/Q2v2Pz6NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYz1lw8zFczhqjj/eDNbA+Ndji5GTg4JAROJK/sXsncxcnEICSxllOh7
        PYexi5EDKCElMb9FCaJGWOLPtS42iJpPjBK75+1nAUmwCRhK9B7tYwSxRYCK7i1dDjaIWWAO
        k8TDnklgg4QFPCXaJwaC1LAIqErc/naECcTmFbCW6Hk2nxVigbzE6g0HmCcw8ixgZFjFKJJa
        WpybnltsqFecmFtcmpeul5yfu4kRGJ7bjv3cvIPx0sbgQ4wCHIxKPLwTdGNjhVgTy4orcw8x
        SnAwK4nwVsyJihXiTUmsrEotyo8vKs1JLT7EaAq0fCKzlGhyPjB28kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MAa+rZUxevqi8rGg57aV39WqC59N7XZ/fuyK
        dFnl+fONh6RmmITOVAr94qI787+U8Mqf9+3Cd6bcYliyVXXRC85zdbylN94fW7x0dexjn8wv
        W05Xd8n4T18a41F+w/Tp8jz2dwWi675FhSxT98mYesqNYdUSt5aKs1YXjjtlhS6UOZ35I4/l
        1jQlluKMREMt5qLiRACGWA8AZQIAAA==
X-CMS-MailID: 20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9
References: <CGME20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 40d8aff614f7 ("soc: samsung: chipid: Convert exynos-chipid
driver to use the regmap API") of_find_compatible_node() call was
substituted with syscon_regmap_lookup_by_compatible() but also an error
log was added for case where lookup fails. On multiplatform the lookup
will always fail on any non-samsung device so the log is incorrect.
Remove the error log and just return an error code from
syscon_regmap_lookup_by_compatible() which internally calls
of_find_compatible_node().

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 75b6b880d9ef..c55a47cfe617 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -56,10 +56,8 @@ int __init exynos_chipid_early_init(void)
 	int ret;
 
 	regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
-	if (IS_ERR(regmap)) {
-		pr_err("Failed to get CHIPID regmap\n");
+	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-	}
 
 	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
 	if (ret < 0)
-- 
2.17.1

