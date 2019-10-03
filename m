Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB26521D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVAA2+Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfJCG0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:26:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36198 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:26:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so1007026plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YOGeYTwEGroap5S9aB6GpA5Ro7B21EcFGC7ugpwhPZA=;
        b=eVAA2+Q20imdfPz4WSQlJHNfcW2XR6vbXK1AMX2w5zKzdenL03cMQs67/CWqoLFXcL
         hs6alQNsN5+eosWnmdvtcupn7Lf2Q52awaQRyvp+6+0MoPvf3zoXLWOZlqElv9iPem5J
         4PqQuf+uwZQAX5MCg2MIm70HnMfArj0Bpxl7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOGeYTwEGroap5S9aB6GpA5Ro7B21EcFGC7ugpwhPZA=;
        b=PRRJ2airu7jCYL1x7j6shYNElyVsN9+lJBm3qxr3tMjlak0PvlPlupj+xL9zg0nCdK
         S0Rvmw9S71V3egx8h1Zljies5lxLbSFHxjV1dYGpzwK1tiy63CjWdRmTucj+w0UZOEy/
         epqvrPqKHs1hrp23wB9TDvISCv1nzN0jAVF5/Iu1z49cMsfp7NoStzeyvrxBIzXcezkK
         yF6ELwtlfL0HeEwNx6s/FuZayK02qDIwkK4eVtxvI3/i5Z8ahF7xINGe6MwVGOg5E2YB
         P4YNGI5QjHW1JwuzFPK3U8G48deSbt2wD9Tp/+NgOeRQvvZj8ZEFlA+oe3xdg2w6Wa4R
         IJDQ==
X-Gm-Message-State: APjAAAVWlIhi0lYh47DmBbWHZ4HHJfoGZptZwIMGK2FpCAOcEsm7xlUh
        PBPAOqOO6qIzc0qd8YWidrUFxAHoQpI=
X-Google-Smtp-Source: APXvYqzpLqpLh8DsNq36BFOFnLEN9Dwe4/5U6EAC6+67PyczlkSrsniPbzj4IAFD+HgB7S/6RTOtoQ==
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr7812984plz.255.1570083964322;
        Wed, 02 Oct 2019 23:26:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e21sm1073023pgk.57.2019.10.02.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:26:03 -0700 (PDT)
Date:   Wed, 2 Oct 2019 23:26:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86: math-emu: check __copy_from_user result
Message-ID: <201910022325.D6769F3@keescook>
References: <20191001142344.1274185-1-arnd@arndb.de>
 <201910011638.F2F70EF@keescook>
 <CAK8P3a2BKyz8Myrd-ob9t5FyJmQ_FVUmNMYbfzr6YUZWfyH4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2BKyz8Myrd-ob9t5FyJmQ_FVUmNMYbfzr6YUZWfyH4XQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:11:23AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 2, 2019 at 1:39 AM Kees Cook <keescook@chromium.org> wrote:
> 
> > > diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
> > > index f3779743d15e..fe6246ff9887 100644
> > > --- a/arch/x86/math-emu/reg_ld_str.c
> > > +++ b/arch/x86/math-emu/reg_ld_str.c
> > > @@ -85,7 +85,7 @@ int FPU_load_extended(long double __user *s, int stnr)
> > >
> > >       RE_ENTRANT_CHECK_OFF;
> > >       FPU_access_ok(s, 10);
> > > -     __copy_from_user(sti_ptr, s, 10);
> > > +     FPU_copy_from_user(sti_ptr, s, 10);
> >
> > These access_ok() checks seem redundant everywhere in this file (after
> > your switch from __copy* to copy*. I mean, I guess, just leave them, but
> > *shrug*
> 
> There have always been duplicate/inconsistent for the get_user/put_user
> case. I considered cleaning it all up but then decided to touch it as little
> as possible.

Yeah, at this point, I'd agree. :)

-- 
Kees Cook
