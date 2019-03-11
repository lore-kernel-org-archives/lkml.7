Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D773C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88AC20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfCKLCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:02:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44803 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCKLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:02:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so2376464qkj.11;
        Mon, 11 Mar 2019 04:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lf2IrSFaiNZ6uVVV9GTG38DOCEKqyi8KfqRbP6Lsg+o=;
        b=S5XFvnYYCOXiePvFByq2BSmS7oEx+1I2Ufz2FONsHs9emHQG3DNqc9jTIIPYQCJQlJ
         3GDzVHRJ8ZgifJGtOmMZykoKrl5Kdy8F1J4M+iln3gvKW5ZhjnHl5t4irvdVsXsbLilJ
         DcwtMsgfar8+4LE+exCRrIW/o+8/Q8xIkji3I4Owi3ydpkIF5ZrVRPt0E1i2y9kv8I9e
         8rN9sAU9R55GeZ4zJHgLa3ubOWi4fRnxGR8xhF28Hx9pJrpC2sIYBOo9zS3MLC/rarvi
         GCSUy//rugJIy4dUx9s0U+rYeu3cYY86mp4h24QG1EB0BYcvTFy+YdOP6kQOHD3x7xz7
         gtnQ==
X-Gm-Message-State: APjAAAVEDqkvS8y/isJyKRK2GRsvbXFwnUC3KCTBxMiPwFeRquZWQ1Jh
        ojgrM+JOk3RP9uA5oA4O3+bdkPDf7sW3d/OQ01E=
X-Google-Smtp-Source: APXvYqyh3pzX5mUwDjlxQh0d9Dv8IeAseXrOzv/fVT5mIhjTNSnTNQZZRclk0v+fLz1hoymFJWOe3958TeSxu7tE0ys=
X-Received: by 2002:ae9:e10d:: with SMTP id g13mr10521517qkm.343.1552302170367;
 Mon, 11 Mar 2019 04:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com> <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
In-Reply-To: <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 12:02:33 +0100
Message-ID: <CAK8P3a2cc0QoG8=y343vXaVQHHayJKT_hSLRDPx-awRdB1MutA@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@alien8.de>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 11:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 10, 2019 at 2:37 PM Matt Turner <mattst88@gmail.com> wrote:
> >
> > I'm not aware of a reason to keep a.out support on alpha.
>
> Hmm. I was looking at removing a.out support entirely, but it's
> actually fairly incestuous on alpha.
>
> For example, arch/alpha/boot/tools/objstrip.c very much has some a.out
> support in it. Maybe it can just be removed entirely.
>
> There's also an a.out.h include in arch/alpha/kernel/binfmt_loader.c.
>
> Finally, note that CONFIG_OSF4_COMPAT also no longer makes sense
> without a.out support.
>
> So this attached patch does not compile on alpha, but it's been many
> many years since I had an alpha to test with, so I'm stuck.
>
> Matt, can you fill in the details and complete this patch?

I wonder if we could remove the osf time32 compat code as well,
this was one of the areas that kept causing problems with the y2038
rework. (I think it's all good now, but it's never been tested as far as I
can tell).

For some syscalls (e.g. brk, mmap, getxuid, ...) we definitely need to
keep the osf1 version, since it is the only supported ABI.

I just looked up some really old source trees and found that glibc-2.1
was the first release to use 64-bit time_t the way we do it today,
as implemented in [1], so all Debian and SuSE releases for alpha
had it, but any ELF binaries built on Red Hat Linux 4.x and 5.x
(released 1996 through 1998) or earlier would use 32-bit time_t
osf1 syscalls. Red Hat 2.x and 3.x were a.out based on alpha.

      Arnd

[1] https://repo.or.cz/glibc/history.git/commitdiff/64819b5c3a94e81e4
