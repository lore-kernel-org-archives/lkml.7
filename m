Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03256CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A582070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/9hunm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505598AbfJYQVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:21:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505349AbfJYQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:21:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so2593214wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRe/VJkh6D1luCxouiqp32mJabv36hi1AArq7g56blc=;
        b=A/9hunm6K9dVRdWwPoXf6v4RE8kYk4+IFpHd8TcungJpmsieHl/196qLOhKqGE5nr+
         0mm6q65T6u162FfWyR4IoOKdfG8jROcx6UDB4H7O215wH3CeF8eZ7IV+zpu4TojyYABK
         Te+AG869H08CsPBaV9qkbUL+gQO0nYm0l5MPYqJtBF/0Wr6ZAoASbBVW4pM3T8QYqMYM
         77BMYztJEQYUVcZJbUWHCwMap4/4Q8j00Hd5qNGEgVuJAujpUpo/Ryq/aoTk9wJVriKM
         g6XwhrG7+b6Pi8wrqnIcBcAmmm3CGqLviaf7mo+wLpb79Jdm9MFvMpwODYSLyzFySmSA
         1/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRe/VJkh6D1luCxouiqp32mJabv36hi1AArq7g56blc=;
        b=d8Z5XdGkSTj919GTGvrqM/EKW5D7RjbVi7bDIR8XKAUip5lzuDHihCDi7SlraMgZRG
         OMzug6v5JMmv3f/m9h1ZWqM2KcqiQGLKWX8TWqIVoYhWr+CM+R30M2tGu2UNs+4/s339
         IZ534tC95XNIatgFJjRbAh6+GPleK35VRvHZmPNVoOIzJ/AQxvJ7WQj/p+2dr1klchXw
         tWddj3Gx+ylTobTAg5Gm/PRn5ZcBvTW99OT2P5F1W/+P5UeRQgDkDVm7+Op1IBaxN68Q
         EyxlIW4srQiYKToJSuZb7Khx9ra+5U5PZvyh/DRx+ANjlfyJXL1YbSc5npAt5BZhDbFT
         EskA==
X-Gm-Message-State: APjAAAWB/wZRqcsTQqDU3+oZPizQa/Iq9RCZnXPUxJntEAo+Xrw6+tgi
        vYNd/j0pZJys73JoB5KOqFDooLOPjLckbht62QA=
X-Google-Smtp-Source: APXvYqzIHcUQAVHMlv2MA6G5in/xBhepeKFD4DVXlyQXF7s6ZneNn5mc7FDAOKdlU/SSSx1fP81B6HRIvBinwB3r2T8=
X-Received: by 2002:a1c:f212:: with SMTP id s18mr4117785wmc.72.1572020500514;
 Fri, 25 Oct 2019 09:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
 <20191025121737.GC4568@sirena.org.uk> <CAHtQpK60d_GT4JMBBwGc2q1FqVT7NNhK5T7rSY0GL288ukUc1A@mail.gmail.com>
 <20191025160242.GE32742@smile.fi.intel.com>
In-Reply-To: <20191025160242.GE32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 18:21:29 +0200
Message-ID: <CAHtQpK7-KRR8+U_AZwrLEOKMeqtFc-gSbd28x0OPtApQJ5jCPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove regulator
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 6:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 25, 2019 at 05:26:56PM +0200, Andrey Zhizhikin wrote:
> > On Fri, Oct 25, 2019 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Fri, Oct 25, 2019 at 03:55:17PM +0200, Andrey Zhizhikin wrote:
> > > > On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
> > > > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> > >
> > > Please don't take things off-list unless there is a really strong reason
> > > to do so.  Sending things to the list ensures that everyone gets a
> > > chance to read and comment on things.  (From some of the things
> > > in your mail I think this might've been unintentional.)
>
> > Sorry for mess, sometimes it happens but I try not to create it...
>
> Script nodded... :)

Point taken! :)

>
> > On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
>
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * intel-cht-wc-regulator.c - CherryTrail regulator driver
> > > > + *
> > >
> > > Please use C++ style for the entire comment so things look more
> > > consistent.
> >
> > This is what I'm puzzled about - which style to use for the file
> > header since the introduction of SPDX and a rule that it should be
> > "C++ style" commented for source files and "C style" for header files.
> > After this introduction, should the more-or-less standard header be
> > also done in C++ style? I saw different source files are doing
> > different things... But all-in-all I would follow you advise here with
> > converting entire block to C++.
> >
> > [Mark]: The only thing SPDX cares about is the first line, the making
> > the rest of the block a C++ one is mostly a preference I have.
> >
> > Got it, would be done!
>
> Also remove the file name(s) from file(s). If we would ever rename the file,
> its name will be additional churn inside file (or often being forgotten).

OK, would use this pattern for all my future work now.

>
> > > Is this really a limitation of the *regulator* or is it a
> > > limitation of the consumer?  The combination of the way this is
> > > written and the register layout makes it look like it's a
> > > consumer limitation in which case leave it up to the consumer to
> > > figure out what constraints it has.
> >
> > This is a tricky point. Since there is no datasheet available from
>
> Key word "publicly".
>
> I may look for it some like in November and perhaps be able to answer to
> (some) questions.

That would be really great! The main point that needs to be clarified
at this moment is about voltages provided by vsdio cell, and if it
safe to include all of them all in the vsel table.

>
> > Intel on this IP - I went with a safe option of taking this part from
> > original Intel patch, which they did for Aero board as the range was
> > described there in exactly this way.
>
> > > This *definitely* appears to be board specific configuration and
> > > should be defined for the board.
> >
> > Above those two points above: I totally agree this is not the
> > regulator configuration but rather a specific board one. The only
> > thing I was not able to locate is a correct board file to put this
> > into.
>
> See below.
>
> > Maybe you or Hans can guide me here on where to have this code as best?
> >
> > [Mark]: I *think* drivers/platform/x86 might be what you're looking
> > for but I'm not super familiar with x86.  There's also
> > arch/x86/platform but I think they're also trying to push things out
> > of arch/.
>
> It's more likely drivers/acpi/acpi_lpss.c.

Thanks for the hint, I'd definitely would have a look at it!

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Regards,
Andrey.
