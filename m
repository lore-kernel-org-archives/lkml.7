Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CCE206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ean+Hb4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDZVDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:03:06 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:43270 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfDZVDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:03:06 -0400
Received: by mail-qt1-f169.google.com with SMTP id g4so5672410qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=injm5xRVHXJEfjutNe1qkbafoc3bABxQEyv9OJ+qshg=;
        b=Ean+Hb4t09+fcdPvQDRIQfc4I9st/cWVZGU7AtOELstTgKPgeoNAZl7jDz9TQhvLbc
         BQj2scZdlOhhPOsji7JUNoyw3ZgQQvqNyXta9om32+0PSoMHnIMf7xWsbjGPH+8MMJhH
         GIVDLNzvRkZ3Ao0zmcJNlMPJYr71eM4EANOvwAZBfRL265eUsTZb8/79692AiIiv0o8q
         S45lhci2e87GxviOj9nsT1nHzoP9Y9JvLlAUSW/CRW30cUYvCXGWSNR27EtRv3AoCCU7
         TqU6Fq4lECyfXJfgUK5jQwGpDssnoqMXF/wI5sr9qPMRUP1FPYqZRqRNKgqzELYphxma
         N1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=injm5xRVHXJEfjutNe1qkbafoc3bABxQEyv9OJ+qshg=;
        b=k5PNkGwfYbTyoxTSe6lEsEatYt2xJLhxP0tsWpd3CyepJmLd5FLtp3N81NYWi6D9Xp
         Gwc5MwBllst17w4HwSRnojdDAhXPsMROA2LPB7BfTYvskaCmwRCofFkK/BQUfuNppxQ8
         8/NbKgBiyGrN57z5MiTTsu2d6yXi8nRkd1ga0c0fMRwWNnN5Ps2h2HxPNWBUAPcp+lZY
         ClB2waJCSls8SS2Z9NrwP9HMsZhjIuJXf8edywdLIAc+T1xSLfhlzJ0mKBdi5gBHbJS8
         ON9lpEmX49iv+JVaMowj2+NcBu0+CEXP0kF+ombaDM6a2zGF/RDx8ro/bDNqNl+ai8mB
         Frcg==
X-Gm-Message-State: APjAAAUkfwCXVRUdT/1MvE2mFru5PRipRha376KdUVofXp+VVS9ceriY
        3YwQvjrWwLqRfiErL3r3UMWwSPlEwF3PQfIptxY=
X-Google-Smtp-Source: APXvYqzfuoft+h6czAAb/RMuqmbud14WW/gpKpYi9r8vLRQtn8Az7HN10n3166a2lj/2d+MEKEnC1metlYvvopoHnvU=
X-Received: by 2002:ac8:19e7:: with SMTP id s36mr9713966qtk.262.1556312584581;
 Fri, 26 Apr 2019 14:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
In-Reply-To: <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
From:   Tim Bird <tbird20d@gmail.com>
Date:   Fri, 26 Apr 2019 14:02:53 -0700
Message-ID: <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>,
        Tim Bird <tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process now of planning Automated Testing Summit 2019,
which is tentatively planned for Lyon, France on October 31.  This is
the day after Embedded Linux Conference Europe and Open Source Summit
Europe, in Lyon.  I've been working with the
Linux Foundation event staff to set this up.

The focus of that event is test standards, including standards for
test definition, results formats, lab and board management, and APIs
between elements of the Automated Testing and CI stack.

I think that the set of things to discuss is somewhat different
between the Plumbers testing microconference and ATS.  But I hope that
I'm not fragmenting the space too much.

With regards to the Testing microconference at Plumbers, I would like
to do a presentation on the current status of test standards and test
framework interoperability.  We recently had some good meetings
between the LAVA and Fuego people at Linaro Connect
on this topic.

Let me know what you think.
 -- Tim

On Thu, Apr 25, 2019 at 6:37 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > From: "Dhaval Giani" <dhaval.giani@gmail.com>
> > To: "Sasha Levin" <alexander.levin@microsoft.com>, "shuah" <shuah@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
> > "Tim Bird" <tbird20d@gmail.com>, "LKML" <linux-kernel@vger.kernel.org>
> > Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Dan Carpenter" <dan.carpenter@oracle.com>, willy@infradead.org, "gustavo
> > padovan" <gustavo.padovan@collabora.co.uk>, "Dmitry Vyukov" <dvyukov@google.com>, "knut omang"
> > <knut.omang@oracle.com>
> > Sent: Thursday, April 11, 2019 7:37:51 PM
> > Subject: Linux Testing Microconference at LPC
> >
> > Hi Folks,
> >
> > This is a call for participation for the Linux Testing microconference
> > at LPC this year.
> >
> > For those who were at LPC last year, as the closing panel mentioned,
> > testing is probably the next big push needed to improve quality. From
> > getting more selftests in, to regression testing to ensure we don't
> > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > we need more testing around the kernel.
> >
> > We have talked about different efforts around testing, such as fuzzing
> > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > testing, test frameworks such as ktests, smatch to find bugs in the
> > past. We want to push this discussion further this year and are
> > interested in hearing from you what you want to talk about, and where
> > kernel testing needs to go next.
> >
> > Please let us know what topics you believe should be a part of the
> > micro conference this year.
> >
>
> Hi,
>
> as CKI team, we would like to join the Plumbers discussions about CI for
> kernel. We obviously have our own working pipeline but would like to get
> more involved with the other upstream projects working on the same and
> collaborate on common solutions.
>
> I already started some of these discussions on automated-testing mailing
> list and got in contact with Kevin about the possibility of joining forces
> with KernelCI project.
>
> Our team planned to organize a 'hackfest' for upstream CI during the
> conference but I heard that the Automated Testing Summit should likely take
> place during that time too. If that's the case, we should meet up and
> discuss everything there instead of organizing a separate event.
>
>
> Information and links about CKI Project can be be found at [1] in case
> people are curious. Some of the things we'd like to achieve is having a
> single source for all upstream kernel test results where anyone doing the
> testing can publish them and collaborate on solving common problems (like
> interpreting test results, making build times faster, increasing the test
> coverage, detecting regressions etc.)
>
> With one of my colleagues, we will submit a microconference proposal that
> could serve as the starting point for the followup discussions about these
> topics.
>
>
> We would like to get feedback from kernel developers and maintainers about
> their expectations for testing and receiving results, as well as discuss
> the collaboration with other testing/CI projects.
>
>
>
> Veronika Kabatova
> CKI Project
>
>
> [1] https://cki-project.org/
>
>
> > Thanks!
> > Sasha and Dhaval
> >



-- 
 -- Tim Bird
Senior Staff Software Engineer, Sony Corporation
Architecture Group Chair, Core Embedded Linux Project, Linux Foundation
