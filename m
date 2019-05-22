Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30423C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D362070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0NExzf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfEVPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:52:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53566 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:52:29 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so4354822ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFtUhOuSgO/od0ILZVXNBGI9ljdusS+fhIuCiAjLn48=;
        b=K0NExzf+g8ek1lt12+v9z0gTKIKmmBd9tYGM487RkeZwmWQN3DuYM8NtVD0Q+qDpVg
         Xm3Sdhid9QFrG41/glaFL4h5/b4NATrRanVMRXNdxqebLkak8Xj63vUBEQo9wMJ26K7H
         tq5Z7cOrM15cmdXCjfN7qj+J+4cZ8niRtl7dBAEbo+Mg/TBtRSvVIzsexR6O5ku/JYO4
         hZBl7uoPmM8MtllReoFQmF+zKdS3h0sub964wFavEPN5Lb4rTgbRB4gnzNioPBly2nqj
         lrcfr/+xZgd6KRTHrXi4VRM/ccVousi6w17VUz84Gz4JQlL5pJ8wE/k9SAkYI/1TGZUN
         qQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFtUhOuSgO/od0ILZVXNBGI9ljdusS+fhIuCiAjLn48=;
        b=fbMbpTojKhocEOnd+JdPIBZB/utFNhY1F7yrfZ8Kon1BnTK8DH461Ns2mnx6ek5sud
         BwTzd/vRKBZ0ucrbbG3gRG5zjWJk9ZEibkZl6opW9ho90ziLVjDLPYmEIlo4D/jo0pPL
         H4H7M3b36iapd1a/ZkpvtwmUXLStI+pvSd3qWRqjjjx/J49uGzN/Xixx2kN2Hrnb/xAs
         QKOwhakZaMN20A2tcoxFZnLhInYOHAjs33yPrGmLki7eKaJ5V+SU/jGiMRBmeHSEeGgL
         kWCOzVkIQZW44wGL0sMjkphXVa+9tY5pFUmvYiL27kAG1+TCv6sQqIktvsnT4TBVpFAw
         lDqg==
X-Gm-Message-State: APjAAAWUm/GPJwcw7VSl9f7y8AHGN6xr9u3ewQ9UGaQ7znFIlV/7p57o
        +Vi4svGhCqg9COoNQ2xTzByn/ulJydCV3os1//oTOg==
X-Google-Smtp-Source: APXvYqwAuOW3ydq2mXf4g01JqLL4a7vLjM3htP/Z61fkyVt/torlrtjN4lpa4SMfIUdnOogKJE1tmnKx+eBaduw8GVI=
X-Received: by 2002:a02:1384:: with SMTP id 126mr53557329jaz.72.1558540348687;
 Wed, 22 May 2019 08:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <20190423102250.GA56999@lakrids.cambridge.arm.com> <20190512004008.GA6062@andrea>
In-Reply-To: <20190512004008.GA6062@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 May 2019 17:52:17 +0200
Message-ID: <CACT4Y+aj8i0VNad91F-QkHNsXYXUFrYF+j=wnG-USzfQfoD55A@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 2:40 AM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Tue, Apr 23, 2019 at 11:22:50AM +0100, Mark Rutland wrote:
> > On Thu, Apr 11, 2019 at 10:37:51AM -0700, Dhaval Giani wrote:
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
> >
> > I'd be interested to discuss what we could do with annotations and
> > compiler instrumentation to make the kernel more amenable to static and
> > dynamic analysis (and to some extent, documenting implicit
> > requirements).
> >
> > One idea that I'd like to explore in the context of RT is to annotate
> > function signatures with their required IRQ/preempt context, such that
> > we could dynamically check whether those requirements were violated
> > (even if it didn't happen to cause a problem at that point in time), and
> > static analysis would be able to find some obviously broken usage. I had
> > some rough ideas of how to do the dynamic part atop/within ftrace. Maybe
> > there are similar problems elsewhere.
> >
> > I know that some clang folk were interested in similar stuff. IIRC Nick
> > Desaulniers was interested in whether clang's thread safety analysis
> > tooling could be applied to the kernel (e.g. based on lockdep
> > annotations).
>
> FWIW, I'd also be interested in discussing these developments.
>
> There have been several activities/projects related to such "tooling"
> (thread safety analysis) recently:  I could point out the (brand new)
> Google Summer of Code "Applying Clang Thread Safety Analyser to Linux
> Kernel" project [1] and (for the "dynamic analysis" side) the efforts
> to revive the Kernel Thread sanitizer [2].  I should also mention the
> efforts to add (support for) "unmarked" accesses and to formalize the
> notion of "data race" in the memory consistency model [3].
>
> So, again, I'd welcome a discussion on these works/ideas.
>
> Thanks,
>   Andrea

I would be interested in discussing all of this too: thread safety
annotations, ktsan, unmarked accesses.
