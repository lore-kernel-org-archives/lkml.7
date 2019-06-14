Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A258C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BF208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YLYUJXLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFND0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:26:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47643 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfFND0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:26:09 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9CF60886BF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 15:26:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1560482766;
        bh=7cuNjAUOasNNcdtTHWPsfOhv3qMjbKvxs9MCbv9O5Ug=;
        h=From:To:CC:Subject:Date:References;
        b=YLYUJXLC8jQj0CxFuDLhFcOR0xnZ9SRStohsLsmY7DAoSCf8pDCvG1J5fFDQJO3yq
         vcZ++Z4S8R/wA8RsqUPYpVwBzz7fVnAB6TgdDa4YhljxI1/FhkHnYSXpS9LG43EqnV
         wh8G0vGziGTS6zKRD36HkWxBNLFGyHBM4LHiNINR1ttbLmaPILzz7YG7mwGVFFE42c
         Y9pNmORSfIogM0SWgT044OUpkXlrnejbKzBNfyyMdFv12D8OqJYCOjWyTacN2EOt1a
         m/w6MXRy+LOX/u27t0lA0IXrbS49lsqgo9XEhe+hGUb18kmo3MMs7xvpiblixZerXP
         bUtGMALmfNLVQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d0313ce0000>; Fri, 14 Jun 2019 15:26:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 14 Jun 2019 15:26:04 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 14 Jun 2019 15:26:04 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Topic: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Index: AQHVEPTbCX8jgKCQ/EWiWr4BFnYFGQ==
Date:   Fri, 14 Jun 2019 03:26:03 +0000
Message-ID: <355dad1321ed46baa98ca6f47b4d00b5@svr-chch-ex1.atlnz.lc>
References: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
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
Ping?=0A=
=0A=
On 23/05/19 11:19 AM, Chris Packham wrote:=0A=
> concat_lock() and concat_unlock() only differed in terms of the mtd_xx=0A=
> operation they called. Refactor them to use a common helper function and=
=0A=
> pass a boolean flag to indicate whether lock or unlock is needed.=0A=
> =0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
> Changes in v2:=0A=
> - Use a boolean flag instead of passing a function pointer.=0A=
> =0A=
>   drivers/mtd/mtdconcat.c | 44 +++++++++++------------------------------=
=0A=
>   1 file changed, 12 insertions(+), 32 deletions(-)=0A=
> =0A=
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c=0A=
> index cbc5925e6440..6cb60dea509a 100644=0A=
> --- a/drivers/mtd/mtdconcat.c=0A=
> +++ b/drivers/mtd/mtdconcat.c=0A=
> @@ -451,7 +451,8 @@ static int concat_erase(struct mtd_info *mtd, struct =
erase_info *instr)=0A=
>   	return err;=0A=
>   }=0A=
>   =0A=
> -static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
> +static int concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t len,=
=0A=
> +			 bool is_lock)=0A=
>   {=0A=
>   	struct mtd_concat *concat =3D CONCAT(mtd);=0A=
>   	int i, err =3D -EINVAL;=0A=
> @@ -470,7 +471,10 @@ static int concat_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)=0A=
>   		else=0A=
>   			size =3D len;=0A=
>   =0A=
> -		err =3D mtd_lock(subdev, ofs, size);=0A=
> +		if (is_lock)=0A=
> +			err =3D mtd_lock(subdev, ofs, size);=0A=
> +		else=0A=
> +			err =3D mtd_unlock(subdev, ofs, size);=0A=
>   		if (err)=0A=
>   			break;=0A=
>   =0A=
> @@ -485,38 +489,14 @@ static int concat_lock(struct mtd_info *mtd, loff_t=
 ofs, uint64_t len)=0A=
>   	return err;=0A=
>   }=0A=
>   =0A=
> -static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
> +static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
>   {=0A=
> -	struct mtd_concat *concat =3D CONCAT(mtd);=0A=
> -	int i, err =3D 0;=0A=
> -=0A=
> -	for (i =3D 0; i < concat->num_subdev; i++) {=0A=
> -		struct mtd_info *subdev =3D concat->subdev[i];=0A=
> -		uint64_t size;=0A=
> -=0A=
> -		if (ofs >=3D subdev->size) {=0A=
> -			size =3D 0;=0A=
> -			ofs -=3D subdev->size;=0A=
> -			continue;=0A=
> -		}=0A=
> -		if (ofs + len > subdev->size)=0A=
> -			size =3D subdev->size - ofs;=0A=
> -		else=0A=
> -			size =3D len;=0A=
> -=0A=
> -		err =3D mtd_unlock(subdev, ofs, size);=0A=
> -		if (err)=0A=
> -			break;=0A=
> -=0A=
> -		len -=3D size;=0A=
> -		if (len =3D=3D 0)=0A=
> -			break;=0A=
> -=0A=
> -		err =3D -EINVAL;=0A=
> -		ofs =3D 0;=0A=
> -	}=0A=
> +	return concat_xxlock(mtd, ofs, len, true);=0A=
> +}=0A=
>   =0A=
> -	return err;=0A=
> +static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
> +{=0A=
> +	return concat_xxlock(mtd, ofs, len, false);=0A=
>   }=0A=
>   =0A=
>   static void concat_sync(struct mtd_info *mtd)=0A=
> =0A=
=0A=
