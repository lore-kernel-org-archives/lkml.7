Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47BC205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AkLnTHTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfF1OdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:33:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40686 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfF1OdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:33:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5SEWOEs119507;
        Fri, 28 Jun 2019 09:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561732344;
        bh=gbEQ2MAf5BreXjP6+h+dDk7mJOuxFlU+NRxCOXS9m7w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AkLnTHTtRg4KS+kVRvkLRmV+VhAQcDI3zp86HBbQpW8UjJ590rtHGC7jKKzjTaal7
         DRF9ndtHsDrV5uUNvWTUBE62BsKGq2H8oRPgO718IlsMcxkFKF/ZVU1CPkLIJEb5Mu
         Su9sVgyCRYrHgWUHWiKtx28wJIgDlBx9wojdY310=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5SEWOKn109975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 09:32:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 28
 Jun 2019 09:32:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 28 Jun 2019 09:32:23 -0500
Received: from [10.250.132.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5SEWK5h014844;
        Fri, 28 Jun 2019 09:32:21 -0500
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC:     <sr@denx.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b4a2970f-40ff-3c6c-d408-4c19d5d502ad@ti.com>
Date:   Fri, 28 Jun 2019 20:02:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-May-19 5:36 AM, Chris Packham wrote:
> Because PPB unlocking unlocks the whole chip cfi_ppb_unlock() needs to
> remember the locked status for each sector so it can re-lock the
> unaddressed sectors. Dynamically calculate the maximum number of sectors
> rather than using a hardcoded value that is too small for larger chips.
> 
> Tested with Spansion S29GL01GS11TFI flash device.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
branch mtd/next.

Regards
Vignesh

>  drivers/mtd/chips/cfi_cmdset_0002.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index c8fa5906bdf9..a1a7d334aa82 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -2533,8 +2533,6 @@ struct ppb_lock {
>  	int locked;
>  };
>  
> -#define MAX_SECTORS			512
> -
>  #define DO_XXLOCK_ONEBLOCK_LOCK		((void *)1)
>  #define DO_XXLOCK_ONEBLOCK_UNLOCK	((void *)2)
>  #define DO_XXLOCK_ONEBLOCK_GETLOCK	((void *)3)
> @@ -2633,6 +2631,7 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>  	int i;
>  	int sectors;
>  	int ret;
> +	int max_sectors;
>  
>  	/*
>  	 * PPB unlocking always unlocks all sectors of the flash chip.
> @@ -2640,7 +2639,11 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>  	 * first check the locking status of all sectors and save
>  	 * it for future use.
>  	 */
> -	sect = kcalloc(MAX_SECTORS, sizeof(struct ppb_lock), GFP_KERNEL);
> +	max_sectors = 0;
> +	for (i = 0; i < mtd->numeraseregions; i++)
> +		max_sectors += regions[i].numblocks;
> +
> +	sect = kcalloc(max_sectors, sizeof(struct ppb_lock), GFP_KERNEL);
>  	if (!sect)
>  		return -ENOMEM;
>  
> @@ -2689,9 +2692,9 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd_info *mtd, loff_t ofs,
>  		}
>  
>  		sectors++;
> -		if (sectors >= MAX_SECTORS) {
> +		if (sectors >= max_sectors) {
>  			printk(KERN_ERR "Only %d sectors for PPB locking supported!\n",
> -			       MAX_SECTORS);
> +			       max_sectors);
>  			kfree(sect);
>  			return -EINVAL;
>  		}
> 
