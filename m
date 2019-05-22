Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A14020879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WN0qKKvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfEVQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:04:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36161 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:04:18 -0400
Received: by mail-it1-f196.google.com with SMTP id e184so3919189ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u66aTMlghlwE0R/0etcbv7od+O8arnRDTZloXPsbsI=;
        b=WN0qKKvCMEQ9wXLVklzYdIpUzxaAmYwFU+TrKNAFkVJl5ObnUU8T/c9+9YMC5VfEvX
         HU6clxrMEMnKj9wWiDULcYlp/Q1DRQQHQkqVyCuXDNzcxVNdMO8YJFVdAxCsDIik7DFb
         M5bZJCaPxd8MZYa5iidi837/o3QdNZwdod19hffBtA6fnC0CsSH3bh0WFLm6LXkbd27M
         9J1yGmXtYfDfFvnSDwMfkkVvsCAA7OBfnl+9qojPV9aDQfs1WsjMQ1vbcAr0f2iTN3/L
         JaJ/eJbhBlAMe7lEdqdhASKuvr+gvVKPjQoqiDfgT8Z7IghGyqwtv09WGbO3vd7+IYJI
         00qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u66aTMlghlwE0R/0etcbv7od+O8arnRDTZloXPsbsI=;
        b=OXiKPeWDCAlFBzFtgaWGn2OWfHMPXV+uklaliVYEpvgTlTta7WcZjMzPVRpPA9FStV
         f/AksbyA2HfUjh54HYqwADCUhhAlREhfObA6LIjJBXL1OCsDaRqsm5kda4y3oPtfHLCw
         iNb2KXMQy28o4vw3o11+nP/ylRGGHwkIbuW2myxQ3FZYIKrlOojzP6zy6gFYeIyvl04k
         glFrgpHV1QDQ/Fiqk4Fb3jgzJBOZt0Souc9h6XdgrXV/s1bzh9T5FXWl1uwKaWvyfHSv
         TG0rbrKGmz/akLMXr6qcYgBnrXMnkZH11RmK2fzMM54fZ+QM9Rv1WrnhkYVWiITkqqF2
         Nk5A==
X-Gm-Message-State: APjAAAVMnpgY7pDvS18fDnhP/MIxGuB0A/VBJd27i37zqPxiW6wvzpBN
        j4WjX/kP+jl/AwlOlBoKpVlfncWlkUHlRZ6HlQvJgA==
X-Google-Smtp-Source: APXvYqwJUUu35Pd7vmXvXZr8Kh7nnijKYTNRH7jrot/Aug4RrV8GKxgBBDQAiqv0AjIzGf7hDF2fv9L9qnCa2P+EIe8=
X-Received: by 2002:a24:c204:: with SMTP id i4mr9004381itg.83.1558541057519;
 Wed, 22 May 2019 09:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
 <20190516003915.GT11972@sasha-vm> <ECADFF3FD767C149AD96A924E7EA6EAF9771A6DF@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF9771A6DF@USCULXMSG01.am.sony.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 May 2019 18:04:05 +0200
Message-ID: <CACT4Y+aq0eu5gG=Xnc6nDkQoH+_Hh=q3iiivq4nOowG8ncG+Cw@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Tim Bird <Tim.Bird@sony.com>
Cc:     sashal@kernel.org, Tim Bird <tbird20d@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 2:51 AM <Tim.Bird@sony.com> wrote:
> > -----Original Message-----
> > From: Sasha Levin
> >
> > On Fri, Apr 26, 2019 at 02:02:53PM -0700, Tim Bird wrote:
> ...
> > >
> > >With regards to the Testing microconference at Plumbers, I would like
> > >to do a presentation on the current status of test standards and test
> > >framework interoperability.  We recently had some good meetings
> > >between the LAVA and Fuego people at Linaro Connect
> > >on this topic.
> >
> > Hi Tim,
> >
> > Sorry for the delayed response, this mail got marked as read as a result
> > of fat fingers :(
> >
> > I'd want to avoid having an 'overview' talk as part of the MC. We have
> > quite a few discussion topics this year and in the spirit of LPC I'd
> > prefer to avoid presentations.
>
> OK.  Sounds good.
>
> > Maybe it's more appropriate for the refereed track?
> I'll consider submitting it there, but there's a certain "fun" aspect
> to attending a conference that I don't have to prepare a talk for. :-)
>
> Thanks for getting back to me.  I'm already registered for Plumbers,
> so I'll see you there.
>  -- Tim


I would like to give an update on syzkaller/syzbot and discuss:
 - testability of kernel components in this context
 - test coverage and what's still not tested
 - discussion of the process (again): what works, what doesn't work, feedback

I also submitted a refereed track talk called "Reflections on kernel
quality, development process and testing". If it's not accepted, I
would like to do it on Testing MC.
