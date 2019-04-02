Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF566C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCA420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jUhJ5tm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfDBGh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:37:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:33771 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDBGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:37:28 -0400
X-Greylist: delayed 5498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 02:37:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554187046;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KC6/gyCXj+Bx7HLRKYEgPFrG69w9jRaa2uAypU+Rlok=;
        b=jUhJ5tm+mxGu4BnuDvoZ72sfvoCUZghJHPRNqa1T3M7IolzhX8vc0XjzSQXoVOSMgI
        ntrcn/fC0pAtfOqbDxq0YxOeFfnZJy223YqNPDgC6uUXUDYabf1YjrY2b4ymq7stuD7x
        x89YiRUTjY25TNFMW+ifHPh1c288Y0+Jn1cyr4npml4aL9K9K71HJ+juORLMYQcfmNT1
        uycOtOyCr//DZ5JrM2mwyjFtNjc4Az9yU2yuN7tVel02JGN8si1wOCENP8yrFHBv/7AM
        lNF8Cq6Cj6nF7t89Q2xDGpc4sO5J0y3mGQA016yn8acyjdvZK9MxyGdKb3O6icooMxkG
        VUgQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDVCUXA0Jq+U="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v326bNfh2
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 2 Apr 2019 08:37:23 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190402053143.GZ2059@sirena.org.uk>
Date:   Tue, 2 Apr 2019 08:37:23 +0200
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com> <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com> <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com> <20190402053143.GZ2059@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 02.04.2019 um 07:31 schrieb Mark Brown <broonie@kernel.org>:
>=20
> It's relatively common, especially with older devices, for people to =
be
> perfectly happy to update the kernel and do so frequently but =
unwilling
> to update the bootloader as the procedure for recovering a broken
> bootloader is difficult or perhaps not even possible.

Yes, that is the case Linus tries to solve, where it is not even =
possible
to modify the DTB. No idea how it could be solved if it would not be
possible to change our 6 years old DTB.

Fortunately we do not need to change it at all with the latest check for
cs-gpios.

>=20
>> This also gives another idea: make it depend on "powerpc".
>=20
> That won't fly, the code has always been architecture neutral.

Ok. Just an idea.

>=20
>>> Dunno about this, it looks fragile, I would prefer to keep all =
working.
>>> But I will listen to reason.
>=20
>> Reason why I propose a CONFIG option is:
>=20
>> if someone is able to compile and deploy a v5.1 kernel for some =
device which
>> has (old) and problematic DTB in ROM he/she must have access to the =
.config.
>> So it is easy to modify it to enable legacy handling of spi-cs-high. =
And keep
>> it disabled for all others.
>=20
> This assumes people aren't able to run a distro kernel...

Yes, indeed.

I have learned from Linus that the problem with legacy spi-cs-high are =
mostly embedded
powerpc systems deployed between 2008 and 2013 where the boot-loader =
can't be
changed. And where the dts is not maintained on kernel.org.

IMHO it is very unlikely that they are running distro kernels. Or is =
there an example
of such a system?

BR and thanks,
Nikolaus

