Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EC320657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfCKVep convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:34:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34838 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfCKVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:34:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so336173qte.2;
        Mon, 11 Mar 2019 14:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nrHq7yZf8D9z0i9FW4UPhbrDKoMd6sDIcTNy4S1jgA0=;
        b=n419Sjr5xz1CIept8JGDD+1xeVwjqjYTDyD4wRvRR3uE26SamX3/oMTH0s0HnspfbC
         up2l4+mZ4eesW9hdIHYsVsbD2ef540YXDSTL9fw9Xzg/EtOHhwIMMyEcLXWpxhORYlDz
         Pg2kavuoFirkrYkDlIFDLC5vdAW/RZ9/5pwQFkf+tODXztjbXIr+d+1RQBlxUqRfBCAn
         FMbCmvGOteGPgYArCh2AkoJhr24Sx/C/j1oPYi2bt0iF/nLgt8drNYBMWryiT4bWIspK
         shoaqyUfR3OG4cumFKd/ZCxfRDFUrugVhED/SGhCZxBPHP4vCx1tJ7Trhja+xZKelgcj
         R9dw==
X-Gm-Message-State: APjAAAXy5KzLsAsC25OQdiSr+E7AQQuUHCIKQQFl9fdhlLGwvvMAJop5
        im7d7BwXQa45AkX4xesBhzYJedwfSznxCSK5Jb++vjh2
X-Google-Smtp-Source: APXvYqziNzwGjEEBBFr3p4AAMX7aM6pxJUfKYtFgXjzB6jLucrqbIevpeLAxI+Ois9dU6S749WDR3RpIYJXL/axEIC8=
X-Received: by 2002:ac8:1e17:: with SMTP id n23mr5425799qtl.152.1552340083914;
 Mon, 11 Mar 2019 14:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
 <yw1xa7i14btw.fsf@mansr.com> <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
 <yw1x5zsp473a.fsf@mansr.com> <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
 <yw1x1s3d42ia.fsf@mansr.com>
In-Reply-To: <yw1x1s3d42ia.fsf@mansr.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 22:34:26 +0100
Message-ID: <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:47 PM Måns Rullgård <mans@mansr.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Mon, Mar 11, 2019 at 11:08 AM Måns Rullgård <mans@mansr.com> wrote:
> >>
> >> The latest version I have is 5.1, and that uses ECOFF.
> >
> > ECOFF _is_ a.out as far as Linux is concerned.
> >
> > So Linux basically treats ECOFF as "regular a.out with just some
> > header extensions".
> >
> > We don't have any specific support for ECOFF.
> >
> > I _think_. Again, it's been years and years.
>
> Right, which is why killing a.out entirely would have the unfortunate
> effect of also removing the OSF/1 compatibility on Alpha.
>
> If we are to support Alpha as an architecture at all, it makes sense to
> support the things people actually use it for.
>
> Now, personally I can live without it.  I just don't like to see
> features removed without due consideration.

The main historic use case I've heard of was running Netscape
Navigator on Alpha Linux, before there was an open source version.
Doing this today to connect to the open internet is probably
a bit pointless, but there may be other use cases.

Looking at the system call table in the kernel
(arch/alpha/kernel/syscalls/syscall.tbl), we seem to support a
specific subset that was required for a set of applications, and
not much more. Old system calls (osf_old_open, osf_execve,
osf_old_sigaction) are listed but not implemented, and the same
is true for most of the later calls (osf_fuser, osf_sigsendset,
osf_waitid, osf_signal, ...), just the ones in the middle are there.
This would also indicate that it never really worked as a
general-purpose emulation layer but was only there for a specific
set of applications.

Another data point I have is that osf1 emulation was broken
between linux-4.13 and linux-4.16 without anyone noticing, see
47669fb6b595 ("alpha: osf_sys.c: fix put_tv32 regression").

      Arnd
