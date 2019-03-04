Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E277C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D8320663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QLrIUJGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCDS0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:26:18 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47208 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551723975; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKYMXddv8sOWyO8ziFgxyWSaKQEpPo4k2jXSN/BG3dI=;
        b=QLrIUJGKb06+ImxXzPaCvyfurdt1Z8g8RlCF//svkOvMC8Iotgil588hyyllTRftiIQ8dA
        0xcat6W6R+x4m/2S4wIdSyTf2W5ndlkJIZoO2kCN6ebUnVD7V2d8lkxuv7A5wAGKXZtISC
        d4h4r20n5fcS1cUxjwilckQqUtn48Gs=
Date:   Mon, 04 Mar 2019 19:26:08 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 6/9] mtd: rawnand: ingenic: Separate top-level and SoC
 specific code
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1551723968.4932.4@crapouillou.net>
In-Reply-To: <20190304112058.67cd5194@xps13>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-6-paul@crapouillou.net> <20190304112058.67cd5194@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 4, 2019 at 11:20 AM, Miquel Raynal=20
<miquel.raynal@bootlin.com> wrote:
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>>=20
> wrote on Sat,  9 Feb 2019 16:23:02
> -0300:
>=20
>>  The ingenic-nand driver uses an API provided by the jz4780-bch=20
>> driver.
>>  This makes it difficult to support other SoCs in the jz4780-bch=20
>> driver.
>>  To work around this, we separate the API functions from the=20
>> SoC-specific
>>  code, so that these API functions are SoC-agnostic.
>>=20
>=20
> I like the idea, actually I am working on this separation (see
> [1]) and I would really appreciate that you try to implement the
> interface when it will be available (v2 is coming this week, I think=20
> v3
> will be the one to test when raw NAND devices will be properly
> supported). I will add you in Cc: if you want to follow/review.
>=20
> [1]=20
> <http://lists.infradead.org/pipermail/linux-mtd/2019-February/087815.html=
>

Do you think this will be ready for 5.2?

You can add me in Cc:.

>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net=20
>> <mailto:paul@crapouillou.net>>
>>  ---
>>=20
>>  v2: Add an optional .probe() callback. It is used for instance to=20
>> set
>>      the clock rate in the JZ4780 backend.
>>=20
>>  v3: The common code is now inside the ingenic-ecc module. Each
>>      SoC-specific ECC code is now in its own module, which leaves to=20
>> the
>>      user the choice of which (if any) ECC code should be supported.
>>=20
>>  v4: No change
>>=20
>>   drivers/mtd/nand/raw/ingenic/Kconfig        |  17 +++
>>   drivers/mtd/nand/raw/ingenic/Makefile       |   5 +-
>>   drivers/mtd/nand/raw/ingenic/ingenic_ecc.c  | 157=20
>> +++++++++++++++++++++++++
>>   drivers/mtd/nand/raw/ingenic/ingenic_ecc.h  |  84 ++++++++++++++
>>   drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  38 +++----
>>   drivers/mtd/nand/raw/ingenic/jz4780_bch.c   | 170=20
>> +++++-----------------------
>>   drivers/mtd/nand/raw/ingenic/jz4780_bch.h   |  40 -------
>>   7 files changed, 308 insertions(+), 203 deletions(-)
>>   create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
>>   create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
>>   delete mode 100644 drivers/mtd/nand/raw/ingenic/jz4780_bch.h
>>=20
>=20
> [...]
>=20
>>  diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c=20
>> b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
>>  index 8c73f7c5be9a..0f51fd15fe79 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
>>  +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
>>  @@ -22,7 +22,7 @@
>>=20
>>   #include <linux/jz4780-nemc.h>
>>=20
>>  -#include "jz4780_bch.h"
>>  +#include "ingenic_ecc.h"
>>=20
>>   #define DRV_NAME	"ingenic-nand"
>>=20
>>  @@ -40,7 +40,7 @@ struct ingenic_nand_cs {
>>=20
>>   struct ingenic_nfc {
>>   	struct device *dev;
>>  -	struct jz4780_bch *bch;
>>  +	struct ingenic_ecc *ecc;
>>   	struct nand_controller controller;
>>   	unsigned int num_banks;
>>   	struct list_head chips;
>>  @@ -124,10 +124,10 @@ static int ingenic_nand_ecc_calculate(struct=20
>> nand_chip *chip, const u8 *dat,
>>   {
>>   	struct ingenic_nand *nand =3D to_ingenic_nand(nand_to_mtd(chip));
>>   	struct ingenic_nfc *nfc =3D to_ingenic_nfc(nand->chip.controller);
>>  -	struct jz4780_bch_params params;
>>  +	struct ingenic_ecc_params params;
>>=20
>>   	/*
>>  -	 * Don't need to generate the ECC when reading, BCH does it for=20
>> us as
>>  +	 * Don't need to generate the ECC when reading, ECC does it for=20
>> us as
>=20
> "the ECC engine does it for us" would be more meaningful.

OK.

>>   	 * part of decoding/correction.
>>   	 */
>>   	if (nand->reading)
>>  @@ -137,7 +137,7 @@ static int ingenic_nand_ecc_calculate(struct=20
>> nand_chip *chip, const u8 *dat,
>>   	params.bytes =3D nand->chip.ecc.bytes;
>>   	params.strength =3D nand->chip.ecc.strength;
>>=20
>>  -	return jz4780_bch_calculate(nfc->bch, &params, dat, ecc_code);
>>  +	return ingenic_ecc_calculate(nfc->ecc, &params, dat, ecc_code);
>>   }
>>=20
>=20
> Thanks,
> Miqu=E8l

=

