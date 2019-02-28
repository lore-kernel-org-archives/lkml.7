Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85975218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp0owfE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfB1KFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:05:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46781 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfB1KFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:05:23 -0500
Received: by mail-io1-f68.google.com with SMTP id k21so16080958ior.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeEfp8MAqA+ucdvLUAqXs6r3S1y/W4WvU7P5Wd9L+zg=;
        b=jp0owfE0GN06XKZCVfZd6c1Sib8+d/UBwpQ+tcG7oaQKLc+f1E3UTK0tokksn1OneB
         6wb4zeCZWPv/QBCLnvmzebcuc3CeXIIhtrN/M3KcRqbqvykPgXlozFoC0XY7A0H7A3sx
         Kl0sXVB4P/7ejnzkb1tHXi39E8+OkSzcuJWw4wAkylZcqbGhmHVEBqYf71PbWYjSDWTK
         7w0I7Xn27W9cCXx0Lq3q8yPHRj4OlWLVFDstIoHc/8YAEP6ukqeRjoRZtoTV+HM0EUT1
         bmM9x9n4XI0B9GSgOWg2i57lVTOt6bkfJ+KVkoNPcVl0CZ2pJaZaUYozq39HeqVWbC3h
         dhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeEfp8MAqA+ucdvLUAqXs6r3S1y/W4WvU7P5Wd9L+zg=;
        b=PED8rWfkgBffX2D481Pfb7pghdtqGkCfCZPXkc2yvoyURcQHcw7jzdcMK1XhOw1TSE
         BkQwtA2RHI+WYPQl27RtzKz/AZ7j0G4mXkVrqeyHhlXEXWF6MtS0UZxwZu0b/WI3r//x
         09vS9b4m5U8Uz7DeE23nDXmHdUgy5nIrtrQ4cAhbYXvXrT/ZawTlrlYZ1PS2qpnLDY2C
         jEwVo/F4TDGvTyNxzq0l755Csn1Vf2dW148CvDXhVP2IzDlcO0nrmamX4aj/00TAmut9
         0m9xxNgHaYxJf7T2TRUp6sckc3XnyFqe/IAfFTWIxvQWRD7kN8akpGFQGOodCBPOjG3c
         Sx3w==
X-Gm-Message-State: APjAAAVw3+Rg09VFXijSSuziPhnA6Ofbv/B6zVwJbxuuorCKq2OfsiRb
        eiCPTNwRZOvv9BM6rJAH8jLfnFxCjU5M/ZNO0MosmA==
X-Google-Smtp-Source: APXvYqz39mhSjnsBynLAR2FICRcgXc8ALtLpsjYOn6HSJ5GsTeuYy4UHMqMkbMFQteay3YI7q6S4l9rm+uCwNkhcQ4w=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr4384239ior.271.1551348321770;
 Thu, 28 Feb 2019 02:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net> <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net> <20190227143313.GK32534@hirez.programming.kicks-ass.net>
 <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
 <20190227172816.GT32494@hirez.programming.kicks-ass.net> <20190228094008.GN32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YSi_XnjNnOhtL1ctQQuZViarxvN+muB-oCmakjgB9mzQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YSi_XnjNnOhtL1ctQQuZViarxvN+muB-oCmakjgB9mzQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 11:05:10 +0100
Message-ID: <CACT4Y+Y6yp+1fuOMM9xK2gzKk1tPvarjQuUaNC1h0L8EZKenQQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 28, 2019 at 10:40 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >
> > On Wed, Feb 27, 2019 at 06:28:16PM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 27, 2019 at 04:40:28PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Feb 27, 2019 at 3:33 PM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> > >
> > > > > Urgh, kasan_report() is definitely unsafe. Now, admitedly we shou=
ld
> > > > > 'never' hit that, but it does leave us up a creek without a paddl=
e.
> > >
> > > > If SMAP detects additional bugs, then it would be pity to disable i=
t
> > > > with KASAN (detect bugs in production but not during testing).
> > > >
> > > > You mentioned that exception save/restore the UACCESS state. Is it
> > > > possible to do the same in kasan_report? At the very least we need =
to
> > > > survive report printing, what happens after that does not matter mu=
ch
> > > > (we've corrupted memory by now anyway).
> > >
> > > Ideally we'll put all of kasan_report() in an exception, much like we=
 do
> > > for WARN. But there's a distinct lack of arch hooks there to play wit=
h.
> > > I suppose I can try and create some.
> > >
> > > On top of that we'll have to mark these __asan functions with notrace=
.
> > >
> > > Maybe a little something horrible like so... completely untested.
> >
> > OK, I got that to compile; the next problem is:
> >
> > ../include/linux/kasan.h:90:1: error: built-in function =E2=80=98__asan=
_loadN_noabort=E2=80=99 must be directly called
> > UACCESS_SAFE(__asan_loadN_noabort);
> >
> > Which doesn't make any sense; since we actually generated that symbol,
> > it clearly is not built-in. What gives?
>
> I guess this warning originated for user-space where programmer does
> not define them and does not generally know about them and signature
> is not a public contract for user. And then for kernel it just stayed
> the same because not doing this warning would require somebody to
> proactively think about this potential difference and add an
> additional code to skip this check and even then it wasn't obvious why
> one will want to do this with these functions. So that's where we are
> now.

Maybe asm directive will help to trick the compiler?
