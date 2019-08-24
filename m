Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E2C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B86D2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566668526;
	bh=yly5sFTo+a6v2vjaAcj1kiZIZD38+OFrCyG+/GfsxPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YxqFqSFnIK52f1LtcRdGW5OK8XJP/ydxlds3ZTRTALkkPUUNIY3AEXMVVAGH47Ozx
	 gtw15POREuc5pbchRtttVdpHoTOenyjXuLG2f5pIBtHhjiN66nOUo0ayhXiewiqyl6
	 fHFYQdZ16w5YnsdQ3uWETE1PAtEuufmRyT1EqFZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfHXRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 13:41:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43056 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfHXRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:41:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so9342309lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWNLoKRhZGbJK72flTwiREpe5vM9DrBzk3dGtQIZvWw=;
        b=PvyMCaoEY8WOKLiNw2muT+Zmol3Dc/QZ8Kcl7xZ/MHm7dKrp3a4H3HrbE66xW/0t9S
         RNZ+zuAG2L0aXLH+jOZiSSYVcacoNtW2spHcEz03u5Yx8/OnmIk6oUFwnp245jQthdrg
         2ncH3wuLn/Rx7mIITrk8GIwwLIysZD9mLFiUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWNLoKRhZGbJK72flTwiREpe5vM9DrBzk3dGtQIZvWw=;
        b=EHmJ163Kx+GlDGLgkbdqtsO1/2OWVKAw2ZLzsOY7/foslQ5X3JVoRbgj2GK0GwhEu7
         TQoVaV+mtdl+3JfXaMGkCrWZjShXbYCNZqVYAEMT0jEKc3oZiCOATcfN+hlYF0R3EpLf
         z41sHg1d8i6yWJgnv2rdngGJ918b/gY+0eallANbmOTlKgIDDNR0EY/uJaP9mpZR3h3O
         DNCCrEzu8M1IO+A6QuYkUuyQL1Gtmgnk2zoDYwe9ZFIhVM8OSwYOVVnkoWQK23W/25u6
         JqQeYqe3S7ZtGEafrGvUucSmcsgn+3S9TEJDEHMuHfD1jtvFcjSN/CE/cRmGzZ//xjMc
         /uwA==
X-Gm-Message-State: APjAAAV3OnLAznP9qYvDMks3vZ09PTQZx2eoJrsPA33iKvBf8ZWcf7HW
        xwWUIZ8fzG4gcKeqSbkh03T01yqUJk0=
X-Google-Smtp-Source: APXvYqzSPhREwAR3oUyMwfmCdsBkd3je4eKQNKkwjZUNxXjUhslaMx9RYu2vbAe1B5z2VxwcrTjPNQ==
X-Received: by 2002:a19:488f:: with SMTP id v137mr823161lfa.26.1566668465218;
        Sat, 24 Aug 2019 10:41:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m4sm1206774ljj.78.2019.08.24.10.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2019 10:41:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m24so11586777ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 10:41:04 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr6105481lji.52.1566668463591;
 Sat, 24 Aug 2019 10:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com> <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
In-Reply-To: <20190824161432.GA25950@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Aug 2019 10:40:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
Message-ID: <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
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

On Sat, Aug 24, 2019 at 9:14 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> What I noticed is that while reading regular RAM is reasonably fast even
> in very large chunks, accesses become very slow once they hit iomem - and
> delays even longer than the reported 145 seconds become possible if
> bs=100M is increased to say bs=1000M.

Ok, that makes sense.

So for IOMEM, we actually have two independent issues:

 (a) for normal unmapped IOMEM (ie no device), which is probably the
case your test triggers anyway, it quite possibly ends up having ISA
timings (ie around 1us per read)

 (b) we use "probe_kernel_read()" to a temporary buffer avoid page
faults, which uses __copy_from_user_inatomic(). So far so good. But on
modern x86, because we treat it as just a regular memcpy, we probably
have ERMS and do "rep movsb".

So (a) means that each access is slow to begin with, and then (b)
means that we don't use "copy_from_io()" but a slow byte-by-byte
access.

> With Tetsuo's approach the delays are fixed, because the fatal signal is
> noticed within the 4K chunks of read_mem() immediately:

Yeah. that's the size of the temp buffer.

> Note how the first 100MB chunk took 17 seconds, the second chunk was
> interrupted within ~2 seconds after I sent a SIGKILL.

It looks closer to 1 second from that trace, but that actually is
still within the basic noise above: a 4kB buffer being copied one byte
at a time would take about 4s, but maybe it's not *quite* as bad as
traditional ISA PIO timings.

> Except that I think the regular pattern here is not 'break' but 'goto
> failed' - 'break' would just result in a partial read and 'err' gets
> ignored.

That's actually the correct signal handling pattern: either a partial
read, or -EINTR.

In the case of SIGKILL, the return value doesn't matter, of course,
but *if* we were to decide that we can make it interruptible, then it
would.

> I also agree that we should probably allow regular interrupts to
> interrupt /dev/mem accesses - while the 'dd' process is killable, it's
> not Ctrl-C-able.

I'm a bit nervous about it, but there probably aren't all that many
actual /dev/mem users.

The main ones I can see are things like "dmidecode" etc.

> If I change the fatal_signal_pending() to signal_pending() it all behaves
> much better IMHO - assuming that no utility learned rely on
> non-interruptibility ...

So I cloned the dmidecode git tree, and it does "myread()" on the
/dev/mem file as far as I can tell. And that one correctly hanles
partial reads.

It still makes me a bit nervous, but just plain "signal_pending()" is
not just nicer, it's technically the right thing to do (it's not a
regular file, so partial reads are permissible, and other files like
it - eg /dev/zero - already does exactly that).

I also wonder if we should just not use that crazy
"probe_kernel_read()" to begin with. The /dev/mem code uses it to
avoid faults - and that's the intent of it - but it's not meant for
IO-memory at all.

But "read()" on /dev/mem does that off "xlate_dev_mem_ptr()", which is
a bastardized "kernel address or ioremap" thing. It works, but it's
all kinds of stupid. We'd be a *lot* better off using kmap(), I think.

So my gut feel is that this is something worth trying to do bigger and
more fundamental changes to.

But changing it to use "signal_pending()" at least as a trial looks
ok. The only user *should* be things like dmidecode that apparently
already do the right thing.

And if we changed the bounce buffering to do things at least a 32-bit
word at a time, that would help latency for IO by a factor of 4.

And if the signal_pending() is at the end of the copy, then we'd
guarantee that at least _small_ reads still work the way they did
before, so people who do things like "lspci()" with direct hardware
accesses wouldn't be impacted - if they exist.

So I'd be willing to try that (and then if somebody reports a
regression we can make it use "fatal_signal_pending()" instead)

                    Linus
