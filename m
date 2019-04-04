Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92AEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE42075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBUZIgP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfDDJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:40:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39331 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfDDJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:40:39 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so2615674ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8Vyla9QNzNo9BecqTGrDOscCBWrInVxTy9QUxd/nW4=;
        b=oBUZIgP2ZO9sXM6ppKlX4I9vXkkTCUG1HAA6lCIwxg7a3wp900/6Whq5WEYGLsXZG3
         wUl9TOjWh4Znplqa6qHZ36NQIk1Z24+JknKUQBXEaE7+ZETQ2qWO6h42ULF9j0ldSr/K
         zj2DL9nucUM+6J6SJeky1McjqUNP5uQL/knHwya1hlmkpIu0GssHcS+UQ95SHp9a12Wr
         Yn8cis0OfQWJEwVu/Q2suqWap691w8WoLaa7zStk2FH3F/agZzJxgHP5q1V2HyeBjbJf
         cH+BhLEUUwqj3qdMUjwJmNnCoc1W4ZeM8VCw+0v6DMbyFxZGXS7u1SasSPFW65kcSj2V
         OcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8Vyla9QNzNo9BecqTGrDOscCBWrInVxTy9QUxd/nW4=;
        b=JnIREXwPE/bCO++GaCQgvXRk/24SfJtCM8GWS9/H/T4f6zVjpn0et1/6NjtSUgUPtS
         1DqQovE+xUb2CHso2kEogQ6ZKjBAYwLQe9sVRd43odiHaWDopzXn4ru11r+aaepB5GAG
         sjiaDK8qgoykKo4TMQp++pW86lzPyHspfqT6mqTVicgNi3QccgKvwo3g3qS26QkHcSpi
         QE7iYE4b32xNmEkE9R/8Z9ajLNyeLiusGRsVINy8fuOkHKW+XR8MOysd4digdrudOMoP
         tpaCdfGHp+fcHRs0zv7nSjrbxiqm7/fqaoYjEJ1E1EgWwJHXii90gtfs5i42nZ/DG4tT
         zlkg==
X-Gm-Message-State: APjAAAXk2jWSOGfgz4C6xehmOsb1O6RDNl7Jo285uVXQ+ltNH483U9Dh
        Bj0ydhY+bq1/8H5gCUmqx9OgQMagZWUoKAbU+Q==
X-Google-Smtp-Source: APXvYqz4tgnZN5BzLpM0BrBpW767gGT2kEetbOy91JEFhfsGv/xeWkM6ZxsmLnowXDlxeySBOE2kIc2WRK7f29cutVQ=
X-Received: by 2002:a24:1f44:: with SMTP id d65mr3770016itd.65.1554370838515;
 Thu, 04 Apr 2019 02:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
 <20190402080811.GO7627@MiWiFi-R3L-srv> <CAFgQCTtYLVS8Mfztg8=PWEn8cxDm9Lm1p=zXDR1YG8Oo0MLx0Q@mail.gmail.com>
 <20190403031049.GP7627@MiWiFi-R3L-srv>
In-Reply-To: <20190403031049.GP7627@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 4 Apr 2019 17:40:26 +0800
Message-ID: <CAFgQCTs0YTFOePmv6R+j41BTsixE0HdED8kHHVY6+GaZzq4TMg@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 11:10 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/03/19 at 10:58am, Pingfan Liu wrote:
> > On Tue, Apr 2, 2019 at 4:08 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > > +/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> > > > +static void mem_avoid_specified_crashkernel_region(char *option)
> > > > +{
> > > > +     unsigned long long crash_size, crash_base = 0;
> > > > +     char    *first_colon, *first_space, *cur = option;
> > > > +
> > >
> > > Another thing which need be noticed is that you may only need to handle
> > > when '@' is found. Otherwise just let it go. Right?
> > >
> > According to kernel's behavior, only the last "crashkernel=" option
> > takes effect. Hence if no '@', then clearing mem_avoid
>
> Here I mean that you can search '@' at the beginning if crashkernel is
> found. Maybe no need to clear mem_avoid since it's global data, has been
> initialized to 0 during loading. It's in BSS, right?
>
Consider the following cmdline crashkernel=256M@1G crashkernel=512M.
These two options are handled independently by handle_mem_options(),
and the later one should overwrite the previous one. This is the
behavior of current kernel's code, referring to
get_last_crashkernel().
> You don't have to search first colon or first space, then parse size of
> crashkernel, and finally find out that it's only crashkernel=512M-2G:64M,2G-:128M
> style, no '@' specified. What do you think?
>
Yes, that will be better. But I plan to reuse parse_crashkernel_mem/simple().

Thanks,
Pingfan
> >
> > > > +     first_colon = strchr(option, ':');
> > > > +     first_space = strchr(option, ' ');
> > > > +     /* if contain ":" */
> > > > +     if (first_colon && (!first_space || first_colon < first_space)) {
> > > > +             int i;
> > > > +             u64 total_sz = 0;
> > > > +             struct boot_e820_entry *entry;
> > > > +
> > > > +             for (i = 0; i < boot_params->e820_entries; i++) {
> > > > +                     entry = &boot_params->e820_table[i];
> > > > +                     /* Skip non-RAM entries. */
> > > > +                     if (entry->type != E820_TYPE_RAM)
> > > > +                             continue;
> > > > +                     total_sz += entry->size;
> > > > +             }
> > > > +             handle_crashkernel_mem(option, total_sz, &crash_size,
> > > > +                     &crash_base);
> > > > +     } else {
> > > > +             crash_size = memparse(option, &cur);
> > > > +             if (option == cur)
> > > > +                     return;
> > > > +             while (*cur && *cur != ' ' && *cur != '@')
> > > > +                     cur++;
> > > > +             if (*cur == '@') {
> > > > +                     option = cur + 1;
> > > > +                     crash_base = memparse(option, &cur);
> > > > +             }
> > > > +     }
> > > > +     if (crash_base) {
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > > > +     } else {
> > > > +             /*
> > > > +              * Clearing mem_avoid if no offset is given. This is consistent
> > > > +              * with kernel, which uses the last crashkernel= option.
> > > > +              */
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> > > > +     }
> > > > +}
