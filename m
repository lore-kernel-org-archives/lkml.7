Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D50C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A462083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pyZPyavb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfF1TxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:53:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56288 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfF1TxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561751593; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXThYP6vEL2CRlY5WzupI6gQ/RhO4QbnhM+KuTasqDo=;
        b=pyZPyavbwN58kLdm306KC9LokVom5Rwg+HfXnbKM4U+Qp1NK5uBplbXFQrcbrxoIFXpx5B
        1QnngrkGcFjVdjkniE1o7QWhhFrbphNSUZD56up0p2qrEi1jQ53w3Ws/4l+HeAbsE0P8IY
        ZuzzYoBN6I9kg7PGYG+r0EFBwh5hb5I=
Date:   Fri, 28 Jun 2019 21:53:08 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <1561751588.1914.0@crapouillou.net>
In-Reply-To: <20190627184047.6faa058a@xps13>
References: <20190617111110.2103786-1-arnd@arndb.de>
        <1560770644.1774.0@crapouillou.net>
        <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
        <20190617141659.376c0271@xps13> <20190627184047.6faa058a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 27 juin 2019 =E0 18:40, Miquel Raynal=20
<miquel.raynal@bootlin.com> a =E9crit :
> Hi Paul,
>=20
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 17 Jun 2019
> 14:16:59 +0200:
>=20
>>  Hello,
>>=20
>>  Arnd Bergmann <arnd@arndb.de> wrote on Mon, 17 Jun 2019 14:12:48=20
>> +0200:
>>=20
>>  > On Mon, Jun 17, 2019 at 1:24 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>  >
>>  > > I think there's a better way to fix it, only in Kconfig.
>>  > >
>>  > > * Add a bool symbol MTD_NAND_INGENIC_USE_HW_ECC
>>  > > * Have the three ECC/BCH drivers select this symbol instead of
>>  > >   MTD_NAND_INGENIC_ECC
>>  > > * Add the following to the MTD_NAND_JZ4780 config option:
>>  > >   "select MTD_NAND_INGENIC_ECC if MTD_NAND_INGENIC_USE_HW_ECC"
>>  >
>>  > I don't see much difference to my approach here, but if you want
>>  > to submit that version with 'Reported-by: Arnd Bergmann=20
>> <arnd@arndb.de>',
>>  > please do so.
>>  >
>>  > Yet another option would be to use Makefile code to link both
>>  > files into one module, and remove the EXPORT_SYMBOL statements:
>>  >
>>  > obj-$(CONFIG_MTD_NAND_JZ4780) +=3D jz4780_nand.o
>>  > jz4780_nand-y +=3D ingenic_nand.o
>>  > jz4780_nand-$(CONFIG_MTD_NAND_INGENIC_ECC) +=3D ingenic_ecc.o
>>  >
>>=20
>>  I personally have a preference for this one.
>=20
> Would you mind sending the above change? I forgot about it but I would
> like to queue it for the next release. Preferably the last version=20
> Arnd
> proposed.

It does change the module name from 'ingenic_nand' to 'jz4780_nand',=20
though.
That's not really ideal...

>=20
> Thanks,
> Miqu=E8l

=

