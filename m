Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCo/hGgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391236AbfETRcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:32:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53312 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390654AbfETRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:32:04 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so342209ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xcLMbjckTZ6l/D4OPRbALZW9nrjKg92nkD4l8fduoc8=;
        b=uCo/hGgLQmhpZOrTu1shzmnvLf9unrWslOUc0OcezlzbX99EGVTuRJzR/Iw7BhYNTU
         ZyPo93KCrwffiZW2yUgcZ+axPm2p9kG+ZUIq/D+l7fEUodflNoSPliJsuaruEQABP2Jf
         zPrV6Ay+NjfwTljpnHMlgWSIdTgnlxA3U+/bsxgmEtaoMwp7t3031e3uJvm5pOBrA+TL
         kvvWYqUrNPjj0ERFdUpLVmv0l27hV0RRb+Z6fn6i2DrgUOApSvLm4GR37IV6AecBIcT2
         ThT6lWOIVV3NlUOHCWzjD0OWyeQGr1OpWaDJlyvPFsLulOdIj9YgEvIAYJBGTDAkep53
         YZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xcLMbjckTZ6l/D4OPRbALZW9nrjKg92nkD4l8fduoc8=;
        b=sNmB1+swJGaqNb6Hcp3nDWb0GWb7mFoS8WoTSBi5rDwJdai6QaP2M0HUSzjqU8qZj5
         Rf84G/MxyZLJgfc2r0SzE7/vF7J4vIc0LLhy2fHeAug4BbdJVFbujHW3E0k1hDcZL6vg
         PvSAvvVxwcY00nIkJoz6gOip4GMpK2m2SNY2t/wf8zyMdv9gPrQpLvaZY7qw5/qIEn2U
         rz6ysvjmpZRVBXFYqcew9XotcbZx/ntq4lJ9kK9V8/lbGKXLMxBCau1SneqoQ7IL8gUy
         O83KjX7vlMb/LyYk/xiy3ZYXa+jbwifK6foxXamJaK/ruY4pidFEvuV4IWpNNqwfbmSe
         zHPg==
X-Gm-Message-State: APjAAAVkLyUQczVU74hWaW3mX6CpW8W00G2EjUm4YC5tLiobhxsIF0oZ
        oYP/01kxQ/wZaGLTPAl/xrxw2226wSbSNNRWJMpk3A==
X-Google-Smtp-Source: APXvYqxMSSP1oqTIxbcg+oz1+JAy+IJiK1E3y1OXF4FdCTX/NR9OwpR5L0j8G7kuvH+21np1Zkbotqy/mL1jlYbEixw=
X-Received: by 2002:a24:6294:: with SMTP id d142mr184616itc.102.1558373523378;
 Mon, 20 May 2019 10:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
 <1558117914-35807-2-git-send-email-kdasu.kdev@gmail.com> <20190520144436.67e42f00@xps13>
In-Reply-To: <20190520144436.67e42f00@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 20 May 2019 13:31:52 -0400
Message-ID: <CAC=U0a0bZHgM2yQzz5SupRNWcBg7rpqpGh_o9cvSQNNKsSp9Cg@mail.gmail.com>
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

Will make the changes and send a V2 patch.

On Mon, May 20, 2019 at 8:44 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 May 2019 14:29:55
> -0400:
>
> > This change supports nand-ecc-step-size and nand-ecc-strenght fields in
>
>                                                        strength
>
> > brcmnand dt node to be  optional.
>
>            DT            ^ extra space
>
> > see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> >
> > If both nand-ecc-strength and nand-ecc-step-size are not specified in
> > device tree node for NAND, nand_base driver does detect onfi ext ecc
>
> s/nand_base driver/the raw NAND layer/
> s/onfi/ONFI/
> s/ecc/ECC/
>
> What is "ext"? Please use plain English here.
>
> > info from ONFI extended parameter page for parts using ONFI >=3D 2.1. I=
n
>
> s/info/information/
>
> > case of non-onfi NAND there could be a nand_id table entry with the ecc
>
> s/ecc/ECC/
>
> > info. If there is a valid  device tree entry for nand-ecc-strength and
> > nand-ecc-step-size fields it still shall override the detected values.
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index ce0b8ff..e967b30 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -2144,6 +2144,16 @@ static int brcmnand_setup_dev(struct brcmnand_ho=
st *host)
> >               return -EINVAL;
> >       }
> >
> > +     if (!(chip->ecc.size > 0 && chip->ecc.strength > 0) &&
>
> Is the case where only size OR strength is valid handled?

Both strength and need to be valid, else the driver will behave like
before and will fail the probe.

>
> > +         (chip->base.eccreq.strength > 0 &&
> > +          chip->base.eccreq.step_size > 0)) {
> > +             /* use detected ecc parameters */
>
>                    Use          ECC
>
> > +             chip->ecc.size =3D chip->base.eccreq.step_size;
> > +             chip->ecc.strength =3D chip->base.eccreq.strength;
> > +             pr_info("Using detected nand-ecc-step-size %d, nand-ecc-s=
trength %d\n",
> > +                     chip->ecc.size, chip->ecc.strength);
> > +     }
> > +
> >       switch (chip->ecc.size) {
> >       case 512:
> >               if (chip->ecc.algo =3D=3D NAND_ECC_HAMMING)
>
>
> Thanks,
> Miqu=C3=A8l

Kamal
