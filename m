Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2158120830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XcrIfAGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfIMPCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:02:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45557 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390433AbfIMPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:02:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so2857844oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL1GjXU4OxVtgje4G6mCeYw5JgQRyVmMHSk6LS6L6h0=;
        b=XcrIfAGLgnCngGnqO1DJcdE95s67blXTpvCmuoC4POiBmx1B9clK5ZNugaQYZJsHUK
         LRRlS7On0v8cTv9pXBKg5amy+FZZUlwUL7z05OwVEHx82wbE3R4S2AW1N/pUtqyq+coe
         IxqcEgPQZzwzDUjxbbqdywUSKT8qPsXxZunO4CUbU0DklVvrpC3nBd3ULVxpo/T9HIUV
         CxZ18AffXR0nlOKPGBkl6EiS3GhbOs46/HGXTUldnrXoG2kQLecamfhdRyIzxHQX4Ta4
         86UKX/JIqHw9xYUfiv4/nwCOTRYSHTLVvwAOG3sBbWBbBCNaCkJREJNSrKCEVbUnh+Ms
         xEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL1GjXU4OxVtgje4G6mCeYw5JgQRyVmMHSk6LS6L6h0=;
        b=W7NUcGoN2/tWL1SZ9eh8XXTfwiY2PKjQ66EkWVfATL8yUn+VzWdlM3s30Ww2wp4lwt
         nuQaFhsRckEK5/HT/4WBe+XO/F/tpR6xLK7v58qYVpJKCnpNA29XBPBwDjgxrftNJCMR
         hnvrwXM6UOQGFucLD3H8D3elVEvB5OisQTeFRgDw26owTCKRDMPjBr+Ay1d5M6Y8wo4Q
         XpG1RquqYSWG3zZYUx6QtZMDM+i4EiESXJiOXJcenD6gugx4fMvryrR3YVr09rMAg0ON
         QOh4pv8bhmmBjTWHr+sgF3V7tXc3VsCkcZJFYqef8CTlAyUhdekqUe7r1Q7ri2Wy6boU
         d5RQ==
X-Gm-Message-State: APjAAAW4Ca1a6J4oUDAUByt1UKHAccezJBwRov3PlydrlEXY3r9/oADe
        EOppkfUaZGwIV1gjZSjp0nuDxCaMLTyvsQznUNChow==
X-Google-Smtp-Source: APXvYqyeEJXWj7rpxrv1qz+5i2zLZaF/SLL5wmnwCw6eD+cUG7FsoCaEJNlzjXu8gUdNFX/hYHgq60QKgMlpEmp2U7Y=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr2670978oia.70.1568386960199;
 Fri, 13 Sep 2019 08:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-UK75nCreZb=v7PQne4Ay25B7oRAeRg4AB1XopYXt3Cg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-UK75nCreZb=v7PQne4Ay25B7oRAeRg4AB1XopYXt3Cg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 08:02:26 -0700
Message-ID: <CAPcyv4jv8OacA-P+DFj_d9gq3P-7b9xcr4=m3kx7nTvyko6i2g@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 6:02 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Aug 2019 at 03:07, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Given that EFI_MEMORY_SP is platform BIOS policy descision for marking
>
> decision

Fixed.

>
> > memory ranges as "reserved for a specific purpose" there will inevitably
> > be scenarios where the BIOS omits the attribute in situations where it
> > is desired. Unlike other attributes if the OS wants to reserve this
> > memory from the kernel the reservation needs to happen early in init. So
> > early, in fact, that it needs to happen before e820__memblock_setup()
> > which is a pre-requisite for efi_fake_memmap() that wants to allocate
> > memory for the updated table.
> >
> > Introduce an x86 specific efi_fake_memmap_early() that can search for
> > attempts to set EFI_MEMORY_SP via efi_fake_mem and update the e820 table
> > accordingly.
> >
>
> Is this early enough? The EFI stub runs before this, and allocates
> memory as well.

Unless I'm missing something the stub only allocates where the kernel
will land. That should be handled by the new mem_avoid_memmap()
extensions to consider "efi_fake_mem" in its exclusions.
