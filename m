Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55DC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E5206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHlwS3VP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbfFMPWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:22:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41357 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbfFMMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:35:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so11090594oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odgDtuS4Pz09+zc7wgiVUlzZ7gbjNw0joU36SILLNfo=;
        b=bHlwS3VP2wcXGi3xrYIozsGT3vGUQfd+kcxKhlv9uBlcTERbuhQhhF0kEMY7ho5Hej
         uVpGjc6DyuIOGUHDvn1P8gVzlLSf9MUF0DVRM/o94o3wbGbpzqz6m4CYglgA6sT/gkpo
         mj6FXp8dvOKeKFiVAeLOFyPm75BMOIpquGdY28vCs0CmJlT1RaV/eCWCfsiIyldSOd4z
         RZrTm9Gll7iFkdl3vS1NSCNhQh/rwSYneUdTpBXlsyqqzTgXGWCTTS5hCi4WUGXUcWAw
         /gjS1zgIMPGcztWl/Qo6cVIEnA0H+dPh4xh40fc9EMjQWUA0M+Ek7A+5ua5bNZH9pz3U
         FBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odgDtuS4Pz09+zc7wgiVUlzZ7gbjNw0joU36SILLNfo=;
        b=ihELQVqJWjX7MzGeOObv/erjc98gwsXi6XM9Eu5UKIUNg1ezqcQeb6Mza4lo1og9Nv
         QYUCnDmu9t7yk20TCyiYaP76KNA9QlF3NGM/wo3d9b+1jvpdrCTiIpI1sD0t2IhOOfao
         YBy1YPHD/+1xbMVFzdIFgfjmX1iRTXPpCpZg62IR5B0M3/ALcPf4kk+W1NxdEWStlwJA
         pCaeHT/ktJxhSUBCB4KTDSkJrx6NxImf6Y06qzWATXdti6VCMSLlTn6EtkefQP7SVrH9
         F+hLosHdTArlCeAl/gyr7aIG4dAPFmHGE++FQfrWtcQqvBPo7LPaUTZ6EHLUsJBf8d8e
         9srg==
X-Gm-Message-State: APjAAAWJLMxmzmFjPkTkBM7sztaP0LiwsTgzZ0PUku+OGUmgJRlXxojB
        WMXGZQdwN4xdlPISwEXhNlQlQxZeMkZsEJONV2z7HQ==
X-Google-Smtp-Source: APXvYqyCmCYDNUjsDblBRApysZRON5tDwG/jjtd99QGf2YuyNbFs79TrwdjyYvtxHxcJFTJA18sGVw14rplLLkNM0do=
X-Received: by 2002:aca:530f:: with SMTP id h15mr2627831oib.155.1560429328714;
 Thu, 13 Jun 2019 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190531150828.157832-1-elver@google.com> <20190531150828.157832-2-elver@google.com>
 <5c35bc08-749f-dbc4-09d0-fcf14b1da1b3@virtuozzo.com>
In-Reply-To: <5c35bc08-749f-dbc4-09d0-fcf14b1da1b3@virtuozzo.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 Jun 2019 14:35:17 +0200
Message-ID: <CANpmjNNz8-dfnSXGouHQJqg+zBHJWVPmCM9Ggxj_LAb4VeOocg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] lib/test_kasan: Add bitops tests
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've sent v4.

On Thu, 13 Jun 2019 at 12:49, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 5/31/19 6:08 PM, Marco Elver wrote:
> > This adds bitops tests to the test_kasan module. In a follow-up patch,
> > support for bitops instrumentation will be added.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Changes in v3:
> > * Use kzalloc instead of kmalloc.
> > * Use sizeof(*bits).
> >
> > Changes in v2:
> > * Use BITS_PER_LONG.
> > * Use heap allocated memory for test, as newer compilers (correctly)
> >   warn on OOB stack access.
> > ---
> >  lib/test_kasan.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 72 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 7de2702621dc..1ef9702327d2 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -11,16 +11,17 @@
> >
> >  #define pr_fmt(fmt) "kasan test: %s " fmt, __func__
> >
> > +#include <linux/bitops.h>
> >  #include <linux/delay.h>
> > +#include <linux/kasan.h>
> >  #include <linux/kernel.h>
> > -#include <linux/mman.h>
> >  #include <linux/mm.h>
> > +#include <linux/mman.h>
> > +#include <linux/module.h>
> >  #include <linux/printk.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> > -#include <linux/module.h>
> > -#include <linux/kasan.h>
> >
> >  /*
> >   * Note: test functions are marked noinline so that their names appear in
> > @@ -623,6 +624,73 @@ static noinline void __init kasan_strings(void)
> >       strnlen(ptr, 1);
> >  }
> >
> > +static noinline void __init kasan_bitops(void)
> > +{
> > +     long *bits = kzalloc(sizeof(*bits), GFP_KERNEL);
>
> It would be safer to do kzalloc(sizeof(*bits) + 1, GFP_KERNEL) and change tests accordingly to: set_bit(BITS_PER_LONG + 1, bits) ...
> kmalloc will internally round up allocation to 16-bytes, so we won't be actually corrupting someone elses memory.
>
>
> > +     if (!bits)
> > +             return;
> > +
> > +     pr_info("within-bounds in set_bit");
> > +     set_bit(0, bits);
> > +
> > +     pr_info("within-bounds in set_bit");
> > +     set_bit(BITS_PER_LONG - 1, bits);
>
>
> I'd remove these two. There are plenty of within bounds set_bit() in the kernel so they are well tested already.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/5c35bc08-749f-dbc4-09d0-fcf14b1da1b3%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
