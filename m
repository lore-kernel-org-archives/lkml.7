Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F59C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1A2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HvfwSa7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEATPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:15:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37470 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEATPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:15:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id b12so27060lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lN/T7u/Fwv/EZb1xnNEtQOimSnN0fKeQ0FgHDhL5cBA=;
        b=HvfwSa7BpGPqmfwAzZ8rcwbDFlwJ4hpWrUJPUJsE3eFt11Goqpt/1vRLjP3ywENTuY
         dHU3/RLqF3UuRqIzs9xTtBjXGT8I4/ZoBAqOCvP3p2tk3ZFfaLdIevoAP1l8HEodf3iR
         PHCme2zGJAitP3pVoN3U2mC3yMFKw/yYOtzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lN/T7u/Fwv/EZb1xnNEtQOimSnN0fKeQ0FgHDhL5cBA=;
        b=oX4uxWDS2lp3wFK5GTbf6oSbqxR3tAY4SmJStUvvYZnNomDn9YdLXdH2B5yDEuLKtX
         h5C57X/77yXELpD5JCy0hxmxy8eaa/DojMj2tRtNWDVjMtsE89Nt6/CxE4Lj/pzQyz6N
         emE0/tK0TFk/w/+wHpdeeD2+QPevixswpWz9AwjdiaQgdYNDlgGWUFMbU/YKxObNmRe8
         KzCPyox8bWmTUb6ZkJrrRtjUYSfMd/rOKnoBlElGeeyGLFsks80EIYdeFbberS7GDGig
         JUSZ7nwTXleTiuLXYUrkDMMlAnM5uApIGMZdjVlh4fVf8KWKcwf+gRJdn6rzc1f8GslH
         vNlw==
X-Gm-Message-State: APjAAAXf9REIeg8rKxvY1jLFl6U/Y1KQhFc+bcvn+9h8rTuULwRTjPri
        DWLCwJ02YeGu5XRZva4aE+RTxVdK3TEc/AiGUhaauw==
X-Google-Smtp-Source: APXvYqyWGF2NMYI9BPDRGBc0+XeTHClGa9e/p6VaS1O+iWmSKYioFVks55J90nFQb5uomXM+1AtzGfJ8x74N1uVJ3YQ=
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr8422799ljk.172.1556738136636;
 Wed, 01 May 2019 12:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <1556306615-37990-1-git-send-email-kdasu.kdev@gmail.com> <8e1b5dd6-3f8d-9288-7c43-5d7650269397@gmail.com>
In-Reply-To: <8e1b5dd6-3f8d-9288-7c43-5d7650269397@gmail.com>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Wed, 1 May 2019 15:15:00 -0400
Message-ID: <CAKekbeux0To7EEDYa=6YHaPrE_p95i812qxi6hcanN2guX6mKg@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: brcmnand: fix bch ecc layout for large page nand
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 2:35 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 4/26/19 12:22 PM, Kamal Dasu wrote:
> > The oobregion->offset for large page nand parts was wrong, change
> > fixes this error in calculation.
>
> Should this have a Fixes tag so this can be backported to stable trees
> seemingly automatically? Thanks!
>

The brcmnand files got moved, however should have the fixes tag, will
send V2 patch.

> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > index 482c6f0..3eefea7 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -939,7 +939,7 @@ static int brcmnand_bch_ooblayout_ecc(struct mtd_info *mtd, int section,
> >       if (section >= sectors)
> >               return -ERANGE;
> >
> > -     oobregion->offset = (section * (sas + 1)) - chip->ecc.bytes;
> > +     oobregion->offset = ((section + 1) * sas) - chip->ecc.bytes;
> >       oobregion->length = chip->ecc.bytes;
> >
> >       return 0;
> >
>
>
> --
> Florian
