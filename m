Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936B527DDE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrx6dijn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfFCI76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:59:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39570 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfFCI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:59:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so12159999ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elEezw8eJNRjZQYTDHVvzRVE/Q+eySJgjyiQLVkYQkQ=;
        b=Xrx6dijnKVT97gSJqYAR8nt8N75Qn3S9qQU1IBZFGTkLOVou1gTnjYv36KthGz20+h
         UHP2PnpYWxq6NAIfrhKvGRB0senB32856cmTB6aBaqlyb7aZbUPNXb0MdRqposVfxrxO
         rbcHV9V1Or/iXt/+dSS2CVhjGchIVWorsN5pvtWqDwIiUd1elY3svWqIqRpi/N8FkfIh
         znZ+PNXVpkR42l9Xsx8osk70rCqB0Y02JF/yk0Z/vTxDayEWqyzE3UHLsFjYQXWWpWEN
         Cv7+MRbRGKDst9c5t6WExokDOS+9zmqNul9vTDZPlHRLjDBtTLYt1baRxI7hC3FrdPXO
         g6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elEezw8eJNRjZQYTDHVvzRVE/Q+eySJgjyiQLVkYQkQ=;
        b=t8khBAqQMFc4UtcTG4u9UeVqfjiDAGfRgYf4wKj1ZBabWWGqC1NVxRtE+AkoRD2nza
         eqCQyTbIY1Erxd4/YTDHFjZPOmgBtX0+uEEOpU3580p84I0a+3GJ3c/AlJ/Zw/HOnN1a
         oi/mloeAsd/2t3cbnej7Kz7PIEXGJ3TT78w4R/UJx/zzlrps/QJqqgz+fBntQ2L09OIX
         6VC6oeXIlDdiXTnLPAL7n6kTz+fVJV5KFSA8VMsXYVK17ifHnDIKGdhCvddgYLT3elJC
         dVCa8tho3IGhlAImUx4mxiKFFwU5U6To19ayk3JWM0iyhpHzGNBwy3NAtpZBKe8pb2Ur
         fIYg==
X-Gm-Message-State: APjAAAXTUO5+uNbyiO6bv4T+iVE/IklHhctp8z0uD4gFENu+yc1CFmJ8
        XAsQXaNHkTVUPdQx7Ti4RNnpiTrP+LrtQOa6z13eMw==
X-Google-Smtp-Source: APXvYqwEt7J0r6HvOaSAONyZvMuco9w19yjR+TjJOnL9dv97sUzRs/jfS7txgkaPK5ZevM4cVCPjw5nIJ6R0+PW9I48=
X-Received: by 2002:a2e:a318:: with SMTP id l24mr1308827lje.36.1559552395602;
 Mon, 03 Jun 2019 01:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org> <20190516003649.GS11972@sasha-vm>
 <20190522210231.GA212436@google.com> <44957d4eccc4df68036ad44cbe9b16778191f47d.camel@oracle.com>
In-Reply-To: <44957d4eccc4df68036ad44cbe9b16778191f47d.camel@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Jun 2019 01:59:44 -0700
Message-ID: <CAFd5g46y36Rpm_oaRRmYYqL_0Jrj95rQVBn8EoFw3qpO9Or69g@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Knut Omang <knut.omang@oracle.com>
Cc:     Sasha Levin <sashal@kernel.org>, shuah <shuah@kernel.org>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo.padovan@collabora.co.uk, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 9:55 PM Knut Omang <knut.omang@oracle.com> wrote:

Sorry for the delayed reply.

>
> On Wed, 2019-05-22 at 14:02 -0700, Brendan Higgins wrote:
> > On Wed, May 15, 2019 at 08:36:49PM -0400, Sasha Levin wrote:
> > > On Wed, May 15, 2019 at 04:44:19PM -0600, shuah wrote:
> > > > Hi Sasha and Dhaval,
> > > >
> > > > On 4/11/19 11:37 AM, Dhaval Giani wrote:
> > > > > Hi Folks,
> > > > >
> > > > > This is a call for participation for the Linux Testing microconference
> > > > > at LPC this year.
> > > > >
> > > > > For those who were at LPC last year, as the closing panel mentioned,
> > > > > testing is probably the next big push needed to improve quality. From
> > > > > getting more selftests in, to regression testing to ensure we don't
> > > > > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > > > > we need more testing around the kernel.
> > > > >
> > > > > We have talked about different efforts around testing, such as fuzzing
> > > > > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > > > > testing, test frameworks such as ktests, smatch to find bugs in the
> > > > > past. We want to push this discussion further this year and are
> > > > > interested in hearing from you what you want to talk about, and where
> > > > > kernel testing needs to go next.
> > > > >
> > > > > Please let us know what topics you believe should be a part of the
> > > > > micro conference this year.
> > > > >
> > > > > Thanks!
> > > > > Sasha and Dhaval
> > > > >
> > > >
> > > > A talk on KUnit from Brendan Higgins will be good addition to this
> > > > Micro-conference. I am cc'ing Brendan on this thread.
> > > >
> > > > Please consider adding it.
> > >
> > > FWIW, the topic of unit tests is already on the schedule. There seems to
> > > be two different sub-topics here (kunit vs KTF) so there's a good
> > > discussion to be had here on many levels.
> >
> > Cool, so do we just want to go with that? Have a single slot for KUnit
> > and KTF combined?
> >
> > We can each present our work up to this point; maybe offer some
> > background and rationale on why we made the decision we have and then we
> > can have some moderated discussion on, pros, cons, next steps, etc?
>
> I definitely had KTF and KUnit in mind when proposing this topic.

Awesome!

> If you recall from the last time we discussed unit testing, each slot is
> fairly limited in time. My plan for the intro for discussion is to

Yeah, as per Steven's comment, I also submitted a refereed talk for
more detailed stuff.

> itemize some of the distinct goals we try to achieve with our frameworks and have a
> discussion based on that. In light of the discussion around your patch sets,

Sounds good to me. One thing I would like to talk about is maybe
trying to classify different categories of tests (unit vs. integration
vs. end-to-end), where they fit into the Linux kernel, how
prescriptivist should we be in categorization and what a test is for,
etc. I think this has been a point of disagreement/confusion on my
patchsets as well.

> one topic is also the question of whether a common API would be useful/desired,
> and whether we can "capture" a short namespace for that.

I am not opposed. This could potentially tie in to what kind of test
something is as I mentioned above. In anycase, sounds like there is a
lot of room for good discussion.

Thanks!
