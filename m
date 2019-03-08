Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ABAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B32820643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BGPtMK0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCHWej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:34:39 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38393 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCHWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:34:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id h132so7597111vsd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9URJUprKYok9DoDJJ1KQjX0JlJiDVTfA7y6V233RllA=;
        b=BGPtMK0hfmUPWZmPiH4Qqa39rLNoVnmGeDcSCddfwEatoPVyERhOcENk1DM4fG6aik
         1Qm+086QA5Q1oQkG4EXQ8FQGspczCrIuE/vgXH8OnIUoQudzuMW4jCjKyLAQxZojJD+9
         zCSoBewAqqLO7eUrPlfHVc7MxFrL1J85gpCXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9URJUprKYok9DoDJJ1KQjX0JlJiDVTfA7y6V233RllA=;
        b=S7ZzKHq8BGRBAReLVrWIphRSwnQEgMibwjRCkCNIZQk3acQCRd4ZVQlIICswM1badf
         gtqd+Zv2lOWb3dQ/rv0Kgwg5pDZSMqa04ix5LvcfqsdMFCw2rsBVajlWoSxbpZviFyiX
         D9HCNnVEWG9yuHctI+AGixhh41SUsGvLzbgV4ZVbEzhrutlidY+pAEdUUqimQpAqSLDL
         eiYK0gXsadaeMDOTKU4I/6yrwbhlfz0YKiBORcKtfiBBLi6H99nL8xWx4Bm+O1TXt79P
         wTo7hN9eG8AgbTbVG+AGTXyZd7p538MxiP37AC0B7gaZBvUFQgQOqDgKQZVpsDt03MoR
         Xgiw==
X-Gm-Message-State: APjAAAUbiNB24EB6Y+nScGuZ6YTPYrq6sM6nYpLsJB0zaB7Me69SGSe5
        felu/YPOlJdaz/1fMGhj+qeCpdRPT4U=
X-Google-Smtp-Source: APXvYqws8OYcueCuksjqCckuEeFrEqlvQVSDnZ9ROSyjYLD/uM5tILNfvVPM04WJGwhylwlYLK1ITw==
X-Received: by 2002:a67:af05:: with SMTP id v5mr11720371vsl.114.1552084476973;
        Fri, 08 Mar 2019 14:34:36 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id j186sm1832819vsd.21.2019.03.08.14.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 14:34:36 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id j12so7605861vsd.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:34:35 -0800 (PST)
X-Received: by 2002:a67:f611:: with SMTP id k17mr11417614vso.149.1552084475547;
 Fri, 08 Mar 2019 14:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20190308212524.121126-1-dianders@chromium.org> <CABXOdTe6hGWCsRpQcc_coB-whvJR2XfPfdLuc9QHMMvoXDNW=w@mail.gmail.com>
In-Reply-To: <CABXOdTe6hGWCsRpQcc_coB-whvJR2XfPfdLuc9QHMMvoXDNW=w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Mar 2019 14:34:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VGL-Z93WtU8LTQXeJtdUU085T+Vd_MXNuuvWnJ6-eyDw@mail.gmail.com>
Message-ID: <CAD=FV=VGL-Z93WtU8LTQXeJtdUU085T+Vd_MXNuuvWnJ6-eyDw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Speed up install, modules_install and kernelrelease
To:     Guenter Roeck <groeck@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 8, 2019 at 2:29 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Mar 8, 2019 at 1:25 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As per the description of the old commit 3298b690b21c ("kbuild: Add a
> > cache for generated variables"), calling the C compiler lots of times
> > during the parsing stage of the Makefile can be a little slow.  If you
> > happen to have a C compiler whose fork/exec time isn't optimized
> > (perhaps it was linked dynamically, or perhaps it's called through
> > several wrappers, or ...) then this can be more than a little slow, it
> > can be very slow.
> >
> > The above slowness was addressed with the old Makefile cache, but the
> > cache was reverted in commit e08d6de4e532 ("kbuild: remove kbuild
> > cache").  That commit indicated that we expected to get the speed
> > gains back because "the result of compiler tests will be naturally
> > cached in the .config file", but as of the latest mainline there are
> > still lots of direct calls to the C compiler that happen in the
> > Makefile parsing stage.
> >
> > Perhaps we could try re-introducing the Makefile cache and fix the
> > problems it was causing, but this patch codes up another solution that
> > gets some of the speed gains back, perhaps with less complexity.
> >
> > Specifically I observed that by timing the parsing stage of the
> > Makefile by adding statements like this to the beginning and end of
> > the Makefile:
> >   ZZZ := $(shell echo "$$(date '+%T.%N'): ..." >> /tmp/timing.txt)
> >
> > ...that three targets were spending 3 seconds each parsing the
> > Makefile in my environment (building a Chrome OS kernel with clang)
> > when it felt like they ought to be quick.  These were: install,
> > modules_install and kernelrelease
> >
> > I saw timings that looked like:
> >   09:23:08.903204451: Parsing Makefile, goals: install
> >   09:23:11.960515772: Done parsing Makefile, goals: install
> >
> > Given that the kbuild system doesn't sync the config for any of these
> > options I believe it is safe to say that it can't compile any code.
> > Thus if we can avoid the C compiler invocation here we'll save time.
> >
> > The simplest way to accomplish this is to neuter all the calls to the
> > compiler by stubbing them out.  After doing so (AKA applying this
> > change) the same timing looks like:
> >   09:28:04.929252271: Parsing Makefile, goals: install
> >   09:28:05.107468449: Done parsing Makefile, goals: install
> >
> > During an incremental kernel build/install on Chrome OS we call
> > install once, modules_install twice (once to keep unstripped), and
> > kernelrelease once.  Thus this saves ~12 seconds on an incremental
> > kernel build/install.  With my current setup, this brings it from ~40
> > seconds to ~28 seconds.  Re-introducing the Makefile cache would
> > likely save us an extra ~3 seconds since we'd avoid the parsing in the
> > compile stage.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  Makefile | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index f070e0d65186..5f7532d9be65 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -304,6 +304,20 @@ else
> >  scripts/Kbuild.include: ;
> >  include scripts/Kbuild.include
> >
> > +# If we can't sync the config then we know we can't compile code.
> > +# Replace the slow option-testing commands with stubs to significantly
> > +# speed up the Makefile parsing stage of the build.
> > +ifeq ($(may-sync-config),0)
>
> I think that breaks KBUILD_EXTMOD, which sets the variable to 0.

Yup, thanks for catching--I should have realized that from the code
but somehow skimmed over the KBUILD_EXTMOD bits.  I confirmed that
this is broken.

I can certainly add an extra check to confirm that '$(KBUILD_EXTMOD)'
is unset and I'll do that in a v2 if I don't hear anything, but before
sending that I'll give folks a little bit of time to smack down my
general approach.  To be honest my approach is a bit of a hack so if
others can think of better ways to avoid all the unnecessary work
during install / modules_install / kernelrelease then I'm all ears!
:-)


-Doug
