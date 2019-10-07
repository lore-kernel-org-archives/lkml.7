Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD1ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF87206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472816;
	bh=s51GuTf5UBNeGJTJcuN9WJYnvjNCzJywyuwt+janFlw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d90TBoI9WJtYOWafZkPVcPejtqn5OX/U8AMsvzrjS4kAxVYUSDSSDmZL3vTkyXoyI
	 Kbg+1ogaIp/TY/oE2jKPKhBkmNktBGoHWt2HgnSfzYXqss1OAC05ofX0NSkHnaTD5i
	 plRJW8ZgR2I7OVVqZZJuk2arT/VY0vFUX+iHvcMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJGS0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:26:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40508 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfJGS0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:26:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so9986978lfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7Vyfz7UunT8KOMcxUj/KmQkAWydtzjl94OFb9852io=;
        b=ZUn2yZzwcywqCxfn/AooAu387VR/0wKoIuT2JKs4AdSOiBNTdCv38NkIJUhxDyBMvm
         CxtfD2syu3hHc4adBEBg4Ms4tb9HKuwIqUen1FqsmJsnDmMRUSO48rcpHdmThYY1FDYF
         3ZvrBHe0Vp5A5d6MZRxEURRDKHOtBXvn6vAcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7Vyfz7UunT8KOMcxUj/KmQkAWydtzjl94OFb9852io=;
        b=rY9Jaug+KTQFZ0bU+yCIUgpneWaxv0dbZ2ulxJpN2iog131sZ0sbB0ctrWXqJBEfxu
         wNGbgMEAjsTgnQfoUF3Qfx78QWqcqCVZvdqFPRFJBIxU6bPb4C55ia3vD31Mk/8oFXy3
         RItZ4oZMBtl/Da5T2v5BjkKQZ/36xlJULYSUsaKh7XTJppmmfUyVH+Bf2gdd9y6ZZLkV
         OIRlMfw4YcQyZpoEGkXJTBHXLqqENIJ8+So50qQ1rwmdMSMX2hbn4dlGlM1KNCNyvhAl
         UJ2dcyfrKgzdOq+1gi6GayFkLKgxVsQ9Uy/9wfPFto6pHYUkSzWosxtE1T7TXykqW8kc
         94fw==
X-Gm-Message-State: APjAAAVZqOpnjbub7FoJXUwzNqNuFymhw2WQs9Vv5dI8R/PwAEmWuQuq
        6kZMVYGBalw3zjbYL8hdS9DJyw9I1VM=
X-Google-Smtp-Source: APXvYqz8j4u08eTU8ybEXfNrA4uDl2SHTufAJkLyPBuF7pIwWobob/ck6YEjAjFyLF4WRh0Goci7hw==
X-Received: by 2002:a19:7b03:: with SMTP id w3mr11208685lfc.16.1570472812959;
        Mon, 07 Oct 2019 11:26:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c69sm3390543ljf.32.2019.10.07.11.26.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:26:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t8so9941387lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:26:52 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr17755031lfe.79.1570472811673;
 Mon, 07 Oct 2019 11:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
In-Reply-To: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 11:26:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
Message-ID: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 8:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> >
> > The last two should just do user_access_begin()/user_access_end()
> > instead of access_ok().  __copy_to_user_inatomic() has very few callers as well:
>
> Yeah, good points.

Looking at it some more this morning, I think it's actually pretty painful.

The good news is that right now x86 is the only architecture that does
that user_access_begin(), so we don't need to worry about anything
else. Apparently the ARM people haven't had enough performance
problems with the PAN bit for them to care.

We can have a fallback wrapper for unsafe_copy_to_user() for other
architectures that just does the __copy_to_user().

But on x86, if we move the STAC/CLAC out of the low-level copy
routines and into the callers, we'll have a _lot_ of churn. I thought
it would be mostly a "teach objtool" thing, but we have lots of
different versions of it. Not just the 32-bit vs 64-bit, it's embedded
in all the low-level asm implementations.

And we don't want the regular "copy_to/from_user()" to then have to
add the STAC/CLAC at the call-site. So then we'd want to un-inline
copy_to_user() entirely.

Which all sounds like a really good idea, don't get me wrong. I think
we inline it way too aggressively now. But it'sa  _big_ job.

So we probably _should_

 - remove INLINE_COPY_TO/FROM_USER

 - remove all the "small constant size special cases".

 - make "raw_copy_to/from_user()" have the "unsafe" semantics and make
the out-of-line copy in lib/usercopy.c be the only real interface

 - get rid of a _lot_ of oddities

but looking at just how much churn this is, I suspect that for 5.4
it's a bit late to do quite that much cleanup.

I hope you prove me wrong. But I'll look at a smaller change to just
make x86 use the current special copy loop (as
"unsafe_copy_to_user()") and have everybody else do the trivial
wrapper.

Because we definitely should do that cleanup (it also fixes the whole
"atomic copy in kernel space" issue that you pointed to that doesn't
actually want STAC/CLAC at all), but it just looks fairly massive to
me.

            Linus
