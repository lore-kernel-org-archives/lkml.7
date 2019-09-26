Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CA4222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PTUqsJNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfIZQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:08:23 -0400
Received: from mout.web.de ([212.227.15.14]:44547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569514098;
        bh=YNKXwJ4v4t56S8Yf9jkX6NW8l6qjopora7e1Mr3YlIA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=PTUqsJNCQlSEE1dUnqVeTz5a12WOuNhj0+koppPEPxYIOupaLvt3eAkImmBFgilMn
         Ph6jlN20GzqRged1LQxNEFbOBO/ROBBJ3SNCMVk/RcQm43pJCGxUOukZthipwlbslu
         pl+1o3rxGH0Lu12R/D2Q+jTrkJmMiiVJ5dHiKGCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.81.241]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiUF2-1hatmI16tg-00ceg8; Thu, 26
 Sep 2019 18:08:18 +0200
To:     bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] phy-brcm-usb: Use devm_platform_ioremap_resource() in
 brcm_usb_phy_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88679e6a-6701-7d30-d52e-5e970af4de04@web.de>
Date:   Thu, 26 Sep 2019 18:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ByQ1b5OIGZCUFr8no3mtz1BppgbF//TMZe3c3Y7b0lI+sResh11
 7W/Peo9SopIQZcVYquBEZm8Ask1EKIkTPnBMAQSL+o3MoFeyOc8zpUw0QLRP4cPkRixcQMN
 4XuuKOiZyCUU5xyu7pL59dhpjC/KJ2wwu0wk1AqEoENsB5doPXg1L+v+kqfz0RtXfQN0Mqm
 O71xYfy/L2qcPX+pqpQFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqCZHgwFRtc=:e7js8cA05H2c9z+egKElqH
 FMlLJwrSiw6HJvGnWwK6aEI8GPgdCyP1+4fHXtOCkLDRzUiSKgoF6ClC7whR2kqew/T26wMKd
 RbCouvKbzrA2P0hkSw2H/jA6CF+WbTisqsGLKB1a5Y8ajvBkX89mXzPice//mE8OCCBCxhTL6
 ffapH+zlKln/KLvBz6CTMMny0sJAqSleq1XrzrPFTvQDONyGEdkJ/4iFuaqqlmDGj7LRp18l3
 vtLXL62TnFh4R/4HtWuBfzyBKhEq9nyzgJdu0B/XPE6pOcGBvLno+1+tlvjx8BMji7usXJJtB
 U2s+j+zxNFtTj1prvkXwfQvEQOQitwkTf1qXIZABwBcb6R5p/A8jMw29/f9O1wv979wjScxQF
 srcUVNlGm0xuZZMf3kc/CfG6Csputs+cAwszXSUKUIdpIjOfRJzDVU4GG1+l2N7nOBDL73MLC
 rgXEUG+yJfUNBuHxMzsnCOdSNTAfmeu9bYYBSINtk/XftjcoJi44njDznzmvVWdlx6j2EAz66
 XK+ntGZHU6D+mGlPEpusEwaQdjwhjcKewz9U45GTEsR4bM3E8XV+V1aI5MnewS6L5Jxfzmwu/
 /VSC7Xc/b7b0Qp9NOWTtlrzcctZuHGjPZMo6m77EdmirY+gtFixOj8+5V4F0N9ngGbSEa0mmf
 ZC5I1zhc2DATgOpD5jHgiB7P9FE8zZRo/qbyzh+oIUv7+xrGVpBFDhniVm0f3qXbYjbmz0aKV
 mAm/mq/MgLTU8xMWCmJeUpgcleFhBTi8zM83YE+MzS49ILmeKKhEEe7+1C++DhFOp8n+KOl5q
 9PGzym4RSSlLEJ2wOxS1ZI65atIrz2Nvaf5b5NTQedEWISvkgo2njO/DfL+WT65HKnev9CBz4
 F7d/7ZE+yO9ptcT85TLHAP2XZutic7EnnDlxDhtdO7nWbwaVxFqokglZT7gJAd1TiVTU5i705
 Gj2Nxr2KPfara86qsSdzza+xdOnFhRycRiUpCcvWTtIF8uvUt2fSdmV6urHKBT48J99HV6SmY
 nNfUr9mF0TELXRQEYG2+Tr3/MmqKCAMu4ftyhRwU08Ao0YRnXCODigcCSAoccJWUV0wVsco8Y
 nd97xrGeacq1L8ukol4Y61Cj/EazQ8ru2SojY6Hj/KYOAStMCDaPFzS29q3Uu4vcUH5fZUAHJ
 VXtVc2xYMxOAogTedX9nAOOc/hvgYEakwtTGpckHwoXlOhkuRCi3KUgeHvgVRAtzwgh1+5kp7
 gu/uq4/r8aYgkQWZiV6Gadryg6GS/qi6G8e0IP2eTKCWE41CdWtFgQI0Vla4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2019 18:00:14 +0200

Simplify this function implementation a bit by using
a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/phy/broadcom/phy-brcm-usb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/ph=
y-brcm-usb.c
index f5c1f2983a1d..2a0a8bd2b056 100644
=2D-- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -298,12 +298,7 @@ static int brcm_usb_phy_probe(struct platform_device =
*pdev)
 	brcm_usb_set_family_map(&priv->ini);
 	dev_dbg(dev, "Best mapping table is for %s\n",
 		priv->ini.family_name);
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "can't get USB_CTRL base address\n");
-		return -EINVAL;
-	}
-	priv->ini.ctrl_regs =3D devm_ioremap_resource(dev, res);
+	priv->ini.ctrl_regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->ini.ctrl_regs)) {
 		dev_err(dev, "can't map CTRL register space\n");
 		return -EINVAL;
=2D-
2.23.0

