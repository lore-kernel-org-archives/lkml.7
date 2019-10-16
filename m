Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A592DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B532054F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IupuLxn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390139AbfJPImC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:42:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58800 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbfJPIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G8fQnT054935;
        Wed, 16 Oct 2019 03:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571215286;
        bh=aSRpuLVp5PoC9Dq+98yBbK/K+q52Oq+i7oGbPusjzIs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IupuLxn5B/Ry75qSBUOS3YhHXhxCLYq3BDscxUdS3jqm0CZCiVGKerYAz8fpodgG8
         3y3O6VcA4ZrtQJ5yTDsOoYyaSA3wCSscjPy+QcMqaRSp7EV1xegxyWgLmvXGYMF/IZ
         kSa/0XSjoUbWrxXzW+jHaIzsbKzJVVHSAAz/vnqg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G8fQ1e101268;
        Wed, 16 Oct 2019 03:41:26 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 03:41:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 03:41:19 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G8fLCx117756;
        Wed, 16 Oct 2019 03:41:22 -0500
Subject: Re: [PATCH] Fix reading support of the 1-4-4-DTR read-mode from the
 wrong bit of the SFDP table which is part of the linux-imx fork located in
 the following repo:
 https://source.codeaurora.org/external/imx/linux-imx/?h=imx_4.14.98_2.1.0
To:     Christoph Fink <christoph.fink@omicron-lab.com>
CC:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Christoph Fink <fink.christoph@gmail.com>,
        Huang Shijie <shijie8@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Han Xu <han.xu@nxp.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1568184843-11300-1-git-send-email-christoph.fink@omicron-lab.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2c950e5b-bf77-b2a8-d7ee-6c669948b68f@ti.com>
Date:   Wed, 16 Oct 2019 14:11:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568184843-11300-1-git-send-email-christoph.fink@omicron-lab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/19 12:24 PM, Christoph Fink wrote:
> From: Christoph Fink <fink.christoph@gmail.com>
> 

This patch is not against mainline kernel. There is no support for DTR
mode in kernel yet. Below hunk is not even present in the spi-nor.c.

For future submissions:
Subject line should be one line summary of the patch starting with
prefix "mtd: spi-nor:" (hint: run git log on file to know the format)
and commit message should have detailed description of the patch

Regards
Vignesh


> Signed-off-by: Christoph Fink <fink.christoph@gmail.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8cc4b04..7fd52fa 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2089,7 +2089,7 @@ static const struct sfdp_bfpt_read sfdp_bfpt_reads[] = {
>  	/* Fast Read 1-4-4-DTR */
>  	{
>  		SNOR_HWCAPS_READ_1_4_4_DTR,
> -		BFPT_DWORD(1), BIT(21),	/* Supported bit */
> +		BFPT_DWORD(1), BIT(19),	/* Supported bit */
>  		BFPT_DWORD(3), 0,	/* Settings */
>  		SNOR_PROTO_1_4_4_DTR,
>  	},
> 

-- 
Regards
Vignesh
