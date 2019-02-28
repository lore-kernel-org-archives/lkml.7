Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488BB218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECHmsqcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfB1J7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:59:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40061 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfB1J7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:59:23 -0500
Received: by mail-it1-f196.google.com with SMTP id l139so12647766ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f3LqmqaebfffZUG5sjVxK/0AMd9MtYxsw0UIo2Axk5A=;
        b=ECHmsqcmWf+nI+Ty0vBCuMrZzfwnmz8b/N12F/9XAiaTHWVn+BJkltpIi1A30tj2MH
         L9uwpLVT9NUL3X2IjLW7B/INgQxbAnhcfc6I4Sd4ijKOLLJAcMTY9d5TWzs9x13Phh//
         gIFh5bbH5E+ehbQz4rPqnGXPfCelYau25fxvv0aGvRzsvmYKGwDCIkX0vxFmXg1SEbV5
         7aiSesB42dJ5r9vikjV6LBCb78p0SoadKFcCbhHbydpLuI5O13jyPZutvHTGd0FgRyWN
         3MxUxZsRZb/fdPs5I2QlvgdP9zCQB+rgO/VYThDUjMKav59+wk6Y2ikt//4oUNUv16o+
         6Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f3LqmqaebfffZUG5sjVxK/0AMd9MtYxsw0UIo2Axk5A=;
        b=iLT3IBRc2snUxSNkl6CHNhYwSTrHhnzjly8dGHBDtHz2NjY4ZJJ0NKDfiJoLO4Rtyj
         aYEPsE0L/TUZXV+DH0UX4aOYyxyHqbxernPlLhYwwFB9XXpBtGsEmvtmSpk8EMXRAVxu
         bXOZOd1nntlYdkcZE313BjVn4Urjn1M3ur3NBYKcGX/RB5v0oG3KFw7grB8JbdrkuO1N
         Qtm0Z8L2OStz5J8ZbEliFQkA7XeJMU1jqvKwe5A3NJhx2Puir6K9lnq1iTCSja0G7CeM
         1L6Oa1E9UmvPHLpA2q6Dn6Uo0JKHpGT99kMy07ZVz7iuCFqQiGUThYX2xrn4eVwE1XxR
         MorQ==
X-Gm-Message-State: AHQUAuZqMPOqb88eUc153v5Y9yazC24SI8K5gkMelHqef5iQrxD3k6tb
        G2ZfNVN3QRLWWn7vXHxPuspmWAy1nses+vE+E8oOYw==
X-Google-Smtp-Source: APXvYqzsXr+QsWeYa4mqx04C2qE6IQuhR5H5LjMJULqtejRfpbHuKgUS3jJLkyfOxBbVS0gVNvOFEkaex0wafufXNbc=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr2083911ita.144.1551347961884;
 Thu, 28 Feb 2019 01:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net> <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net> <20190227143313.GK32534@hirez.programming.kicks-ass.net>
 <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
 <20190227172816.GT32494@hirez.programming.kicks-ass.net> <20190228094008.GN32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228094008.GN32534@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 10:59:10 +0100
Message-ID: <CACT4Y+YSi_XnjNnOhtL1ctQQuZViarxvN+muB-oCmakjgB9mzQ@mail.gmail.com>
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

On Thu, Feb 28, 2019 at 10:40 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Wed, Feb 27, 2019 at 06:28:16PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 27, 2019 at 04:40:28PM +0100, Dmitry Vyukov wrote:
> > > On Wed, Feb 27, 2019 at 3:33 PM Peter Zijlstra <peterz@infradead.org>=
 wrote:
> >
> > > > Urgh, kasan_report() is definitely unsafe. Now, admitedly we should
> > > > 'never' hit that, but it does leave us up a creek without a paddle.
> >
> > > If SMAP detects additional bugs, then it would be pity to disable it
> > > with KASAN (detect bugs in production but not during testing).
> > >
> > > You mentioned that exception save/restore the UACCESS state. Is it
> > > possible to do the same in kasan_report? At the very least we need to
> > > survive report printing, what happens after that does not matter much
> > > (we've corrupted memory by now anyway).
> >
> > Ideally we'll put all of kasan_report() in an exception, much like we d=
o
> > for WARN. But there's a distinct lack of arch hooks there to play with.
> > I suppose I can try and create some.
> >
> > On top of that we'll have to mark these __asan functions with notrace.
> >
> > Maybe a little something horrible like so... completely untested.
>
> OK, I got that to compile; the next problem is:
>
> ../include/linux/kasan.h:90:1: error: built-in function =E2=80=98__asan_l=
oadN_noabort=E2=80=99 must be directly called
> UACCESS_SAFE(__asan_loadN_noabort);
>
> Which doesn't make any sense; since we actually generated that symbol,
> it clearly is not built-in. What gives?

I guess this warning originated for user-space where programmer does
not define them and does not generally know about them and signature
is not a public contract for user. And then for kernel it just stayed
the same because not doing this warning would require somebody to
proactively think about this potential difference and add an
additional code to skip this check and even then it wasn't obvious why
one will want to do this with these functions. So that's where we are
now.
