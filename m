Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3964D2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMb1KwUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfFGPcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:32:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfFGPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:32:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so1386275pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I7ozsQLaOgj0MR9jFDS0vY/ACLnRjUvlCOsI+qsnQSE=;
        b=PMb1KwUOxWy7M5vtJkbvKRrSeqFBXw5wn46RTCMPfk7VWqJr1DXAQEbeX8GP72niYE
         BNlslRoKbVLV5qwrRTf85CnT3M8NmPmSXpjujnimL4GmQrn0m1xaVXFBTTHKCAv0oGqe
         vbBCVaXK88Pepnh49gjS5NITkVkx8XKSOmaATWZIo/j4eI4sI0L7jWEam+302Vjpt3Eo
         z46upIm7QkeU7Y6YbxlnA6vrrSD9mpgcLQEpPfBrBCGDrFLR1GNxj83pVvFlbud/+TS0
         G75AdhHeb1ZimhF9U9rAVvQpR/+OpyCz1eZRSaNuVx6YG0qM67yIkaCO7JYgzahAYbZI
         4k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I7ozsQLaOgj0MR9jFDS0vY/ACLnRjUvlCOsI+qsnQSE=;
        b=GpxzLi6O9ohv2kb4RFM2gYpvYkY3lg1l8AA6lKQe8x4Y0XVSmDC9mQ7iUNWDcG+cSj
         SD52fvq4t2LyNtVY8p0uFMrNuYGGDmxs1N32i8WNP+GK8gRvz3yeMJ8R2Ebm2v7YDg3X
         G2hDyFLha6Uze2SVsDJ1CeQMxrWZ/w1+1Hhy9EE82mh5TpkukZPLSRpBtEgVnR7tLkei
         LPYcnQNUfunUGiJv1wy+Z3yxJ4gontnw8k1Ahk9sr7PSAsbdLgC64EY6rhfo61g92wDf
         KGpXD1hGC7zGnGPUGTZOqcrIn2EcZgI+Ao8s5jb7hvV61h1ey1QmwxnyyWwxQsJ0bKBg
         9vYA==
X-Gm-Message-State: APjAAAWRlDboKTxSaiFgymhvKQsQ2RfHVAp9jqqyBgvIY2tYTTIJvKiR
        CUmOwkoNiH/oUY9d9DhBsO8a6g==
X-Google-Smtp-Source: APXvYqw3v5+4N7H7TwAQ9NFuBhK+UkEA5KDHUocteGCJxUh3oXsf8cdtMrws3lGImj9jRjFZGfz6Uw==
X-Received: by 2002:aa7:8ecb:: with SMTP id b11mr19920591pfr.220.1559921570760;
        Fri, 07 Jun 2019 08:32:50 -0700 (PDT)
Received: from google.com ([2620:0:1008:1100:dac3:f780:2846:b802])
        by smtp.gmail.com with ESMTPSA id b7sm2432205pgq.71.2019.06.07.08.32.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 08:32:50 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:32:46 -0700
From:   Tom Roeder <tmroeder@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>, zwisler@chromium.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] kbuild: Add option to generate a Compilation Database
Message-ID: <20190607153246.GB101503@google.com>
References: <20190606203003.112040-1-rrangel@chromium.org>
 <20190606205406.GA120512@google.com>
 <CAKwvOd=RCL3hpHBVukomrRiXKhvJHMxe3HSrtd0MRcCe1B3ZGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=RCL3hpHBVukomrRiXKhvJHMxe3HSrtd0MRcCe1B3ZGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 04:40:00PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 6, 2019 at 1:54 PM Tom Roeder <tmroeder@google.com> wrote:
> >
> > On Thu, Jun 06, 2019 at 02:30:03PM -0600, Raul E Rangel wrote:
> > > Clang tooling requires a compilation database to figure out the build
> > > options for each file. This enables tools like clang-tidy and
> > > clang-check.
> > >
> > > See https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html for more
> > > information.
> 
> I'm also super happy to see this!
> https://nickdesaulniers.github.io/blog/2017/05/31/running-clang-tidy-on-the-linux-kernel/
> I don't know enough about GNU Make/Kbuild to answer the questions, but
> hopefully Masahiro can help there.
> 
> > I'm glad to see someone adding this to the Makefile directly. I added
> > scripts/gen_compile_commands.py in b302046 (in Dec 2018) when I was
> 
> Heh, cool.  I had a script that basically did this; we recently
> dropped it from the Android trees when doing an audit of out of tree
> patches.
> 
> > working on using clang-check to look for bugs in KVM. That script
> 
> I'm very interested in this work; my summer intern is looking into
> static analyses of the Linux kernel.  Can you maybe reach out to me
> off thread to tell me more about what you found (or didn't)?
> 
> > > Normally cmake is used to generate the compilation database, but the
> > > linux kernel uses make. Another option is using
> > > [BEAR](https://github.com/rizsotto/Bear) which instruments
> > > exec to find clang invocations and generate the database that way.
> 
> It's probably possible to get this to work w/ GCC if the additional
> dependency of bear exists on the host's system (and may reduce the
> number of implementations).  Downside is the additional host
> dependency.
> 
> Sounds like it may also be possible to just run
> scripts/gen_compile_commands.py at build time if this config is
> enabled?

Yes, for scripts/gen_compile_commands.py, you run a build first with
whatever configuration you want, then call the script to produce the
compile_commands.json file.
