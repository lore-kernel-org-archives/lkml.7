Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F6C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D10F20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563127999;
	bh=ad4zsG4mgnfX2Gqru9GGR3aSg2jN8d8xkesMAkiflKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M6IltekbC3FVLVg6WWjiHfvtb5UKft7joxgaXly7nGTiSBkmyNeE/4bid/2IeO8h3
	 h/cok+l9mgGULuroLhP11Vh3v4sFlX/tdbC2s433pNJE7OLgjaRwy36RfTCejGdgIV
	 Z2cYRQuaUnumJ5QI6VfGV+6XzFA3ZpsKimMlTRGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGNSNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 14:13:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40777 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfGNSNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:13:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so9486268lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr5TLKMCpyeVVqScbE1i8kC2438X/aWPB/b+xLbsqcM=;
        b=GuNHLnEM1Cbw5cSbt/4qPWUCWsHjSuo+xOAAuQnqZuLEbABT3lU5GbOKGB8QvMjX0z
         gOyOTF2SfJK3maXH8nc8MjOmKkLR7/lszvGFgKKlOGecYNtZZQqPZh/LTi6ygwVAT+rr
         7jmKtZgz37JEYFIzo/leQkjA78AqcSi4k4Tgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr5TLKMCpyeVVqScbE1i8kC2438X/aWPB/b+xLbsqcM=;
        b=D/5cYU2wAeuFQlEx8kUHrhppnddglj8Sc4Rzzy2L/v4Qy9rfHNGBrVo6lB+fhX0T4u
         rJBxHQGEflBVYLV3XdqKCxjfrlo+ZyC3aSgVbqlqmQu97nM1PwuC4u145vaPmVcso11/
         xZ1I6OJQACkJrj0DWe7Z0ZZyNaZBbS3vPf7fpFJ4MGAVxGAD6tQ/2AcMwbRn10Jg/9Fw
         ApLWYNwWJ+hAbxEXGL8WCWz742GMxnSzWUsIakAU21numQX7+MD5hBh+UNjPKq7u2bvl
         5QFaSaZ7gQ0D/Q3GQHMYkmKsyyYrc7hvNSaTfrrIBu+ixSqOM0aEyToaB6q0V19+0K8d
         reVw==
X-Gm-Message-State: APjAAAX9wTZ/jDFYPCu01/lW0PU6Uel98l0C2aPnLm5bBZdrvz3oH87I
        jhUThGXJ762SQba+CsCbPWiA92Vg238=
X-Google-Smtp-Source: APXvYqyqaTHNg9oFs88jS/zmIxC09tE8URaLX5xSTXDx74+B8GffbhAUWGkg3yJNyb9C8oV9hwv+UA==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr9985112lfo.114.1563127993807;
        Sun, 14 Jul 2019 11:13:13 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e62sm2665897ljf.82.2019.07.14.11.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 11:13:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i21so13925472ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 11:13:12 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr11234478lji.84.1563127991687;
 Sun, 14 Jul 2019 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190713072855.GB23167@avx2> <CAHk-=wj_mrNnM-q_z95GcNB=Ab4LaUC6Bi6Q-+3Q9u9NC=3iDA@mail.gmail.com>
 <20190714095157.GA2276@avx2>
In-Reply-To: <20190714095157.GA2276@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jul 2019 11:12:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyV8TxUKGSUaSe1toZumq5OOz90W7XQB3QDSdTuE+YAw@mail.gmail.com>
Message-ID: <CAHk-=wgyV8TxUKGSUaSe1toZumq5OOz90W7XQB3QDSdTuE+YAw@mail.gmail.com>
Subject: Re: [PATCH] proc: revert /proc/*/cmdline rewrite
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Kubecek <mkubecek@suse.cz>, shasta@toxcorp.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 2:52 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> The problem is that I can't even drag this trivia in out of _fear_ that
> it is userspace observable:
>
>         https://marc.info/?t=155863429700002&r=1&w=4
>         [PATCH] elf: fix "start_code" evaluation

Oh, we should do things like this all the time.

"Observable" isn't a problem per se. It only turns into a problem when
it actually breaks things.

We should always strive for understandable - and maintainable - code.

"Make it as simple as possible, but no simpler".

Of course, if you can prove that some change isn't observable, then
that is always the safer change.

Because any observable change _can_ (and admittedly surprisingly
often) does end up showing that yes, somebody out there depended on
some particularly subtle observable detail.

But often "observable" doesn't mean "breakage", and it's not that
uncommon that we do things that have slightly different semantics in
order to clean stuff up (or fix actual bugs that cause problems).

The important thing when something observable _does_ cause actual
breakage is that it gets fixed, and that people don't try to make
excuses for it. In particular the "but I fixed a bug" is _not_ an
excuse for causing some user load to break, because that was just
another bug.

Of course, it's also perfectly valid to say "ok, this could be
improved, but changing it changes observable behavior, and it's not
worth my time to worry about whether something can break".

So there should certainly be a *worry* about breakage (and the pain
that breakage can cause) when making cleanups etc. But as long as you
stand behind your cleanup and know that you may have to fix it up if
somebody reports an issue with it, it's all good.

IOW, it's a balancing thing. Do you think the cleanup is worth the
"this may come back to bite me" problem?

> and yet the patch which did a regression and an infoleak continues
> to be papered over and for which the only justification was
> "simplify and clarify".

See above. "Simplify and clarify" is a good excuse in general.

What is *not* a good excuse is then if somebody doesn't stand up and
say "oh, my bad, I screwed up, and here's the fix for the breakage".

In this case it took a year for people to report problems, which shows
that at least the breakage wasn't obvious.

And I'd rather fix it by cleaning up *more* and making the rules
simpler and easier to understand.

Don't get me wrong - reverting is often a good strategy too.

I will revert very aggressively when close to a release, for example,
when we just don't have time to try to figure things out. Or if the
breakage is large enough that it hinders people from testing and
working on other things.

Or if the original developer is not responsive and there isn't
somebody around that goes "ok, that can be fixed by xyz.."

Then "let's just revert" is the right thing to do. It can be the
simplest thing, when you just don't have the resources to do anything
else, or it's not just worth it.

                     Linus
