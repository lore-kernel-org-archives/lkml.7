Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411952171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AsAMNnYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCMMqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:46:48 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50212 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552481204; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpLx8TDEbAzhN6basKpnA1clLFtf8oKedyNixevNEl4=;
        b=AsAMNnYg9hFu6/ZWA2ftTABrJ7yE3lPPuKrWyNoZUT3qyDtVbGw37FHk459sfGKeQ8Ezfk
        r8SZYRuwJ0S+EiIPp/cPPzK0QWstHWf5L3W4T3XAVbqDntq5hnkioqPVFQmVgvjlUnafBb
        9nTWBVnSSVGvjLIAZh3BB5AWEEx7iBM=
Date:   Wed, 13 Mar 2019 09:46:40 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 8/9] mtd: rawnand: ingenic: Add support for the JZ4725B
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
Message-Id: <1552481200.2412.0@crapouillou.net>
In-Reply-To: <20190304200947.69237b05@xps13>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-8-paul@crapouillou.net> <20190304113519.2e102b25@xps13>
        <1551724204.4932.6@crapouillou.net> <20190304200947.69237b05@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Le lun. 4 mars 2019 =E0 16:09, Miquel Raynal <miquel.raynal@bootlin.com>=20
a =E9crit :
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019=20
> 19:30:04
> +0100:
>=20
>>  On Mon, Mar 4, 2019 at 11:35 AM, Miquel Raynal=20
>> <miquel.raynal@bootlin.com> wrote:
>>  > Hi Paul,
>>  >
>>  > Paul Cercueil <paul@crapouillou.net=20
>> <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:23:04
>>  > -0300:
>>  >
>>  >>  The boot ROM of the JZ4725B SoC expects a specific OOB layout=20
>> on the
>>  >>  NAND, so we use it unconditionally in the ingenic-nand driver.
>>  >> >>  Also add the jz4725b-bch driver to support the=20
>> JZ4725B-specific BCH
>>  >>  hardware.
>>  >> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net >>=20
>> <mailto:paul@crapouillou.net>>
>>  >>  ---
>>  >> >>  Changes:
>>  >> >>  v2: Instead of forcing the OOB layout, leave it to the board=20
>> code or
>>  >>      devicetree to decide if the jz4725b-specific layout should=20
>> be >> used
>>  >>      or not.
>>  >> >>  v3: - Revert the change in v2, as the previous behaviour was=20
>> >> correct.
>>  >>      - Also add support for the hardware BCH of the JZ4725B in=20
>> this
>>  >>        patch.
>>  >> >>  v4: - Add MODULE_* macros
>>  >>      - Add tweaks suggested by upstream feedback
>>  >> >>   drivers/mtd/nand/raw/ingenic/Kconfig        |  10 +
>>  >>   drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
>>  >>   drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 ++++-
>>  >>   drivers/mtd/nand/raw/ingenic/jz4725b_bch.c  | 292 >>=20
>> ++++++++++++++++++++++++++++
>>  >>   4 files changed, 350 insertions(+), 1 deletion(-)
>>  >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
>>  >> >
>>  > [...]
>>  >
>>  >>  +static int jz4725b_calculate(struct ingenic_ecc *bch,
>>  >>  +			     struct ingenic_ecc_params *params,
>>  >>  +			     const u8 *buf, u8 *ecc_code)
>>  >>  +{
>>  >>  +	int ret;
>>  >>  +
>>  >>  +	mutex_lock(&bch->lock);
>>  >>  +	ret =3D jz4725b_bch_init(bch, params, true);
>>  >
>>  > I really don't like this bch_init name. A BCH initialization is=20
>> what > is
>>  > supposed to be done only once (probably at boot time), can you=20
>> find a
>>  > better name or a better organization of the correct/calculate=20
>> path?
>>=20
>>  jz4725b_bch_setup() maybe?
>=20
> Unless I am not understanding what this does, I don't get why you=20
> would
> need to do this setup everytime you want to use the ECC engine. Are=20
> you
> sure this is needed?

It configures the hardware for a new ECC encoding or decoding sequence,=20
so
yes, it has to be done everytime.

-Paul
=

