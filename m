Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9784CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCED21E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8M+rsMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438708AbfJYJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:32:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36486 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391119AbfJYJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:32:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so1290360wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADyU6Z2jK9AB09XTZHkzM4lAgFm2hJZu/T4tVvjXP0k=;
        b=p8M+rsMRCp3qR+NJ+ga5tDRsMQt2LNF7f31NAxGStwzFOWOtwucaq0kEixpesIaFGZ
         mrPqlLsRN5sloxkLjNKeOCx5gLJ5YlzT4+8AbrB8LsGbyX0OfpWGRc8GsY6yGQOOkaE6
         kzMXangbfKtD8cPLj4kT4zugEkmR10BG/BgjZ2foLEIEkdAUJwGw+9y0lG4oEg92F5O3
         QuUX0kvL4bvR3JJcHIJIdbs0+73kbgOgxUy31uHIm4c07AJlFodMSTnUV8dzZZ717USk
         t478IPUrH5i71zfJSDeprb9VMvl1eeQkz73ZEZseaThXJifSYxr87QsG/CG/OEZEOxs8
         TYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADyU6Z2jK9AB09XTZHkzM4lAgFm2hJZu/T4tVvjXP0k=;
        b=GbYUcoYPIMQ2rbR/95vWRaR65glT5VaGOKXpnJmAdwJTB+DCNMTGeF5E10tw02Gm8C
         kD0bRnLJrw2pwDcXdR3pftr/0r1lt52jcTVpnE9/tbCaQg+AUmGBDEVwHF99CnwwlcRe
         1cmQqpP2/AMAFew5rSZAZz4hd6oFCJtPzAo9S6Wy+LZJQ30WPcRCYvX2QlGFHqaMD9ox
         T1CasYQLNY1kExKz1YdvEZRjWciM90+IxbD41AW6PbOH6otoSJv+JGX4+dHRyhygCfK2
         NWj8Ts1A124TKoIZUYr8wc47ZbzSiRwtHtjvI4WJWEI0Xag4MSfRTiq85YhH217swxhl
         VrTw==
X-Gm-Message-State: APjAAAUpu+G5qjItMyW9c08X1Sd1DjOhXj8MAzVK0fD30KTL/6sq/Wqn
        djeiJ145Q1etO6Xazajm2y3q/C0ZlbFMYNiLkpo=
X-Google-Smtp-Source: APXvYqyySz0PxXz2xAyzlk2juXTZP9vyRRfKp8BnRIMa40MXdj26AyuAa+ho3uMqrwviRYn0OVMg4Nm5/5/OyU08Whw=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr2352824wmi.123.1571995923093;
 Fri, 25 Oct 2019 02:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
 <20191025080129.GE32742@smile.fi.intel.com> <CAHtQpK7e-W9cGyCan=yxM7sSN=L_SKaFy8DSNE4vQGrc_pFdQw@mail.gmail.com>
 <20191025091430.GJ32742@smile.fi.intel.com>
In-Reply-To: <20191025091430.GJ32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 11:31:50 +0200
Message-ID: <CAHtQpK4r6ELeT78y8+hrYYDuuhqVx9Xj2=t=D+0X9UF_cOpYFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove regulator
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 25, 2019 at 10:58:05AM +0200, Andrey Zhizhikin wrote:
> > On Fri, Oct 25, 2019 at 10:01 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> > > > Add regulator driver for Intel Cherry Trail Whiskey Cove PMIC, which
> > > > supplies various voltage rails.
> > > >
> > > > This initial version supports only vsdio, which is required to source
> > > > vqmmc for sd card interface.
> > >
> > > This patch has some style issues. I will wait for Adrian and Hans to comment on
> > > the approach as a whole and then we will see how to improve the rest.
> >
> > Agreed, styling issues are coming from definition of CHT_WC_REGULATOR
> > elements in regulators_info array, and they are mainly related to 80
> > characters per line. I decided to leave it like this since it is more
> > readable. But if the 80 characters rule is to be enforced here - I can
> > go with something like this for every element:
> > CHT_WC_REGULATOR(V3P3A,    3000, 3350, 0x00, 0x07,\
> >                                      50, 0x01, 0x01, 0x0, true,  NULL),
>
> No, I'm not talking about these. Actually I hate this 80 limit in 21st century.
> But let's not discuss it right now.

I just ran a checkpatch and I think I know what you're referring to:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

In this case I really have to wait what others have to say, since I do
not know who and how the maintainer would be assigned.

>
> > Let's wait for other people's comments here and I can then come up
> > with v2 of this patch.
>
> Exactly!
>
> --
> With Best Regards,
> Andy Shevchenko
>

-- 
Regards,
Andrey.
