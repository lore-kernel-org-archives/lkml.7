Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C460C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFA821019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="tKXqnvKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfEVUxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:53:43 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38642 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfEVUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:53:42 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6E53A886BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:53:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558558418;
        bh=DOEO3y2soOvXq8t/1GH0lADqJ6A3XwpUwCBU/Y2+CsU=;
        h=From:To:CC:Subject:Date:References;
        b=tKXqnvKm1e2jPtxiUAa9wBkNp5sPy3IrM8N13NfWSr/ObgLN3VIh7ZmkH4qjwe+01
         i3gi8mbXgliFjD3Ceq5pSXJb9q8v0jQh1B4Y94ryyTMauKVP8wNxOrHVD2z9o0wQqv
         lGgB4nIONrovafdDAmf5WXQhyKQ8Ze+xrnMG0/fIPWkt+0Naj2Ws9aDXlCyCdq7Gda
         2ZE2yveMBtHBtZgXanpd6MaJvdEHbq2mRUA86Kdl5+AQdzcGnY++v+GQlIAL6qyTOd
         9sBIzwC2sNiVKluVS7qt6sYBgMGPcBGWokc+/6/RbX5u0etwgtXbNsqVNuyzP9V6VR
         Xe2cIy+F6eWXw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce5b6d00001>; Thu, 23 May 2019 08:53:36 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Thu, 23 May 2019 08:53:37 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 23 May 2019 08:53:37 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Topic: [PATCH 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Index: AQHVEDJo4rpNy/YxbUOF1g0LZpyjfw==
Date:   Wed, 22 May 2019 20:53:36 +0000
Message-ID: <86adfe1f5a18492fbdf4bbe26ca05a93@svr-chch-ex1.atlnz.lc>
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
 <CAFLxGvzvAdhmNOaNmPCRXUR9GGgaQ1n2HuRLLCb4Nj-tUrm5yQ@mail.gmail.com>
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

On 23/05/19 8:30 AM, Richard Weinberger wrote:=0A=
> On Wed, May 22, 2019 at 2:08 AM Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>> concat_lock() and concat_unlock() only differed in terms of the mtd_xx=
=0A=
>> operation they called. Refactor them to use a common helper function and=
=0A=
>> pass mtd_lock or mtd_unlock as an argument.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>   drivers/mtd/mtdconcat.c | 41 +++++++++--------------------------------=
=0A=
>>   1 file changed, 9 insertions(+), 32 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c=0A=
>> index cbc5925e6440..9514cd2db63c 100644=0A=
>> --- a/drivers/mtd/mtdconcat.c=0A=
>> +++ b/drivers/mtd/mtdconcat.c=0A=
>> @@ -451,7 +451,8 @@ static int concat_erase(struct mtd_info *mtd, struct=
 erase_info *instr)=0A=
>>          return err;=0A=
>>   }=0A=
>>=0A=
>> -static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
>> +static int __concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t l=
en,=0A=
>> +                          int (*mtd_op)(struct mtd_info *mtd, loff_t of=
s, uint64_t len))=0A=
>>   {=0A=
>>          struct mtd_concat *concat =3D CONCAT(mtd);=0A=
>>          int i, err =3D -EINVAL;=0A=
>> @@ -470,7 +471,7 @@ static int concat_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)=0A=
>>                  else=0A=
>>                          size =3D len;=0A=
>>=0A=
>> -               err =3D mtd_lock(subdev, ofs, size);=0A=
>> +               err =3D mtd_op(subdev, ofs, size);=0A=
>>                  if (err)=0A=
>>                          break;=0A=
>>=0A=
>> @@ -485,38 +486,14 @@ static int concat_lock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)=0A=
>>          return err;=0A=
>>   }=0A=
>>=0A=
>> -static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len=
)=0A=
>> +static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)=
=0A=
>>   {=0A=
>> -       struct mtd_concat *concat =3D CONCAT(mtd);=0A=
>> -       int i, err =3D 0;=0A=
>> -=0A=
>> -       for (i =3D 0; i < concat->num_subdev; i++) {=0A=
>> -               struct mtd_info *subdev =3D concat->subdev[i];=0A=
>> -               uint64_t size;=0A=
>> -=0A=
>> -               if (ofs >=3D subdev->size) {=0A=
>> -                       size =3D 0;=0A=
>> -                       ofs -=3D subdev->size;=0A=
>> -                       continue;=0A=
>> -               }=0A=
>> -               if (ofs + len > subdev->size)=0A=
>> -                       size =3D subdev->size - ofs;=0A=
>> -               else=0A=
>> -                       size =3D len;=0A=
>> -=0A=
>> -               err =3D mtd_unlock(subdev, ofs, size);=0A=
>> -               if (err)=0A=
>> -                       break;=0A=
>> -=0A=
>> -               len -=3D size;=0A=
>> -               if (len =3D=3D 0)=0A=
>> -                       break;=0A=
>> -=0A=
>> -               err =3D -EINVAL;=0A=
>> -               ofs =3D 0;=0A=
>> -       }=0A=
>> +       return __concat_xxlock(mtd, ofs, len, mtd_lock);=0A=
>> +}=0A=
>>=0A=
>> -       return err;=0A=
>> +static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len=
)=0A=
>> +{=0A=
>> +       return __concat_xxlock(mtd, ofs, len, mtd_unlock);=0A=
>>   }=0A=
>>=0A=
>>   static void concat_sync(struct mtd_info *mtd)=0A=
> =0A=
> Not sure if it passing a function pointer is worth it. bool is_lock would=
=0A=
> also do it. But this is a matter of taste, I guess. :)=0A=
=0A=
I briefly considered that. But since mtd_lock(), mtd_unlock() and =0A=
mtd_is_locked() all take the same arguments I figured it'd benefit from =0A=
some type checking. A bool wouldn't work (assuming I can convince you =0A=
about 2/2) but an enum mtd_op or int flags would do the trick if you =0A=
want me to change it.=0A=
=0A=
> =0A=
> Reviewed-by: Richard Weinberger <richard@nod.at>=0A=
> =0A=
=0A=
