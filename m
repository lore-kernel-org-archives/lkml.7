Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14963C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0B321835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfJLDqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJLDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:46:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAA5E10B78
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 03:46:54 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id q18so17289968ios.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 20:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX6rdBEDjPMIvpmo1yfONxMIg/joRZEC9Kr+34iTwtQ=;
        b=e+q3blCl4Jc5BKRfhVep692Y0QsWJKLWg+jn2/3tnHnSUhd/uEH3VLyS2wo/V5v1RT
         Y6QEOuXLavmiLpAFaJJVNS2lJ31WilAm0dogwdOqOoQnVSKOP6X4Krs4I6sZGuw18T8d
         O6TwCOXXKIlIiy4NECYZe06TtksqWBq2w0EHGtsynaE1CP1GFxxuywk+mMVssxBCo2pp
         EJA9Hr0Nn8ULy2uPuvLBETcVh8YFeA6pOamtlgiIaUC7T65DAQ1srzRnwAX1XOVN4lxf
         QbtQ4MsQauc2fxpJ95U73bcP8Wod1bsEr1EKfZO/Ctzji8KO92SscC0OQRptjs3Lv4HY
         OCDg==
X-Gm-Message-State: APjAAAXK8WDxz103RD7ME87f7K075P2a6iZJG4kSIwl48QC4pchcHt6o
        7HQCCpGG7X7qvM3m7seyXqmItTM58NCcJ2glV/vrQIyuQCPk60ig8X56S1UsJTpkHCh1Vqs7F+k
        sZ+fQXp9+aW1VaoLNYqle4k+sAT9j6l+dDW42KTOJ
X-Received: by 2002:a5d:9052:: with SMTP id v18mr2839600ioq.13.1570852014001;
        Fri, 11 Oct 2019 20:46:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxgN/oeG+/byRql2+hJra84DTMBSjIQyBIvwut4vl0gjW2FpkzZ8PlIJObwmJP2KyWI5PgCHtWv22SL2Ku3iwE=
X-Received: by 2002:a5d:9052:: with SMTP id v18mr2839572ioq.13.1570852013679;
 Fri, 11 Oct 2019 20:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com> <20191011132339.GB8824@zn.tnic>
In-Reply-To: <20191011132339.GB8824@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Sat, 12 Oct 2019 11:46:42 +0800
Message-ID: <CACPcB9cK1DfxbVjTV0oFz__RvNwzR=JA2CFx9c8THdS=hdZsZw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 9:24 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 20, 2019 at 12:05:21AM +0800, Kairui Song wrote:
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
> >
> > Efi stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, efi stub can't relocate kernel to the preferred
> > address, so it fallback to query and alloc from EFI firmware for lowest
> > usable memory region.
> >
> > It's incorrect to use the lowest memory address. In later stage, kernel
> > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > but efi stub will end up relocating kernel below it.
>
> So far, so good.
>
> > Then before the kernel decompressing. Kernel will do another relocation
> > to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> > over write the blockage at the default load address, which efi stub tried
> > to avoid, and lead to unexpected behavior. Beside, the memory region it
> > writes to is not allocated from EFI firmware, which is also wrong.
>
> This paragraph is an unreadable mess and should be rewritten in simple,
> declarative sentences.
>
> The patch itself looks ok.

Thanks. I've sent V3 updating that paragraph.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
--
Best Regards,
Kairui Song
