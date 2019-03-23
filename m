Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C138C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D042190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="KEhpYwun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCWOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:40:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:10505 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553352046;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VS1ahpFuYFV4NmPn8Kph+6zm6Kx0r5ttBoH/tc36CQM=;
        b=KEhpYwunKwVqI9pnV9kL3V/ujlVRdQOo8+oSj4r3MSXqipYducelHbH0CRCThlCnWM
        b2on2ipl4M9zzlA7TVJuHbCjloO2R8b4+iA3IMxttLp3UKNI9DYEaOMZtkYa7l97PxrY
        foEZdFU1L5GUtBs66l5wN7ewbwmO/153J4g3WdQR7LatpVmiQ0y2jIzTtNcVhn++mAyN
        x5/hQA7jbHoM44YbwerMHbIqCGNGno7SMjQlFPqUdmZVFiRgQAxq7Np+WWm6NpAbdbyh
        nYMB530Sy20AWIPgPlejadWT0Nd1ZK8uTciB3dxgg0ConV0CiHGH1j0tYNt1RaLpGNAs
        lIgw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDleUXA0Oqng="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2NEeTqTx
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Mar 2019 15:40:29 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
Date:   Sat, 23 Mar 2019 15:40:29 +0100
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I am sorry to report that your patch

(1) c1c04cea13dc gpio: of: Fix logic inversion

together with the basic patch

(2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings

leads to a severe regression for our GTA04 board. The symptom was easy =
to see but really difficult
to understand: the LCD panel stopped working (did only show white =
pixels) after upgrading from
v5.0 to v5.1-rc1.

In a long bisect session, I was able to identify patch (1) as the first =
bad commit and started
to analyse what the code is supposed to do and then found the older =
patch (2).

I learned that it tries to handle a legacy "spi-cs-high" property of SPI =
slaves, but was stopped
from doing so by a bug (1). So only with both patches, the legacy =
handler becomes active which
explains why it was not noticed earlier.

Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written =
without any legacy spi properties
in mind

(3) c2e138bc8ed80 ARM: dts: omap3-gta04: Add display support

So it has no spi-cs-high property and just defines constant 0 for the =
flags (GPIO_ACTIVE_HIGH after
some fix from 2015) assuming that this is sufficient. And it was until =
before v5.1-rc1.

This is now wrongly turned into an GPIO_ACTIVE_LOW by your legacy fix =
which makes the panel
stop feeling responsible to receive any initialization data over SPI.

Yes, there is a new message in the boot log for this case, but to be =
honest, nobody did see it
before I found the code that does print it. A non-working LCD panel was =
a too distracting indicator
and could have been everything (most likely drm or the panel driver or =
clock or regulator or
dma setup or whatever)...

So your assumption that this case is the exception as stated in commit =
message of (2) seems not
to be true. IMHO it should be standard (at least since 2015) that there =
is GPIO_ACTIVE_HIGH and
no spi-cs-high. So your patch (2) gives a legacy property a new priority =
over modern style.

BTW: the spi-cs-high is described as optional and indicative in the =
bindings document. But it
now appears to be required to get a cs-high.

By the way, the detection of spi-cs-high still seems to be wrong as of =
v5.1-rc1. Shouldn't it
look at the child node for "spi-cs-high" and not the controller node =
pointer? As far as I understand
the current code, all such legacy flags are therefore ignored and should =
break all boards that
use spi-cs-high and GPIO_ACTIVE_HIGH.

Of course, adding spi-cs-high; (at the controller node!) of our device =
tree can make it work,
but I do not like to be forced to introduce a legacy property to our DTS =
file, just because
gpio-lib tries to fix a legacy problem in the SPI subsystem (quite =
mind-twisting cross-subsystem
dependencies, aren't they?).

The real problem seems to be that the legacy spi-cs-high property itself =
still exists although
it should not be needed for ca. 5 years. =46rom all this I conclude that =
nobody really needs this
legacy support or does test it. And if he/she does, they should better =
fix the cs-gpios entries
in the DTS and remove spi-cs-high completely.

Therefore I would suggest:
* revert both patches as soon as possible (v5.1-rc series) to remove the =
unexpected spi legacy
  code handler from the gpio subsystem.
* replace all uses of spi-cs-high by correct cs-gpios flags - unless =
they already are there.
  fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of DTS =
candidates.
* fix spi-bus.txt documentation to describe this potential pitfall.

Then we can leave our GTA04 display and device tree untouched as from =
v3.16-rc1 up to v5.0.x.

BR and thanks,
Nikolaus

