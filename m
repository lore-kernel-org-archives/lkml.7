Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A46C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D53249DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1qaT6gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfFDMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:05:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39566 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfFDMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:05:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so10247515pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j34LYUoJM4InkQPNFKh7Ow4BYIjL6/oVFRsfu7DIJqw=;
        b=Q1qaT6guKN0cVPZ3I7m80z+l8td98w2uqIqeYi7AFZlLfwx0G3uMrYBq/J+BmnmOkM
         atOxQZO2OZRPqsjN3jqBQv44CvwjPmxvlTBcPKmMi6XjoZEmV/fygK5lB45wakW1x509
         lWKLza5Yda4CAzzaQyvI+9jrqysNJKJVvTJhllwO+UsWDQVgevJunQ8PW4WiDuXWRUXU
         7jLII5xQ27xFuA+YQ/J9v/BCfFu0O+m0Eo51qSbf6BhnxxvgwoGoytsvTWBHtF3OYNCG
         5xAYIJ3eDxoQdAcL8X0Di1QghLFbw2D39YI3GMMqxvSPlDl32yI9DfA4EynC+NBnx3BM
         Md2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j34LYUoJM4InkQPNFKh7Ow4BYIjL6/oVFRsfu7DIJqw=;
        b=qfG4TVaiN31oJwmZonsvCzg3ol4e5gf+r2LkLtOZCKlp4H5QUzZQu2itteAtKj74er
         VG54Q5RsjjdIdy8BDoFtL+6UYyCIb4fpS1gUWGmU2aMf2UMFyHE5qCKpS8KSxIYF8T7h
         Z9bIm+EmqjLR/srplbHIZer81bFlFxXC/SkYEG82xN4b1MENzxYyOa083uRCERkDCuur
         lKWV7T91/YVhblLZ3nZyJHFboOKB8kb/KRK6xgeP8V6OElNJImpM9FqTxtV1Dq8Dzv2r
         2Y60PtBr5yGtyGreYobHFC09GTL5yDE+NVhgNhzpgth8ADpH0y26/Ffx+Uu4e+9FvN9S
         xfRA==
X-Gm-Message-State: APjAAAX7U/HqZcBCvr7G3qfdrqcb/KL9hXhL2pMvs4szBQQadPGp9Q+v
        sbAgYgwT/iltzQv03InSrJj32C5vidSPEaQfV6zU8w==
X-Google-Smtp-Source: APXvYqwvrt39xcYJfCMZYMz7iLhPbel6HsvYFhEAa8PCAaMa5qdXOZSee+ccpu58h4UkbZo4zcE90xOl7nDE7Qf6Y+o=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr28700584pje.123.1559649927361;
 Tue, 04 Jun 2019 05:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <8ab5cd1813b0890f8780018e9784838456ace49e.1559648669.git.andreyknvl@google.com>
 <d74b1621-70a2-94a0-e24b-dae32adc457d@amd.com> <CAAeHK+w0_9QdxCJXEf=6nMgZpsb8NyrAaMO010Hh86TW75jJvw@mail.gmail.com>
 <ff73058a-f57b-526b-af53-c0e30b7b1bc1@amd.com>
In-Reply-To: <ff73058a-f57b-526b-af53-c0e30b7b1bc1@amd.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Jun 2019 14:05:16 +0200
Message-ID: <CAAeHK+wfNbNz_AP8c4PqcpWXuLxx23D1coY0SS5ORM_tUewNFA@mail.gmail.com>
Subject: Re: [PATCH] uaccess: add noop untagged_addr definition
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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

On Tue, Jun 4, 2019 at 1:49 PM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 04.06.19 um 13:48 schrieb Andrey Konovalov:
> > On Tue, Jun 4, 2019 at 1:46 PM Koenig, Christian
> > <Christian.Koenig@amd.com> wrote:
> >> Am 04.06.19 um 13:44 schrieb Andrey Konovalov:
> >>> Architectures that support memory tagging have a need to perform untagging
> >>> (stripping the tag) in various parts of the kernel. This patch adds an
> >>> untagged_addr() macro, which is defined as noop for architectures that do
> >>> not support memory tagging. The oncoming patch series will define it at
> >>> least for sparc64 and arm64.
> >>>
> >>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> >>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >>> ---
> >>>    include/linux/mm.h | 4 ++++
> >>>    1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 0e8834ac32b7..949d43e9c0b6 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >>>    #include <asm/pgtable.h>
> >>>    #include <asm/processor.h>
> >>>
> >>> +#ifndef untagged_addr
> >>> +#define untagged_addr(addr) (addr)
> >>> +#endif
> >>> +
> >> Maybe add a comment what tagging actually is? Cause that is not really
> >> obvious from the context.
> > Hi,
> >
> > Do you mean a comment in the code or an explanation in the patch description?
>
> The code, the patch description actually sounds good to me.

Sent v2, thanks!

>
> Christian.
>
> >
> > Thanks!
> >
> >> Christian.
> >>
> >>>    #ifndef __pa_symbol
> >>>    #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
> >>>    #endif
>
