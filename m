Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFD4C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E58320880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfGPTPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:15:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46918 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:14:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so21105356ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSiJ7P7aree/QouHzJYNVvw8TbrZalu/D2PKc2JLvyE=;
        b=EjtvowbuLPHepVlPDRyVKocXQiFaHWN9T9C94p3u/t5nSI671H4QUHtUH9z/G9L3nx
         ysjaN+uUyGc5CjWhBCtzdzhB1WnHnLQFOnIHWnbHLqyY/bcihYZKHIVAlLN7Y4apQzxF
         X00s2Ve++LOk1exX/SZKJiiK5MuvpeKRgfXgvZD1krEbeMrBlWopmTac/W4DvFlAXSO1
         JxXTzXeYAb/cbSXcWvxW10g63lGw2Pb2zLNlAyuUpwmPRAQ2dkgzP6wjpCRNBED66Id5
         kHm3gjOZcxyu9VZX+yz9rRJLbNeqD1EaohSTPqK4MkOU5ns8YaqPCqnb45FhtEO4M86d
         e7+A==
X-Gm-Message-State: APjAAAVrlp/28iU3icg1Dj0c4DPiun7DAA4YUH1GGshHBO9AdwjIDPMF
        3XD1GSZ6NwVGUgWoXVD0oIGUyaAT4K6QtgBF538e6A==
X-Google-Smtp-Source: APXvYqxEROc6iOj5lyf6ClNcARL3AIGUQmNApDc2V696Z1bJ00PUcJWPOlBHwgZIHSUwXD3dvtcpApTXvXdaE56AT2w=
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr18269442ljj.17.1563304497831;
 Tue, 16 Jul 2019 12:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 17 Jul 2019 00:44:45 +0530
Message-ID: <CACi5LpOO+sF3o+5u4jHXzba+Ki8fZ5auekKLayxSwNOL6Lp=-w@mail.gmail.com>
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
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

On Tue, Jul 16, 2019 at 10:26 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Added identity mapped page table, and keep MMU enabled while
> kernel is being relocated from sparse pages to the final
> destination during kexec.
>
> More description about the problem I am trying to solve here, can be
> found here:
> https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/
>
> This patch series works in terms, that I can kexec-reboot both in QEMU
> and on a physical machine. However, I do not see performance improvement
> during relocation. The performance is just as slow as before with disabled
> caches.

Thanks for the patchset, but if the changes still don't positively
impact the kexec-reboot timings, I am not sure we if gain by adding
these to the kernel.

Like I mentioned in the previous threads, we have been carrying some
relevant fixes for the same in Linux distros. I have been trying to
find time to fix them and send them upstream, but I am caught up with
some nasty kexec_file_load() issues on arm64 currently.

So, I will find some time to work on them (may be next week) and will
Cc you when I post them out after some checks on real physical
hardware.

Thanks,
Bhupesh

> Am I missing something? Perhaps, there is some flag that I should also
> enable in page table? Please provide me with any suggestions.
>
> Pavel Tatashin (4):
>   arm64, mm: identity mapped page table
>   arm64, kexec: interface preparation for mmu enabled kexec
>   arm64, kexec: add kexec's own identity page table
>   arm64: Keep MMU on while kernel is being relocated
>
>  arch/arm64/include/asm/ident_map.h  |  26 ++++++
>  arch/arm64/include/asm/kexec.h      |   5 +-
>  arch/arm64/kernel/cpu-reset.S       |   8 --
>  arch/arm64/kernel/cpu-reset.h       |   7 +-
>  arch/arm64/kernel/machine_kexec.c   | 128 +++++++++++++++++++++-------
>  arch/arm64/kernel/relocate_kernel.S |  36 +++++---
>  arch/arm64/mm/Makefile              |   1 +
>  arch/arm64/mm/ident_map.c           |  99 +++++++++++++++++++++
>  8 files changed, 255 insertions(+), 55 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ident_map.h
>  create mode 100644 arch/arm64/mm/ident_map.c
>
> --
> 2.22.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
