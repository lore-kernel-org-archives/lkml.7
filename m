Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609DAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3EC216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l/HzSh/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfHUPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:07:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48800 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfHUPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:07:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821150720euoutp0298d327669538c9f940593e796b2d9275~8_ImqHc8q2370223702euoutp02Q
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:07:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821150720euoutp0298d327669538c9f940593e796b2d9275~8_ImqHc8q2370223702euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566400040;
        bh=QdKl1h+NYGT1+GJ6+CO55MR1LWqPpwQB2KPUyY1C/kU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=l/HzSh/yn9oWVTBMVtRk+j++sCanPowxZIV5hbXiP1hKYK5YAeFFzqH1CeBDmQx1b
         i/tiz9ve+STqsauAO43+CYpyAUHl8KOVGPDjojELPTOJGW5mDVHEOcCFk9PLjfOTiy
         vQjUPk1FmyH4QcYOBJkU8aGht3a+8rCsprUf6ChE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821150720eucas1p1858eff5877d763685a54389a05c73c5a~8_ImOA1rd1286912869eucas1p1w;
        Wed, 21 Aug 2019 15:07:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.01.04309.72E5D5D5; Wed, 21
        Aug 2019 16:07:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821150719eucas1p26bddabb16499647860805e61a8b63010~8_IlWAMVn1312913129eucas1p29;
        Wed, 21 Aug 2019 15:07:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821150718eusmtrp2cf8a039e03506e5212b91a78d73bade1~8_IlH3ddu0045700457eusmtrp2k;
        Wed, 21 Aug 2019 15:07:18 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-fd-5d5d5e27aad5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.68.04166.62E5D5D5; Wed, 21
        Aug 2019 16:07:18 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821150718eusmtip16e52f4973fa0a6ee569f8507ec348494~8_IkpACWr3066430664eusmtip1H;
        Wed, 21 Aug 2019 15:07:18 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     jonathanh@nvidia.com, kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] soc: samsung: Add missing Kconfig dependencies for
 EXYNOS_CHIPID
Date:   Wed, 21 Aug 2019 17:07:11 +0200
Message-Id: <20190821150711.31398-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87rqcbGxBrNO6FlsnLGe1aJl1iIW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWi7Z+Ybc4/Kad1YHLY9OqTjaPzUvq
        PXqb37F59G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8avPzeYCy6xVszvecTawHidpYuRg0NC
        wESif31MFyMXh5DACkaJDw8Ps0I4Xxgl/i1axwbhfGaUaL/xlKmLkROsY8e17+wQieWMEjcv
        L2UDSYC1/GrzBrHZBAwleo/2MYLYIgLCEveWLmcHsZkFJjFJ7OhTB1ktLBAs8fq3JEiYRUBV
        orNjNztImFfAWmL1HF6IVfISqzccYIawX7NJfDiVDmG7SPR8f84GYQtLvDq+hR3ClpH4v3M+
        E8hpEgLNjBI9u2+zQzgTGCXuH1/ACFFlLXH4+EVWkGXMApoS63fpQ4QdJW6/vscICRU+iRtv
        BSEu5pOYtG06M0SYV6KjTQiiWkXi96rp0BCRkuh+8p8FwvaQmPavBWy4kECsxNT7dhMY5WYh
        rFrAyLiKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMD2c/nf8yw7GXX+SDjEKcDAq8fBO
        0I2NFWJNLCuuzD3EKMHBrCTCWzEnKlaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTE
        ktTs1NSC1CKYLBMHp1QD4+JKl9tbZgtw6oj3G0RuydfdVl3cFjNHtetVkbQv65GTxvniXXWx
        ahaRF7YItOrV9HBekjkQtbTpipV194+1lvofsn4yX1i3+Oh6w09bNaofdqS0TXEUnOn0ef2J
        5+wfRc8Zx3+4tfNp96OCOcmxnlFVKpfWTXpquCLuoVyqgbd///227tJHSizFGYmGWsxFxYkA
        UQNzXwsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t/xu7pqcbGxBrf+mVlsnLGe1aJl1iIW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWi7Z+Ybc4/Kad1YHLY9OqTjaPzUvq
        PXqb37F59G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+
        nU1Kak5mWWqRvl2CXsavPzeYCy6xVszvecTawHidpYuRk0NCwERix7Xv7F2MXBxCAksZJQ6t
        vcnWxcgBlJCSmN+iBFEjLPHnWhcbRM0nRonpn9YzgyTYBAwleo/2MYLYIkBF95YuBxvELDCH
        SeJhzySwhLBAoMTc029YQWwWAVWJzo7d7CALeAWsJVbP4YVYIC+xesMB5gmMPAsYGVYxiqSW
        Fuem5xYb6hUn5haX5qXrJefnbmIEhue2Yz8372C8tDH4EKMAB6MSD+8E3dhYIdbEsuLK3EOM
        EhzMSiK8FXOiYoV4UxIrq1KL8uOLSnNSiw8xmgLtnsgsJZqcD4ydvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjIvmZeSbHlghVvXAzSJG02K6qlrYOZnI2xtv
        xTC/5fiyrrvvgpbC0ddZfjm7hRhfi35hPnPkZ/13R7kfeR23f3yXLxL7n1HNKZY2vaXC9tik
        2/WXZPY8/+d36debsKlbnlgwfW0yXbgyd8fifx/ZZuvnXK8q5E1l0cw40SflseOcUGLqpw7L
        RUosxRmJhlrMRcWJANvvQXplAgAA
X-CMS-MailID: 20190821150719eucas1p26bddabb16499647860805e61a8b63010
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821150719eucas1p26bddabb16499647860805e61a8b63010
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821150719eucas1p26bddabb16499647860805e61a8b63010
References: <CGME20190821150719eucas1p26bddabb16499647860805e61a8b63010@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chipid driver uses the regmap and the MFD syscon API
but it was not covered properly in Kconfig.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2905f5262197..a03f83492716 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -9,7 +9,7 @@ if SOC_SAMSUNG
 
 config EXYNOS_CHIPID
 	bool "Exynos Chipid controller driver" if COMPILE_TEST
-	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on (ARCH_EXYNOS && REGMAP && MFD_SYSCON) || COMPILE_TEST
 	select SOC_BUS
 
 config EXYNOS_PMU
-- 
2.17.1

