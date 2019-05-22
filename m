Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85374C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CBA2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="w/FMcy8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfEVVGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:06:54 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38679 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfEVVGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:06:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 721EB886BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:06:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558559209;
        bh=8p35s5XVWClYRtrAwLIBY55P6drz9IsxEb7+jakkOSE=;
        h=From:To:CC:Subject:Date:References;
        b=w/FMcy8LrCkP7/k1jhsMg6PjVW5Yf3xubMEg37maZ+K8yhuJsWQSxFV9ARFjjfU7n
         pSM13x6MhgVkg5CBWS27fnOk6e4qOp4HHUQt+FlQe1X7DpIWHcVTzol0/Jvl3SKC+r
         zaEgjZ7d4eWhmSu748gxfZjpyn6JR1SV7o+Y/MVcWho4ldU3qmVkEaz4MenDvuMPtz
         SV2B8Vb3NfXIXboQcXgoCiut3aSvfyyGQsQbh/wEm4EkJArmM2EkvaSGnJUGTQK9kd
         QOHrnVvCaFFFrv9bF/pJSoHj/gSJL2cnLTRMnfz71Qv8X2K3RB60cuNalM1FBzKpuY
         1U1KOJU+w5i+Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce5b9e70001>; Thu, 23 May 2019 09:06:47 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Thu, 23 May 2019 09:06:49 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 23 May 2019 09:06:49 +1200
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
Subject: Re: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
Thread-Topic: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
Thread-Index: AQHVEDJo0iBq93PH/EeJquPgUtfeew==
Date:   Wed, 22 May 2019 21:06:48 +0000
Message-ID: <0c59bcd6c866429cb9727f787b7f61ce@svr-chch-ex1.atlnz.lc>
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
 <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
 <CAFLxGvy2c9KV1CyoFaD76jvThfPiotqfoeNchqjGcDp+uHie7Q@mail.gmail.com>
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

On 23/05/19 8:44 AM, Richard Weinberger wrote:=0A=
> On Wed, May 22, 2019 at 2:08 AM Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>> Add an implementation of the _is_locked operation for concatenated mtd=
=0A=
>> devices. As with concat_lock/concat_unlock this can simply use the=0A=
>> common helper and pass mtd_is_locked as the operation.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>   drivers/mtd/mtdconcat.c | 6 ++++++=0A=
>>   1 file changed, 6 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c=0A=
>> index 9514cd2db63c..0e919f3423af 100644=0A=
>> --- a/drivers/mtd/mtdconcat.c=0A=
>> +++ b/drivers/mtd/mtdconcat.c=0A=
>> @@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, loff=
_t ofs, uint64_t len)=0A=
>>          return __concat_xxlock(mtd, ofs, len, mtd_unlock);=0A=
>>   }=0A=
>>=0A=
>> +static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t =
len)=0A=
>> +{=0A=
>> +       return __concat_xxlock(mtd, ofs, len, mtd_is_locked);=0A=
>> +}=0A=
> =0A=
> Hmm, here you start abusing your own new API. :(=0A=
=0A=
Abusing because xxlock is a poor choice of name? I initially had a third =
=0A=
copy of the logic from lock/unlock which is what lead me to do the =0A=
cleanup first. mtd_lock(), mtd_unlock() and mtd_is_locked() all work the =
=0A=
same way namely given an offset and a length either lock, unlock or =0A=
return the status of the len/erasesz blocks at ofs.=0A=
=0A=
> =0A=
> Did you verify that the unlock/lock-functions deal correctly with all=0A=
> semantics from mtd_is_locked?=0A=
> i.e. mtd_is_locked() with len =3D 0 returns 1 for spi-nor.=0A=
> =0A=
=0A=
I believe so. I've only got access to a parallel NOR flash system that =0A=
uses concatenation and that seems sane  (is mtdconcat able to work with =0A=
spi memories?). The concat_is_locked() should just reflect what the =0A=
underlying mtd device driver returns.=0A=
