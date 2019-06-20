Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1654C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBFE20652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmo+79nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfFTU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:57:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37180 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfFTU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:57:14 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so860350iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clvCWOgrf+bohYw4yPLb3cRL+S1vltb3Xjm9acQt7gc=;
        b=fmo+79nDbCw1LpEWNQuMz3TNZn/Agh17uX72Jpp7q6b2HvuhGW1kZQ9w9YwtzXg3z2
         /c739uDRHe8FPIWbBXlypKWcZxCFxSOtSQcjJCFUPnkccul+7ySI22Ey9bEqvPsZkHPi
         x9tDyl9iGhsEIRv8KDy0ciKm79J/jHdToPbV6RjYhhWbBMNCeuNX+L5fxSb56iwB+Sce
         d+gC6ukOMm2Fk5M/Ql4M5wyk+M8KRsIrp3mTcQ+0+YZ0HDi5H93pBa9DemOWu+GigIDg
         hV9wS9IAnlyKY5A8RFTiS2NQDzMDossP9+GvAZxA1QWn7BS4uLbzGLKflsbL5RRYsMmw
         Lahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clvCWOgrf+bohYw4yPLb3cRL+S1vltb3Xjm9acQt7gc=;
        b=nFRHfUrX8swoaECFd8tsJCtoHyQDwTwb56zAPyErhu+DIDuCPAk8UiF3mnCdJd8ktW
         chHVc01jKPzEN1ZCHcUq5O4Axp4j3s5FbmRFFENv5GzFDLBAOH6+sCA1u90UC3eRY2vY
         TCh1au5AJED82srwx4jrIFYyBVJFKUGaYN6+c+JmDKnUq7H/Uip+Vczje13H3Dse54Rp
         9Ca53o8/wK/9V3Odz6tPMLVb9Hd0sAs006WodO16iAVXwIr7lFJTDygCjQGSCVvBatau
         G3V5AEDkCBFD90tcgguthqFkpX1qAg7QB1ABnLf4gNW2H/5jjVDV5vuAduJg/22NfS54
         Esfg==
X-Gm-Message-State: APjAAAWJT6I4qryB/irLSUwK6hJsL8X1VHKSgM/aOhZECLv5mFTT/eIb
        WNpmUnBD6LbUsUXN1z5K73xnbG9chq4pbB4iDFm5Qw==
X-Google-Smtp-Source: APXvYqyoE6yVE00Eod4xt7YYeSZb5+bhhG3FG4eMRcSKpCjKHKHIlIROzex6qp1ezLxojf+kzqzXWbf0kL5uiXi22KU=
X-Received: by 2002:a02:878a:: with SMTP id t10mr3379368jai.112.1561064232696;
 Thu, 20 Jun 2019 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190620184523.155756-1-mka@chromium.org> <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
 <CAD=FV=WcH=dVeVWznO7Ti5A8HBDRM=rPvvH=-XJ2o1PKXvHAQw@mail.gmail.com> <CAKwvOd=twuZAAyKsBRSeJEFuQZGdyTw+=JAwmJugUhV+bppdtg@mail.gmail.com>
In-Reply-To: <CAKwvOd=twuZAAyKsBRSeJEFuQZGdyTw+=JAwmJugUhV+bppdtg@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 20 Jun 2019 13:57:00 -0700
Message-ID: <CAD=FV=UHNwXhGcqua=gfGzyRMUt=fBd0RbRvQwttj-6hFdrjKw@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 1:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 20, 2019 at 1:13 PM Doug Anderson <dianders@google.com> wrote:
> > On Thu, Jun 20, 2019 at 12:53 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > I do miss Doug's Kbuild caching patches' speedup.
> >
> > You actually get quite a bit of this by grabbing a new version of
> > ccache (assuming you use ccache).  :-P  You still have to pay the
> > penalty (twice) for all the options that are tested that the compiler
> > _doesn't_ support, but at least you get the cache for the commands
> > that the compiler does support.
>
> Hello darkness my old friend:
> https://nickdesaulniers.github.io/blog/2018/06/02/speeding-up-linux-kernel-builds-with-ccache/
> Man, that post has not aged well.  Here's what we do now:
> https://github.com/ClangBuiltLinux/continuous-integration/blob/45ab5842a69cb0c72d27d34e73b0599ec2a0e2ed/driver.sh#L227-L245
>
> > Specifically, make sure you have a ccache with:
> >
> >     * https://github.com/ccache/ccache/pull/365
> >     * https://github.com/ccache/ccache/pull/370
>
> Oh! Interesting finds and thanks for the pointers.  Did these make it
> into a release version of ccache, yet? If so, do you know which
> version?
>
> > I still have it in my thoughts to avoid the penalty for options that
> > the compiler doesn't support but haven't had time to work on it
> > recently.
>
> It had better not be autoconf! (Hopefully yet-to-be-written GNU C
> extensions can support feature detection via C preprocessor)

I've had a few ideas.  I won't object if you wanted to steal any of
them and implement them yourself.  :-P

1. Lamest but easiest (and best speedup for me personally) is to just
cheat and hack our toolchain wrapper (which is invoked _before_
ccache) to immediately reject flags we know our toolchain doesn't
support.  I don't love our toolchain wrapper since it adds ~15 ms to
every compiler invocation, but if it's there anyway might as well use
it.

2. Part of the slowness in testing for unsupported options is that
ccache runs twice.  After validating that it doesn't have a cache hit,
it first tries to produce a preprocessed version of the file.  With an
unsupported option that fails.  ...so ccache tries again _without_ the
preprocessor.  So you call the compiler twice.  We could either make
ccache skip this double-step when the target is /dev/null (why bother
trying to preprocess /dev/null?) or we could add a CCACHE directive
into the kernel build when testing options.  Probably the ccache
option makes the most sense.

3. In theory we could teach ccache how to cache these "tests for
unsupported options".  That might be hard, though.

-Doug
