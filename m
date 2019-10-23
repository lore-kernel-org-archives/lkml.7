Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED816CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA33F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IcB0MbM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbfJWF1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:27:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41394 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfJWF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:27:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N5RDlI014638;
        Wed, 23 Oct 2019 00:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571808433;
        bh=Ih4/uFm6sqHulM90MB4kP1Nl9YmjPSK1R8KiMD92JJw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IcB0MbM1BLLILAokmEkWZAYqkDRZRMYZYOjYMLK0ad12n37L4CFA/+Q+9a/w/u92V
         refXVGfAFAbGW6uWe8CGVfQc/hZciYXOU/FMkTc4LP+LphyyD3WdQUg07Fk3OV0/Tj
         2fuXjfRszWouDkN9eaNm/Z5eLO1vMlLItjNmtnqg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N5QhJD108133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 00:26:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 00:26:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 00:26:33 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N5Ped0023779;
        Wed, 23 Oct 2019 00:25:41 -0500
Subject: Re: [PATCH] phy-mvebu-a3700-utmi: Use
 devm_platform_ioremap_resource() in mvebu_a3700_utmi_phy_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <kernel-janitors@vger.kernel.org>,
        Igal Liberman <igall@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <5403540b-d3de-4a29-ec84-7ce5bb8d6d9f@web.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5e5cfafa-ade8-6f26-9989-d949c6d5c388@ti.com>
Date:   Wed, 23 Oct 2019 10:55:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5403540b-d3de-4a29-ec84-7ce5bb8d6d9f@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/09/19 9:50 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2019 18:15:23 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

merged, thanks!

-Kishon

> ---
>  drivers/phy/marvell/phy-mvebu-a3700-utmi.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
> index ded900b06f5a..23bc3bf5c4c0 100644
> --- a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
> +++ b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
> @@ -216,20 +216,13 @@ static int mvebu_a3700_utmi_phy_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mvebu_a3700_utmi *utmi;
>  	struct phy_provider *provider;
> -	struct resource *res;
> 
>  	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
>  	if (!utmi)
>  		return -ENOMEM;
> 
>  	/* Get UTMI memory region */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "Missing UTMI PHY memory resource\n");
> -		return -ENODEV;
> -	}
> -
> -	utmi->regs = devm_ioremap_resource(dev, res);
> +	utmi->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(utmi->regs))
>  		return PTR_ERR(utmi->regs);
> 
> --
> 2.23.0
> 
