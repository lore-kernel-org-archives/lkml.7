Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889CC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4872168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kK6Kk2II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFNDYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:24:03 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47627 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfFNDYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:24:02 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4F0E9886BF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 15:23:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1560482639;
        bh=AbZqhinaeDDXdEDPzuAuewpZ+Ugz4DonDu2l7bEltmo=;
        h=From:To:CC:Subject:Date:References;
        b=kK6Kk2IISGYuLBUAa5ZgFnskmSHT+XwHWmucjvXoPGeMKvahtzFTF9c+R3FxvPLIS
         fzq/PYJVIGdfkyJAZWJq32eiGNUJ4wWUewlPLQlYpOyoeijEsmlDH6gOlXvw5sdeaf
         DLuLVteoGXBnNmWmdXhtocnZ6wQYK1Ac6ydDwYEVHmcnG8eq5V2sdoLPoEaCKlhr5m
         gd8pcxHEEKDWtOEJa/8jhL+CYF4QzW4xyP5f2n8UvYHIyhEABhxrM+vYtvTvpfshDb
         gzv6wiBhfe58E4StnYwtgyJYU9BOOsZhSJri9fQMSeE4Ok+e20Q8HLbxaVj2w0RA2w
         suJUd3UtKXIWQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d03134f0000>; Fri, 14 Jun 2019 15:23:59 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 14 Jun 2019 15:23:58 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 14 Jun 2019 15:23:58 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC:     "sr@denx.de" <sr@denx.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
Thread-Topic: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
Thread-Index: AQHVEDI+CoqUJR97jEy7wwMr7iI19Q==
Date:   Fri, 14 Jun 2019 03:23:57 +0000
Message-ID: <8e80d911f0dd4759b3edc72fb76530d6@svr-chch-ex1.atlnz.lc>
References: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,=0A=
=0A=
I think this may have got lost in the change of maintainer for mtd.=0A=
=0A=
On 22/05/19 12:06 PM, Chris Packham wrote:=0A=
> Because PPB unlocking unlocks the whole chip cfi_ppb_unlock() needs to=0A=
> remember the locked status for each sector so it can re-lock the=0A=
> unaddressed sectors. Dynamically calculate the maximum number of sectors=
=0A=
> rather than using a hardcoded value that is too small for larger chips.=
=0A=
> =0A=
> Tested with Spansion S29GL01GS11TFI flash device.=0A=
> =0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
>   drivers/mtd/chips/cfi_cmdset_0002.c | 13 ++++++++-----=0A=
>   1 file changed, 8 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_=
cmdset_0002.c=0A=
> index c8fa5906bdf9..a1a7d334aa82 100644=0A=
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c=0A=
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c=0A=
> @@ -2533,8 +2533,6 @@ struct ppb_lock {=0A=
>   	int locked;=0A=
>   };=0A=
>   =0A=
> -#define MAX_SECTORS			512=0A=
> -=0A=
>   #define DO_XXLOCK_ONEBLOCK_LOCK		((void *)1)=0A=
>   #define DO_XXLOCK_ONEBLOCK_UNLOCK	((void *)2)=0A=
>   #define DO_XXLOCK_ONEBLOCK_GETLOCK	((void *)3)=0A=
> @@ -2633,6 +2631,7 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd=
_info *mtd, loff_t ofs,=0A=
>   	int i;=0A=
>   	int sectors;=0A=
>   	int ret;=0A=
> +	int max_sectors;=0A=
>   =0A=
>   	/*=0A=
>   	 * PPB unlocking always unlocks all sectors of the flash chip.=0A=
> @@ -2640,7 +2639,11 @@ static int __maybe_unused cfi_ppb_unlock(struct mt=
d_info *mtd, loff_t ofs,=0A=
>   	 * first check the locking status of all sectors and save=0A=
>   	 * it for future use.=0A=
>   	 */=0A=
> -	sect =3D kcalloc(MAX_SECTORS, sizeof(struct ppb_lock), GFP_KERNEL);=0A=
> +	max_sectors =3D 0;=0A=
> +	for (i =3D 0; i < mtd->numeraseregions; i++)=0A=
> +		max_sectors +=3D regions[i].numblocks;=0A=
> +=0A=
> +	sect =3D kcalloc(max_sectors, sizeof(struct ppb_lock), GFP_KERNEL);=0A=
>   	if (!sect)=0A=
>   		return -ENOMEM;=0A=
>   =0A=
> @@ -2689,9 +2692,9 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd=
_info *mtd, loff_t ofs,=0A=
>   		}=0A=
>   =0A=
>   		sectors++;=0A=
> -		if (sectors >=3D MAX_SECTORS) {=0A=
> +		if (sectors >=3D max_sectors) {=0A=
>   			printk(KERN_ERR "Only %d sectors for PPB locking supported!\n",=0A=
> -			       MAX_SECTORS);=0A=
> +			       max_sectors);=0A=
>   			kfree(sect);=0A=
>   			return -EINVAL;=0A=
>   		}=0A=
> =0A=
=0A=
