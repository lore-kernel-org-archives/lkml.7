Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F87C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6957B20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9zA6Ql8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406013AbfFKRSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:18:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46123 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405263AbfFKRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:18:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so7816423pfy.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRK7dSJ9ozXpkMag7XMLUlUKlJp+YVQsFuMywlLYIIY=;
        b=b9zA6Ql86DPqQkTp5i0i6v7MtDOq0tAACNbJiToG/gsWM88lOHPNTLEE2A75D2FKoO
         SaTGSkkdbkFjBHB6V7dNy3yNl8DW1iE0pnw0WmGXH9zKr6DLv5bE7mRA4LdyIllbpD/D
         KcrOvJfjpWiyccNOyNMsy4lUx+9EWF4+Rz1owvnwBXs022X3zquKp/rp+skYCj68ppuI
         s9oCX7Or8ik9oAg9pTuxoIFV/Q0kJ7gPx7GPxqYH4vPwX3SSd1Ma3tHuV9GC8yXrZkiY
         8Msdnuz2aqf5gojfEQ2ZtoCfHhj+2CsKFVVs7asqO5iLhZbFI9QDBNBmCP2d56v0+z1i
         p9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRK7dSJ9ozXpkMag7XMLUlUKlJp+YVQsFuMywlLYIIY=;
        b=ss8Djxo/EI26S6vmL9Zb5m1SCLq6f2Rui8ikg6gk+iUuVEfWW9AgnjBiO/sa3rD4n5
         nY/z2vWthT8D9FDRkjKSC0m229of/YScuYRfoj+fxzlHoM1MPqNRS0R1VceX5Cnw3Zb5
         BYvK30n21PN6fkUA2BAWmkxaJP2wx+tlM+V8jkB8Y1tPhQaoEZZZKTPu+ikIyTaqLTBb
         pXYdpMBI/BdSRVfBxaN9LQ/wp54zeh+1qix4RnRQmGheD158TS7Z9wP44blQDHtX2XEs
         L1wHyaDv/MJqAYwIqaq92EMA4qYD4W8hUG0OjpRjywq8jL6BxZZMysuzhgbUEV2C+roD
         ZGnA==
X-Gm-Message-State: APjAAAUalinDFAUFTN7SWZt8sMLxwAcbDMap8n8UrEpPNnSb55Qdgjum
        /EWpHesuo2ElTWxEAXvMsZQw0V4MdPUjA+a8F028GQ==
X-Google-Smtp-Source: APXvYqwTIY2/OtCAe2ytKIYqGY3omJlioSYHG1JrmGnaMaDG0e9TwsYGQisqOCiIuCpfggd2Tzz2lgNj29c+F+rHVNg=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr27381746pje.123.1560273495783;
 Tue, 11 Jun 2019 10:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
 <20190611150122.GB63588@arrakis.emea.arm.com>
In-Reply-To: <20190611150122.GB63588@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Jun 2019 19:18:04 +0200
Message-ID: <CAAeHK+wZrVXxAnDXBjoUy8JK9iG553G2Bp8uPWQ0u1u5gts0vQ@mail.gmail.com>
Subject: Re: [PATCH v16 16/16] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 5:01 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 03, 2019 at 06:55:18PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > This patch adds a simple test, that calls the uname syscall with a
> > tagged user pointer as an argument. Without the kernel accepting tagged
> > user pointers the test fails with EFAULT.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> BTW, you could add
>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> since I wrote the malloc() etc. hooks.

Sure!

>
>
> > +static void *tag_ptr(void *ptr)
> > +{
> > +     unsigned long tag = rand() & 0xff;
> > +     if (!ptr)
> > +             return ptr;
> > +     return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
> > +}
>
> With the prctl() option, this function becomes (if you have a better
> idea, fine by me):
>
> ----------8<---------------
> #include <stdlib.h>
> #include <sys/prctl.h>
>
> #define TAG_SHIFT       (56)
> #define TAG_MASK        (0xffUL << TAG_SHIFT)
>
> #define PR_SET_TAGGED_ADDR_CTRL         55
> #define PR_GET_TAGGED_ADDR_CTRL         56
> # define PR_TAGGED_ADDR_ENABLE          (1UL << 0)
>
> void *__libc_malloc(size_t size);
> void __libc_free(void *ptr);
> void *__libc_realloc(void *ptr, size_t size);
> void *__libc_calloc(size_t nmemb, size_t size);
>
> static void *tag_ptr(void *ptr)
> {
>         static int tagged_addr_err = 1;
>         unsigned long tag = 0;
>
>         if (tagged_addr_err == 1)
>                 tagged_addr_err = prctl(PR_SET_TAGGED_ADDR_CTRL,
>                                         PR_TAGGED_ADDR_ENABLE, 0, 0, 0);

I think this requires atomics. malloc() can be called from multiple threads.

>
>         if (!ptr)
>                 return ptr;
>         if (!tagged_addr_err)
>                 tag = rand() & 0xff;
>
>         return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
> }
>
> --
> Catalin
