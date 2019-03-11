Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A028B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz3xsJ9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfCKUul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:50:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39540 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCKUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:50:35 -0400
Received: by mail-io1-f66.google.com with SMTP id x3so102163ior.6;
        Mon, 11 Mar 2019 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h3e09nPexFL1d+StgQQ2seLSeIrMyIbV2/hM/Z+YGuI=;
        b=jz3xsJ9zknfNxcqL63/8AK35ddZujWqTu3vt6GRMpHnYa3a8HREYGdg2wmiMKxYUKP
         7YG+6UQYpdjI64YY8ehDQT8LxATEGgcK7M8wBWAvEXqb+uJgzMfCU+NZ7PKsSGD+swr4
         Qh4WdTZ6g+zVSIN78dopmBSuhzvPMVbey5a7ObZSgdhRFjC+HHNyk+V40964ugArHxlk
         W1eo8FmIc5AjMcmm0EmkwGK1sRRDXnWIBAJgxQzKk7e2HVQJqS5CUpqGllPEcVyBGvVK
         EBtUXRAoeAGXiynVeXwRkduUFbhUjWllU28kGirMFK6DEI8O8kS3iddu2G8Fzg3oKyii
         /PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h3e09nPexFL1d+StgQQ2seLSeIrMyIbV2/hM/Z+YGuI=;
        b=KUclBmY6z6eeHhquLCHJJO9HpltOOKNkOP1TbEn3X2XHnx9v9GkiRh79BPleBfbU8J
         s/dnbeQOmfMjoivAmmXRGHq2opz7CtyQ1Musq5BqTHudyATh1qZDusHak5MLl+sB4P8I
         1F5bxvqEUvcudPh8yg9d0T8Y3INtAGK6AQNf0SWpRuMx6mu3ZlutASr5l4hfApEKnByB
         tZyuZsE+c/w1OoUCEoK92rVNwNOzy16G2vkB1uFVdKgBM/62AY7sD4xQGvypQIGTrJb2
         Qq0nUkD0Mdy6mXsIiqVR1z7VZDRc1C5Nn/8w0yERZykC32N6hfQyZINqXuhLzAochCLV
         zJqw==
X-Gm-Message-State: APjAAAW3iSxuWJGq3SPUKLDfG0schEWhtbjFpDvLYpzhOaiDBTwSKXJp
        VHCkABZyuQ6OYUL3UBWdSh4184GwZYNUITFUb0U=
X-Google-Smtp-Source: APXvYqwFPP3uVjpJAc0mbhr0ge++2Fns2p9ZjUEhfxpcAxpeiaggHOy+G0J9yOMtcNZp6jRpFxzdvo7ceyPDNRrVn7k=
X-Received: by 2002:a6b:c543:: with SMTP id v64mr18449937iof.6.1552337433952;
 Mon, 11 Mar 2019 13:50:33 -0700 (PDT)
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
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 11 Mar 2019 13:50:21 -0700
Message-ID: <CAEdQ38F3RxBXB2ow3L7F4vQd5JnJLPJ-mEqCK5ENV7NDQO9eJQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:47 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> w=
rote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Mon, Mar 11, 2019 at 11:08 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
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

I agree. I was not aware that a.out was effectively the same as ECOFF.
