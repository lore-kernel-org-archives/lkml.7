Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E599C21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+HAYxss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503853AbfJYMAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:00:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409923AbfJYMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:00:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so1842896wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhHAdHsaOmL633PWB+Nv1shzHRTR1yQ6YiNmAxA5vZ0=;
        b=c+HAYxssJ6PmAichZwcofghRZRRfb4FXHmThSMVT18jqwxfH98y+ArRu2B2v81lO1b
         rAKP+Eij3RVSTBFtNNMSwr2CCaIIotMdQfx4XtS/EghtV2mDxqZt/sBAUYYZTDmY9Vvd
         ggD6H5htobsWbw22Imh87vdNeiRFjqgPnt0tJRUJJ0Fy/bp8uswnmR5Hy06uAaeulyZL
         HEHgT0knd3yfzPOYH3jWqzZCi7wQstYA10GvBYVADJo5O7x80cGLTytmIZdvDQVeRdA0
         jevbZifhvawJlFkXGMmZ/G8sJrextdLlW7M91txbhXPSxEXBPnOq8Pelw8bjIVcrr6/2
         s0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhHAdHsaOmL633PWB+Nv1shzHRTR1yQ6YiNmAxA5vZ0=;
        b=N3OdmJq/4o3jPpOJijsfVCC0Me9+TcwwEglr6DBXuvUTMQE93Y4Aj6Z1ww28iISjhx
         LfKqOXG8n5b/C4YsQitzs58PixfgdDPooa4yDKye1qDvWRHST2yLJmImjQbUM7l61xkW
         NcKLF3e/aHKxQDui8hDp6D7Z4e67R93tWAS/Yv67Lnt5bo65oxXurCRVa51vQPHnsiBa
         lUeRltJBXYw0xwID/unicOe0XVoigkmkFtTaaD2qtQyVI3rcCJZeOl5KkWQG2bnSYVgu
         rXas+X+COPONg+KPT/4AsMXPknniY7mXhw/rEr5GLUiwufedQbBhsIXIHPFU5/3ZfNhf
         dguA==
X-Gm-Message-State: APjAAAXlA2TRPrLzFF16uHr8+toPQtasDzUscQH6yRCjOuyIRFe97rt1
        /9ktmmRee6XP1iJSmplq251p+jWW9VOaQ6quqYQ=
X-Google-Smtp-Source: APXvYqz53WRnRzuRZle2h9/cd3RYP1HGa5S/+d6xQfKRmQmSIRqOEf2+ejx8NuH4glFtcf2jjdWIqZsCaCeFhOy8gv4=
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr2234228wmd.88.1572004832208;
 Fri, 25 Oct 2019 05:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com>
 <20191025080655.GF32742@smile.fi.intel.com> <CAHtQpK7P2X42WxZzok+XVZESV7O_JWK3Th7JMnMQsaq6f0gELw@mail.gmail.com>
 <20191025104925.GR32742@smile.fi.intel.com>
In-Reply-To: <20191025104925.GR32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 14:00:21 +0200
Message-ID: <CAHtQpK6OLkzSO_k6qv_Le3w8bSocwwZWiFSaOWLJLjDkVNSMCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: add regulator cell to Cherry Trail Whiskey Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 12:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 25, 2019 at 11:16:22AM +0200, Andrey Zhizhikin wrote:
> > On Fri, Oct 25, 2019 at 10:07 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 24, 2019 at 02:29:39PM +0000, Andrey Zhizhikin wrote:
> > > > Add a regulator mfd cell to Whiskey Cove PMIC driver, which is used to
> > > > supply various voltage rails.
> > > >
> > > > In addition, make the initialization of this mfd driver early enough in
> > > > order to provide regulator cell to mmc sub-system when it is initialized.
> > >
> > > Doesn't deferred probe mechanism work for you?
> > > MMC core returns that error till we have the driver initialized.
> >
> > This would work for mmc sub-system, but my idea was that later when
> > more cells are added to this mfd - it might turn out that we would
> > require an early initialization anyway. So I decided to take an
> > opportunity to adjust it with this patch as well, and this is what I
> > roughly explained in the commit message. When I'm reading it now,
> > exactly this point was not mentioned in commit message at all, and I
> > rather coupled the early init with mmc sub-system, which creates a
> > source of confusion here. I guess if there would be no other
> > objections about early init - I'd go with v2 of this patch, where I
> > would clean-up the point below and adjust the commit description.
> >
> > Thanks a lot for pointing this out!
>
> > > > -static struct i2c_driver cht_wc_driver = {
> > > > +static struct i2c_driver cht_wc_i2c_driver = {
> > >
> > > Renaming is not explained in the commit message.
> >
> > True, this point I forgot to mention. Actually, this is tightly
> > coupled with the fact that mfd driver has been moved to an earlier
> > init stage and since it does belong to I2C sub-system (and represented
> > by i2c_device structure) - I decided to make a name sound more
> > logical.
>
> So, seems you have three changes in one patch. Please, split accordingly.

Got it, thanks! Now I see it would be more logical to have 3 patches
in the following order:
- i2c driver renaming
- additional regulator cell
- early init

If you don't mind - I'd wait for other people to comment on this
patch, collect all points, and then come up with v2 of this patch (and
whole series in fact).

>
> In v2 also Cc all stakeholders I mentioned.

Would certainly do!

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Regards,
Andrey.
