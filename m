Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A041C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9512468A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlyBr3/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLNVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 16:04:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37149 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfLNVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 16:04:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so2613753wru.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 13:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wnKTPr8/3r2YII52ChVOnxqx80JfjbUnrxVzdXCZKo=;
        b=FlyBr3/0YeOz6HxsMr93QGnPD1w8kqOok1nJA0Dmnyt3d9CFyynf6P73phyvsB4hxd
         8ItZ3oryn7X7ExW415Av8R+8Mu2KsXnkfF9la+2bTfsj2UJ23izzcFZL8/iQCck3QST0
         PimHnixHc5WRSdxALLRfUkELA6wV46XKQvZ4TTGiRBfdnwZ495w550nAtNeYAbn7xMvN
         At5ScgnTN5n8htA1RshUQHB0zMVabsA0LLQrppQ63s2k5eAK2nVia7jy9UWVlvRAeV74
         +mlMz/22GIuBYKLfhB+mV6oUpvpYK0cRwyasbJdzbvUlkMUN+Gykge7QkUPF+vcf/Jxk
         nNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wnKTPr8/3r2YII52ChVOnxqx80JfjbUnrxVzdXCZKo=;
        b=VZs+fuRHiXWL/gZ6fJHIG6pyr93sdAWXb7jAozTcxfJVxceo8BV1QqVpkw8mCLHUP1
         00hpNAuIRl4ub6eKdd2zOZ6//2ktzf0LWv3Vv9whdPgOJhb25UWCTmYKR8b/5dvUyeJE
         6OmOLnPgxb0f5FJqFmWk4qhc3Eps9vadlXf0+aKb+tc/qJADWOioSe3F2FCGmiIUqKHj
         0gnmXdf4RPjeEA6DyBS4XOW8X94S9UBwqfZeOb/PKSJQRKBZB0ZrL8GXoBN31lUwnIRt
         8o3q7jOLV+X1epxS46lp5UBLmZdWDLNRrvf9GhAUIx406DPJlFtMQjmplD+xzAE6STtx
         jXIw==
X-Gm-Message-State: APjAAAXGmsInEZu4OdfHk0nq5JCc7rhxDsz7+rGYULtkEj/Ax5fCg/VV
        HYpRTJUHZk9ExYFWoFxk5+i6YLjXo/Ww2G+jYyrqTQ==
X-Google-Smtp-Source: APXvYqy4KzF6rpVGj19sV1ZE7fuOBPF30uH565+9FDO3G7wn5LubWztbl70HVbbJf5AdfEL2rKh3PvW+gRSxtXhiWZA=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr20198121wrs.200.1576357451503;
 Sat, 14 Dec 2019 13:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-4-ardb@kernel.org>
 <20191214203257.GD140998@rani.riverdale.lan> <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 21:04:10 +0000
Message-ID: <CAKv+Gu9kEySOrKM0Q01a-ZFbSTZz51TcfmnWbSq=LWqKw=8cNw@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/libstub: use a helper to iterate over a EFI
 handle array
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2019 at 21:40, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 14 Dec 2019 at 21:33, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 06:57:28PM +0100, Ard Biesheuvel wrote:
> > > Iterating over a EFI handle array is a bit finicky, since we have
> > > to take mixed mode into account, where handles are only 32-bit
> > > while the native efi_handle_t type is 64-bit.
> > >
> > > So introduce a helper, and replace the various occurrences of
> > > this pattern.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >
> > > +#define for_each_efi_handle(handle, array, size, i)                  \
> > > +     for (i = 1, handle = efi_is_64bit()                             \
> > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[0]      \
> > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[0];     \
> > > +         i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)      \
> > > +                                          : sizeof(u32));            \
> > > +         handle = efi_is_64bit()                                     \
> > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[i]      \
> > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> > > +
> > >  /*
> > >   * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> > >   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > > --
> > > 2.17.1
> > >
> >
> > This would access one past the array, no? Eg if the array has one
> > handle, i is incremented to 2 the first time the condition is checked,
> > then the loop increment will access array[2] before the condition is
> > checked again. There seem to be at least a couple of other for_each
> > macros that might have similar issues.
> >
>
> Indeed.
>
> > How about the below instead?
> >
> > #define for_each_efi_handle(handle, array, size, i)                     \
> >         for (i = 0;                                                     \
> >             (i < (size) / (efi_is_64bit() ? sizeof(efi_handle_t)        \
> >                                           : sizeof(u32))) &&            \
> >             ((handle = efi_is_64bit()                                   \
> >                 ? ((efi_handle_t *)(array))[i]                          \
> >                 : (efi_handle_t)(unsigned long)((u32 *)(array))[i]), 1);\
> >             i++)
> >
>
> Yeah, that looks correct to me, but perhaps we can come up with
> something slightly more readable? :-)
> (Not saying my code was better in that respect)

How about

#define efi_get_handle_at(array, idx)      \
    (efi_is_64bit() ? (efi_handle_t)(unsigned long)((u64 *)(array))[idx] \
                    : (efi_handle_t)(unsigned long)((u32 *)(array))[i])


#define efi_get_handle_num(size) \
    ((size) / (efi_is_64bit() ? sizeof(u64) : sizeof(u32)))

#define for_each_efi_handle(handle, array, size, i) \
    for (i = 0; \
         i < efi_get_handle_num(size) && \
            ((handle = efi_get_handle_at((array), i)) || true); \
         i++)
