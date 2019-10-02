Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A358820640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfJBHLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:11:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45578 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:11:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so25009788qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 00:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzEPD7yUZII/OLID9qnHyDK3ZuGZCYJgLZz3PxgXZO4=;
        b=LPZqdyuH1VJLH26TJTkLvUo+f7kQb9OhmXUXmcm2gbhBVoibO2g75mG8qDdV5yB4y0
         C7H34VeZgd37gzeDD70mhv738RxJHsHJxCzkHE5JshNiafaha6AkF5ovPpotQJ64XnGJ
         RKc+uCdkBlvr1k9n/CVNsebRf2TSNb1AURw5xQfqi3K0CHQW6Yp44Hc0P0i/pekX4X6Z
         0R7OXYnoiAYLjAD4X6B6gpTZdTg35vw6IvsPY45XCH5CJhaUlnJiZC6ss9rB4JcAO3Jy
         +M0vwVZ9d3BmvQrl0BDIdI8d5BDUuPKDx7oOolQtiY97MSlA2RXZuh2mSSsnfsg8JA8q
         3oEw==
X-Gm-Message-State: APjAAAVNC9elBTt2+LRYwF2a6moLxa5KZSsLX+cShF8Orvsav1NXjOVh
        +Ew9G0u6cmnmmT870m9gijeDI/uHabFsa+J4QjbNglyI
X-Google-Smtp-Source: APXvYqzmCfeXUIuNUpkbPztV/2KADLBZLe7RZtYrsox6044lGb5aqwIPFiaxREThkYpV9qNC+C/0QeXDubefinRfDx8=
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr2558213qtj.204.1570000300203;
 Wed, 02 Oct 2019 00:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142344.1274185-1-arnd@arndb.de> <201910011638.F2F70EF@keescook>
In-Reply-To: <201910011638.F2F70EF@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 09:11:23 +0200
Message-ID: <CAK8P3a2BKyz8Myrd-ob9t5FyJmQ_FVUmNMYbfzr6YUZWfyH4XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: math-emu: check __copy_from_user result
To:     Kees Cook <keescook@chromium.org>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 1:39 AM Kees Cook <keescook@chromium.org> wrote:

> > diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
> > index f3779743d15e..fe6246ff9887 100644
> > --- a/arch/x86/math-emu/reg_ld_str.c
> > +++ b/arch/x86/math-emu/reg_ld_str.c
> > @@ -85,7 +85,7 @@ int FPU_load_extended(long double __user *s, int stnr)
> >
> >       RE_ENTRANT_CHECK_OFF;
> >       FPU_access_ok(s, 10);
> > -     __copy_from_user(sti_ptr, s, 10);
> > +     FPU_copy_from_user(sti_ptr, s, 10);
>
> These access_ok() checks seem redundant everywhere in this file (after
> your switch from __copy* to copy*. I mean, I guess, just leave them, but
> *shrug*

There have always been duplicate/inconsistent for the get_user/put_user
case. I considered cleaning it all up but then decided to touch it as little
as possible.

       Arnd
