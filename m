Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27539C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B1206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6gZFxSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfETRvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:51:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37313 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfETRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:51:31 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so11745842ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CzknmS3algkOP4TKdwdGkF2v7Kn89/q/nMaTVG+rIi8=;
        b=b6gZFxSgX7BPxz6wATO5y49g6szkHUt8pyyQn+7XD7mrpu3cNB6yoRVVd3CQvBlLUD
         13e0jpbks5gt4rufx6DheFuvjKy6fqoLQe5k+i4NbPXAmU7Py5WTPjzKm3Ye/gfqqtbO
         IBI1sOcKPkonTGXIdjCADvDpfHTxuG9IzltrrfuTy0D89/1OXk+OJrZL1VGuqvaTb4vX
         5rl9WKSNT+8OV+7pLttFS9HM5InfGbkOBtqtl67aozzNhRveetBT1WVIZVWEmOs/32gF
         6fURxoruuPRoibbX8YGJss+ZvWeXxGX45ycH3oJyLFWWDdknweY+owdP0ToMVDLUOI2m
         ndiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CzknmS3algkOP4TKdwdGkF2v7Kn89/q/nMaTVG+rIi8=;
        b=K/NI2c2RuUvt1rhsEdgGYPKVfCMSBzU1QE2a4yC0H3fbW0cJpa5/pTw4BswFVAuyU7
         L5vop8iEzMoscUxF6VPJC2wgb9sXXMKRWfk1m7TuQU9wtTwglhVlfHhbR4moG0FfEZMf
         Q3yCeXcTR37vxjoKnrlteyT1OtnKtEnNlGUB+TDAjuPyest9v/2eh38+/L56h1Z+9Qzp
         ww+vHlIPaoeTNmzkS9bFtbidXhakpFiCnaGw2LcnntlnIxb39PVBnOyyntIP519GV1if
         avnH1A9beQTUD48pNqaKNUcAVXxFGh7Y4I/9l4qCVzoqa5K+9hoGNjuQZ2xegorpKSkT
         f1Pw==
X-Gm-Message-State: APjAAAUSLpyTWht4NfgoqlQy41yYOcW1xoet+m8lgWD9aVBohXZGAS8b
        J3AZSZ6PSeLw8hWU6EXPS/Q3p8IVT0DtNg6uz3c=
X-Google-Smtp-Source: APXvYqz7OWSIRs2P8CsvaRzfpmv3wagFOUsv/KaVjSLxn86WbbTrU/Nn8C3++YXXQ4BxT3Hh/t66bF6WSl6xDtqiedY=
X-Received: by 2002:a6b:3b88:: with SMTP id i130mr26971762ioa.21.1558374690717;
 Mon, 20 May 2019 10:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
 <1558117914-35807-2-git-send-email-kdasu.kdev@gmail.com> <20190520144436.67e42f00@xps13>
 <CAC=U0a0bZHgM2yQzz5SupRNWcBg7rpqpGh_o9cvSQNNKsSp9Cg@mail.gmail.com> <20190520193432.79cf132f@xps13>
In-Reply-To: <20190520193432.79cf132f@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 20 May 2019 13:51:19 -0400
Message-ID: <CAC=U0a2NzK_BS27eGd6i2f8sBxOsEYdg1ZdQNfmf7G3Tdo7bJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: brcmnand: fallback to detected
 ecc-strength, ecc-step-size
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:34 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 20 May 2019 13:31:52
> -0400:
>
> > Will make the changes and send a V2 patch.
> >
> > On Mon, May 20, 2019 at 8:44 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Kamal,
> > >
> > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 May 2019 14:29:55
> > > -0400:
> > >
> > > > This change supports nand-ecc-step-size and nand-ecc-strenght field=
s in
> > >
> > >                                                        strength
> > >
> > > > brcmnand dt node to be  optional.
> > >
> > >            DT            ^ extra space
> > >
> > > > see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > > >
> > > > If both nand-ecc-strength and nand-ecc-step-size are not specified =
in
> > > > device tree node for NAND, nand_base driver does detect onfi ext ec=
c
> > >
> > > s/nand_base driver/the raw NAND layer/
> > > s/onfi/ONFI/
> > > s/ecc/ECC/
> > >
> > > What is "ext"? Please use plain English here.
> > >
> > > > info from ONFI extended parameter page for parts using ONFI >=3D 2.=
1. In
> > >
> > > s/info/information/
> > >
> > > > case of non-onfi NAND there could be a nand_id table entry with the=
 ecc
> > >
> > > s/ecc/ECC/
> > >
> > > > info. If there is a valid  device tree entry for nand-ecc-strength =
and
> > > > nand-ecc-step-size fields it still shall override the detected valu=
es.
> > > >
> > > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > > ---
> > > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd=
/nand/raw/brcmnand/brcmnand.c
> > > > index ce0b8ff..e967b30 100644
> > > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > @@ -2144,6 +2144,16 @@ static int brcmnand_setup_dev(struct brcmnan=
d_host *host)
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > +     if (!(chip->ecc.size > 0 && chip->ecc.strength > 0) &&
> > >
> > > Is the case where only size OR strength is valid handled?
> >
> > Both strength and need to be valid, else the driver will behave like
> > before and will fail the probe.
>
> Yes, but you do not handle the case when either strength OR size is not
> valid but the other one is. Is it one purpose?
>

If I understand you want me to use the following check:

if (ecc->mode !=3D NAND_ECC_NONE && (!ecc->size || !ecc->strength)) {
if (chip->base.eccreq.step_size && chip->base.eccreq.strength) {
     /* use the base values */
}

> >
> > >
> > > > +         (chip->base.eccreq.strength > 0 &&
> > > > +          chip->base.eccreq.step_size > 0)) {
> > > > +             /* use detected ecc parameters */
> > >
> > >                    Use          ECC
> > >
> > > > +             chip->ecc.size =3D chip->base.eccreq.step_size;
> > > > +             chip->ecc.strength =3D chip->base.eccreq.strength;
> > > > +             pr_info("Using detected nand-ecc-step-size %d, nand-e=
cc-strength %d\n",
> > > > +                     chip->ecc.size, chip->ecc.strength);
> > > > +     }
> > > > +
> > > >       switch (chip->ecc.size) {
> > > >       case 512:
> > > >               if (chip->ecc.algo =3D=3D NAND_ECC_HAMMING)
> > >
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Kamal
>
>
>
>
> Thanks,
> Miqu=C3=A8l

Kamal
