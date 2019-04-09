Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB3EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4B12084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="dC5c373J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIUyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:54:08 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34847 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDIUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:54:07 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7EA8A806AC;
        Wed, 10 Apr 2019 08:54:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1554843244;
        bh=QBUK6mbS+nYm7+XkF9yS7vGy86jhswwoBeELi74EilE=;
        h=From:To:CC:Subject:Date:References;
        b=dC5c373Jv+YIg8jhUabtlxFcAxhRZEou2WOLxZyN8w/J9FV0Hk2DgjXhtpKfzCVc8
         e3bosBQ9HsN92oAVzb0od4SPAnpZMoWTleb0wakBeJKFim4PxtR80tbJfVMryiZSiK
         Ia8cadZAQGAiD9J+2WycJq6Jon+R19ziHMT44rxcSuOX2xSKAYgUtfyBksR6prNC1j
         BnD15ZUEdjV3507L77kh+6XVMcUrUneOVbymKN98P1bPHQpNTB+QBeKsyOzoaH3E2A
         xMZdPi4B/S8xDzdfNxi9k0BRBnqmJUwWktHophFXQCpaeXa2Gi3UW2YDGUrMuCgUzn
         D3fZF81gXFdNA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cad066d0002>; Wed, 10 Apr 2019 08:54:05 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 10 Apr 2019 08:54:04 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 10 Apr 2019 08:54:04 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Frank Rowand <frowand.list@gmail.com>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: Using device tree overlays in Linux
Thread-Topic: Using device tree overlays in Linux
Thread-Index: AQHU6ojCpZF8ouBfMkagL4RUBC6Q3g==
Date:   Tue, 9 Apr 2019 20:54:03 +0000
Message-ID: <85be88b38c79424d84ee2499b5ab81fc@svr-chch-ex1.atlnz.lc>
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
 <61185ee9-4bee-eec3-f0d0-6d6760595845@gmail.com>
 <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
 <b2e0e55e-38a3-3dfb-3453-f57d7e2e99a3@gmail.com>
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

On 10/04/19 7:19 AM, Frank Rowand wrote:=0A=
> On 4/7/19 6:27 PM, Chris Packham wrote:=0A=
>> Hi Frank,=0A=
>>=0A=
>> On 8/04/19 1:05 PM, Frank Rowand wrote:=0A=
>>> Hi Chris,=0A=
>>>=0A=
>>> On 4/3/19 6:50 PM, Chris Packham wrote:=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> I'm implementing support for some modular Linux based systems using=0A=
>>>> device tree overlays. The code is working but it seems a little more=
=0A=
>>>> fiddly that than it should be so I'm wondering if I'm doing it right.=
=0A=
>>>=0A=
>>> Let me start by saying that I strongly discourage using device tree=0A=
>>> overlays in the Linux kernel until the support is more baked.  For=0A=
>>> some info on how unbaked overlays are, see:=0A=
>>>=0A=
>>>      https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts=0A=
>>>=0A=
>>> You should consider applying overlays in the Linux kernel to be=0A=
>>> fragile at best.=0A=
>>>=0A=
>>> If you can not figure out how to solve your needs without using=0A=
>>> overlays, then having the boot loader apply the overlay instead=0A=
>>> of the kernel applying the overlay avoids most of the issues.=0A=
>>>=0A=
>>=0A=
>> Consider us beta-testers :).=0A=
> =0A=
> You should read the elinux.org page more carefully.  The support=0A=
> isn't even alpha stage.  It is at the level of proof of concept.=0A=
> =0A=
> I'll update that page to explicitly say the code is proof of=0A=
> concept.=0A=
=0A=
pre-alpha-testers then. We've actually been using the early overlay =0A=
support for a while and it's suited our needs quite well. Aside from the =
=0A=
internal API changes as we move to the latest kernel the current support =
=0A=
also seems to meet our needs.=0A=
=0A=
Both Hamish and I are quite keen to see this move forward so please =0A=
don't hesitate to ask us if there are things we might be able to help =0A=
with. Even if it's just trying something out on our hardware platforms.=0A=
