Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F17C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62320881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="D64Gj/jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfEVWQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:16:50 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38810 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEVWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:16:50 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9CED5886BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:16:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558563405;
        bh=ZxBUBp8Foj7N0iN33J8UMixBBZWHJz1GggRM1ihzeWM=;
        h=From:To:CC:Subject:Date:References;
        b=D64Gj/jxcx8scWArXZz7xjybNDG7QMVSoMz48ZJRu70tsPjvCBNuQDs80jEJUmBXN
         GFMRmqAzydF7zJ10I+KRjNVI2I9LrUwSpsT6cac37alW1/wFD/YATSrQZRVMiAuaYh
         oQAVWBwfjGJBK47abZyb6t2Jfj1bJTSKEnkT+nBAdnHSQPkpabEZE/XxLrd7KBlLkS
         YRbKp360cOkBmHN4AkUiMUWZse3z3gw0gk9nVPN60KMfHFqOKnTB8N0I49bLYd72MJ
         8pXIFwHidWCl4pR7bqUTrqeigcsvAI+R3q8SEZOKlIOJeQdpGZkr3utIY86objZ9au
         zSm/b0AUat4Sw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce5ca4b0001>; Thu, 23 May 2019 10:16:43 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 23 May 2019 10:16:45 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 23 May 2019 10:16:45 +1200
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
Date:   Wed, 22 May 2019 22:16:44 +0000
Message-ID: <82de06c4122b4b958b5c840aa2166dd8@svr-chch-ex1.atlnz.lc>
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
 <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
 <CAFLxGvy2c9KV1CyoFaD76jvThfPiotqfoeNchqjGcDp+uHie7Q@mail.gmail.com>
 <0c59bcd6c866429cb9727f787b7f61ce@svr-chch-ex1.atlnz.lc>
 <CAFLxGvwRnBtscaJDQ4qYGpQt87+amKYb4vBJvtt-3BmsOorL_g@mail.gmail.com>
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

On 23/05/19 9:27 AM, Richard Weinberger wrote:=0A=
> On Wed, May 22, 2019 at 11:06 PM Chris Packham=0A=
> <Chris.Packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>> On 23/05/19 8:44 AM, Richard Weinberger wrote:=0A=
>>> On Wed, May 22, 2019 at 2:08 AM Chris Packham=0A=
>>> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>>>=0A=
>>>> Add an implementation of the _is_locked operation for concatenated mtd=
=0A=
>>>> devices. As with concat_lock/concat_unlock this can simply use the=0A=
>>>> common helper and pass mtd_is_locked as the operation.=0A=
>>>>=0A=
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>>>> ---=0A=
>>>>    drivers/mtd/mtdconcat.c | 6 ++++++=0A=
>>>>    1 file changed, 6 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c=0A=
>>>> index 9514cd2db63c..0e919f3423af 100644=0A=
>>>> --- a/drivers/mtd/mtdconcat.c=0A=
>>>> +++ b/drivers/mtd/mtdconcat.c=0A=
>>>> @@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, lo=
ff_t ofs, uint64_t len)=0A=
>>>>           return __concat_xxlock(mtd, ofs, len, mtd_unlock);=0A=
>>>>    }=0A=
>>>>=0A=
>>>> +static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_=
t len)=0A=
>>>> +{=0A=
>>>> +       return __concat_xxlock(mtd, ofs, len, mtd_is_locked);=0A=
>>>> +}=0A=
>>>=0A=
>>> Hmm, here you start abusing your own new API. :(=0A=
>>=0A=
>> Abusing because xxlock is a poor choice of name? I initially had a third=
=0A=
>> copy of the logic from lock/unlock which is what lead me to do the=0A=
>> cleanup first. mtd_lock(), mtd_unlock() and mtd_is_locked() all work the=
=0A=
>> same way namely given an offset and a length either lock, unlock or=0A=
>> return the status of the len/erasesz blocks at ofs.=0A=
> =0A=
> Well, for unlock/lock it is just a loop which applies an operation to=0A=
> a given range on all submtds.=0A=
> But as soon an operation returns non-zero, the loop stops and returns=0A=
> that error.=0A=
> This makes sense for unlock/lock.=0A=
> =0A=
> Now you abuse this as "apply a random mtd operation to a given range".=0A=
> So, giving it a proper name is the first step. Step two is figuring=0A=
> for what kind=0A=
> of mtd operations it makes sense and is correct.=0A=
=0A=
Ah now I understand you concern. I guess the question is what is the =0A=
right thing for MEMISLOCKED to return when consecutive blocks differ in =0A=
lock status.=0A=
=0A=
>>>=0A=
>>> Did you verify that the unlock/lock-functions deal correctly with all=
=0A=
>>> semantics from mtd_is_locked?=0A=
>>> i.e. mtd_is_locked() with len =3D 0 returns 1 for spi-nor.=0A=
>>>=0A=
>>=0A=
>> I believe so. I've only got access to a parallel NOR flash system that=
=0A=
>> uses concatenation and that seems sane  (is mtdconcat able to work with=
=0A=
>> spi memories?). The concat_is_locked() should just reflect what the=0A=
>> underlying mtd device driver returns.=0A=
> =0A=
> mtdconcat *should* work with any mtd. But I never used it much, I see=0A=
> it more as legacy=0A=
> code.=0A=
> =0A=
> What happens if one submtd is locked and another not?=0A=
> Does concat_is_locked() return something sane then?=0A=
> I'd expect it to return true if at least one submtd is locked and 0=0A=
> of no submtd is locked.=0A=
> =0A=
> If the loop and return code handling in __concat_xxlock() can take care o=
f that,=0A=
> awesome. Then all you need is giving it a better name. :-)=0A=
=0A=
As implemented right now the loop will stop at the first locked block. =0A=
So if the range starts in a unlocked block and spans into a locked one =0A=
the return value will be 1.=0A=
=0A=
Is that correct? Well do_ppb_xxlock and  do_getlockstatus_oneblock seem =0A=
to only care about the first block (they both ignore len)? So they'd =0A=
return 0 in the case of unlocked,locked.=0A=
=0A=
stm_is_locked_sr does about the len and will return 0 if len falls =0A=
outside the locked region or if ofs starts before the locked region.=0A=
=0A=
So here's a quick breakdown=0A=
=0A=
                  ppb_is_locked intelext_is_locked stm_is_locked concat=0A=
unlocked,unlocked            0                  0             0      0=0A=
locked,locked                1                  1             1      1=0A=
locked,unlocked              1                  1             0      1=0A=
unlocked,locked              0                  0             0      1=0A=
=0A=
I'll try and make concat_is_locked consistent with the two cfi =0A=
implementations.=0A=
=0A=
Thanks for your feedback on this. I think the v2 series should look a =0A=
lot better as a result.=0A=
=0A=
=0A=
