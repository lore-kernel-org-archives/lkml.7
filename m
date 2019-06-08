Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28386C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29F3212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDyg19KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFHHU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 03:20:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53050 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfFHHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 03:20:26 -0400
Received: by mail-it1-f195.google.com with SMTP id l21so6120308ita.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
        b=NDyg19KRBwWKCsuIiFvg9iRfAOK0BFmH02/xvBLHZXW8TjkcbUXa07UNeCGFNRcVSQ
         8RbFmVpFH1UV2N+/j05HX8NIJQJMtjsgEKFE86KKcUhlfShKCx8Iz8dbQ9Vsx6tckJ5T
         rS+m/g1NYezNDmc1RO4A3Sgo+UodJa8hGFvDUEImNfqv0n+QszCBKoGTKvUhISzRtwkA
         Xb1wAh6WTP39KnlTRX4OirLbaYKQbvdRLkSl+jZyYeOtzDdqjdwK37E0w6E6cb4CmU/O
         DCw//CheJdpE6T4DkIGFn5i6qQUWUaZYBqkDJxVbCvsO0AZmxviK0yDSf2JLaX3ABS1p
         82Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
        b=GRXbzt2x3KT9/95G82X0ik9CKf+Bdn+DBjoXhKpjs0ckPfW9WEnOHlzuyg+SMzoEKb
         ZdsDi4nQKjmnv+LFNSKcEl4XE4Sox2AhJb7XhZSI1EN7DHzPkmYSMmaqRbXOUw7INzKd
         i12yySwHOaAHd05M3bFHsLvj7cWViASAhVpcTCAmU5AXtJ3hUQ5KUXExhXotXBiP+4yF
         M8vXImqr0KbiOLRJfw4eeFd9DtuaXjrq2DOUQ16mzPJ/M9hlcn0PI5RNYTMYZWP9K0Ig
         IRlZFUPizBbVTdxKteA/rciF05wRoundDdF6oAWXJg9SuQ55bAa0JGL33KrCwdnyxMuI
         FLVw==
X-Gm-Message-State: APjAAAVlcHmfCmP6aHWEsYmeqPynufuVayc/ShJG9ZLu+2dCOzriKwEF
        7Zl4VBYUsKlFgTu4WoR1u71xMQZwJ3PJNQS+RUV54A==
X-Google-Smtp-Source: APXvYqwnMZ8z1ON6onK6aLjM8baTZPCff6UnkQu1+3vja3H65nm9+6f6XC126h9UoGCw6NSPIu5HIfQvokO9SnkaUhk=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr6512194itb.104.1559978425951;
 Sat, 08 Jun 2019 00:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com>
 <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com> <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
In-Reply-To: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 8 Jun 2019 09:20:13 +0200
Message-ID: <CAKv+Gu_OcsWi5DqxOk-j6ovc0CMAZV37Od7zA5Bs4Ng5ATQxAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Dan Williams <dan.j.williams@intel.com>
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

On Fri, 7 Jun 2019 at 19:34, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> [..]
> > > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > > >                 && (md->attribute & EFI_MEMORY_SP);
> > > > }
> > > > #else
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return false;
> > > > }
> > > > #endif
> > >
> > > I think this policy decision should not live inside the EFI subsystem.
> > > EFI just gives you the memory map, and mangling that information
> > > depending on whether you think a certain memory attribute should be
> > > ignored is the job of the MM subsystem.
> >
> > The problem is that we don't have an mm subsystem at the time a
> > decision needs to be made. The reservation policy needs to be deployed
> > before even memblock has been initialized in order to keep kernel
> > allocations out of the reservation. I agree with the sentiment I just
> > don't see how to practically achieve an optional "System RAM" vs
> > "Application Reserved" routing decision without an early (before
> > e820__memblock_setup()) conditional branch.
>
> I can at least move it out of include/linux/efi.h and move it to
> arch/x86/include/asm/efi.h since it is an x86 specific policy decision
> / implementation for now.

No, that doesn't make sense to me. If it must live in the EFI
subsystem, I'd prefer it to be in the core code, not in x86 specific
code, since there is nothing x86 specific about it.

Perhaps a efi=xxx command line option would be in order to influence
the builtin default, but it can be a followup patch independent of
this series.
