Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B1221904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dosrz1Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCVHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:43:49 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54109 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:43:47 -0400
Received: by mail-it1-f196.google.com with SMTP id w85so2218692itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LJcxQiBxVwiPD/78aWDVPhv4zia0X6OwrfoJ2C57Ig=;
        b=Dosrz1Kyr+wp4IPD3C52twTiKvDkttURLJyLSwV4HCR4gST2aLzZPrY3fD2qhiZRrn
         c4KkHRfc8p3PRsxaoDWHGd+joZT3Ppizx2Ejw92ao7BBUTR3cjUBkeLvgfdt4uIDqDAG
         1voNNiEOpC8ekRrne1CcP5ZZVXjow/vkxIWMlkkE1dLipbViY/2DscbPXf7x5AtkDmCF
         2tEWvQdfqSZ0lKCyvSmsi+IalhVNqgv8yP00wgo6C6t5MG5mySpW9NXVAyrn2Q1plwGv
         OLC47812RnJeOgf9FrODw251F6YSU4gsCfjNFgXFdrSDyrG5ma8wPQr+oqJyNTfq9EVM
         W49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LJcxQiBxVwiPD/78aWDVPhv4zia0X6OwrfoJ2C57Ig=;
        b=W9Fwvam5BXwT8PTIY1c4/runNGnaXJnmut2YJ/w6hluVqtdylVumv6G6/ny23P3ikM
         g03qPgroCRyUBTy0CN0mT8ecZm7Nu4ELP52WXD+ySjTM2+gGuA0nZKENoIEC8J/kNQKN
         Xgs/DiASJvUsJ7tnjGYx3SzhGtbcHp5U/HGUBkDm0Dc5m6MsC+Wvja1mWIqwoYNSKmya
         8+To0JfqPzPwCM1uWhNxRjawdi6B6CuV42HxluSV3/YPQ0YbbvuLz8Oi+4isyRezJmko
         ZlakB+ENgCX/X7Y9jZJxSqTRdq45x/p4eotlU2vyYpv/7nLiH+mhODJKVDUwUX5apziw
         hOgA==
X-Gm-Message-State: APjAAAVCY/L7O8soAyWjva5/N+6uNib7bJ+wfYzlKzPs3ZCOtTQWZEZE
        ox50iDY78kavFiSp12H8eNuBq9LlNb9le6rpYQ==
X-Google-Smtp-Source: APXvYqwhXNoh9Ovd4O++Jj41YC7k2xLDnIgHgg2Is0g1WiRyfL3YKX2u1AUwUcaGx6aT5+ABEwhXBZIi5kzyDm1KQn8=
X-Received: by 2002:a02:93ee:: with SMTP id z101mr6217191jah.17.1553240626579;
 Fri, 22 Mar 2019 00:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com> <20190320002524.GD18740@MiWiFi-R3L-srv>
In-Reply-To: <20190320002524.GD18740@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 22 Mar 2019 15:43:35 +0800
Message-ID: <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel reserved region
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 8:25 AM Baoquan He <bhe@redhat.com> wrote:
>
> Please change subject as:
>
> "x86/boot/KASLR: skip the specified crashkernel region"
>
OK.

> Don't see why reserved is needed here.
>
> On 03/13/19 at 12:19pm, Pingfan Liu wrote:
> > crashkernel=x@y option may fail to reserve the required memory region if
> > KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> > skip the required region.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > v1 -> v2: fix some trival format
> >
> >  arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 9ed9709..e185318 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -109,6 +109,7 @@ enum mem_avoid_index {
> >       MEM_AVOID_BOOTPARAMS,
> >       MEM_AVOID_MEMMAP_BEGIN,
> >       MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> > +     MEM_AVOID_CRASHKERNEL,
> >       MEM_AVOID_MAX,
> >  };
> >
> > @@ -240,6 +241,25 @@ static void parse_gb_huge_pages(char *param, char *val)
> >       }
> >  }
> >
> > +/* parse crashkernel=x@y option */
> > +static void mem_avoid_crashkernel_simple(char *option)
>
> Chao ever mentioned this, I want to ask again, why does it has to be
> xxx_simple()?
>
Seems that I had replied Chao's question in another email. The naming
follows the function parse_crashkernel_simple(), as the notes above
the definition
/*
 * That function parses "simple" (old) crashkernel command lines like
 *
 * crashkernel=size[@offset]
 *
 * It returns 0 on success and -EINVAL on failure.
 */
static int __init parse_crashkernel_simple(char *cmdline,

Do you have alternative suggestion?

> Except of these, patch looks good to me. It's a nice catch, and only
> need a simple fix based on the current code.
>
Thank you for the kindly review.

Regards,
Pingfan

> Thanks
> Baoquan
>
> > +{
> > +     unsigned long long crash_size, crash_base;
> > +     char *cur = option;
> > +
> > +     crash_size = memparse(option, &cur);
> > +     if (option == cur)
> > +             return;
> > +
> > +     if (*cur == '@') {
> > +             option = cur + 1;
> > +             crash_base = memparse(option, &cur);
> > +             if (option == cur)
> > +                     return;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > +     }
> > +}
> >
> >  static void handle_mem_options(void)
> >  {
> > @@ -250,7 +270,7 @@ static void handle_mem_options(void)
> >       u64 mem_size;
> >
> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> > -             !strstr(args, "hugepages"))
> > +             !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> >               return;
> >
> >       tmp_cmdline = malloc(len + 1);
> > @@ -286,6 +306,8 @@ static void handle_mem_options(void)
> >                               goto out;
> >
> >                       mem_limit = mem_size;
> > +             } else if (strstr(param, "crashkernel")) {
> > +                     mem_avoid_crashkernel_simple(val);
> >               }
> >       }
> >
> > @@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> >
> >       /* We don't need to set a mapping for setup_data. */
> >
> > -     /* Mark the memmap regions we need to avoid */
> > +     /* Mark the regions we need to avoid */
> >       handle_mem_options();
> >
> >  #ifdef CONFIG_X86_VERBOSE_BOOTUP
> > --
> > 2.7.4
> >
