Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF1C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2220833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE+YAIX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfEQSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:45:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43637 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:45:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so7152772lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux/gl6McQJJa3CX8DofSKSwxuavrH2KDlAPJpksGrDk=;
        b=fE+YAIX2ifUwo3J+cnk6O2qQqEpl5xhGXk4l1AJTkr28uATZ2fBvyawiZt0qJAOGzZ
         KWbQ7hBcIlvt2SqA10+VuvrSsGseRtVIsZU+R5Rwm4uJbwEL5nnS5bK+R0pUQmmLWJKb
         5CFgxXXQnhtvJPMurFjOcNoMywAPvHOP7AhRkfciUmQ28VZXrLxTX3VBQXJJhUhwqHLR
         RXK40sJ7io7UBVn3Bka9hQv29PhKw/DpYWFNmGeeJNTG/0bM9hykZgiDLhc9h4LFmetN
         q4YqnoTApdCigkOiB1fHTehea/ioJ5C5lmjNWzJWW2UB6bT3+iBexZ7EPc6lIU2U+Vhr
         vufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux/gl6McQJJa3CX8DofSKSwxuavrH2KDlAPJpksGrDk=;
        b=Ge3msUntV2HOx/rMcqkWh8HZ/HbpIDyqyZh/qQWDPaQKE4QB1Qswt+7L2ebwt9arYh
         EJp2QuTgodEYQud0L0RPdnpZnk1RNllWSZOx5dQEtJ7JYXux5K/BhKQLfXD8ndgGI2xZ
         pPUBb5RVbwMtX6ZQ+32r3NGixCOxqY0nzfdOodQwOu8yHRlGt3txYH2guHfVXg4g0w1V
         q++uSl9HzGmQDL+++1yaTfCrvpefqMaenKpQqOZ3KiFTg8NAJVrtfSOQgDXAXaLAWHRC
         ZwEyStps2UFqdAwCNPsOqgUSfTYCyBGmVUGYL0jXWF2J/mFiEP3moOZEEsWZl786JtNs
         +Aeg==
X-Gm-Message-State: APjAAAXAOi+dkV/Q1XN9jntpmy2UMDYqWUcwDLeCwgvnxn+6R5IcEmf2
        eRMek/RSaZDGhd1mRyC+sYnaSxQ5gcPCtqAZFi2I0T8J
X-Google-Smtp-Source: APXvYqyJRGl/2ktL/VbBwAytGizwNR7h+J1oQacMpLJfcSgyxORnivU7YdE2A1SXIQWgyUDky1HGTvlfsAF7E3IJxRE=
X-Received: by 2002:a2e:5515:: with SMTP id j21mr3202876ljb.198.1558118718705;
 Fri, 17 May 2019 11:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190517092502.GA22779@gmail.com> <20190517124715.3d82bdbe@oasis.local.home>
In-Reply-To: <20190517124715.3d82bdbe@oasis.local.home>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 May 2019 20:45:07 +0200
Message-ID: <CANiq72=Wr-u1S8bxV07zPSV8vaXGVqYkTULKQADXfXXEZ0cmxQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Fri, May 17, 2019 at 6:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hi Miguel,
>
> Linus mentioned this too.
>
>  https://lore.kernel.org/lkml/CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com/T/#u

Ah, I didn't see that. We were discussing here [1] backporting to 4.19
some cleanups we did for GCC 9 a few months ago, so I was testing that
Linus' master was still clean a few hours ago. When I found that
couple of warnings I quickly made a patch before I forgot. I should
probably have added RFC :-)

[1] https://lore.kernel.org/lkml/CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com/

> Setting the LAT_FMT isn't something a function called "reset" should do.

I added the surrounding code heuristically since it was in a single
block with the comment above and since it was repeated in both places,
but I had no idea on the semantics. :-)

> > +     memset((char *)(iter) + offsetof(struct trace_iterator,
>
> Why (char *)? Please use (void *).

We are adding a byte-sized offset, so char * is the one that makes
sense. Doing it with void * works, although it is a GNU extension. But
as you prefer :-)

Cheers,
Miguel
