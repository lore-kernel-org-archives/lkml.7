Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB57C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9B22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uGHf5HOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfLLHcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:32:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55600 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfLLHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:32:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBC7VQQh072778;
        Thu, 12 Dec 2019 01:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576135886;
        bh=haW2fs/1/sUuQpF8Y3YpZnBRlXcDpUlKfXo5LXqv/OI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uGHf5HOo/y3rmRn0ytwmvZZww9niyfwPMg5JlFrNKgDCtqbXwoO+5yFTiPgkODcA5
         pN8QO0cNKEH1QsRZ4qOwblX4SG3JOnJ/WCHD0aiXKvnD9az0FhQGI41pkKAItl6+3T
         nLnAytAxL+JlPnjLQJiacGA2TLZH91y58v1AyhzQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBC7VQBY006953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Dec 2019 01:31:26 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 01:31:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 01:31:25 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBC7VMHk027359;
        Thu, 12 Dec 2019 01:31:23 -0600
Subject: Re: [PATCH 3/3] mtd: spi-nor: Add USE_FSR flag for n25q* entries
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <Ashish.Kumar@nxp.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>
References: <20191205065935.5727-1-vigneshr@ti.com>
 <20191205065935.5727-4-vigneshr@ti.com>
 <2d931347-d927-4674-86ff-7eb285624bfc@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <fec29113-e048-bd47-595e-3d1f6e3955e0@ti.com>
Date:   Thu, 12 Dec 2019 13:01:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2d931347-d927-4674-86ff-7eb285624bfc@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 10/12/19 10:11 pm, Tudor.Ambarus@microchip.com wrote:
> Hi, Vignesh,
> 
> On 12/5/19 8:59 AM, Vignesh Raghavendra wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Add USE_FSR flag to all variants of n25q entries that support Flag Status
>> Register.
> 
> On a first look, all Micron flashes define the Flag Status Register. Do you know
> if there are any Micron flash that don't support FSR? If not, would you be
> interested in doing some documentation work to check this?
> 

n25q and mt25 series support FSR but older m25p/m45p parts don't have
FSR.  I don't know any easy way of finding out if flash part is m25p type.

> I think we can do this more generic, always set SNOR_F_USE_FSR for micron
> flashes, like below. More, if FSR is specific just for Micron, we can get rid of
> the USE_FSR flag too.
> 

AFAIK, FSR is definitely Micron specific (other flash vendors have
different registers/bits providing similar information though).


> Thanks, Vignesh.
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index f4afe123e9dc..fe10beea60c3 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4595,7 +4595,7 @@ static void sst_set_default_init(struct spi_nor *nor)
> 
>  static void st_micron_set_default_init(struct spi_nor *nor)
>  {
> -       nor->flags |= SNOR_F_HAS_LOCK;
> +       nor->flags |= SNOR_F_HAS_LOCK | SNOR_F_USE_FSR;
>         nor->params.quad_enable = NULL;
>         nor->params.set_4byte = st_micron_set_4byte;
>  }
> 

-- 
Regards
Vignesh
