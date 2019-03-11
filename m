Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF664C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983EB20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXgA5uqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfCKWMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:12:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39093 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKWMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:12:08 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so285331ior.6;
        Mon, 11 Mar 2019 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ysx/UKq12I/Rua0O3R7u5gG/pK1ykD+ChVMzn+XGK9c=;
        b=rXgA5uqDORBu7CQJgLjbHr7TzTh1f6prMxD8vThCsfeuJOOH+CgSKlUuVKKnBwXyjR
         N3EXVhcRLGwg31uHQVX4QqqvLOBy/I0ap2AkOol0y80vJuDuO+mT729xmdlJWDPYL10x
         mqKTLJYbRmMqxJeCEotLJ8kLeBPp2/FNySn+0lmKY8+wqY09AuPVT8jILaIRpuyuxHRX
         krbgQ6vTiw4hTtZ7dKtBEx0xUfekJzQvIHlIEZbkbs2QnfwhNXlZLI0P8x6Xu6yzRuUL
         2etTcAoiwA/KAR+BVQ6C4MFna9vh4xsWzq+ULQWaQOZc8fjuIMu78Q31XcMMyv4HYQHJ
         QWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ysx/UKq12I/Rua0O3R7u5gG/pK1ykD+ChVMzn+XGK9c=;
        b=m1Iz8wzb/JqH2SjjiZy2eM7QNAdwA1KM7aCS/7PmclqHeRt5wSC4adX43rCdgYstu1
         oMLe4Rv/wXTfAVQ4aDhKRgIWBw8+CIakIyf8CuvrhR3O6ZTgS62R01PzZGJHuToxkxLe
         IwGSFe8IlIs4QggsiWdL/jixmJFNzyHPH6TsdEcYI4OnGorPRBObLBsf/Pr4T6QODzeu
         fg7ye/YjuLFAbcujzAmEv4lGWWjiOnpgm1z5gVnjjbCWorSy47FaWAN6Ms8gySwt5a6j
         GkdoGmj8kwVaTYQ4tiGme711JOo3KTOeE87klW0QprumNto+KBD2KTL2p88fOFZ/5zos
         FXlA==
X-Gm-Message-State: APjAAAXQbXzgV8zkUPqYM1rcANfZDn4q2HZx62Kd/WtbUiAq8IcU24k2
        3K0rEhqYHbMd/yQ8Tbi+jE/tdCM+LWQI24BtnY8=
X-Google-Smtp-Source: APXvYqzKQCeCbE6sJ7LamwAOUuZEZ/2+//WBXpqwUq35KFjNkZfwMGCK5Rx+YGOwGJLAzSmDOKNX8jRR2zOI4AinQTo=
X-Received: by 2002:a5d:8590:: with SMTP id f16mr17940276ioj.70.1552342327011;
 Mon, 11 Mar 2019 15:12:07 -0700 (PDT)
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
 <yw1x1s3d42ia.fsf@mansr.com> <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
In-Reply-To: <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 11 Mar 2019 15:11:55 -0700
Message-ID: <CAEdQ38HSKy+muCwAk9w0yNCt649HVja1Pe+yY23-4zBjDvWFRA@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 11, 2019 at 8:47 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> =
wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > On Mon, Mar 11, 2019 at 11:08 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.=
com> wrote:
> > >>
> > >> The latest version I have is 5.1, and that uses ECOFF.
> > >
> > > ECOFF _is_ a.out as far as Linux is concerned.
> > >
> > > So Linux basically treats ECOFF as "regular a.out with just some
> > > header extensions".
> > >
> > > We don't have any specific support for ECOFF.
> > >
> > > I _think_. Again, it's been years and years.
> >
> > Right, which is why killing a.out entirely would have the unfortunate
> > effect of also removing the OSF/1 compatibility on Alpha.
> >
> > If we are to support Alpha as an architecture at all, it makes sense to
> > support the things people actually use it for.
> >
> > Now, personally I can live without it.  I just don't like to see
> > features removed without due consideration.
>
> The main historic use case I've heard of was running Netscape
> Navigator on Alpha Linux, before there was an open source version.
> Doing this today to connect to the open internet is probably
> a bit pointless, but there may be other use cases.

The best use case I know of is to run their C compiler. M=C3=A5ns sent
patches in fact to make it work.

There is a Linux version of the same compiler but I have a vague
memory that it's broken in various ways that the Tru64 version is not.
