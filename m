Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C55C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DB9206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gC4jb/bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfDDRW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30963 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfDDRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:56 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190404172253epoutp031febee5b5375070aea981f4fe862cb8d~SVURobTHB3170231702epoutp03e;
        Thu,  4 Apr 2019 17:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190404172253epoutp031febee5b5375070aea981f4fe862cb8d~SVURobTHB3170231702epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398573;
        bh=mFu9pHyAERC20vEXDnsfmvOBo7ZAvPQhMkRL8LugJe8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=gC4jb/bn+ZuY0OM0KehFN6vm3is+Ktee1AHplpFn9VHnswDezXyKRegRAYTBkXbxi
         aTCCHhAVZ5FQpRv5A+V9DTEYgANdEC1T3RZtIb79O13Xhh0nnoARcmG4Jn4O9rilyR
         yAKfaV7UhpzXl2BeINOuCTviBGS/59gnkXtPn5Hw=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172253epcas2p253a36cb320bbe5fb5447c0f2df87b4fa~SVURRIJgp3184831848epcas2p2L;
        Thu,  4 Apr 2019 17:22:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.15.04195.D6D36AC5; Fri,  5 Apr 2019 02:22:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172252epcas2p284b7e2e9e7102f6f95c982d547ed9d64~SVUQZkOwK1739317393epcas2p2u;
        Thu,  4 Apr 2019 17:22:52 +0000 (GMT)
X-AuditID: b6c32a45-d5fff70000001063-9a-5ca63d6d15db
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.68.03620.C6D36AC5; Fri,  5 Apr 2019 02:22:52 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:52 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RFC 7/8] ARM: EXYNOS: Enable exynos-asv driver for
 ARCH_EXYNOS
Date:   Thu, 04 Apr 2019 19:17:34 +0200
Message-id: <20190404171735.12815-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfUhTYRTGe7f7tdHs5Wr2skHBsCgxTYl4Qw2RhAUWgiRhoxx5/crNsaui
        ZjgRm47UxAX7I5fkpjLNdKWYWoZbCAUTCTUmamRppSGotLSE2q7+9xzO7zzPORxGzI4RciZf
        V8wZdJpCJSUlBt2n8GltYof6zJeNQ7jf+ozEs1srJH7s8ZK4aWlVjCcn+2jsWpoh8YfhRxS2
        Tr4W4aeeeRo7ZqdEeK66i8JPBrZoXPvKQ2P3molMClH12HqAyuWsp1TP7VWqxhdOoNp0HU0j
        M6UJ2VxhfilniLmQJc1rH/XRei9RZmmdIYxgXWwGEgbBs+jv3E+RGUgZFg4BVL+zC4TCD1Db
        ioXap7Z/fAtOsHAEIOf3GAHaBsj7axYEGhSMRQ1vG4M6DIaiBUcnHYDE0C9C71a/kmbAMKEw
        DS0uxAQYAh5H5o1eUUDLYDzqXTCLhLBjqLvvTTBMAhPQkn2NCvggOEqh5RoLEKCLyGpyEoJW
        oGVnPxCgGoDuj8zRQvEAoMWJtr2JeOSemCIDWgxDUJ17lw5shKAM1d1jBUSFjL6BvfubAOoa
        qaf/W7SBA04Qzul5bS7Hx+ljo3mNli/R5UbfKtK6QPCtkSlDwOpNHQeQAcqDMiPRoWZJTSlf
        rh0HiBErw2TpfoealWVryis4Q9FNQ0khx48DBUMoj8g+K1qvszBXU8zd5jg9Z9jvihiJ3AhS
        yiylKcnllfMtNtOd89aMrRtJ8sOSvp7fVWqf7lO1vnu3gS3oMnaEXU58aC6TX123XPHkpTNx
        7b4xe1ZJCx0+uolaXJEFjKM1yneXr4mI2Kms2DmpfnntXO103cf45oRm4s+0PcqvGrZdylDk
        dCYP2kzSyuxUmzdk80TOeyXB52liI8UGXvMPuwLWydICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t9jAd0c22UxBnu6hC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik8XtxhVsFou2fmG3
        aN17hN3i8Jt2Vgc+jzXz1jB6bFrVyeaxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGUs
        3nOLveAcS8WUuddYGhjfM3cxcnJICJhI/Hz1Asjm4hAS2MkosXHvPlYI5yejxP+jK1lAqtgE
        DCV6j/YxgtgiAsIS95YuZwexmQW+M0nMnpfXxcjBISzgJzFrEi9ImEVAVaLr0zomEJtXwFpi
        3b0uJohl8hKrNxwAW8wpYCPxeMkbNpBWIaCa71sSJjDyLGBkWMUomVpQnJueW2xUYJSXWq5X
        nJhbXJqXrpecn7uJERiG2w5r9e9gfLwk/hCjAAejEg+vBtOyGCHWxLLiytxDjBIczEoivMHf
        l8YI8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYDR8PpnB
        2uDcnf917nLMR2M11weE5+iq8JWwzLvBcPRYmNpW867A0sYzf3fOPZAt94j71MGH9XmO0kXz
        Nxw4bFizln3LfYZF37Q/R34V/WLU79uVEx73aFf09mPC8/gedZbtDzi4WM9gEffccpmAPU+Z
        Y843aZWVZD7TSbp/LT1+2e00K4ay10osxRmJhlrMRcWJAPDwQU0/AgAA
X-CMS-MailID: 20190404172252epcas2p284b7e2e9e7102f6f95c982d547ed9d64
CMS-TYPE: 102P
X-CMS-RootMailID: 20190404172252epcas2p284b7e2e9e7102f6f95c982d547ed9d64
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172252epcas2p284b7e2e9e7102f6f95c982d547ed9d64@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable exynos-asv driver for Exynos 32-bit SoCs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e3e63aa5d60a..fe306a85228c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_ASV
 	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
-- 
2.17.1

