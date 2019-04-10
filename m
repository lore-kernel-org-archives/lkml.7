Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D7BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F68520820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N8eqtqo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDJXYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:24:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42873 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJXYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:24:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id f15so2393229vsk.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMdRKn3t3H36AxpYfbOfyxvAGjXlvqO7f6OfKCgDBOs=;
        b=N8eqtqo1pGrtDLoEUN6e6a2nDm0Rlc4+JhBF+/z1R9sXTZsoDpqshRmf4UJ1vKKEqm
         aVcM3IG6fkyf1g6AWYUHes0FRKLg2FG3H+IMk3qHTRsZirKgL1MhHIJybSIfgcycveJ7
         5beOhG6aDjjFtzpDuNj/WN0sAX7Q1Dy1ZMQBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMdRKn3t3H36AxpYfbOfyxvAGjXlvqO7f6OfKCgDBOs=;
        b=sOdsXdvw1z8eV7Xh+RSQWWS2WB1OkMHHUmrNDqg6y1oVtZS0+vVLI/f/1QbG84H5bC
         oYQ2ixwGK+ZSON53INtg6pkq99dws3Miff2PIegUW7L5jVfaOgAJMzFrPdIbSRQTazrJ
         cvPRGJ9Uy/LSPortFtmlicGIhUSgIBDJKIYrIWWRl0KJdbB9ecoAW6z6QnehxM47jhMH
         fukJZLHjImGSxsQ+9/P+H/6Jx1Glp1uEarP85DQqEoeUkP09SkDuya6UVK35/taDSocc
         20/zZTvpD1KjIZIWKRN5kcOlSVfzrjpbu/sNOKd+3jku+zrDaqwkoOfhmjNc/Mq1BreX
         LaAw==
X-Gm-Message-State: APjAAAU5y4iVcp6PBbXSIoiPT8Z21wwhx8YAOA0iwBaeZm6UU3sADbvI
        SVOrtQbTlvczG3TpE9TzeJnz+7yHdd4=
X-Google-Smtp-Source: APXvYqyG04L1t4c2nYbilGfnPEERJnlI0FLnq++9GMT6I5x1xYTV/c4SuUq4IB7lZ0+8jOokZwNFew==
X-Received: by 2002:a67:f843:: with SMTP id b3mr26434707vsp.152.1554938671520;
        Wed, 10 Apr 2019 16:24:31 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id j71sm29920067vsd.0.2019.04.10.16.24.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:24:30 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id f15so2393189vsk.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:24:29 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr26387737vsm.133.1554938669436;
 Wed, 10 Apr 2019 16:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190410224213.20651-1-okaya@kernel.org> <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
In-Reply-To: <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 16:24:18 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
Message-ID: <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Sinan Kaya <okaya@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:22 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On April 10, 2019 3:58:55 PM PDT, Kees Cook <keescook@chromium.org> wrote:
> >On Wed, Apr 10, 2019 at 3:42 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> We can't seem to have a kernel with CONFIG_EXPERT set but
> >> CONFIG_DEBUG_KERNEL unset these days.
> >>
> >> While some of the features under the CONFIG_EXPERT require
> >> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> >>
> >> It looks like CONFIG_KALLSYMS_ALL is the only feature that
> >> requires CONFIG_DEBUG_KERNEL.
> >>
> >> Select CONFIG_EXPERT when CONFIG_DEBUG is chosen but you can
> >
> >Typo: CONFIG_DEBUG_KERNEL
> >
> >> still choose CONFIG_EXPERT without CONFIG_DEBUG.
> >
> >same.
> >
> >>
> >> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >
> >But with those fixed, looks good to me. Adding Josh (and others) to CC
> >since he originally added the linkage to EXPERT in commit
> >f505c553dbe2.
>
> CONFIG_DEBUG_KERNEL shouldn't affect code generation in any way; it should only make more options appear in kconfig. I originally added this to ensure that features you might want to *disable* aren't hidden, as part of the tinification effort.
>
> What specific problem does having CONFIG_DEBUG_KERNEL enabled cause for you? I'd still prefer to have a single switch for "don't hide things I might want to disable", rather than several.

See earlier in the thread: code generation depends on
CONFIG_DEBUG_KERNEL now unfortunately.

-- 
Kees Cook
