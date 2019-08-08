Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB10C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C0B2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lsfCX3zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbfHHSod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:44:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33724 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404008AbfHHSoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:44:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so28449343edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OnD8REJjiUQ09MeUwthsY9J1rWTm5v/HD9eRCPSk++8=;
        b=lsfCX3ztpMTCzqQ61QI4k4mLGAlSga+SA+JM6MdlUtTurWRbcKyta2HZw3aGr9JkSh
         lh083Z3RQT+f96/OdGYY7TOTlfAXs/Ct/3S0YbTSDYFzd8i69ZTheFeB3q4VymF/1yuN
         jqJju+D34kBHkVCSmAsH6IsyvyWSC+HhugcsOldPNvAEue88NIkHWqVWOtBZmSxafItq
         4ClmEOENGPnKoxSymB55KP6UKk5UPwEq5MZjHjuDDxvtfUq7x0Tim3ajHEehi1BnGAt0
         4EB3+8c0QNGsSJ9+adK3i80N5672PpkAQIZkxp+VGnC9YbnpQiwunnuyTku/bsdLLn3Y
         V2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OnD8REJjiUQ09MeUwthsY9J1rWTm5v/HD9eRCPSk++8=;
        b=LxrzUNt5juK4hSNqi0ih3c6g/gIbN/FOLqX3JyFom3WGv71W42xjG2p/DqpmHv14rm
         lmwVYuHyd+lzcx/4GrDLeoBLZtVdnqJzrJ2dorOjqvDRikMr1861uY9wRygQX8d9Dtwp
         bSvWqTeapoqWzPZ0pO5eV7q4f2KunjvCzNl2boPD6Qm9VXLljgtoNpXY3pLxRMt2fMT4
         OqXJXI8UBguvqtnxlLGwYekuLv5rgZCmZucFN9ehNhZ01yPAZnFAwR1eYOiNHn0g19yx
         Hxf+G1ZaKRHnYEE8jDvYYgoWIjHf9vbAeJD7oT/7jas3vWo/NUPlnlXNlO8SN4FCfh4S
         iHnA==
X-Gm-Message-State: APjAAAVjdWJAZtHxh72Lp8X/81BV6CJkXH6b697k41ILvvIrwerHYYUI
        w0m7ljuecjv7f32LqhI8bGV7aoOCoZOE2j15JpYNkg==
X-Google-Smtp-Source: APXvYqzNTM/2itQnnnFi1jbNoHH2r8FhmS0Cb3CycZsD8PIZEFgt7etfdlqdZQ/7cAtXUSR7Ohty4Mg1UyiSLvXGrPI=
X-Received: by 2002:a17:906:5409:: with SMTP id q9mr15148025ejo.209.1565289871191;
 Thu, 08 Aug 2019 11:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190801152439.11363-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 8 Aug 2019 14:44:20 -0400
Message-ID: <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a friendly reminder, please send your comments on this series.
It's been a week since I sent out these patches, and no feedback yet.
Also, I'd appreciate if anyone could test this series on vhe hardware
with vhe kernel, it does not look like QEMU can emulate it yet

Thank you,
Pasha

On Thu, Aug 1, 2019 at 11:24 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Enable MMU during kexec relocation in order to improve reboot performance.
>
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs takes a significant portion
> of reboot.
>
> The reason for slow relocation is because it is done without MMU, and thus
> not benefiting from D-Cache.
>
> Performance data
> ----------------
> For this experiment, the size of kernel plus initramfs is small, only 25M.
> If initramfs was larger, than the improvements would be greater, as time
> spent in relocation is proportional to the size of relocation.
>
> Previously:
> kernel shutdown 0.022131328s
> relocation      0.440510736s
> kernel startup  0.294706768s
>
> Relocation was taking: 58.2% of reboot time
>
> Now:
> kernel shutdown 0.032066576s
> relocation      0.022158152s
> kernel startup  0.296055880s
>
> Now: Relocation takes 6.3% of reboot time
>
> Total reboot is x2.16 times faster.
>
> Previous approaches and discussions
> -----------------------------------
> https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
> reserve space for kexec to avoid relocation, involves changes to generic code
> to optimize a problem that exists on arm64 only:
>
> https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
> The first attempt to enable MMU, some bugs that prevented performance
> improvement. The page tables unnecessary configured idmap for the whole
> physical space.
>
> https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
> No linear copy, bug with EL2 reboots.
>
> Pavel Tatashin (8):
>   kexec: quiet down kexec reboot
>   arm64, mm: transitional tables
>   arm64: hibernate: switch to transtional page tables.
>   kexec: add machine_kexec_post_load()
>   arm64, kexec: move relocation function setup and clean up
>   arm64, kexec: add expandable argument to relocation function
>   arm64, kexec: configure transitional page table for kexec
>   arm64, kexec: enable MMU during kexec relocation
>
>  arch/arm64/Kconfig                     |   4 +
>  arch/arm64/include/asm/kexec.h         |  51 ++++-
>  arch/arm64/include/asm/pgtable-hwdef.h |   1 +
>  arch/arm64/include/asm/trans_table.h   |  68 ++++++
>  arch/arm64/kernel/asm-offsets.c        |  14 ++
>  arch/arm64/kernel/cpu-reset.S          |   4 +-
>  arch/arm64/kernel/cpu-reset.h          |   8 +-
>  arch/arm64/kernel/hibernate.c          | 261 ++++++-----------------
>  arch/arm64/kernel/machine_kexec.c      | 199 ++++++++++++++----
>  arch/arm64/kernel/relocate_kernel.S    | 196 +++++++++---------
>  arch/arm64/mm/Makefile                 |   1 +
>  arch/arm64/mm/trans_table.c            | 273 +++++++++++++++++++++++++
>  kernel/kexec.c                         |   4 +
>  kernel/kexec_core.c                    |   8 +-
>  kernel/kexec_file.c                    |   4 +
>  kernel/kexec_internal.h                |   2 +
>  16 files changed, 758 insertions(+), 340 deletions(-)
>  create mode 100644 arch/arm64/include/asm/trans_table.h
>  create mode 100644 arch/arm64/mm/trans_table.c
>
> --
> 2.22.0
>
