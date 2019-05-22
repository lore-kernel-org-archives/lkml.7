Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1234BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF1821841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEil9MH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfEVPsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:48:45 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:36979 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfEVPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:48:45 -0400
Received: by mail-io1-f54.google.com with SMTP id u2so2256448ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mITDoe4J8/uvH5cdbzz1r9ing0tGJhxbtiSsHCLEmkw=;
        b=CEil9MH7n1qNdPzMfHsM1KNbUTc28OaQK6fEycZuF4UhvpzbDJdSWlU3vavvZSULDy
         XtLgMkgBh8Ulg1aV+5bmNUT7Sx1Wdg6BGD3FSZsKbTR/9EUfFdyXnJlTI0Fy+HtaaEn1
         /Xf4Q9LXl51jXxwHgMSPjhcox3Whq8L1CqI+aNHVVphyKZnOijizvT45uInjNZgmluJz
         N7PerUDsCftti0nYnWwoPbo5mpxSNU2TPYUXUM7GEBq5IXWdvSM25Wlp/Jl0HQF6/KAd
         ZgEm9epZfUtiGHx8/VBnz/g8ZXOM8EMT8Vq/QW2OqWPHavKMTh1+SAZT6ZZNwezvlMJJ
         SgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mITDoe4J8/uvH5cdbzz1r9ing0tGJhxbtiSsHCLEmkw=;
        b=a/7CuyqgbtRWqbPC+91wbi0CZDY2Yc6K0cOo336d8T6Sq30Kwm7AVGyWHskaTsnP1m
         m3KOYmtrcsEQLZc+EcbHs5NH9hjV/zXxKbN0mQLDZv7aYdV+CF0aFUQVEG6plZtCF8uU
         GO8k5NcqBnk9PdzhMpCIqUBRQ9SFo+hlmIJzJdLovlNhIhA/5ulkB1j4hya1lgnRBW0a
         xwQJaNpcNvGLhzbgH0v1y+AIEqOukWhgEKCtpvgqwAB0dknFi1E5vogdRxEI8JwU+Hkz
         sSJE2GeFjEbi6vtcnQT4RYeVGV1pOhF2ad5B1kGPjA0o4PF/tl79NAUMDoBYQ7AJNDmF
         QkHg==
X-Gm-Message-State: APjAAAVQj1w6ZhlzubJo4oMgKHQUJmDj5vOD3Chp1o8K7v+ixT83DLGN
        pvXtCL7rD+/B/8ZHVD1LQzEODz5Q0eRaNZsbaACDUA==
X-Google-Smtp-Source: APXvYqzAGfNBDCXPjpHuyu5Je3rx967AAaVdw6S4GlogBFy2IrDQSukSh49iWLophVX9XmsCBJyPoLwBI0iqVwYpFO4=
X-Received: by 2002:a5d:9dc2:: with SMTP id 2mr23339293ioo.3.1558540123678;
 Wed, 22 May 2019 08:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com> <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
In-Reply-To: <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 May 2019 17:48:30 +0200
Message-ID: <CACT4Y+a_wLnB_f1bfNy_HAipF4iHFiyraogMHWdK285oxgJr+g@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Tim Bird <tbird20d@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>,
        Tim Bird <tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:03 PM Tim Bird <tbird20d@gmail.com> wrote:
>
> I'm in the process now of planning Automated Testing Summit 2019,
> which is tentatively planned for Lyon, France on October 31.  This is

This is _November_ 1, right?

> the day after Embedded Linux Conference Europe and Open Source Summit
> Europe, in Lyon.  I've been working with the
> Linux Foundation event staff to set this up.
>
> The focus of that event is test standards, including standards for
> test definition, results formats, lab and board management, and APIs
> between elements of the Automated Testing and CI stack.
>
> I think that the set of things to discuss is somewhat different
> between the Plumbers testing microconference and ATS.  But I hope that
> I'm not fragmenting the space too much.
>
> With regards to the Testing microconference at Plumbers, I would like
> to do a presentation on the current status of test standards and test
> framework interoperability.  We recently had some good meetings
> between the LAVA and Fuego people at Linaro Connect
> on this topic.
>
> Let me know what you think.
>  -- Tim
>
> On Thu, Apr 25, 2019 at 6:37 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > From: "Dhaval Giani" <dhaval.giani@gmail.com>
> > > To: "Sasha Levin" <alexander.levin@microsoft.com>, "shuah" <shuah@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
> > > "Tim Bird" <tbird20d@gmail.com>, "LKML" <linux-kernel@vger.kernel.org>
> > > Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Dan Carpenter" <dan.carpenter@oracle.com>, willy@infradead.org, "gustavo
> > > padovan" <gustavo.padovan@collabora.co.uk>, "Dmitry Vyukov" <dvyukov@google.com>, "knut omang"
> > > <knut.omang@oracle.com>
> > > Sent: Thursday, April 11, 2019 7:37:51 PM
> > > Subject: Linux Testing Microconference at LPC
> > >
> > > Hi Folks,
> > >
> > > This is a call for participation for the Linux Testing microconference
> > > at LPC this year.
> > >
> > > For those who were at LPC last year, as the closing panel mentioned,
> > > testing is probably the next big push needed to improve quality. From
> > > getting more selftests in, to regression testing to ensure we don't
> > > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > > we need more testing around the kernel.
> > >
> > > We have talked about different efforts around testing, such as fuzzing
> > > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > > testing, test frameworks such as ktests, smatch to find bugs in the
> > > past. We want to push this discussion further this year and are
> > > interested in hearing from you what you want to talk about, and where
> > > kernel testing needs to go next.
> > >
> > > Please let us know what topics you believe should be a part of the
> > > micro conference this year.
> > >
> >
> > Hi,
> >
> > as CKI team, we would like to join the Plumbers discussions about CI for
> > kernel. We obviously have our own working pipeline but would like to get
> > more involved with the other upstream projects working on the same and
> > collaborate on common solutions.
> >
> > I already started some of these discussions on automated-testing mailing
> > list and got in contact with Kevin about the possibility of joining forces
> > with KernelCI project.
> >
> > Our team planned to organize a 'hackfest' for upstream CI during the
> > conference but I heard that the Automated Testing Summit should likely take
> > place during that time too. If that's the case, we should meet up and
> > discuss everything there instead of organizing a separate event.
> >
> >
> > Information and links about CKI Project can be be found at [1] in case
> > people are curious. Some of the things we'd like to achieve is having a
> > single source for all upstream kernel test results where anyone doing the
> > testing can publish them and collaborate on solving common problems (like
> > interpreting test results, making build times faster, increasing the test
> > coverage, detecting regressions etc.)
> >
> > With one of my colleagues, we will submit a microconference proposal that
> > could serve as the starting point for the followup discussions about these
> > topics.
> >
> >
> > We would like to get feedback from kernel developers and maintainers about
> > their expectations for testing and receiving results, as well as discuss
> > the collaboration with other testing/CI projects.
> >
> >
> >
> > Veronika Kabatova
> > CKI Project
> >
> >
> > [1] https://cki-project.org/
> >
> >
> > > Thanks!
> > > Sasha and Dhaval
> > >
>
>
>
> --
>  -- Tim Bird
> Senior Staff Software Engineer, Sony Corporation
> Architecture Group Chair, Core Embedded Linux Project, Linux Foundation
