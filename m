Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36635C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8082082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGIKgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:36:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIKgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:36:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so19011010ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 03:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WJ4m/DGadKDJn7LI59T/jmaK1sNDv+NLzWApQUyooQ=;
        b=p/RyByyP29692VJpuKJfNzwifP+BtOwwwveLcTYpAj/SjEgpxp3fIR/o1bAwBYpa8o
         z5pxAiMFMniixQnICjyKMyL9duNQFfpE8lWctIJQgM/y8YN0Su1ZhG280Dzr45sCTHpX
         +rd+BPXO477nQkJwoG7n5eyqffC2zKAsWG3RT2JgeAL0LKOXI1X4BcbOfMxRWqrYyf4E
         ksNWP6GJ2g5KAuLidVxWYbwgblkbJprpRDJvR4lH0UAjnb+P0oeRWaY2TRgwnsVz67T9
         jhHPTbu+cHv9wGOdXil25jLkmm1RgVDy4fAFrG9r/HLcKn9qLHlaoX8ZASgDNYLIa87I
         2zyA==
X-Gm-Message-State: APjAAAWaaT7KBZOkLcLCKTuZW6cVSfM0fTPU0Sd6nuaWVNmyGNVmuWg0
        xXApFhmJk4nMdqIl1LVL1yupaUy1FJ7mOWn+Cfzqig==
X-Google-Smtp-Source: APXvYqxPHBLg8W3ob44pbfsQreCW94qFhPE+cEwluc5uu4+OgXOPXOW4idA52S+Cl1VzOEXfq3Z9ZQKY+KVJgWw/EsE=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr13056704ljk.93.1562668577294;
 Tue, 09 Jul 2019 03:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 9 Jul 2019 16:06:05 +0530
Message-ID: <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, sashal@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, Jul 9, 2019 at 2:46 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Currently, it is only allowed to reserve memory for crash kernel, because
> it is a requirement in order to be able to boot into crash kernel without
> touching memory of crashed kernel is to have memory reserved.
>
> The second benefit for having memory reserved for kexec kernel is
> that it does not require a relocation after segments are loaded into
> memory.
>
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs might take a significant
> portion of reboot.
>
> In fact, on the machine that we are using, that has ARM64 processor
> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> time:
>
> kernel shutdown 0.03s
> relocation      0.35s
> kernel startup  0.29s
>
> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> time increases proportionally.
>
> While, it is possible to add 'kexeckernel=' parameters support to other
> architectures by modifying reserve_crashkernel(), in this series this is
> done for arm64 only.
>
> Pavel Tatashin (5):
>   kexec: quiet down kexec reboot
>   kexec: add resource for normal kexec region
>   kexec: export common crashkernel/kexeckernel parser
>   kexec: use reserved memory for normal kexec reboot
>   arm64, kexec: reserve kexeckernel region
>
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/arm64/kernel/setup.c                     |  5 ++
>  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
>  include/linux/crash_core.h                    |  6 ++
>  include/linux/ioport.h                        |  1 +
>  include/linux/kexec.h                         |  6 +-
>  kernel/crash_core.c                           | 27 +++---
>  kernel/kexec_core.c                           | 50 +++++++----
>  8 files changed, 127 insertions(+), 58 deletions(-)
>
> --
> 2.22.0

This seems like an issue with time spent while doing sha256
verification while in purgatory.

Can you please try the following two patches which enable D-cache in
purgatory before SHA verification and disable it before switching to
kernel:

http://lists.infradead.org/pipermail/kexec/2017-May/018839.html
http://lists.infradead.org/pipermail/kexec/2017-May/018840.html

Note that these were not accepted upstream but are included in several
distros in some form or the other :)

Thanks,
Bhupesh
