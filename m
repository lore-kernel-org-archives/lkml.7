Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC81C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4472146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoXySve3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDCDAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:00:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50574 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDCDAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:00:02 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so8793197itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdS0dfKBYecEwQwKHBe5egXm6nHt/JVy0ktggg3WRWc=;
        b=hoXySve34txiXfjdB5hxYjWiduT04kuWhtitjVxpVQqgLn48ga5VTKg5j/Jjz7ESM1
         PMMJav16konNIxi8DWY26v3jnA8ra18sf4ELf1uY0QaDAKM29+OCu9lpPhf85yGsxr0Y
         OunGSibVk/nQEJoQD+mpsAvsuuDY3QYFYex2mzZz0+hcUDg9MfbZobGVV1zabfrYEhxu
         i1M94LR90yyAT7PGDp7wmwcofKvMK+gb1mTcSVGvvxBu3ovm6kQiLe3ccVhnVIrLzIoX
         8lysYea2jeO317sDyQkRHc0Ko4UwXhZbAVcF3wjP6Hdq8pULrNquw0k+HBAMUl8aK+pV
         JUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdS0dfKBYecEwQwKHBe5egXm6nHt/JVy0ktggg3WRWc=;
        b=QPTe3JunjssNBg12J5WGi1agiAcZYPM1PNVhg3QljbqBY4Mb+avv3dve2Bqxfmywgz
         7kMdGJh8+gDbYffT2HWPk7M4BdJSm0w6lcnPjaCcEwoDeIC1apNafMArBX8A6lFjrhyL
         e6p3XvsRY0zBJ5vUAbBQ6K8SSZXoo/5VOI6eEGGTQS1knVQ1ETnAD0pmoMEcCF/u0bBW
         ElG0QLOdHoajSssC+jPFXz3YrUoKwVnXzVOtYk9KiwJkSkn46HVbwzDqWr6ULwIUa1vR
         DfdjjWl8AYNMkhYOh8QRGUonpiV8M8ZEwE1eGHsQRWdU8KNx98V+cEqxSTuS0h6KtwOp
         mZFQ==
X-Gm-Message-State: APjAAAXChVS9KF3KLVqG92cXkx5itHDF/DjBlk4i9r3fjp1P+jNvm0zC
        ZquDGlzJLa5+AvUPkLDAw1Edo5AMTNPvur5MAA==
X-Google-Smtp-Source: APXvYqw1pF5vxWigpmlGD2UHA/NwQ2asL3eNaqiKJWkDtJBgle1Faa9EotUNPxlWSEtfiFIG30OEJZkquUFE1bS9r68=
X-Received: by 2002:a05:660c:38e:: with SMTP id x14mr207588itj.146.1554260401821;
 Tue, 02 Apr 2019 20:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com> <20190402064636.GM7627@MiWiFi-R3L-srv>
In-Reply-To: <20190402064636.GM7627@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 3 Apr 2019 10:59:50 +0800
Message-ID: <CAFgQCTvT3o4khFM6uYpe2m4D+L_kxkrWCMGsK-oL4St4_=EsTg@mail.gmail.com>
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
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

On Tue, Apr 2, 2019 at 2:46 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/02/19 at 12:10pm, Pingfan Liu wrote:
> > crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
> > fail to reserve the required memory region if KASLR puts kernel into the
> > region. To avoid this uncertainty, asking KASLR to skip the required
> > region.
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
> > v2 -> v3: adding parsing of crashkernel=range1:size1[,range2:size2,...]@offset
> >
> >  arch/x86/boot/compressed/kaslr.c | 116 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 114 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 2e53c05..7f698f4 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -107,6 +107,7 @@ enum mem_avoid_index {
> >       MEM_AVOID_BOOTPARAMS,
> >       MEM_AVOID_MEMMAP_BEGIN,
> >       MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> > +     MEM_AVOID_CRASHKERNEL,
> >       MEM_AVOID_MAX,
> >  };
> >
> > @@ -238,6 +239,115 @@ static void parse_gb_huge_pages(char *param, char *val)
> >       }
> >  }
> >
> > +/* code heavily copied from parse_crashkernel_mem() */
> > +static void handle_crashkernel_mem(char *cmdline,
> > +                                     unsigned long long system_ram,
> > +                                     unsigned long long *crash_size,
> > +                                     unsigned long long *crash_base)
>
> This version looks better and the logic is simple. It will be much better
> if we can share code with parse_crashkernel_mem() since both of them look
> almost the same.
>
A little hard, but I will have a try.
> > +{
> > +     char *tmp, *cur = cmdline;
> > +
> > +     /* for each entry of the comma-separated list */
> > +     do {
> > +             unsigned long long start, end = ULLONG_MAX, size;
> > +
> > +             /* get the start of the range */
> > +             start = memparse(cur, &tmp);
> > +             /* no value given */
> > +             if (cur == tmp)
> > +                     return;
> > +             cur = tmp;
> > +             if (*cur != '-')
> > +                     return;
> > +             cur++;
> > +
> > +             /* if no ':' is here, than we read the end */
> > +             if (*cur != ':') {
> > +                     end = memparse(cur, &tmp);
> > +                     /* no value given */
> > +                     if (cur == tmp)
> > +                             return;
> > +                     cur = tmp;
> > +                     /* invalid if crashkernel end <= start */
> > +                     if (end <= start)
> > +                             return;
> > +             }
> > +             /* expect ":" after range */
> > +             if (*cur != ':')
> > +                     return;
> > +             cur++;
> > +
> > +             size = memparse(cur, &tmp);
> > +             /* no size value given */
> > +             if (cur == tmp)
> > +                     return;
> > +             cur = tmp;
> > +             if (size >= system_ram)
> > +                     return;
> > +
> > +             /* match ? */
> > +             if (system_ram >= start && system_ram < end) {
> > +                     *crash_size = size;
> > +                     break;
> > +             }
> > +     } while (*cur++ == ',');
> > +
> > +     if (*crash_size > 0) {
> > +             while (*cur && *cur != ' ' && *cur != '@')
> > +                     cur++;
> > +             if (*cur == '@') {
> > +                     cur++;
> > +                     *crash_base = memparse(cur, &tmp);
> > +             }
> > +     }
> > +}
> > +
> > +/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> > +static void mem_avoid_specified_crashkernel_region(char *option)
>
> Maybe just add more words to explain the specified crashkernel region
> cases, but remove the 'speecified' word in function name?
>
OK.
> > +{
> > +     unsigned long long crash_size, crash_base = 0;
> > +     char    *first_colon, *first_space, *cur = option;
> > +
> > +     first_colon = strchr(option, ':');
> > +     first_space = strchr(option, ' ');
> > +     /* if contain ":" */
> > +     if (first_colon && (!first_space || first_colon < first_space)) {
> > +             int i;
> > +             u64 total_sz = 0;
> > +             struct boot_e820_entry *entry;
> > +
> > +             for (i = 0; i < boot_params->e820_entries; i++) {
> > +                     entry = &boot_params->e820_table[i];
> > +                     /* Skip non-RAM entries. */
> > +                     if (entry->type != E820_TYPE_RAM)
> > +                             continue;
> > +                     total_sz += entry->size;
>
> Wrap this for loop into a static function to calculate the system RAM
> size?
>
OK.

Thanks for your review.

Regards,
Pingfan
> Other than these, I think this adding looks good. It won't impact the
> current handling, and very easy to recognize what it's doing. Thanks for
> the effort.
>
> Thanks
> Baoquan
> > +             }
> > +             handle_crashkernel_mem(option, total_sz, &crash_size,
> > +                     &crash_base);
> > +     } else {
> > +             crash_size = memparse(option, &cur);
> > +             if (option == cur)
> > +                     return;
> > +             while (*cur && *cur != ' ' && *cur != '@')
> > +                     cur++;
> > +             if (*cur == '@') {
> > +                     option = cur + 1;
> > +                     crash_base = memparse(option, &cur);
> > +             }
> > +     }
> > +     if (crash_base) {
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > +     } else {
> > +             /*
> > +              * Clearing mem_avoid if no offset is given. This is consistent
> > +              * with kernel, which uses the last crashkernel= option.
> > +              */
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> > +     }
> > +}
> >
> >  static void handle_mem_options(void)
> >  {
> > @@ -248,7 +358,7 @@ static void handle_mem_options(void)
> >       u64 mem_size;
> >
> >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> > -             !strstr(args, "hugepages"))
> > +             !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> >               return;
> >
> >       tmp_cmdline = malloc(len + 1);
> > @@ -284,6 +394,8 @@ static void handle_mem_options(void)
> >                               goto out;
> >
> >                       mem_limit = mem_size;
> > +             } else if (strstr(param, "crashkernel")) {
> > +                     mem_avoid_specified_crashkernel_region(val);
> >               }
> >       }
> >
> > @@ -412,7 +524,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> >
> >       /* We don't need to set a mapping for setup_data. */
> >
> > -     /* Mark the memmap regions we need to avoid */
> > +     /* Mark the regions we need to avoid */
> >       handle_mem_options();
> >
> >       /* Enumerate the immovable memory regions */
> > --
> > 2.7.4
> >
