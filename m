Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6BC2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8620706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hN/H9UkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLNUlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:41:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40802 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfLNUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:41:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2385132wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 12:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIrmPdhUQoEFUpl9pVyfp9mVBMFH/es2QUeZpBBMI0M=;
        b=hN/H9UkJbqHG3eIyw7LV32khWF14F7HuwFEWwgG+fPhtjj90pFkDouO8IZ+uHLexMr
         px9Ad5kTt6nq9QMiRdtDunkh01u8oFtXfIpRovKtSvDSZF50GIammzIQRv1kGUuT9Inn
         Sl4DXE7MgLb1NWvBq9JL1TLYihdL4vB/XBjCzMMtuckA3XEo0CtNIubp/QFpI8bqM4xC
         Rx2HT3wKA2RCrCVprkqdNeerjCk4YIgOT7pHkyD2+cOQF6JoGcd9VEQCqznrq4GP8IDf
         JolQwhYPtA/GjJ7BUiuE4Qsw6pn0oOhr5Or8RmSGD3R+mPncu2BxnHbkYtNe3qZvcF4z
         wMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIrmPdhUQoEFUpl9pVyfp9mVBMFH/es2QUeZpBBMI0M=;
        b=lVnqqkA6RF2jAl2YyOLpjKyESs7UuxNegwoIa+JxWXKKHHPo/jDxM6FI3rYuErBoiq
         Qe1Ctt3ChusdnH7L/y0sPuem/I6ZWq2bhqBzqrcLWv6u04mL7spotWSJD1RGI+VHHb+j
         oIp6/fvebtkmHdmQSPfeMTjeYbOaKS+C4hHxaBu2vhLt8/3QvTMY4vLxNo9Ju4XguQm3
         jiUL3MO84nJHPZXp5+1tiZHUNJGUuWkx2VJFWN/f9NIstEs323JCGwolO7UmwUXD2OZz
         FeAa3Wo1MgsQFtLY29anAjeCq3buvBOdkJ1QNFST+LRU/iOGBCBQrx8M8xV+g/2ex5Ri
         BGRQ==
X-Gm-Message-State: APjAAAXCLWtupfsM4xM5pXZhnba0RruEk6Vxl/zNgnquMfsq4w8RDkk6
        i+/jzuChrShek6P0Sgwj9itk8ewoNXjgH2bihFv1Tg==
X-Google-Smtp-Source: APXvYqw5rwBA/idqU4BftHyVMJmzJ1tZL3XDI4yM2IzqJB5Uhrlcn06heFXpeLQX/FqRMDlk4tysqAWtqNF2vinn3mk=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr21792417wmc.9.1576356058556;
 Sat, 14 Dec 2019 12:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-4-ardb@kernel.org>
 <20191214203257.GD140998@rani.riverdale.lan>
In-Reply-To: <20191214203257.GD140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 20:40:57 +0000
Message-ID: <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
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

On Sat, 14 Dec 2019 at 21:33, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 06:57:28PM +0100, Ard Biesheuvel wrote:
> > Iterating over a EFI handle array is a bit finicky, since we have
> > to take mixed mode into account, where handles are only 32-bit
> > while the native efi_handle_t type is 64-bit.
> >
> > So introduce a helper, and replace the various occurrences of
> > this pattern.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >
> > +#define for_each_efi_handle(handle, array, size, i)                  \
> > +     for (i = 1, handle = efi_is_64bit()                             \
> > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[0]      \
> > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[0];     \
> > +         i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)      \
> > +                                          : sizeof(u32));            \
> > +         handle = efi_is_64bit()                                     \
> > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[i]      \
> > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> > +
> >  /*
> >   * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> >   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > --
> > 2.17.1
> >
>
> This would access one past the array, no? Eg if the array has one
> handle, i is incremented to 2 the first time the condition is checked,
> then the loop increment will access array[2] before the condition is
> checked again. There seem to be at least a couple of other for_each
> macros that might have similar issues.
>

Indeed.

> How about the below instead?
>
> #define for_each_efi_handle(handle, array, size, i)                     \
>         for (i = 0;                                                     \
>             (i < (size) / (efi_is_64bit() ? sizeof(efi_handle_t)        \
>                                           : sizeof(u32))) &&            \
>             ((handle = efi_is_64bit()                                   \
>                 ? ((efi_handle_t *)(array))[i]                          \
>                 : (efi_handle_t)(unsigned long)((u32 *)(array))[i]), 1);\
>             i++)
>

Yeah, that looks correct to me, but perhaps we can come up with
something slightly more readable? :-)
(Not saying my code was better in that respect)
