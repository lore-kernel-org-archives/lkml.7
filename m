Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F662171F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfGVO05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:26:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43083 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGVO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:26:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so3052827qka.10;
        Mon, 22 Jul 2019 07:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ah6GZe+0UgXZUd+jkutuNIUFv66KlGrmYWfNByDcOvg=;
        b=YiHIKSd/Y12Jj4HEZ/c0CIq4VcU7J+EREpXOgiwu0Z4dZsNHvJBBw+WciCnsCvxQph
         Tr+5vm38/wzhGyAAJ5FzbImSVr7MXLUNOyX/HVq/dmBeZo1JwELWlqXtrAkDfYx+GbkD
         xV5ndf8EGQ5+wdtQaAxTtzsAwsSU8Z8FjjYtound6momZ3YVtjRybrz9puAXZ/xyF64g
         SioWnE08q9GeLNLvfELhmvn5+GWM7o8esz+PJcN15q+nqcLK23rry8tkx4l2kFpX1xMA
         wcSBvbd9xH2iXW51hjXbOGhtocwzTeF6Ox7WNdC7xGxkVIk8C4loro46mAV0jIqriaYC
         2KLg==
X-Gm-Message-State: APjAAAVvq37G0+pbbFuAZtRjVpi3u0kyYKN/ZTF50JweCIydaeJg1PMm
        vAumt2BXhk+yWiO5vdSCQ4pYmBnfm7xbL574kXA=
X-Google-Smtp-Source: APXvYqzV66V/n6SbUhF6RDSLieeP6SB8mXvDJ9CDlP2FV1DOr+tPhe6IyteNQRDa+DJx1zn2b70XAfY2PzNKTYedJIM=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr13035375qki.352.1563805616319;
 Mon, 22 Jul 2019 07:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190722114134.3123901-1-arnd@arndb.de> <CAG_fn=UxowACw5w+erKaAPRr4SWk3WbLTfAgJj=cOL4HgZHK=Q@mail.gmail.com>
In-Reply-To: <CAG_fn=UxowACw5w+erKaAPRr4SWk3WbLTfAgJj=cOL4HgZHK=Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 16:26:40 +0200
Message-ID: <CAK8P3a28c5V5VnsFrttgtCC5+i87yuAT-G5xx50KOsKUJ6-VKg@mail.gmail.com>
Subject: Re: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in
 combination with KASAN_STACK
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:43 PM Alexander Potapenko <glider@google.com> wrote:
> On Mon, Jul 22, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > KASAN_STACK is currently implied by KASAN on gcc, but could be made a
> > user selectable option if we want to allow combining (non-stack) KASAN
> > with GCC_PLUGIN_STRUCTLEAK_BYREF.
> >
> > Note that it would be possible to specifically address the files that
> > print the warning, but presumably the overall stack usage is still
> > significantly higher than in other configurations, so this would not
> > address the full problem.
> >
> > I could not test this with CONFIG_INIT_STACK_ALL, which may or may not
> > suffer from a similar problem.
> We would love to be able to run KASAN together with
> CONFIG_INIT_STACK_ALL on syzbot, as this will potentially reduce the
> number of flaky errors.

Doesn't that just limit the usefulness of KASAN, as you no longer catch
actual accesses to unintialized variables that KASAN is designed to find?

> Given that we already increase the stack size in KASAN builds, how big
> of a problem are these warnings?
> Perhaps it's better to disable them in this configuration, or push the limit up?

I'm really hoping to lower the per-function limit for 'allmodconfig' builds,
since both a high limit and lots of bogus warnings prevent us from
noticing any newly introduced functions that use a lot of kernel stack
without KASAN.

An allmodconfig build (and ideally also any randconfig build) should always
complete without warnings to be useful for compile testing.

       Arnd
