Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A19C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5221520643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcetIFuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfCKS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37942 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfCKS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:58:40 -0400
Received: by mail-it1-f194.google.com with SMTP id k193so375951ita.3;
        Mon, 11 Mar 2019 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aLCvz858hUYTF/dMencUvDgx3C6vOwwgHb25WIkm1N0=;
        b=KcetIFuJsDmDeerEPxRqK0Fj8NPiy7HqxD/Rw3zfoGjChl+F30BS4LjwnB07yx8m0x
         ej+SPOKS5lXE4JjQDkZcD79Fs8p6PkwTmhdTyEpG/oqpFsumcjwQXzYPmG+cAfwLUwON
         LHbkla/38bHrmlAxxoG5cjuM+R1WVHHdAhfNfJqvZEYEXQ5gp+WqZ4zzxCDNNo0/lChV
         ifePUd0l4UJ266kfrWkhIIQUUs497eL4l2stqCyUTfWks2tIrzgbhYugI05YHufzi3j1
         omROnIzKbrWBCyxlaTVKJqQuDu0jYRuB/fuI8pxrFd8uFHPVL23qSXXo9BsqbKTj0Kwb
         y8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aLCvz858hUYTF/dMencUvDgx3C6vOwwgHb25WIkm1N0=;
        b=aS5RaMLM29jtQ/Q++754cCz/evSF3c4UBN195CmvVYfuENclE2ZaGoF8HcMFWg8M7k
         bljqQarTWFahbcNbze5KSAnTcSbGlUqPRe6dg9bMWWxfEaEiY/B3msfJNWkp0SdMBR03
         G0PiMHgtNMEoOTbETL8V6avSCcybNILZrf+YersUiUiPWiZpWVJD8kDe2ZH+/hqPM5Gs
         +A6jWLg7mFhkvwocVmBb+vkCpdvLacZXODcWiWVDh1tpND0ntDhFN2Kj4D6KiM8SbhD7
         TA8k+r7gPyEf/DhpSarb1tKlG4umtcNK4EjmuhHXirzMw+qAE0jRFGZydS/qR1IRSvyc
         FzfA==
X-Gm-Message-State: APjAAAUAOmEH5AUxev2Jp6IW6pTPFg61vgoWOCjAoZ89CGBgfPJWDciK
        Edi9Lz1vMECYzh1HBbCzNJ93QHhI6CVKH6WP7h8=
X-Google-Smtp-Source: APXvYqymFtArCQ9y5bKE49/fdRh9KOq5Ie02DTR9XQy/wMd/48pdJT4wpoBAPi5ieAq96+jtQRT5XsuUpa28/LwYsj4=
X-Received: by 2002:a02:c84f:: with SMTP id r15mr18184954jao.97.1552330718723;
 Mon, 11 Mar 2019 11:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com> <yw1xa7i14btw.fsf@mansr.com>
In-Reply-To: <yw1xa7i14btw.fsf@mansr.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 11 Mar 2019 11:58:26 -0700
Message-ID: <CAEdQ38ESK4mz6T4=fO_1Zyg-jJfhR3A+jg2Nw0rMKq-p_1U0UA@mail.gmail.com>
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

On Mon, Mar 11, 2019 at 9:26 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Sun, Mar 10, 2019 at 2:37 PM Matt Turner <mattst88@gmail.com> wrote:
> >>
> >> I'm not aware of a reason to keep a.out support on alpha.
> >
> > Hmm. I was looking at removing a.out support entirely, but it's
> > actually fairly incestuous on alpha.
> >
> > For example, arch/alpha/boot/tools/objstrip.c very much has some a.out
> > support in it. Maybe it can just be removed entirely.
> >
> > There's also an a.out.h include in arch/alpha/kernel/binfmt_loader.c.
> >
> > Finally, note that CONFIG_OSF4_COMPAT also no longer makes sense
> > without a.out support.
>
> Anyone running an Alpha machine likely also has some old OSF/1 binaries
> they may wish to use.  It would be a shame to remove this feature, IMO.

Tru64 5.1 uses ECOFF binaries, I believe. Do you know when OSF/1 /
Digital UNIX / Tru64 switched from a.out to ECOFF?
