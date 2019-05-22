Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F61C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0042089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhyPoLIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfEVNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:11:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41515 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfEVNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:11:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id q16so2021926ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qFqSEgKvjm2FzdXcF6PCbM2rvp+ThItKS5Y3HKtAdA=;
        b=WhyPoLIz7JsHlFh5bfGwDqCg6o2yNqnXl85UL9ajKIwKXWpHQ6Kc5eLkrq2FATTqdM
         virhOK39PMXPIZlD0S0X+nKtpvrZknoOnJUXkCULCTolJibugB3h2K19kano4oM5kXTz
         P/IzQpg4BFsNNw0gXrYkjCSE1Zrmj/Uxs9PupczdIAueC02Jbi0w6bJQG5gawQ1xEjjk
         7HpcdSUAfTy6tMPDNROcaohAKsLYKuMTVyzUBbiHcM12gKKv0ha0o+zrsemL8Mxi66F5
         ziybe9Exk164Vv8yOVYaGgk3PG3gAPyVILnYiUnxdFK6BKIxuwy06edLNnzbCzmD7ADh
         LDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qFqSEgKvjm2FzdXcF6PCbM2rvp+ThItKS5Y3HKtAdA=;
        b=mvZgzv+cC7CkZIFNz1OR9bWi0f5W0Vt9faBB1z1bShWmVp3ynyUvLIXQWitr2++x60
         eLIGxjmlHw3Uy+HWT1Ar45gEg4AzRveg4aMaNiPyN0W1RZyspkD7axQ6M5VkT8rFRItb
         BNUzCnSVSxbMUCS24oWw1FSA0ZjEDOg7pqdQzS6F6Jp5PFQMkXySYRVN/508MciZ8BtP
         p4aN6X8cYd0nNgpRLoC2ERfZ3YZ9zCgoTolCv+48Qo6SzR/lQFB9MvFN1kqa1P/hzEXI
         MvNgIoZ/22HeFgIbhNUIh4VaKjt39MoIjtigh936Spm03caV1RXdZhbu7f6caNTk+Dro
         qgcQ==
X-Gm-Message-State: APjAAAUdHsJS+ed792tFcJ6pjU9lIOinK2iqWk8auvdi9xSIdl7JWbcz
        M4VqEzGzWfks5RhKsYwANk3Ptcqz0d8JijL9XDes7NoP
X-Google-Smtp-Source: APXvYqwOOGVsZ6GSQK/aHBYHMFlRyEU0BXc3locCzh2oPGqPeuOufGxabLVD8QnkfOK4Eg8/PVmXB4Wj7sgLrGAyVXk=
X-Received: by 2002:a2e:2b58:: with SMTP id q85mr46163360lje.179.1558530681812;
 Wed, 22 May 2019 06:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190522095810.GA16110@gmail.com> <20190522075227.52ae4720@gandalf.local.home>
In-Reply-To: <20190522075227.52ae4720@gandalf.local.home>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 22 May 2019 15:11:10 +0200
Message-ID: <CANiq72=uRuyDuRvZgxYAHxKRCOyJ-KQew+R24tPwOJuQmaO1Yw@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: silence GCC 9 array bounds warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 22 May 2019 11:58:10 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
> > +/* reset all but tr, trace, and overruns */
> > +static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
> > +{
> > +     /*
> > +      * We do not simplify the start address to &iter->seq in order to let
> > +      * GCC 9 know that we really want to overwrite more members than
> > +      * just iter->seq (-Warray-bounds).
>
> This comment is fine for the change log, but here it is too specific.
> Why does one care about GCC 9 when we are at version GCC 21? I care
> more about why we are clearing the data and less about the way we are
> doing it.

Since the code is not written the obvious way on purpose, the idea is
to document why that is so -- otherwise the reader may wonder (and
possibly re-introduce it back). Specifying when the warning started
appearing tends to be clarifying, too.

The commit message explains the change itself, but the comment
explains why the current code is written like that.

> A comment like:
>
>         /*
>          * Reset the state of the trace_iterator so that it can read
>          * consumed data. Normally, the trace_iterator is used for
>          * reading the data when it is not consumed, and must retain
>          * state.
>          */
>
> That is more useful than why we have the offset hack.

That comment would be great in the function's description, in my
opinion, and it is a great addition to have nevertheless. I re-used
the existing comment for that to keep the change as minimal as
possible (and nevertheless I am not qualified to write it since I have
not studied the tracing code). In other words, I'm not saying there
are no further improvements :-)

Cheers,
Miguel
