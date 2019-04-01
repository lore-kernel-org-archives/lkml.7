Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58420C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9FE2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="kH+6R8Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDAXb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:31:59 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54410 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554161516; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vb2e2bokFLv0ZFcLQiHkpZaLu5RHD+rz7qIDSO9F10E=;
        b=kH+6R8Ll0HpaZX7Mm+gOxdiNpwPxEhEGkSRv5wcSFdX+VjUOoeyLno3IazpC6TlO8j0Hwf
        e1JyVomq0Vyx+hwTQUcIA9q+UNe9zcDELfWPQNT2yoK9B8IZ/FL+Er2WzHRgDOWER0pH91
        FI9uNUZNiIhZ0Ff0e3PSwK6WTf+ZJzA=
Date:   Tue, 02 Apr 2019 01:31:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: linux-next: build failure after merge of the nand tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <1554161512.10471.3@crapouillou.net>
In-Reply-To: <20190402101431.6708cb70@canb.auug.org.au>
References: <20190402101431.6708cb70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le mar. 2 avril 2019 =E0 1:14, Stephen Rothwell <sfr@canb.auug.org.au> a=20
=E9crit :
> Hi all,
>=20
> After merging the nand tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:26:5: error: redefinition=20
> of 'ingenic_ecc_calculate'
>  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
>      ^~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: note: previous=20
> definition of 'ingenic_ecc_calculate' was here
>  int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
>      ^~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:47:5: error: redefinition=20
> of 'ingenic_ecc_correct'
>  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
>      ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: note: previous=20
> definition of 'ingenic_ecc_correct' was here
>  int ingenic_ecc_correct(struct ingenic_ecc *ecc,
>      ^~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:93:21: error: redefinition=20
> of 'of_ingenic_ecc_get'
>  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *of_node)
>                      ^~~~~~~~~~~~~~~~~~
> In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: note: previous=20
> definition of 'of_ingenic_ecc_get' was here
>  struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
>                      ^~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:119:6: error: redefinition=20
> of 'ingenic_ecc_release'
>  void ingenic_ecc_release(struct ingenic_ecc *ecc)
>       ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: note: previous=20
> definition of 'ingenic_ecc_release' was here
>  void ingenic_ecc_release(struct ingenic_ecc *ecc)
>       ^~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   8278ad0d709a ("mtd: rawnand: ingenic: Separate top-level and SoC=20
> specific code")
>=20
> I have used the nand tree from next-20190401 for today.

That makes no sense to me; from the offsets of the errors in the=20
ingenic_ecc.h
file, it seems that CONFIG_MTD_NAND_INGENIC_ECC is not set, and in this=20
case
ingenic_ecc.c should not be compiled at all.

-Paul

=

