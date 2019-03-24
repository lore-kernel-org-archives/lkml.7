Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941A42148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="RgdRhpzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfCXG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:56:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:25866 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553410592;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=I2pNVx4CIuoPq6vSqtXQJyDYpL3umI36N0rfNy2jcaA=;
        b=RgdRhpzklOQUjOkBz3Fm2/J51XPJ7KmoFA7P4sv1cXGbtCBaeJiSS+mEYPJo0pntcz
        c3YO4tiLXBDhcC4EnBBNFdFpjuxx9j0CYiKcW3VdCAU2OWIUwOit5JabP9RrDLYfvC9J
        HoBO7fwzoz2+BrleziHId/jXGDSy471Fnqzpya5zBYETls62QlbTdd+GXtGml6qY+0cv
        n2KSD9M7mT2DGT63CFjYvbApnSCTz3FgVw1ZDu0CcmUofeJzbLQORa/T/nwfMxIlw5L6
        1x1/XJSrW1foN0Mp7xdJWZ66WKzP7T3tyr0qOCRylTApqfeT6O6fio4s3s65zvT0kbKg
        SEpw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vqwDaqTQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2O6uI0ca
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Mar 2019 07:56:18 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
Date:   Sun, 24 Mar 2019 07:56:17 +0100
Cc:     Jan Kotas <jank@cadence.com>, LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Am 24.03.2019 um 05:15 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> (1) c1c04cea13dc gpio: of: Fix logic inversion
>>=20
>> together with the basic patch
>>=20
>> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
>>=20
>> leads to a severe regression for our GTA04 board.
>=20
> Sorry! :(
>=20
> I found the same problem on my Nomadik board.
>=20
> But I fixed it in that case by introducing a spi-cs-high into the DTS =
file:
> https://marc.info/?l=3Dlinux-arm-kernel&m=3D155292310015309&w=3D2

Yes, that of course works and is our temporary solution.

And I see that you also have it on the controller node and not the slave =
node.

>=20
>> I learned that it tries to handle a legacy "spi-cs-high" property of =
SPI slaves, but was stopped
>> from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
>> explains why it was not noticed earlier.
>>=20
>> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written =
without any legacy spi properties
>> in mind
>=20
> I'm sorry about that, however if you look at the DT binding document:
> Documentation/devicetree/bindings/spi/spi-bus.txt

Shouldn't it be a property of the slave node and not the controller =
node?

>=20
> You will see that spi-cs-high is mandatory. So these DTS files are
> incorrect.

How do you read that it is mandatory from

"All slave nodes can contain the following optional properties:
- spi-cs-high     - Empty property indicating device requires chip =
select
		    active high."

I read it as optional and indicative. Equal priority to cs-gpios.

>=20
>> Therefore I would suggest:
>> * revert both patches as soon as possible (v5.1-rc series) to remove =
the unexpected spi legacy
>>  code handler from the gpio subsystem.
>> * replace all uses of spi-cs-high by correct cs-gpios flags - unless =
they already are there.
>>  fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS =
candidates.
>> * fix spi-bus.txt documentation to describe this potential pitfall.
>=20
> This does not work because there are devices that requires spi-cs-high =
to be
> respected and the DTS second cell GPIO flag to be ignored.

Then, those should be fixed...

>=20
> Jan Kotas reported this problem.

Thanks for adding him to the discussion.

>=20
> They might have deployed DTB binaries that need to keep working,

Well, that is a weak argument. What if the GTA04 would have the DTB in =
FLASH
and would need it working (fortunately we always reflash kernel + dtbs)?

> so we
> cannot change it to ignore spi-cs-high like this. (I might give in if =
it can be
> proven that all of them just recompile the DTS all the time and no
> DTBs are in flash.)

BTW, on which node do these invariable DTBs have the spi-cs-high flag?
In the controller node (IMHO wrong) or the slave node (according to =
bindings doc)?

I have checked with randomly picked imx51-babbage.dts and it has it in =
the
slave node (pmic: mc13892@0). It also seems to be an example where =
different
CS lines want different settings.

If the all these DTBs have spi-cs-high in the slave node, none of them =
will
be fixed by the current code.

>=20
> I think in this case the oldest binding wins.

Ok, it is the question when such deprecated things are really removed.
There is no clear answer...

> The spi-cs-high was there before
> we came up with the scheme to use the flags cell with GPIO phandles.

>=20
> I think you simply have to patch these GTA04 DTS files to use
> spi-cs-high.

Ugly... Well, if DTS maintainers accept that?

>=20
> But I'm open to other ideas, let's discuss this.

What about a CONFIG to explicitly enable/disable this legacy support?

IMHO it will need to be enabled for les than 1% of the kernel builds and
therefore also keeps the zImage smaller for all others. And avoids DTB
changes where the gpio flags are already correct.

BR and thanks,
Nikolaus

