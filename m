Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82326CA9EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524A9205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="O1Vynvw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfJWEUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 00:20:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51873 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfJWEUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:20:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so12371875wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y/LNPigbQ9TB22k2a7RkBNKb5Cm/9R5+HbTyQH04m7U=;
        b=O1Vynvw3eN1/NbNkI1c0SyDg2V/EkrhR9wp6vkwC4xTXDLAluIn8cynh/VXr4ZdtLc
         YkLjkqyRjDf2WIMYXKfuyQYtOQE30/5EgnWBn65L/7X+wul5U/YEsA8xDxSAh58xQrpr
         /+BujZ4ra4A6iDundfSpVzKYMhWNuxHpJ+5BNaIgsAJOGXUX9A6p3vCOU1iyHIhOMVsf
         s+8w+vDRWfin/kSpbgmwYNMs/hgi+9teFu96AFopk3VG7DhHb/gkkLgNe0fNdzTbRNbi
         9uEI5ryHesei0FaCHhUvwDVkmOKtyqRWRgkhJ1C+GbW1NqdHhJILuUsf8wKazszK2Ghl
         pc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y/LNPigbQ9TB22k2a7RkBNKb5Cm/9R5+HbTyQH04m7U=;
        b=tn3iHYrTZzoYT0pXVVceAFeJfpg8yYzJN28o8hxrjRLWtiDvYdv6NbBr5374pR3Pks
         PhXPNOp9I7ROXK1+rZK36ZckLZpkbiX7tH/5/vPQ7YPXjBS9jVVEBUfftoZMHNctSmXE
         nwlMh4/5t9OA75tD4WBhGr1tfFlTjiD/s2H3s3Pet/xRsF3qAozIoOtxjyxrlvJw5ZRt
         IjQU3VlzI0BHwrc+LOdn1DPzRFIAdoj/OQXmAMI+97QOBpXkZTB9X6iGtm2GQLF344dt
         N6CnjbbfKfe9PbgkfdCUwZoYLHCYjSjf6/9AE/CEqQSDFMSEvVsMVWngQnS2VXXnoQdV
         xdPA==
X-Gm-Message-State: APjAAAW7qMn/3C78rbG9C9u6siEfGfnOM4IbEe9iTYDq17TpmyeEYP73
        b+BUnQZqUXlz/2MX/8B/A8lcHrSIW7J84aN/8uB7Aw==
X-Google-Smtp-Source: APXvYqzbNjvdXoXovFD8/74Z9eOicgtaHQjLEWjtEDYS8CkjXlBNsXXL+yHcMacIcWKZs+ur8tNREX6MBtUxkd3hHkQ=
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr5789097wmg.79.1571804439825;
 Tue, 22 Oct 2019 21:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
 <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net> <20191022234921.n5nplxlyq25mksxg@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191022234921.n5nplxlyq25mksxg@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 22 Oct 2019 21:20:27 -0700
Message-ID: <CALCETrUa02muQYndyyeOZu8C6v33+A+9-2bsktxaW5N5-X6axA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 4:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 22, 2019 at 03:45:26PM -0700, Andy Lutomirski wrote:
> >
> >
> > >> On Oct 22, 2019, at 2:58 PM, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
> > >>
> > >> =EF=BB=BFOn Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wr=
ote:
> > >> I gave a solution for this. And that is to add another flag to allow
> > >> for just the minimum to change the ip. And we can even add another f=
lag
> > >> to allow for changing the stack if needed (to emulate a call with th=
e
> > >> same parameters).
> > >
> > > your solution is to reduce the overhead.
> > > my solution is to remove it competely. See the difference?
> > >
> > >> By doing this work, live kernel patching will also benefit. Because =
it
> > >> is also dealing with the unnecessary overhead of saving regs.
> > >> And we could possibly even have kprobes benefit from this if a kprob=
e
> > >> doesn't need full regs.
> > >
> > > Neither of two statements are true. The per-function generated trampo=
line
> > > I'm talking about is bpf specific. For a function with two arguments =
it's just:
> > > push rbp
> > > mov rbp, rsp
> > > push rdi
> > > push rsi
> > > lea  rdi,[rbp-0x10]
> > > call jited_bpf_prog
> > > pop rsi
> > > pop rdi
> > > leave
> > > ret
> >
> > Why are you saving rsi?  You said upthread that you=E2=80=99re saving t=
he args, but rsi is already available in rsi.
>
> because rsi is caller saved. The above example is for probing something
> like tcp_set_state(struct sock *sk, int state) that everyone used to
> kprobe until we got a tracepoint there.
> The main bpf prog has only one argument R1 =3D=3D rdi on x86,
> but it's allowed to clobber all caller saved regs.
> Just like x86 function that accepts one argument in rdi can clobber rsi a=
nd others.
> So it's essential to save 'sk' and 'state' for tcp_set_state()
> to continue as nothing happened.

Oh, right, you're hijacking the very first instruction, so you know
that the rest of the arg regs as well as rax are unused.

But I find it hard to believe that this is a particularly meaningful
optimization compared to the version that saves all the C-clobbered
registers.  Steven,

Also, Alexei, are you testing on a CONFIG_FRAME_POINTER=3Dy kernel?  The
ftrace code has a somewhat nasty special case to make
CONFIG_FRAME_POINTER=3Dy work right, and your example trampoline does
not but arguably should have exaclty the same fixup.  For good
performance, you should be using CONFIG_FRAME_POINTER=3Dn.

Steven, with your benchmark, could you easily make your actual ftrace
hook do nothing at all and get a perf report on the result (i.e. call
the traced function in a loop a bunch of times under perf record -e
cycles or similar)?  It would be interesting to see exactly what
trampoline code you're generating and just how bad it is.  ISTM it
should be possible to squeeze very good performance out of ftrace.  I
suppose you could also have a fancier mode than just "IP" that
specifies that the caller knows exactly which registers are live and
what they are.  Then you could generate code that's exactly as good as
Alexei's.
