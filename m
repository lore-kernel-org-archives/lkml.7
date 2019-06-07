Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A54C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E019120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TiqYN4ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfFGRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:34:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38285 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfFGRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:34:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so1989531oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
        b=TiqYN4ZIeJIcZdyH76CPw/HVLGladFFX1TaVyA8d+bt91TPBoOj+Wl/qYIgyST2If0
         5Q53pA2tQdlIrIXAbCxchjf9ns3sci6CtmdDvUYrvO+YD3Ve5aaBvSMa9VMxmPhN4j3W
         Tn6nVuiG9Y78xQgJXKnl+5bg5ke1pBLB1GlQupAgv6HIX0F0U/aM7XPLV9VOXad4g4Lf
         LMgAgdHX6fzBlIhsSuKFqXCYO1qbZHMxYrPREEUVIDtZdlVAsMCCpwK3xKS/Lk71Awcd
         0pVr2y0nBr1ueHaxoR1TDFfUyDNALDL/sX3kpjnRhqFMhc9LDiPs7+I3miDoeZpWxW9D
         0NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
        b=SxON3yjhIrAi+dryiAkzfoMXP6SL72daDK9o/1y94uZsA7D//JtjSOQ3XaHHyogLgu
         LM5Rfrk/AWA8wJGBniAwo6Zvl5XTNnssjFMxKwz5pV1RLEj66g7Mt6TcE2HDyxGqwee7
         /dmEhlCyyCCPGRIfGhPFFK5DHJzpZrRf/UvDeUGiiqRX7gGm0SsMdtjk6lsdxGwhDS7H
         t33tU91ZA6poqLew9dp95HMtA6mckLhwuh1GFzpWfU/BBkMwst2y9EJzytXgbA5W5Kcg
         vGfs5jxoth3GTL55zYFrV3Ay6HXYVag4DrY4ihM9MK+tHQlrZA1ikDBcEZCtQR28lOpD
         heaA==
X-Gm-Message-State: APjAAAUrPlK/WNAJ3T8DA4N4QFn+jDHxPehRAqokqP5YgNVOkBjWv2a7
        qMwoEmYy6oF2xKYkjz080ReZn2yKQBWa1fZ3i/39Nw==
X-Google-Smtp-Source: APXvYqwxRH9b7zfmNokXa/MJtvxICynfiQZqc9XkLddgj7G1h1cazph56bWLcewkRjUHU4E05igOxqptPTcARwRwv5E=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr1785826oih.73.1559928887822;
 Fri, 07 Jun 2019 10:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com> <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
In-Reply-To: <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 10:34:36 -0700
Message-ID: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
[..]
> > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > >                 && (md->attribute & EFI_MEMORY_SP);
> > > }
> > > #else
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return false;
> > > }
> > > #endif
> >
> > I think this policy decision should not live inside the EFI subsystem.
> > EFI just gives you the memory map, and mangling that information
> > depending on whether you think a certain memory attribute should be
> > ignored is the job of the MM subsystem.
>
> The problem is that we don't have an mm subsystem at the time a
> decision needs to be made. The reservation policy needs to be deployed
> before even memblock has been initialized in order to keep kernel
> allocations out of the reservation. I agree with the sentiment I just
> don't see how to practically achieve an optional "System RAM" vs
> "Application Reserved" routing decision without an early (before
> e820__memblock_setup()) conditional branch.

I can at least move it out of include/linux/efi.h and move it to
arch/x86/include/asm/efi.h since it is an x86 specific policy decision
/ implementation for now.
