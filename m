Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC362184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="MV4wnmG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfC1T7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:59:33 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46004 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfC1T7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:59:33 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1EB7B886BF;
        Fri, 29 Mar 2019 08:59:31 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553803171;
        bh=KyVf0XPYe/Sq2CeY/TstCYgQb42lVq35x7WJh3kz4AE=;
        h=From:To:CC:Subject:Date:References;
        b=MV4wnmG48tgxSpWpN+i9c/XAPIud2US33ZPG3nVR8XWPC5yFiBoVrQFz300pPWNEf
         aINXu2DwRJH/tLydoJNXAdXx22imQCxFIS9hauQmbu10ig0RrC+QnSg772xDNz1w54
         TG5Pytig9cVhr96cjpEi5HC78pWi/v4yD8L3AdJmtePhRkxTtx2OpgMTSZW36fny31
         8fFBMmZO9j6PeHTz2DqQIblOjtk8aCigGj1l5VLj0sNZ22Oe6ZTCtO5+q1HCByNlB5
         mpYST/a00kFUXPuQ7W7XdSabau4FsxQISG8wuOo6NDQQVdcmCQ1O5c7kdS1i2TNOqk
         N0s3r5wtSDvaw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9d27a20001>; Fri, 29 Mar 2019 08:59:30 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Fri, 29 Mar 2019 08:59:30 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 29 Mar 2019 08:59:30 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: maps: physmap: Store gpio_values correctly
Thread-Topic: [PATCH 1/2] mtd: maps: physmap: Store gpio_values correctly
Thread-Index: AQHU5RsQWH5zn2hVsUSt8KG5kvMGiw==
Date:   Thu, 28 Mar 2019 19:59:30 +0000
Message-ID: <1ab4e2f0c6d4404895877ecf539504bd@svr-chch-ex1.atlnz.lc>
References: <20190328040217.1895-1-chris.packham@alliedtelesis.co.nz>
 <20190328040217.1895-2-chris.packham@alliedtelesis.co.nz>
 <20190328093228.5ab79718@collabora.com>
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

On 28/03/19 9:32 PM, Boris Brezillon wrote:=0A=
> On Thu, 28 Mar 2019 17:02:15 +1300=0A=
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>> When the gpio-addr-flash.c driver was merged with physmap-core.c the=0A=
>> code to store the current gpio_values was lost. This meant that once a=
=0A=
>> gpio was asserted it was never de-asserted. Fix this by storing the=0A=
>> current offset in gpio_values like the old driver used to.=0A=
>>=0A=
>> Fixes: commit ba32ce95cbd9 ("mtd: maps: Merge gpio-addr-flash.c into phy=
smap-core.c")=0A=
> =0A=
> You miss=0A=
> =0A=
> Cc: <stable@vger.kernel.org>=0A=
> =0A=
=0A=
I wasn't sure. As the original commit said there are no in-tree users of =
=0A=
  addr-gpios so maybe no-one else noticed. I'll wait for any other =0A=
comments and send a v2 with a Cc for stable.=0A=
=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> =0A=
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>=0A=
> =0A=
>> ---=0A=
>>   drivers/mtd/maps/physmap-core.c | 2 ++=0A=
>>   1 file changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-=
core.c=0A=
>> index d9a3e4bebe5d..21b556afc305 100644=0A=
>> --- a/drivers/mtd/maps/physmap-core.c=0A=
>> +++ b/drivers/mtd/maps/physmap-core.c=0A=
>> @@ -132,6 +132,8 @@ static void physmap_set_addr_gpios(struct physmap_fl=
ash_info *info,=0A=
>>   =0A=
>>   		gpiod_set_value(info->gpios->desc[i], !!(BIT(i) & ofs));=0A=
>>   	}=0A=
>> +=0A=
>> +	info->gpio_values =3D ofs;=0A=
>>   }=0A=
>>   =0A=
>>   #define win_mask(order)		(BIT(order) - 1)=0A=
> =0A=
> =0A=
=0A=
