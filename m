Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92849FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5dHrRuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437236AbfJPUsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:48:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36169 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfJPUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:48:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so15003713pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYN7JdwSAE7xHzfhopvvAQjdWh/Lx0v9lAUmGnJ0U1A=;
        b=P5dHrRuDil3iEngAsHPxvi7wPnXTBVbAKDphzKs+M9AZWEGI5ynkR9mKkQuLOMdM/k
         Q+QyZbfTgoAeHyWXBRG0hq/B18WnurwtIETFwXPagudINItfLFP5YZBuZk1RRYJ+K08j
         u5BSYVcQb7HcAewSUaAnCMAv9xUw6sJYVmDPgcFxltqeA/n1DkAEF/dh8/GUhI4Oop6U
         cYIDoQuzxiShYw8bHKyQcZ3V326qmXQq7VM3V1ICt7VQIqz6JtU9sp5Do1Xfwh0X4Z3/
         ZQze6T1VnxdRcdz1jWS2Bj9LJFcg74up8LnbChXBEwT9nK2fmR+WaU8IGXF+wYXs6oqz
         pEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYN7JdwSAE7xHzfhopvvAQjdWh/Lx0v9lAUmGnJ0U1A=;
        b=GamcVXp5TNWC3HrPFzz//LJoJ5Xsa9ri1id3ZFXjD8G6tSi3BuJ+C/xfG7JyAurUvf
         t+SBMOhPJPstKodt5Smkw977/+EwQR5wI1d1dgkFmg2+0rlHtnzrhoBjm2EYD/mrXXbH
         iREx9DNHI5baDtvQxLSJmEnZH9jdXnkaIzJQsqt1D0gpCoFqRs0+XUj9IsWEtaTPAR1B
         GbaKGtiYxUUPYikgSjaHyF3UBRCzG6e68b0riW9aEUt3YI2BpforF7nqow3g4cgbC3Z6
         cpoco4DKJdtUEUcZEbPPl2lJC4y+R5SkCrsA6gNJ320URrRNhT8COjQLPVcH4azjh6uk
         J8aA==
X-Gm-Message-State: APjAAAVx8JHgtyO4kDolaLF3ukWiAboEgISs1D15VBOg3uamyQu4Pyl+
        L5XHR4AYlWuKNoeiVH53lBRS6g/7x5CmhWSa2W4oxA==
X-Google-Smtp-Source: APXvYqwEyDaRLVpiAaixXq0Yn5GYXEushNQETJprRuecNWkYQysHPXYClGXXGmgv1luDfirwbBvejTJl5+GqGtbIH44=
X-Received: by 2002:a65:6091:: with SMTP id t17mr81764pgu.159.1571258924311;
 Wed, 16 Oct 2019 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191010185631.26541-1-davidgow@google.com> <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
 <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com> <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
In-Reply-To: <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 13:48:33 -0700
Message-ID: <CAFd5g46tNs=E5+_H4H9_aSwPJ7XVbCLTUSH6JYmmFK3QxW6Vdg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for the
 'list' doubly linked list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 11 Oct 2019 14:37:25 -0700 David Gow <davidgow@google.com> wrote:
>
> > On Fri, Oct 11, 2019 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > <looks at kunit>
> > >
> > > Given that everything runs at late_initcall time, shouldn't everything
> > > be __init, __initdata etc so all the code and data doesn't hang around
> > > for ever?
> > >
> >
> > That's an interesting point. We haven't done this for KUnit tests to
> > date, and there is certainly a possibility down the line that we may
> > want to be able to run these tests in other circumstances. (There's
> > some work being done to allow KUnit and KUnit tests to be built as
> > modules here: https://lkml.org/lkml/2019/10/8/628 for example.) Maybe
> > it'd be worth having macros which wrap __init/__initdata etc as a way
> > of futureproofing tests against such a change?
> >
> > Either way, I suspect this is something that should probably be
> > considered for KUnit as a whole, rather than on a test-by-test basis.
>
> Sure, a new set of macros for this makes sense.  Can be retrofitted any
> time.
>
> There might be a way of loading all of list_test.o into a discardable
> section at link time instead of sprinkling annotation all over the .c
> code.

I created a bug to track this here:
https://bugzilla.kernel.org/show_bug.cgi?id=205217
