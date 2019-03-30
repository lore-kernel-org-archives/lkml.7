Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E71C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA752146F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="k9pjHiS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfC3UK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:10:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:29422 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbfC3UK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553976652;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lpuCw8o2tewDWQeyzEL+Q1JSAsOU4WTSpgFXHwxUeLk=;
        b=k9pjHiS+h7Tn9OIJtOPKxPJ3imkziU4vmV4T22fLztj2EfHeDq2AI9ikVLCRVs9v0Y
        H/EDCsfkHBC5dcv+Y3UEAKyAZc3/hnDRXHygv3qjZNpMvW6nLVvlsizvqEba27fz0qih
        UdQbxmmsk5hApxRrFJezVoeFFtzOnc+u7e2zV0u+xhcc/6a1TlYi7/1Z9ReDn3hbBAXP
        xBOo4ABRmUT+57xLNpxgOHf5FRFqG1LkMXPnb6MNYMZ+ioyVtplJ9Ztcl20DcDjFYprk
        Dv0uGGp7LURhzKN6JtAob8z614tJLZcGta/ZZ1lhnrKHq/Hiu4grT0ikofnIeHUarg6m
        p5HQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMlw4vkKg=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2UKAgW0q
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 30 Mar 2019 21:10:42 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190330193259.5054655e@aktux>
Date:   Sat, 30 Mar 2019 21:10:47 +0100
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <14098F3F-0DDD-42AA-A7AD-DC35FD4C1F23@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com> <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <20190330193259.5054655e@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Am 30.03.2019 um 19:33 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Sun, 24 Mar 2019 07:56:17 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi Linus,
>>=20
>>> Am 24.03.2019 um 05:15 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>>>=20
>>> On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>>> (1) c1c04cea13dc gpio: of: Fix logic inversion
>>>>=20
>>>> together with the basic patch
>>>>=20
>>>> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>>>>=20
>>>> leads to a severe regression for our GTA04 board. =20
>>>=20
>>> Sorry! :(
>>>=20
>>> I found the same problem on my Nomadik board.
>>>=20
>>> But I fixed it in that case by introducing a spi-cs-high into the =
DTS file:
>>> https://marc.info/?l=3Dlinux-arm-kernel&m=3D155292310015309&w=3D2 =20=

>>=20
>> Yes, that of course works and is our temporary solution.
>>=20
>> And I see that you also have it on the controller node and not the =
slave node.
>>=20
> So if I get it right is a check added for undocumented properties
> (nothing about  spi-cs-high  in controller node in the bindings
> documentation, only in the slave node) in the two patches mentioned.
>=20
> And then you add that undocumented property to a dts file in your =
"fix".
>=20
> That all sounds strange to me.

>=20
>>>=20
>>>> I learned that it tries to handle a legacy "spi-cs-high" property =
of SPI slaves, but was stopped
>>>> from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
>>>> explains why it was not noticed earlier.
>>>>=20
>>>> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already =
written without any legacy spi properties
>>>> in mind =20
>>>=20
>>> I'm sorry about that, however if you look at the DT binding =
document:
>>> Documentation/devicetree/bindings/spi/spi-bus.txt =20
>>=20
>> Shouldn't it be a property of the slave node and not the controller =
node?
>>=20
>>>=20
>>> You will see that spi-cs-high is mandatory. So these DTS files are
>>> incorrect. =20
>>=20
>> How do you read that it is mandatory from
>>=20
>> "All slave nodes can contain the following optional properties:
>> - spi-cs-high     - Empty property indicating device requires chip =
select
>> 		    active high."
>>=20
>> I read it as optional and indicative. Equal priority to cs-gpios.
>>=20
> Well, it is in the list of optional properties. So the question is how
> that "optional" is interpreted. Is it optional because you only use it
> if cs is active high or is it optional because you can either indicate
> that fact here or via gpio definition.
>=20
> But again that flags makes no sense in the controller node.

I have already prepared some fix for this controller/slave node issue =
and
a new CONFIG option to enable the legacy "spi-cs-high" only if needed.
Seems to be common practice that legacy API support (and legacy DTB
compatibility is also "API") is only enabled by CONFIGs on demand.

This can then replace our current GTA04 hack. Will post ASAP to LKML.

BR,
Nikolaus

