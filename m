Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04029C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C608C20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Jld3AIs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfDBMAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:00:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33936 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfDBMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554206434; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5+l1G83zpt2bbYC67iLKZX2+UVMUFINVU6uXjW3C4M=;
        b=Jld3AIs6KQfSLILQcdw69yR6RbdT4bsDmXEScKl7YBi2wIll48QtKR8AcmOMVgAHHhIFLI
        RCti1vVranAQ1c9sfmJPY11fZZxRQt7CLSQrKiooD4FLlXo8yZ7HsqCUJNd9VgcwPf9oTf
        DhRGO13CK1AbUIdE6+a4JCu4c4+hsN4=
Date:   Tue, 02 Apr 2019 14:00:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: linux-next: build failure after merge of the nand tree
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <1554206414.1199.0@crapouillou.net>
In-Reply-To: <20190402135631.38dcfe2a@xps13>
References: <20190402101431.6708cb70@canb.auug.org.au>
        <1554161512.10471.3@crapouillou.net> <20190402135631.38dcfe2a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Le mar. 2 avril 2019 =E0 13:56, Miquel Raynal=20
<miquel.raynal@bootlin.com> a =E9crit :
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net> wrote on Tue, 02 Apr 2019=20
> 01:31:52
> +0200:
>=20
>>  Hi Stephen,
>>=20
>>  Le mar. 2 avril 2019 =E0 1:14, Stephen Rothwell=20
>> <sfr@canb.auug.org.au> a =E9crit :
>>  > Hi all,
>>  >
>>  > After merging the nand tree, today's linux-next build (x86_64
>>  > allmodconfig) failed like this:
>>  >
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:26:5: error:=20
>> redefinition > of 'ingenic_ecc_calculate'
>>  >  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
>>  >      ^~~~~~~~~~~~~~~~~~~~~
>>  > In file included from=20
>> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: note: previous >=20
>> definition of 'ingenic_ecc_calculate' was here
>>  >  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
>>  >      ^~~~~~~~~~~~~~~~~~~~~
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:47:5: error:=20
>> redefinition > of 'ingenic_ecc_correct'
>>  >  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
>>  >      ^~~~~~~~~~~~~~~~~~~
>>  > In file included from=20
>> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: note: previous >=20
>> definition of 'ingenic_ecc_correct' was here
>>  >  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
>>  >      ^~~~~~~~~~~~~~~~~~~
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:93:21: error:=20
>> redefinition > of 'of_ingenic_ecc_get'
>>  >  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node=20
>> *of_node)
>>  >                      ^~~~~~~~~~~~~~~~~~
>>  > In file included from=20
>> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: note: previous=20
>> > definition of 'of_ingenic_ecc_get' was here
>>  >  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
>>  >                      ^~~~~~~~~~~~~~~~~~
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:119:6: error:=20
>> redefinition > of 'ingenic_ecc_release'
>>  >  void ingenic_ecc_release(struct ingenic_ecc *ecc)
>>  >       ^~~~~~~~~~~~~~~~~~~
>>  > In file included from=20
>> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
>>  > drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: note: previous >=20
>> definition of 'ingenic_ecc_release' was here
>>  >  void ingenic_ecc_release(struct ingenic_ecc *ecc)
>>  >       ^~~~~~~~~~~~~~~~~~~
>>  >
>>  > Caused by commit
>>  >
>>  >   8278ad0d709a ("mtd: rawnand: ingenic: Separate top-level and=20
>> SoC > specific code")
>>  >
>>  > I have used the nand tree from next-20190401 for today.
>>=20
>>  That makes no sense to me; from the offsets of the errors in the=20
>> ingenic_ecc.h
>>  file, it seems that CONFIG_MTD_NAND_INGENIC_ECC is not set, and in=20
>> this case
>>  ingenic_ecc.c should not be compiled at all.
>>=20
>=20
> I think
>=20
>         #ifdef FOO
>=20
> evaluates to true if
>=20
>         FOO=3Dy
>=20
> while we can have
>=20
>         FOO=3Dm
>=20
> which is evaluated to false, hence the double definition with
> allmodconfig.

That's good to know, I guess I'll have to start using IS_DEFINED()
from now on.

> Here is a diff solving the issue, if you are fine with it I will
> correct in-place and push -f nand/next for tomorrow's build.

That would be great.

Thanks!
-Paul

> ---8<---
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h=20
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> index d0486f963cc9..2cda439b5e11 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> @@ -25,7 +25,7 @@ struct ingenic_ecc_params {
>         int strength;
>  };
>=20
> -#ifdef CONFIG_MTD_NAND_INGENIC_ECC
> +#if IS_ENABLED(CONFIG_MTD_NAND_INGENIC_ECC)
>  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
>                           struct ingenic_ecc_params *params,
>                           const u8 *buf, u8 *ecc_code);
> --->8---
>=20
>=20
> Thanks,
> Miqu=E8l
>=20

=

