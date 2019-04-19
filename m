Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F8C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6970D20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="USvdYqwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfDSTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:07:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38803 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfDSTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141955euoutp01228dfbae1cd6181bea233bc7e6299559~W5fzPFc6c2276722767euoutp01P
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419141955euoutp01228dfbae1cd6181bea233bc7e6299559~W5fzPFc6c2276722767euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683595;
        bh=c4kx8rzUZuvENR4GPmajcyTbcTs192pPPPvnLrk0+/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USvdYqwRk/ay7YugDEE84P6C3cPpsp0gk2qZtLKLaJ0dZjIFJNzmrJUypC/EhpdTn
         lrTu6dPizJ/VkuSR4dAyGH2c7vpVGXOmY1RxWA1bDiU7UdZsb4estYF2PCvf+C2Tt1
         1eV9AM8TyviK3C+n1xrlyc87iCJTrnDcg+mEvebY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419141954eucas1p1a454637b8efc38350f1e210eafe9319b~W5fyZDbzM0117601176eucas1p1e;
        Fri, 19 Apr 2019 14:19:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.72.04298.A09D9BC5; Fri, 19
        Apr 2019 15:19:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419141953eucas1p1b403be15353fa31de3e226599b675f67~W5fxo9PK_2918129181eucas1p1f;
        Fri, 19 Apr 2019 14:19:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141953eusmtrp11e0e0cdd551996e6aa8258d8f3b685fb~W5fxa1w2G1759317593eusmtrp1k;
        Fri, 19 Apr 2019 14:19:53 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-31-5cb9d90a748c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.12.04146.909D9BC5; Fri, 19
        Apr 2019 15:19:53 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141952eusmtip265c67a3930848a783e7feb5fdee309e5~W5fwkwQDv3242832428eusmtip2X;
        Fri, 19 Apr 2019 14:19:52 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 10/10] ARM: exynos_defconfig: enable DMC driver
Date:   Fri, 19 Apr 2019 16:19:28 +0200
Message-Id: <1555683568-20882-11-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/ex3Y0Wtyl5MLFYBBalCSsOFFFRcE2CwkpIQ2de1HJqu2kt
        K6aBz5mllK98IaVNzUfLplm+lqamZkq+0kqtIM3wrQnRrnfVf5/v9/f9/c7vHA6Fy5tIeyoo
        5BKrCVEFK0RSoqp5uWundKDae1fLMoYq0stI1Df3jUS55k4SFU+PAZTalo2hN4lqlDw2gaOu
        rnIx6oieFKNBnQPqqbkvQrNJZoDSu15iqNQ8LEZDUUUi1DQZS6K63qNoaGUdWng9Cg7YMAvz
        KQSTpesmmOrMYTFTaYgXMUk3p0RMw1QtxtwyGgDzpD2Sma10PC45I93nzwYHRbAal/2+0sA2
        vUfYF/KKcSmO0IFEMgFIKEgrYUriKwtLKTldBGDG03FMEHMA6kfSxYKYBXByOMEiqNWWOr0b
        3y2nCwFMLT3/r6E2P5ngMyLaGZoMF/mMLR0JP/TV4XwGpycx2PFrieALNvQhWLzYgfNM0Fth
        SXmamGcZ7Q4NpmlcWM8RDnTGr7LE4tc8Mor4QZAeEcMi84A1dBh+HRkVCWwDv7cYxQI7wPZU
        PSEwB3VJ+UDga3AsOdua2QubWrpJfmmc3gbLalwE+yBcaC2w3ncd7P+xnrdxC6ZUpeGCLYNx
        MXIh7QSN+reYwBtgYck963AGxrcZrU+YA+DMSjN2G2zK/H9YHgAGYMeGc+oAlnMNYS87cyo1
        Fx4S4HwuVF0JLF+r/XfLjAnMv/NrBDQFFGtl9SnV3nJSFcFp1Y0AUrjCVnbQ3+gtl/mrtFdZ
        TaiPJjyY5RrBRopQ2Mki13zyktMBqkvsBZYNYzV/qxglsdeBPTkySYPni8F4z1kPZc6xPYv9
        rbedzmbaxuCPNz/XeT/IOqVse+sjzSvM6svz8Tc/S1BEmB7ujd7hq7Xvre/8GPtl+vqtAm1s
        6s/3iye3+uVW9BOjJ05luPklgewF9wavO8qez2T15rwjHm7zN07PxOVMDEWdMPQoHMe1W7rL
        Tu++qyC4QJXrdlzDqf4ApRZqBVYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qcN3fGGOxbxmuxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqme4IKnrBVbfnSwNDB2s3YxcnBICJhI7O/x7GLk
        5BASWMoo8XAhG4gtISAmMWnfdnYIW1jiz7UuoDgXUM0nRolHW7eC9bIJ6EnsWFUIUiMiUC/R
        /+YSWA2zQAOzxJrtV1lBEsICThKrv59lBrFZBFQl1myYDjaUV8BbYtWOj8wQC+Qkbp7rBLM5
        geK7Vm5hgzjIS2LDtb1MExj5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMom3Hfm7e
        wXhpY/AhRgEORiUe3gOTdsYIsSaWFVfmHmKU4GBWEuF1TNkSI8SbklhZlVqUH19UmpNafIjR
        FOioicxSosn5wAjPK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXA
        WLhevurO8cVevs/SdHbs/vXjZej3KW+uiLTpL96yVqbV8W/8rO4sc55LcrVXr/gsmP5wz7MF
        L9n/XpgQab7p6t+5VsmyDDZSJad3/+QrWXWIX7Bo5rsjqzb69nV/+7B+6qGNPzq//YvomnDp
        ut205pIzGfp+OrqaidsaKzt6uy4ztR7q74hcMU2JpTgj0VCLuag4EQCMSGGruAIAAA==
X-CMS-MailID: 20190419141953eucas1p1b403be15353fa31de3e226599b675f67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141953eucas1p1b403be15353fa31de3e226599b675f67
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141953eucas1p1b403be15353fa31de3e226599b675f67
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141953eucas1p1b403be15353fa31de3e226599b675f67@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..04c076e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4

