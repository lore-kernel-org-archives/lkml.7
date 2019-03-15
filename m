Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45126C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B521871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UqSqjLCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfCOOhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:37:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43348 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfCOOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552660659; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6kOoG2l+4ZryPRZR9ndkiXXIfexV8a+h0H/nuKIaCA=;
        b=UqSqjLCH3KFngrfrL7sxgCDgwqBGU4aCUf35U4asZHexA4sDjveEv1hi02SD80tJqSSOPn
        wuT4qP5iPeNL2g7B6gHRsdpurZ1W8U3Wo1QDa8xLH3ArPx/d+OkRxo6du4mKldiwvovzAo
        FWl2dzQSrh6pm5pMuZ1dJY+vXgb0M88=
Date:   Fri, 15 Mar 2019 15:37:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 09/12] mtd: rawnand: ingenic: Make use of ecc-engine
 property
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1552660654.1727.0@crapouillou.net>
In-Reply-To: <20190315094009.66b91ad5@xps13>
References: <20190313222259.28704-1-paul@crapouillou.net>
        <20190313222259.28704-9-paul@crapouillou.net>
        <20190315094009.66b91ad5@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 15 mars 2019 =E0 9:40, Miquel Raynal <miquel.raynal@bootlin.com>=20
a =E9crit :
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net> wrote on Wed, 13 Mar 2019=20
> 23:22:56
> +0100:
>=20
>>  Use the 'ecc-engine' standard property instead of the custom
>>  'ingenic,bch-controller' custom property, which is now deprecated.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v5: New patch
>>=20
>>   drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c=20
>> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
>>  index d7f3a8c3abea..30436ca6628a 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
>>  +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
>>  @@ -82,9 +82,9 @@ static struct ingenic_ecc *ingenic_ecc_get(struct=20
>> device_node *np)
>>=20
>>   /**
>>    * of_ingenic_ecc_get() - get the ECC controller from a DT node
>>  - * @of_node: the node that contains a bch-controller property.
>>  + * @of_node: the node that contains a ecc-engine property.
>=20
> Would "contains an ecc-engine property" be better English?
>=20
> I am not sure what is the rule when it comes to plain English with
> variable names. However if you agree, no need to re-send the series, I
> can fix it when applying.

Yes, that's better.

> BTW, I added hw ECC engines support to my generic ECC engine
> implementation, but migrating the whole raw NAND subsystem (using I/O
> requests like in the SPI-NAND core, adding prepare/finish_io_req=20
> hooks)
> is going to be much more invasive than initially expected, so I am not
> sure I will finish the migration any time soon.

Ok, I will follow the development then.

> Thanks,
> Miqu=E8l

One thing I notice with my patchset: it works perfectly on top of 4.20,
but on top of 5.0 I am unable to erase any eraseblock with flash_erase.
I get -EIO every time. I'm trying to debug it but didn't go very far,
it looks like nand_status_op() gives me a status of 0xff. Do you know
what could have changed between 4.20 and 5.0 that could trigger this=20
bug?

Second thing, everytime I reboot it fails to find the BBT. That's=20
because
the BBT marker is overwritten by the ECC data as they occupy the same=20
area
in the OOB space. Is there a way to move the BBT marker? Or should I use
NAND_BBT_NO_OOB then? Since the eraseblocks where the BBTs are located
is used in my system partition, won't that conflict with the data?

Thanks,
-Paul
=

