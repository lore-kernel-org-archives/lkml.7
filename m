Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F88C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525C3217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HKNB7eUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGQTN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:13:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35133 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQTN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:13:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so27162524edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=af7XSHG9FUQt2yu1S5jYF4Zn8ho5gd7vQCkyA/tLau4=;
        b=HKNB7eUjLd+nxSmK5kC8wj8kzMts/Dpt6A34z7nveegtxZyhnKNjglMj7rQ0vCl6LG
         h/4t0uSBVCIua7IFT+yYWm2Fj59/6h40i8YUKwiETrPB6sZ6v8tarBe4z05I3+6KBe/o
         nVsQcwwepTM0+8r5FULsisZ5p08osnWUZkggEXqUrver/328oW7udcbaG4m29zLP4D64
         st4mdSY/slk8zOdH5QHV/oOGIFI6JB+jLZjhMhxwOlllr+eD2L1dm5L7pJsHWpHbz5iR
         kY5YFUJdTFHOUuTE0MvIKbBNaqb0rDaxBWnAC2VW1rRN5sIlI/nski3ZyMC97oNqcCWt
         vPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=af7XSHG9FUQt2yu1S5jYF4Zn8ho5gd7vQCkyA/tLau4=;
        b=TGkzP9DiiAjr1whhIbF1ODcYZvx0CiCNIeu8JHJ1nH0zGw6EJO6AlAP+fc7ecp4jCm
         VcS9oIPG6Yu42k/GgKJmz/6p0+kE4W299R9S1hBXdAkCkkc37HvWEhTZjaKh/aFV1Etg
         zVx+q/G6eekzhg2XIvO9LUS6C/Kt3R6w2gs6WqbfTYz1iAcgoCwIE05Nip16rzitijd6
         jm9kTyoNkUyorKNBH2uIpah23CpENuZfsKboLzu1OqsgvO1+1kU3euFdyMRegDQksGwn
         6mR0P8SDCQNgfsZ8u+S75OhD9rCW3nN7PeLTa9uy568/okNFFtNfJqWsfpGYO0dGJ5Jq
         y0fw==
X-Gm-Message-State: APjAAAWWn+4p/B95uZSow8+GzDFDqh/V8FNVpnfqG9dMX8EAPMuzvllH
        aC1SaTntgQ+iaD1uI4G7tslJgtvuCjK+dht1V/s=
X-Google-Smtp-Source: APXvYqzGlg1pP7IjPvj4DxUTLs7iKsVaWKc3/xY8HdOnhR8EtZWtRowTgwJdp96WZgETcAPcZ/SpRP0xI4l4xnW+0CI=
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr33040768ejs.156.1563390806721;
 Wed, 17 Jul 2019 12:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190716165641.6990-1-pasha.tatashin@soleen.com> <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
In-Reply-To: <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 17 Jul 2019 15:13:15 -0400
Message-ID: <CA+CK2bBj9UsQZCLsy-S8c_Kd5SRAPvtdS8s9P_Fdg+VifTbT5w@mail.gmail.com>
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for taking a look at this work.

> After a quick skim:
>
> This will map 'nomap' regions of memory with cacheable attributes. This is a non-starter.
> These regions were described by firmware as having content that was/is written with
> different attributes. The attributes must match whenever it is mapped, otherwise we have a
> loss of coherency. Mapping this stuff as cacheable means the CPU can prefetch it into the
> cache whenever it likes.

> It may be important that we do not ever map some of these regions, even though its
> described as memory. On AMD-Seattle the bottom page of memory is reserved by firmware for
> its own use; it is made secure-only, and any access causes an
> external-abort/machine-check. UEFI describes this as 'Reserved', and we preserve this in
> the kernel as 'nomap'. The equivalent DT support uses memreserve, possibly with the
> 'nomap' attribute.
>
> Mapping a 'new'/unknown region with cacheable attributes can never be safe, even if we
> trusted kexec-tool to only write the kernel to memory. The host may be using a bigger page
> size causing more memory to become cacheable than was intended.
> Linux's EFI support rounds the UEFI memory map to the largest support page size, (and
> winges about firmware bugs).
> If we're allowing kexec to load images in a region not described as IORESOURCE_SYSTEM_RAM,
> that is a bug we should fix.

We are allowing this. If you consider this to be a bug, I will fix it,
and this will actually simplify the idmap page table. User will
receive an error during kexec load if a request is made to load into
!IORESOURCE_SYSTEM_RAM region.

>
> The only way to do this properly is to copy the linear mapping. The arch code has lots of
> complex code to generate it correctly at boot, we do not want to duplicate it.
> (this is why hibernate copies the linear mapping)

As I understand, you would like to take a copy of idmap page table,
and add entries only for segment
sources and destinations into the new page table?

If so, there is a slight problem: arch hook machine_kexec_prepare() is
called prior to loading segments from userland. We can solve this by
adding another hook that is called after kimage_terminate().

> These patches do not remove the running page tables from TTBR1. As you overwrite the live
> page tables you will corrupt the state of the CPU. The page-table walker may access things
> that aren't memory, cache memory that shouldn't be cached (see above), and allocate
> conflicting entries in the TLB.

Indeed. However, I was following what is done in create_safe_exec_page():
https://soleen.com/source/xref/linux/arch/arm64/kernel/hibernate.c?r=af873fce#263

ttbr1 is not removed there. Am I missing something, or is not yet
configured there?

I will set ttbr1 to zero page.

> You cannot use the mm page table helpers to build an idmap on arm64. The mm page table
> helpers have a compile-time VA_BITS, and we support systems where there is no memory below
> 1<<VA_BITS. (crazy huh!). Picking on AMD-Seattle again: if you boot a 4K 39bit VA kernel,
> the idmap will have more page table levels than the page table helpers can build. This is
> why there are special helpers to load the idmap, and twiddle TCR_EL1.T0SZ.
> You already need to copy the linear-map, so using an idmap is extra work. You want to work
> with linear-map addresses, you probably need to add the field to the appropriate structure.

OK. Makes sense. I will do the way hibernate setup this table. I was
indeed following x86, hoping that eventually it would be possible to
unite: kasan, hibernate, and kexec implementation of this page table.

>
> The kexec relocation code still runs at EL2. You can't use a copy of the linear map here
> as there is only one TTBR on v8.0, and you'd need to setup EL2 as its been torn back to
> the hyp-stub.

As I understand normally on baremetal kexec runs at EL1 not EL2. On my
machine is_kernel_in_hyp_mode() == false in cpu_soft_restart.

This is the reason hibernate posts EL2 in a holding pen while it rewrites
> all of memory, then calls back to fixup EL2. Keeping the rewrite phase at EL1 means it
> doesn't need independently tweaking/testing. You need to do something similar, either
> calling EL2 to start the new image, or disabling the MMU at EL1 to start the new image there.

OK, I will study how hibernate does this. I was thinking that if we
are running in EL2 we can simply configure TTBR0_EL2 instead of
TTBR0_EL1. But, I need to understand this better.

>
> You will need to alter the relocation code to do nothing for kdump, as no relocation is
> required and building page-tables is extra work where the kernel may croak, preventing us
> from reaching kdump.

Yes, I was planning to do nothing for kdump, which involves not
allocating page table. It is not part of the current patchest, as the
current series is not ready.

>
> Finally, having this independent idmap machinery isn't desirable from a maintenance
> perspective. Please start with the hibernate code that already solves a very similar
> problem, as it already has most of these problems covered.

OK.

> > This patch series works in terms, that I can kexec-reboot both in QEMU
>
> I wouldn't expect Qemu's emulation of the MMU and caches to be performance accurate.

I am not measuring performance in QEMU, I use it for
development/verification only. The performance is measured on real
hardware only.

>
> > and on a physical machine. However, I do not see performance improvement
> > during relocation. The performance is just as slow as before with disabled
> > caches.
>
> > Am I missing something? Perhaps, there is some flag that I should also
> > enable in page table? Please provide me with any suggestions.
>
> Some information about the physical machine you tested this on would help.
> I'm guessing its v8.0, and booted at EL2....

I am using Broadcom's Stingray SoC. Because  is_kernel_in_hyp_mode()
returns false, I believe it is EL1. How can I boot it at EL2?

So, I am still confused why I do not see performance improvements
during relocation on this machine. Any theories?

Thank you,
Pasha
