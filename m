Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC8EC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F4520838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="USKEKP01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGJU61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:58:27 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34654 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGJU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:58:27 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A16C3886BF;
        Thu, 11 Jul 2019 08:58:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562792302;
        bh=3IAiydc3dLx1WVJ0C8G3rfahAcrzpy4g3ADOPjxOOzg=;
        h=From:To:CC:Subject:Date:References;
        b=USKEKP01eDSQDZoRr3UMjHI0nrWQrykZWS3nn26ftLKlij922hgOjfGDQmS3I8qol
         a36GeyBAFMH0ede4iSd+E/YhlUYz6Iv2v7S98wHOjbjhRUnKHSAkM/VbCzb5QV43z5
         Uc7v8RjUi0IH3j7ccV+b79giGE9TDSawX9wrxwe/lFa5vXfv0g35ZK1yw33C5uLXRZ
         wKWUvTpn80ZC1QtFyCxUAv0amCGGGg0L3kOtcmstWxVGBRiOV/JBavNbiNRliFC6J2
         QYOLj6wAnPsYoq5MW97Ey5B2dOhBT8z5AagyveLus8iByY+Rq5kC0I+4wSdEq/t3uY
         EgD7hiYPw56pg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d26516e0001>; Thu, 11 Jul 2019 08:58:22 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 11 Jul 2019 08:58:22 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 11 Jul 2019 08:58:22 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tipc: ensure skb->lock is initialised
Thread-Topic: [PATCH] tipc: ensure skb->lock is initialised
Thread-Index: AQHVNRbM8H0dBbuBFkyTwxApCbaMkw==
Date:   Wed, 10 Jul 2019 20:58:21 +0000
Message-ID: <4d2ac0ce7f974184ac43b71f19aee7a3@svr-chch-ex1.atlnz.lc>
References: <MN2PR15MB3581E1D6D56D6AA7DE8E357E9AF00@MN2PR15MB3581.namprd15.prod.outlook.com>
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

=0A=
On 11/07/19 1:10 AM, Jon Maloy wrote:=0A=
>> -----Original Message-----=0A=
>> From: Eric Dumazet <eric.dumazet@gmail.com>=0A=
>> Sent: 10-Jul-19 04:00=0A=
>> To: Jon Maloy <jon.maloy@ericsson.com>; Eric Dumazet=0A=
>> <eric.dumazet@gmail.com>; Chris Packham=0A=
>> <Chris.Packham@alliedtelesis.co.nz>; ying.xue@windriver.com;=0A=
>> davem@davemloft.net=0A=
>> Cc: netdev@vger.kernel.org; tipc-discussion@lists.sourceforge.net; linux=
-=0A=
>> kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH] tipc: ensure skb->lock is initialised=0A=
>>=0A=
>>=0A=
>>=0A=
>> On 7/9/19 10:15 PM, Jon Maloy wrote:=0A=
>>>=0A=
>>> It is not only for lockdep purposes, -it is essential.  But please prov=
ide details=0A=
>> about where you see that more fixes are needed.=0A=
>>>=0A=
>>=0A=
>> Simple fact that you detect a problem only when skb_queue_purge() is cal=
led=0A=
>> should talk by itself.=0A=
>>=0A=
>> As I stated, there are many places where the list is manipulated _withou=
t_ its=0A=
>> spinlock being held.=0A=
> =0A=
> Yes, and that is the way it should be on the send path.=0A=
> =0A=
>>=0A=
>> You want consistency, then=0A=
>>=0A=
>> - grab the spinlock all the time.=0A=
>> - Or do not ever use it.=0A=
> =0A=
> That is exactly what we are doing.=0A=
> - The send path doesn't need the spinlock, and never grabs it.=0A=
> - The receive path does need it, and always grabs it.=0A=
> =0A=
> However, since we don't know from the beginning which path a created=0A=
> message will follow, we initialize the queue spinlock "just in case"=0A=
> when it is created, even though it may never be used later.=0A=
> You can see this as a violation of the principle you are stating=0A=
> above, but it is a prize that is worth paying, given savings in code=0A=
> volume, complexity and performance.=0A=
> =0A=
>>=0A=
>> Do not initialize the spinlock just in case a path will use skb_queue_pu=
rge()=0A=
>> (instead of using __skb_queue_purge())=0A=
> =0A=
> I am ok with that. I think we can agree that Chris goes for that=0A=
> solution, so we can get this bug fixed.=0A=
=0A=
So would you like a v2 with an improved commit message? I note that I =0A=
said skb->lock instead of head->lock in the subject line so at least =0A=
that should be corrected.=0A=
=0A=
