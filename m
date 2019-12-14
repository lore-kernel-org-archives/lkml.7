Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E4C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7A214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgKhjGqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLNWOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:14:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34992 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLNWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:14:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2566582wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=le9gTEplXasSXY5+vU+POpcZ8GAoVTNi2DgRESF94BM=;
        b=CgKhjGqMjA2Ua4JZEnoVl9pkDc3irF6rNmQisnnigTz32BBdJj0Xz5PRQaXiAcUw5V
         eblM0Al8GX6idpxU+O+1z5URLpOZ39TTZ9JqoXlta344q/oKLNxi0oMNdlPCLT6eq6o+
         Paz31NM4grktE57soKYFyBqOda9J/Jq0tUuk20g6wllWE8fCCbvikAuTBkKc0zPh46DO
         4AwgSLVhpYWXLe1/PrthS5cK77yZPjZBr4fX6TFxqtMFhoeG7JmJl9uQq0Pk7O8HleWr
         8qOWZPATz2piV8ARXFuxta9CBPDQYfHUvve4r8JUb3Pma5oXnOSAgKdOZ0UJcz5bo96Z
         2JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=le9gTEplXasSXY5+vU+POpcZ8GAoVTNi2DgRESF94BM=;
        b=uBazg1iwx6EoOKLOKDHbgmxckCUTT/cCGsGIVq5utc5ui0pQcCcygUkDDuUhya5wGO
         +Yp80Cw74Tc/htuievZeeyb88CK+pJfj5kePthjs6VQigLzb3WwYmpcDMX8UGSJ7ob8j
         0ktkJSY+9ddHq4d/41HzrTkccqQd2Lrpb/Hui3eLiY5Uw9+4/6SlgrVYpe8g6blNa7Xt
         fTSEDcAN7FtAYZQe42pBKhtR26FUJggKkKehvZJOo3xF778XdWXvbTzSnv17yWnyCG5Q
         JO27PH+Sim9i6B+2Y5rCwovtc0siGFYEx1MX+llpjO435XIzsSDfQFZNhBcL5SqINloe
         5wXQ==
X-Gm-Message-State: APjAAAX5T3fqyYKWEtFOkQQhvhd2D8HExOeNTKfG1gBboTReEAtl1206
        DHEj1GzG+ikzUqjfOLLZ6/kHpnMrf1kNDXuG4FIuLg==
X-Google-Smtp-Source: APXvYqz/Z3CqaojWv8/IXIkI9cm5DNoK5eR8xmbyteKGdULWQOhr7KljxO1EoyBbnQ0OjeuG/sHwIDTV+qS+hrVBthM=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr22174711wmc.9.1576361679990;
 Sat, 14 Dec 2019 14:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan> <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan> <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 22:14:38 +0000
Message-ID: <CAKv+Gu8DNwWF4FfiZNStHTqNZeUP90c1_NkSLC_80YxF4smnxA@mail.gmail.com>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
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

On Sat, 14 Dec 2019 at 22:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> > > On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > > +
> > > > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > > > +   if (efi_is_native()) {                                          \
> > > > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > > > +   } else {                                                        \
> > > > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > > > +   }                                                               \
> > > > > > > > +   __ret;                                                          \
> > > > > > > > +})
> > > > > > >
> > > Yes. I'm open to suggestions on how to improve this, but mixed mode is
> > > somewhat of a maintenance burden, so if new future functionality needs
> > > to leave mixed mode behind, I'm not too bothered.
> > >
> >
> > Maybe just do
> >         if (sizeof(at) < sizeof(__ret))
> >                 __ret = (__typeof__(__ret))(uintptr_t)at;
> >         else
> >                 __ret = (__typeof__(__ret))at;
> > That should cover most of the cases.
>
> But the compiler will still be unhappy about the else clause if __ret
> is a pointer type, since we'll be casting an u32 to a pointer,

I think the answer is to have efi_table_ptr() for pointers and
efi_table_attr() for other types.
