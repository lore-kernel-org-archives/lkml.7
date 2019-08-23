Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A1AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80B222CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566578395;
	bh=NberAb6RZePTR4llSoS/DhB3hnE6XdcSWhGXwO73v/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jR0CkqHpBkgqkHy4RY7V1yey35isVzcQ4rmBYYu5bmvMHCZpyVYTr3Vmoo8R/kdmu
	 AGj1ctlMFEHiJtWl4ePdxEtYKzflJPRSXfsCs9jyo3wB21t8pimlezVLhbs7VxBwkM
	 uyjFLe1duAA/lU4QlQxESwcKXAgWvwIhS7r1CggE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436821AbfHWQjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:39:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41309 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390847AbfHWQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:39:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so9420904ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYa2Qs9up8NB/MJ/vRw1SFbPvn8eAXmUwSsfTYCDL7Y=;
        b=XkWUUMSRzE5E25LIeu2aWU/YvR9XtsEwVeRadTbQUk9LjnsvBxBiDlE7qwO1sPnZA7
         KK5kRhKMUepicmyYQQ3ZXbwTfCBAitbTw7pRRFO/qKau+JS4en5EWAVqIsm+3WUnleJ/
         jSRB918U2RKdk59cOw24NZWNHRc65JoSyJdBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYa2Qs9up8NB/MJ/vRw1SFbPvn8eAXmUwSsfTYCDL7Y=;
        b=nbHoTDlGVF5ChMVT20gXOzJnumd0IzLTpTGCN06sTIPCZEYTn/DIDE7IqHh/0BKTda
         s1dOMov7QR8JJ8XntX3RanMAgMjVK8zm/8ItZQHSL8zBq2YgBmZOoBQtRFWb58kCP/op
         IbJyOs5bxm9B17HjKNTPt22A9eTYmUjkPlkqfzr9gk30PvzvVmJglc297nDnjX9UIrLX
         tSeTWQU5fdmB5hoN8uFPvHCuUtgDKoYbWCzEN6MIB372TjcfXn89YM0QQhYkCyggurmY
         VG4uzS/c8b5ywe8nk4ygUo0eDzFhs1elWLG42qQwnTimgbyYDxy335VvSQk0R9qGyfrg
         VQFA==
X-Gm-Message-State: APjAAAXpFKPmFR4HlyAKBDhDoP0MOY+mCQGJvIQwIAfJ6webxe1Uzzsm
        UdQVD7hNnPb25bh/4NK7jjYZzFrMwWg=
X-Google-Smtp-Source: APXvYqwTf3FYU3FXFYW3utHOcwRZh+QtfYE1yilH+G/bbRKOA2bDxl4ojZgvRM39hPkh2+4O+Dj1bw==
X-Received: by 2002:a2e:4601:: with SMTP id t1mr3625149lja.102.1566578391507;
        Fri, 23 Aug 2019 09:39:51 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g12sm647948lfc.96.2019.08.23.09.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 09:39:50 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x18so9477337ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:39:50 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr3485159ljo.90.1566578390307;
 Fri, 23 Aug 2019 09:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com> <20190823091636.GA10064@gmail.com>
In-Reply-To: <20190823091636.GA10064@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Aug 2019 09:39:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
Message-ID: <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 2:16 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> > +      */
> > +     if (fatal_signal_pending(current)) {
> > +             if (!(error_code & X86_PF_USER))
> > +                     no_context(regs, error_code, address, 0, 0);
>
> Since the 'signal' parameter to no_context() is 0, will there be another
> signal generated? I don't think so - so the comment looks wrong to me,
> unless I'm missing something.

The old case only handled the kernel case - which never added a signal
at all, it just failed the access (and results in EFAULT or similar,
but nobody cares since the whole point is that the process is going to
be killed).

The *changed* case handles user space accesses too - by just returning
without any new signal being generated. The old case would fall
through to the "generate SIGSEGV", which seems pointless and wrong
(and also possibly generates misleading messages in the kernel logs).

> Other than that, what we are skipping here if a KILL signal is pending is
> the printout of oops information if the fault is a kernel one.
>
> Not sure that's a good idea in general: carefully timing a KILL signal
> would allow the 'stealth probing' of otherwise oops generating addresses?

That sounds really like a non-issue to me. Plus the old code ALREADY
did that exact thing. The only _new_ case is that it does is silently
for user page faults.

> I.e. I'm not sure this hunk is necessary or even a good idea.

As mentioned, the new code doesn't change the case you are talking about at all.

The new code only changes the case of this happening from user space,
when it doesn't generate a pointless signal and a pointless possible
show_signal_msg() garbage for a user mode access that was denied due
to the new

> > +     if (flags & FAULT_FLAG_KILLABLE) {
> > +             if (fatal_signal_pending(current))
> > +                     return VM_FAULT_SIGSEGV;
> > +     }

code in handle_mm_fault().

And you said that new code looks fine to you, but you didn't seem to
realize that it causes stupid incorrect kernel messages to be printed
("segfault at xyz" etc) that are completely wrong.

Because it's not a "real" SIGSEGV. It gets repressed by the fact that
there's a fatal signal pending.

Otherwise we'd have to add a whole new case of VM_FAULT_xyz..

             Linus
