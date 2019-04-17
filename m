Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0155720835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkRcywwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfDQFxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:53:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36259 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQFxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:53:49 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so2571458itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KskvEh89isveVKjUHJfRsvgMchybcfP9xC7VZPDJedc=;
        b=DkRcywwgZ3MBPlWkG4t+VHo5Vft+HgqbxwJfWP8ccRZwTHHIlue8mVrwNjZ6JzWqfZ
         2vwSh10zQTJkd1iMdskPlwH1fAg9exLkOxGMspAJhNZT9bfMvu2oATWnZH3gE5dbUifk
         yERzgWMpDvs+OUFLn4X6glRN1DGupaL4+mSCyvR95Rk/iwq+Lx+XaMzegSNJqGR5GFP5
         ECt7FIDIey6y/rMsJxPpKjm5tgyiRvjOJngel2d4OsXDTfPZHITXnaWsTp+ociJTVdIX
         UbQe5Ht/UxY0TD0E+g2Ai7UIkv1IZOlY9nK4juDYX6Q+HSyJaM/QhxtuU3zY0C8DuIM9
         rROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KskvEh89isveVKjUHJfRsvgMchybcfP9xC7VZPDJedc=;
        b=iCi6Yp6YuCqxm94/uy2lVL0b7SHorjuzhjTrwD1a6cd0CzTjxjvPLu0GIA1Vb7Gdqf
         swZw2iK9X9ZLj7lkYIUWcbjZGJ51MdM7WZpiu4KYot+gTZWaQdPSYcossW7gjrj3mqqU
         qSQCZIqH1FLeotf+0MCX9Eqhy4lISZVLrI72ykVqtsNp6VMo3gCFHON0PQfmH4uMoB9F
         mkB5v4XmDQjig0peLy7pCfXw/9XlRzU8SlqHYQcUSaJIi06cQO+sj9xJjRCb9dnkhFLL
         YHbxhXElsLkrfBVllIItzliKleoh2xxCSrgWjYUHNFxq/IdPYf5IiL1i8FdYVX52hLv9
         Z9VA==
X-Gm-Message-State: APjAAAWKhl9efUHF9ywBuNjkvrhv1yapHl+3Eo+gxQ4KjDr/fyylUwbt
        DlZSV7zb6Ug4blmLDu3fvEgEJW6m6S0b3Ix/Sg==
X-Google-Smtp-Source: APXvYqx6L2Npid+VYCfagQ0I/rZinFwm5xpX08qYU/D5qpKvf4jmiLdapbFdDm/K/c14h249PvnSaC5W53j1/JR0b4o=
X-Received: by 2002:a24:1f44:: with SMTP id d65mr31710587itd.65.1555480428798;
 Tue, 16 Apr 2019 22:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com> <20190416190128.GL31772@zn.tnic>
In-Reply-To: <20190416190128.GL31772@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 17 Apr 2019 13:53:37 +0800
Message-ID: <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel region
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:01 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 08, 2019 at 01:58:35PM +0800, Pingfan Liu wrote:
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
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 2e53c05..765a593 100644
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
> > @@ -131,6 +132,11 @@ char *skip_spaces(const char *str)
> >  }
> >  #include "../../../../lib/ctype.c"
> >  #include "../../../../lib/cmdline.c"
> > +#ifdef CONFIG_CRASH_CORE
> > +#define printk
> > +#define _BOOT_KASLR
> > +#include "../../../../lib/parse_crashkernel.c"
> > +#endif
> >
> >  static int
> >  parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
> > @@ -292,6 +298,39 @@ static void handle_mem_options(void)
> >       return;
> >  }
> >
> > +static u64 mem_ram_size(void)
> > +{
> > +     struct boot_e820_entry *entry;
> > +     u64 total_sz = 0;
> > +     int i;
> > +
> > +     for (i = 0; i < boot_params->e820_entries; i++) {
> > +             entry = &boot_params->e820_table[i];
> > +             /* Skip non-RAM entries. */
> > +             if (entry->type != E820_TYPE_RAM)
> > +                     continue;
> > +             total_sz += entry->size;
> > +     }
> > +     return total_sz;
> > +}
> > +
> > +/*
> > + * For crashkernel=size@offset or =range1:size1[,range2:size2,...]@offset
> > + * options, recording mem_avoid for them.
> > + */
> > +static void handle_crashkernel_options(void)
> > +{
> > +     unsigned long long crash_size, crash_base = 0;
> > +     char *cmdline = (char *)get_cmd_line_ptr();
> > +     u64 total_sz = mem_ram_size();
> > +
> > +     parse_crashkernel(cmdline, total_sz, &crash_size, &crash_base);
>
> That function has a return value which you could test. And then you
> don't need to set crash_base to 0 above.
>
Take __parse_crashkernel()->parse_crashkernel_simple() for example. If
no offset given, then it still return 0, but crash_base is dangling.

Regards,
Pingfan
