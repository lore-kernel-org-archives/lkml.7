Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A3C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A3F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gUROxfvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGJP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:58:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36246 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGJP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:58:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so2695015edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2hs0dyIQnh/sqo6KZ61rFm4L2r82B8qQvgfu80yNSo=;
        b=gUROxfvOCyof5ttodsBwlj38d9Umt2I6xGHrwlqIsUPaybPlSEyo4PeNiLuLBswZBu
         P2LmcnGTqODgeD4cMmrLHxkm4Iq/LqAXgBIhK2Dx55nA07tPc3wGPSLpk1/msnl6E/Zm
         GYl49EaZAKHk8zVTYx91QARCB83H+wvpSxA90NlBeMIVCcAo15xoY54JpX7JHcIMTKoc
         UsuJnGacdA2AzPTi8L4x6/cRVu1dtBW5/FSXWhxzF2GVvq1x5chEg9DO2wO+GpoyJpz8
         bOu2Oyb4yZhXQsckMoHRzjJsZAv4Q7Jzrfqjb3xwTCrnMTLbJAEvxOBLVwkwPMyH9GOb
         zn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2hs0dyIQnh/sqo6KZ61rFm4L2r82B8qQvgfu80yNSo=;
        b=sK+KSrbv9hJxTj129BLp+YrtB/kavIYwXn3pFre7up2A+kfIeKkNEkexHCNoDFijli
         V+gHLdvng3hpFy0zIhL+KelGY2tVfbH+80VKOL8aSiJDtGVwsmPF3rin2N05evlq2XhY
         HM07ahcMImeapd1LJwNWa2AtkZTJXX/Z8sVYzyO7t8sBV/OWDo+pq2pUQGyr2R8IFvPO
         22cSC5czQJrrR3lWwrNCJKCn/YzygHsHzN9+rUTZH0YFQ3zjl4lENcNsG5VHKUciVxBf
         hteJHk88xNNrKv7BYebyTJCA6YB0t/AcFLfUnRmuWEDkDJ6yXm0U/BKZTtdpj+lWubUJ
         4XSA==
X-Gm-Message-State: APjAAAVp5VKCtlqt4qAPDRWsj6QNp1NEvIkdhnrZ1nmmH7a9TBXoYcQd
        3mPmNA1crW0V05diQSF9RU+E+sDv7vABxmhNiqwruQ==
X-Google-Smtp-Source: APXvYqzjnwEQ5TMXiUq18EB46BY4ST+24XYmOoYFpr+h9ihRCO3FuxJVvZCtqNTGY1LYXAg4KvZi2LZiyzoe+Acj8C8=
X-Received: by 2002:a17:906:d1d0:: with SMTP id bs16mr26806724ejb.286.1562774294818;
 Wed, 10 Jul 2019 08:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com> <0a141018-c09e-56e4-6a73-45b951e8490f@gmail.com>
In-Reply-To: <0a141018-c09e-56e4-6a73-45b951e8490f@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 10 Jul 2019 11:58:04 -0400
Message-ID: <CA+CK2bBJydDGSGtQ49RDLR-WdiH=8G4WfDe5PEe8DE1rfEFONQ@mail.gmail.com>
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
To:     Matthias Brugger <matthias.bgg@gmail.com>
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

On Wed, Jul 10, 2019 at 11:28 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 09/07/2019 20:20, Pavel Tatashin wrote:
> > Changelog
> > v1 - v2
> >       - No changes to patches, addressed suggestion from James Morse
> >         to add "arm64" tag to cover letter.
> >       - Improved cover letter information based on discussion.
> >
> > Currently, it is only allowed to reserve memory for crash kernel, because
> > it is a requirement in order to be able to boot into crash kernel without
> > touching memory of crashed kernel is to have memory reserved.
> >
> > The second benefit for having memory reserved for kexec kernel is
> > that it does not require a relocation after segments are loaded into
> > memory.
> >
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
> >
>
> I wonder if we couldn't use the crashkernel reserved memory area for that and
> just add logic to kexec-tools to pass to the kernel a flag (a new magic reboot
> number?) to use the crashkernel memory for that?
> The kernel would then unload the crash/capture system in the reserved memory
> area and reuse the latter for kexec.
> This would also enable the feature for all architectures.

I decided to take another route: enable MMU during kernel relocation
on ARM64. This will eliminate the problem that I am experiencing with
slow relocation.

Pasha

>
> Regards,
> Matthias
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
> >
> > Note: the above time is relocation time only. Purgatory usually also
> > computes checksum, but that is skipped, because --no-check is used when
> > kernel image is loaded via kexec.
> >
> > Pavel Tatashin (5):
> >   kexec: quiet down kexec reboot
> >   kexec: add resource for normal kexec region
> >   kexec: export common crashkernel/kexeckernel parser
> >   kexec: use reserved memory for normal kexec reboot
> >   arm64, kexec: reserve kexeckernel region
> >
> >  .../admin-guide/kernel-parameters.txt         |  7 ++
> >  arch/arm64/kernel/setup.c                     |  5 ++
> >  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
> >  include/linux/crash_core.h                    |  6 ++
> >  include/linux/ioport.h                        |  1 +
> >  include/linux/kexec.h                         |  6 +-
> >  kernel/crash_core.c                           | 27 +++---
> >  kernel/kexec_core.c                           | 50 +++++++----
> >  8 files changed, 127 insertions(+), 58 deletions(-)
> >
