Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F3CC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7F12064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TqNYtLWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGJPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:55:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43771 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfGJPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:55:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so2658848edr.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaA7wPXrYr7zESysMrfljI9GtiDhiOThoc+Zj7rAeQA=;
        b=TqNYtLWI3NB5JsEVDIYRfoOI4EAUHP4qyxHSRm5QlvOdPdXg+XZBn6KbfVcA+ldNLI
         hfHdkLqaMhNIE5mo1ZJav81oJYcmTzznYM475X10Inp3sCwkcVSFjNi9PCNaC6G/K2Wt
         QX9qQHlgiffcwd7RGi1MUYVX8jaULZWLftt2Mznvv6iNu8iVu0iDA4SSHU3tHsHN3qM/
         o4it1CczGwSnYsettifQezPONE/tBvt/IMgWBy/zxxnFQpt5dhB6puDph7x5F/YyuESq
         m9PpMR3sqidn2gDwZhL58TVLvFBxoTivnIiHN3z96McCrM7yVipkS7cj8oWbeX4pZgu/
         bVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaA7wPXrYr7zESysMrfljI9GtiDhiOThoc+Zj7rAeQA=;
        b=QnsBKib1pbva2FgnU3O+P23VhvzNFwjDSq0lftBZLhSKy5NBGwoMu8phNcAT6Ssiol
         phhKyNilgV6oHd101cHrO8+8ON9EChhIo5IfkcmphMMsirDQWXWXC33rLthBS7N6aDGs
         JJCzJBoNX+RodUFmoqaMdrDNNL7NfhxLWX81cLChuaSFy4WvZceEnkfe4de5TINyJC7Y
         7t8M5Qah8wX8DhlRg7yU/+dmgkRIImRjC9bX+7B4zAIICPeNtju/jEPf5ibHZU3nYl9d
         VXTToE8ZSPEfCBZj0q8I+TZJTBlNPsOXV7GzJRpbmG7hzrHyXCT/qnzJUNs6pd67XFQ6
         CbWg==
X-Gm-Message-State: APjAAAXxnm+OesyaJr8UPnxuIZF8GlgqS2GHYHcwNSo+Syr9EsImPaI1
        bx9wDu+LXW3rLBqnfJ4MvRsWK4vINA8bEEbhsZsx4Q==
X-Google-Smtp-Source: APXvYqxg9GNnMZ/W/1xpM+BzZ1/EcZfrkaZOycPesX2M/S7a3GF/j270Zx7XNeK8JZVUBd9XjN8MzzuAh6A7sMkVG/Y=
X-Received: by 2002:a17:906:d1d0:: with SMTP id bs16mr26795899ejb.286.1562774110079;
 Wed, 10 Jul 2019 08:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com> <d57ec270-a9dc-1820-195c-eb7ef61f9828@redhat.com>
In-Reply-To: <d57ec270-a9dc-1820-195c-eb7ef61f9828@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 10 Jul 2019 11:54:59 -0400
Message-ID: <CA+CK2bC_e=mkxeic--Rw6t84pnP139S_JqoGp9CsJ=aSrnY5mA@mail.gmail.com>
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
To:     Bhupesh Sharma <bhsharma@redhat.com>
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

On Wed, Jul 10, 2019 at 3:32 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Pavel,
>
> On 07/09/2019 11:50 PM, Pavel Tatashin wrote:
> > Changelog
> > v1 - v2
> >       - No changes to patches, addressed suggestion from James Morse
> >         to add "arm64" tag to cover letter.
>
> Minor nit. Please also add PATCH to the subject line. Something like
> [PATCH v2]

OK

>
> Also will suggest to wait for atleast a couple of days before sending a
> new version of the patchset so as to give sufficient time for reviews to
> happen.

OK

>
> >       - Improved cover letter information based on discussion.
>
> > Currently, it is only allowed to reserve memory for crash kernel, because
> > it is a requirement in order to be able to boot into crash kernel without
> > touching memory of crashed kernel is to have memory reserved.
>
> > The second benefit for having memory reserved for kexec kernel is
> > that it does not require a relocation after segments are loaded into
> > memory.
>
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs might take a significant
> > portion of reboot.
> >
> > In fact, on the machine that we are using, that has ARM64 processor
> > it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> > time:
> >
> > kernel shutdown       0.03s
> > relocation    0.35s
> > kernel startup        0.29s
> >
> > Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> > time increases proportionally.
> >
> > While, it is possible to add 'kexeckernel=' parameters support to other
> > architectures by modifying reserve_crashkernel(), in this series this is
> > done for arm64 only.
>
> Note that we normally have two dimensions to this (and similar)
> problem(s) - time we spend in relocating the kernel + initramfs v/s the
> memory space we reserve while enabling kexeckernel (in this case) in the
> primary kernel.

Yes, for our specific case (Microsoft), it is more important to faster
reboot and have 64M permanently reserved. However, after thinking
about this, I decided to go ahead, and implement MMU enabled kernel
relocation for ARM64.

>
> Just to give you an example, I have to shrink even the crashkernel
> reservation size in the primary kernel on arm64 systems running fedora
> which have very small memory footprint. I have a amazon ec2 (aarch64)
> for example which runs with 256M memory space and even enabling
> crashkernel on the same was quite a challenge :)
>
> In such a case we need to do a comparison between the space we reserve
> v/s the time we spend while relocating while doing a kexec load.
>
> Note that we recently had issues with OOM in crashkernel boot, because
> of which we had to introduce kernel command-line parameter to allow a
> user to disable device dump to reduce memory usage, see the following
> commit:
>
> a3a3031b384f ("vmcore: Add a kernel parameter novmcoredd")
>
> More on the same below ...
>
> > The reason it is so slow on arm64 to relocate kernel is because the code
> > that does relocation does this with MMU disabled, and thus D-Cache and
> > I-Cache must also be disabled.
> >
> > Alternative solution is more complicated: Setup a temporary page table
> > for relocation_routine and also for code from cpu_soft_restart. Perform
> > relocation with MMU enabled, do cpu_soft_restart where MMU and caching
> > are disabled, jump to purgatory. A similar approach was suggested for
> > purgatory and was rejected due to making purgatory too complicated.
> > On, the other hand hibernate does something similar already, but there
> > MMU never needs to be disabled, and also by the time machine_kexec()
> > is called, allocator is not available, as we can't fail to do reboot,
> > so page table must be pre-allocated during kernel load time.
>
> ... may be its time to explore this path now with a fresh mind. I know
> Pratyush tried a bit on this and now I am experimenting on the same on
> several aarch64 systems, mainly because we are really short on memory
> resources on several aarch64 systems (used in embedded/cloud domain) and
> frequently run into OOM issues even in the primary kernel.
>
> Some more comments below:
>
> 1. I recommend protecting this code under a CONFIG (CONFIG_FAST_KEXEC ?)
> option and make it dependent on ARM64 being enabled (via CONFIG_ARM64
> option) to avoid causing issues on other archs like s390, powerpc,
> x86_64 (which probably don't need these changes).
>
> Also better to make the CONFIG option disabled by default, so that we
> can avoid OOM issues in primary kernel on arm64 systems with smaller
> memory footprints. A user can enabled it, if he needs fast kexec load
> experience..
>
> 2. Also, I don't see timing results for kexec_file_load() in this cover
> letter. Can you add some results for the same here, or are they on
> similar lines?
>
> I will give this a go on some aarch64 systems at my end and come back
> with more on the kernel + initramfs relocation time v/s memory space
> taken up results.
>
> Thanks,
> Bhupesh
>
> > Note: the above time is relocation time only. Purgatory usually also
> > computes checksum, but that is skipped, because --no-check is used when
> > kernel image is loaded via kexec.
> >
> > Pavel Tatashin (5):
> >    kexec: quiet down kexec reboot
> >    kexec: add resource for normal kexec region
> >    kexec: export common crashkernel/kexeckernel parser
> >    kexec: use reserved memory for normal kexec reboot
> >    arm64, kexec: reserve kexeckernel region
> >
> >   .../admin-guide/kernel-parameters.txt         |  7 ++
> >   arch/arm64/kernel/setup.c                     |  5 ++
> >   arch/arm64/mm/init.c                          | 83 ++++++++++++-------
> >   include/linux/crash_core.h                    |  6 ++
> >   include/linux/ioport.h                        |  1 +
> >   include/linux/kexec.h                         |  6 +-
> >   kernel/crash_core.c                           | 27 +++---
> >   kernel/kexec_core.c                           | 50 +++++++----
> >   8 files changed, 127 insertions(+), 58 deletions(-)
> >
>
