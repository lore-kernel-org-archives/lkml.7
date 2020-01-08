Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1EE206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="q78bn8qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgAHVxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:53:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34331 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgAHVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:53:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so5163776otf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 13:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhzjXDFfjYHRbMTJJFHpwq518k3jjZ5F1Nc5S+y6bT8=;
        b=q78bn8qpIIpykvt7xIGtljLHImgPRgl+m0WhNnnVnT5a8wJXcakJViLzNxt3OdA55Z
         hxiX4Ahmzg4E+dp2k3slw/wbUZuME4N5ryZHKeectR1RrX03U9+7zC266AUvIgZfeRYi
         cHEcRPrhw+JhfpSKM1lZhZMBdba392ylfiqou221Sy5U4GKMxf5KAKQHbuRlqtQExx8K
         hMCqPjcCqPlsZYDn2qwgFuC1BjQcwmpigt4mpha6hQZQmVgsoPzNb4TuxMoJoUYnyss9
         8Xp128m5gzg8Dvibo3RPcBaFil8ise+FaupXZgls3QcWv/4KT0/MwmLn2VFfvbsH8hMU
         Ddiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhzjXDFfjYHRbMTJJFHpwq518k3jjZ5F1Nc5S+y6bT8=;
        b=JqzQB9RJyzY/qwcJ23NkmbZKrmvhdJa3exKTUOP/LmFIBrxaTn82LcdsqLXq2z3rx0
         OlOI8TN3JGEVF+20qvNT5QrDxDwgMd9jniM5jn0S3TOGmAXbrMmlIC8aEFgvOaBiAfUQ
         qgBfkzB7cSjf7/NVYIq61TJ0Qb5ta0la8ODt2QEqM+Puhxue9QPMCne5faF/Krl7GBlV
         LWa2qwrEblR+lTY4rewlYEa7mNFWntnxqrsA0btY9skeVjujmQg6KiuuFZ2FuG6Db5xd
         1wfVXTSl+9IvhYUEKXiePxnWgeEETAkqCe+YlJbKezYKzmta2WgE6AJbo36+f5pC7P5J
         66Sg==
X-Gm-Message-State: APjAAAW4kJGi6fEd+J6f6eV3eldYb3Z9aEpkKDiR6dVhEIZxPiTMy6oK
        NjPiMs7HGHH9/7OI71T8vVsAMAxqQ6wdy3oTNU6RAw==
X-Google-Smtp-Source: APXvYqxgJC+lj68M6vVZvqY28cs6rrDu3iNLGPXMI+DfmkJ6DbcrtgYrcHSP8WXBfLzw+SF0oAkfJncisjw/9a+k+mU=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr5583387otm.247.1578520431507;
 Wed, 08 Jan 2020 13:53:51 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com> <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
 <20200107051919.GC19080@dhcp-128-65.nay.redhat.com> <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jan 2020 13:53:40 -0800
Message-ID: <CAPcyv4ixPchDOet=ztRQxLMgnJf9DauSFgBs3+TEoaua7R1s_Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 9:52 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 7 Jan 2020 at 06:19, Dave Young <dyoung@redhat.com> wrote:
> >
> > On 01/06/20 at 08:16pm, Dan Williams wrote:
> > > On Mon, Jan 6, 2020 at 8:04 PM Dave Young <dyoung@redhat.com> wrote:
> > > >
> > > > On 01/06/20 at 04:40pm, Dan Williams wrote:
> > > > > Dave noticed that when specifying multiple efi_fake_mem= entries only
> > > > > the last entry was successfully being reflected in the efi memory map.
> > > > > This is due to the fact that the efi_memmap_insert() is being called
> > > > > multiple times, but on successive invocations the insertion should be
> > > > > applied to the last new memmap rather than the original map at
> > > > > efi_fake_memmap() entry.
> > > > >
> > > > > Rework efi_fake_memmap() to install the new memory map after each
> > > > > efi_fake_mem= entry is parsed.
> > > > >
> > > > > This also fixes an issue in efi_fake_memmap() that caused it to litter
> > > > > emtpy entries into the end of the efi memory map. An empty entry causes
> > > > > efi_memmap_insert() to attempt more memmap splits / copies than
> > > > > efi_memmap_split_count() accounted for when sizing the new map. When
> > > > > that happens efi_memmap_insert() may overrun its allocation, and if you
> > > > > are lucky will spill over to an unmapped page leading to crash
> > > > > signature like the following rather than silent corruption:
> > > > >
> > > > >     BUG: unable to handle page fault for address: ffffffffff281000
> > > > >     [..]
> > > > >     RIP: 0010:efi_memmap_insert+0x11d/0x191
> > > > >     [..]
> > > > >     Call Trace:
> > > > >      ? bgrt_init+0xbe/0xbe
> > > > >      ? efi_arch_mem_reserve+0x1cb/0x228
> > > > >      ? acpi_parse_bgrt+0xa/0xd
> > > > >      ? acpi_table_parse+0x86/0xb8
> > > > >      ? acpi_boot_init+0x494/0x4e3
> > > > >      ? acpi_parse_x2apic+0x87/0x87
> > > > >      ? setup_acpi_sci+0xa2/0xa2
> > > > >      ? setup_arch+0x8db/0x9e1
> > > > >      ? start_kernel+0x6a/0x547
> > > > >      ? secondary_startup_64+0xb6/0xc0
> > > > >
> > > > > Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
> > > > > services data to fix kexec breakage" is listed in Fixes: since it
> > > > > introduces more occurrences where efi_memmap_insert() is invoked after
> > > > > an efi_fake_mem= configuration has been parsed. Previously the side
> > > > > effects of vestigial empty entries were benign, but with commit
> > > > > af1648984828 that follow-on efi_memmap_insert() invocation triggers
> > > > > efi_memmap_insert() overruns.
> > > > >
> > > > > Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> > > > > Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> > > >
> > > > A nitpick for the Fixes flags, as I replied in the thread below:
> > > > https://lore.kernel.org/linux-efi/CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com/T/#m2bb2dd00f7715c9c19ccc48efef0fcd5fdb626e7
> > > >
> > > > I reproduced two other panics without the patches applied, so this issue
> > > > is not caused by either of the commits, maybe just drop the Fixes.
> > >
> > > Just the "Fixes: af1648984828", right? No objection from me. I'll let
> > > Ingo say if he needs a resend for that.
> > >
> > > The "Fixes: 0f96a99dab36" is valid because the original implementation
> > > failed to handle the multiple argument case from the beginning.
> >
> > Agreed, thanks!
> >
>
> I'll queue this but without the fixes tags. The -stable maintainers
> are far too trigger happy IMHO, and this really needs careful review
> before being backported. efi_fake_mem is a debug feature anyway, so I
> don't see an urgent need to get this fixed retroactively in older
> kernels.

I'm fine to drop the fixes tags.

However, I do want to point out my driving motive for digging in on
efi_fake_mem=nn@ss:0x40000, is that it is a better interface for
diverting memory ranges to device-dax than the current standard bearer
memmap=nn!ss. The main benefit is that the kernel only considers the
attribute when it is applied to EFI_CONVENTIONAL_MEMORY. This fixes a
long standing unsolvable issue of people picking busted memmap=nn!ss
settings that clobber platform memory ranges, or vector off into
nothing.

So yes, efi_fake_mem is a debug feature, but if the popularity of
memmap=nn!ss is any clue I expect efi_fake_mem=nn@ss:0x40000 will be a
useful tool going forward for late enabling, or repairing platform
"soft reservation" declarations.

I'll respin the series with those tags dropped and add the comment you
recommended about the cases when efi_memmap_free() is expected to be a
nop. Holler if there's anything else, but that's all I had on my list
to fix up.
