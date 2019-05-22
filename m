Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C02C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F20620863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VixhObCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfEVVfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:35:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42880 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfEVVfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:35:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so3899784wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB47ddRrKNWzkvlQMhShBURKZepRSv/MUuWiHjNrhfA=;
        b=VixhObCSPbWyKqLO1CMmQvg2SVLU6ChlVUtMUAF1lP4n2Nn4PM/AAenNz1sRbSWpvi
         bCb3FHCGyTmwCRzy88Je5DbLF4WfH6xMTHIObnbLMTnY0OCIEz4PuVNiPtMAw9e2CeHZ
         7aksMNx3MDFrvNGSh9hjfNT4ouy9uLzmHR8VeRyU4JKylcuW2ByOpdBFyFQjn61sDc2R
         AozjR1dBbvnGfPrZBw2r6TmGy3oTutj/hfw1NgfoHA7sLvp5PUuCNqE7k93J407Tg/EW
         HKT2THdPzBPRkizuRovFB+O+D1w+Tjn8WT+A7RMt278syNd2ag7WFBPAmRKeGbrrGlU2
         fzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB47ddRrKNWzkvlQMhShBURKZepRSv/MUuWiHjNrhfA=;
        b=E5nA/Y0ae3SlugvH5TqELm9szyn9baSjpalge+bU9+HERmN2JmO8Ozlm4FZzwWZvMV
         TZ0Ds3t+U+FI5LUPz7puxD/o3+oZiFHSeiRMlTFNDVwfKNreuGnRG2PzlUyXIY0+KhPM
         TNSF8vAiJWvR/Cnvy0ZgnAnuyqHYM/UXWrOlwQweL6dd9JnEMMcJOEcduWcl4nvqYoX3
         L4HDnh6fJWGK8Er9iieXb8eKkFcA33q1DJ0G0dEnAZmet3zIAI5iLGPKufAOEa2cw4VY
         iz/5hVF/70vXH25poTMrBH6tS/cl3HDhnX20BYYOiXtxQXdO0bz8MWikCQITRzCYOJ0F
         jt7w==
X-Gm-Message-State: APjAAAUAq3Xcx/+w5g0oYP+6uHqhCtFhT15KMMC/ZpysVoCDOg+aMcCX
        Kqyizqgbs1UqyGHF6FxKQl/Dw+47QP+/H66dDko=
X-Google-Smtp-Source: APXvYqz/54mDVZbKDP50tur8ClqpWHv3gxaKzRHbKKYmLEG/GgnlwoERxevEQsbttDHewjRiEY6hB88Em886jLOpcck=
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr44438901wrw.75.1558560929456;
 Wed, 22 May 2019 14:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
 <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
 <CAFLxGvy2c9KV1CyoFaD76jvThfPiotqfoeNchqjGcDp+uHie7Q@mail.gmail.com>
 <0c59bcd6c866429cb9727f787b7f61ce@svr-chch-ex1.atlnz.lc> <CAFLxGvwRnBtscaJDQ4qYGpQt87+amKYb4vBJvtt-3BmsOorL_g@mail.gmail.com>
In-Reply-To: <CAFLxGvwRnBtscaJDQ4qYGpQt87+amKYb4vBJvtt-3BmsOorL_g@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 22 May 2019 23:35:18 +0200
Message-ID: <CAFLxGvxGCKi1HH_7tit4ykQDJGm9t6Gt8pz7LTCZZ8G4J8sOhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:26 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Wed, May 22, 2019 at 11:06 PM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >
> > On 23/05/19 8:44 AM, Richard Weinberger wrote:
> > > On Wed, May 22, 2019 at 2:08 AM Chris Packham
> > > <chris.packham@alliedtelesis.co.nz> wrote:
> > >>
> > >> Add an implementation of the _is_locked operation for concatenated mtd
> > >> devices. As with concat_lock/concat_unlock this can simply use the
> > >> common helper and pass mtd_is_locked as the operation.
> > >>
> > >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > >> ---
> > >>   drivers/mtd/mtdconcat.c | 6 ++++++
> > >>   1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> > >> index 9514cd2db63c..0e919f3423af 100644
> > >> --- a/drivers/mtd/mtdconcat.c
> > >> +++ b/drivers/mtd/mtdconcat.c
> > >> @@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> > >>          return __concat_xxlock(mtd, ofs, len, mtd_unlock);
> > >>   }
> > >>
> > >> +static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> > >> +{
> > >> +       return __concat_xxlock(mtd, ofs, len, mtd_is_locked);
> > >> +}
> > >
> > > Hmm, here you start abusing your own new API. :(
> >
> > Abusing because xxlock is a poor choice of name? I initially had a third
> > copy of the logic from lock/unlock which is what lead me to do the
> > cleanup first. mtd_lock(), mtd_unlock() and mtd_is_locked() all work the
> > same way namely given an offset and a length either lock, unlock or
> > return the status of the len/erasesz blocks at ofs.
>
> Well, for unlock/lock it is just a loop which applies an operation to
> a given range on all submtds.
> But as soon an operation returns non-zero, the loop stops and returns
> that error.
> This makes sense for unlock/lock.
>
> Now you abuse this as "apply a random mtd operation to a given range".
> So, giving it a proper name is the first step. Step two is figuring
> for what kind
> of mtd operations it makes sense and is correct.
>
> > >
> > > Did you verify that the unlock/lock-functions deal correctly with all
> > > semantics from mtd_is_locked?
> > > i.e. mtd_is_locked() with len = 0 returns 1 for spi-nor.
> > >
> >
> > I believe so. I've only got access to a parallel NOR flash system that
> > uses concatenation and that seems sane  (is mtdconcat able to work with
> > spi memories?). The concat_is_locked() should just reflect what the
> > underlying mtd device driver returns.
>
> mtdconcat *should* work with any mtd. But I never used it much, I see
> it more as legacy
> code.
>
> What happens if one submtd is locked and another not?
> Does concat_is_locked() return something sane then?
> I'd expect it to return true if at least one submtd is locked and 0
> of no submtd is locked.

BTW: Meant overlapping requests. If it targets always only one submtd,
it is easy.

-- 
Thanks,
//richard
