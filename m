Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B59C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3782081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Wcdu8OQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfETIpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:45:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53892 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfETIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:45:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so12333088wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fm9ij16sdpD8iaSclUBxPmiCBICgn7uQ/6l6aDbLE7U=;
        b=Wcdu8OQJzMjiiXg3qHrtp1i7mlTWP5r5NSt5tnnFBrs+IHpyYY4dSKG5aZ4xSgFttO
         PdBkfMt1sUS+zn8zVhYiC/5wYPoxSDHLL1wRmDP8EGfesv5rRhg88YD4CwGAdBHRHx9q
         Z2n+wAu9/LLZf20saY/0VPKHWc31kOV7Nm/utQ3F+yG1wSbd1Frs7mi3z/rV1vqehYEg
         EQirCb0ad9Dm1iJJK4MTp7mSSUcnHVT66Hl9+ig5Qmgt7tCepfNAiJEz/t4UhRgECTLW
         +/IK7NDp8pgK6RfQgvApqvMibOdJpxeYo9EGlip2UxdcwayONNBrVbhUdlBWV4RqExGO
         oJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fm9ij16sdpD8iaSclUBxPmiCBICgn7uQ/6l6aDbLE7U=;
        b=sk7SE5gHU2RkN0rvUXboxyVHRlHe/mArczu7XRpmvu6/1s+sPiJYFK96qVi5suFG9s
         xJeEWGTitk+vKLouGEa7s2TGqEbdqdnim3Jr8SiBLDVF8wThBcP/BYJC0GSHjK7hlLgr
         WbreJU3J1GFipHXoSbtFiYPEndcJk176AFAdI22R98nkEyHoix2AKv95L/iPi/S9fqp0
         WYN9f5ZkZz84umol37a48acvRDekkLsm4sgzUn4fMSaFasIhbzoZmIEKxRK5aByh3VCE
         Ls7urJkIRiYJmP4ZtIyqEVwI21vIZcJUI6KHOPsNSmG+PL3r28YOqS4JukKSHpz1PbTj
         HJmg==
X-Gm-Message-State: APjAAAUd+rcHmo5bgxB8xcLZ6hReSQtrFkQsGis9U/zVCLgIpg/GXzqF
        etdCAoKxxVVbrIHy6CPQ+IPUuHW6n6aRf5KYw1SBHlV+
X-Google-Smtp-Source: APXvYqy+gaylWYdcZd/BRi5OQNcoo8rzluGD3AdwGg+/XH6ty9nSlun0RpAThRvzg8tL3zLJ4Sc+NdQJ875c4Ho2sos=
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr4257302wmh.55.1558341907386;
 Mon, 20 May 2019 01:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190502050206.23373-1-anup.patel@wdc.com>
In-Reply-To: <20190502050206.23373-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 20 May 2019 14:14:56 +0530
Message-ID: <CAAhSdy0nZVHRNBSyVOiy99_f7qLTO6jzucCnhautHGgNq42JXw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Two-stagged initial page table setup
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:32 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patchset implements two-stagged initial page table setup using fixmap
> to avoid mapping non-existent RAM and also reduce high_memory consumed by
> initial page tables.
>
> The patchset is based on Linux-5.1-rc7 and tested on SiFive Unleashed board
> and QEMU virt machine.
>
> These patches can be found in riscv_setup_vm_v4 branch of
> https//github.com/avpatel/linux.git
>
> Changes since v3:
> - Changed patch series subject.
> - Dropped PATCH1 because it's already merged
> - Dropped PATCH3 because trampoline page table handles a corner case
>   for 32bit systems where load address range overlaps kernel virtual
>   address range
> - Revamped PATCH for 4K aligned booting into two-stagged initial page
>   table setup
>
> Changes since v2:
> - Dropped PATCH2 because we have separate fix for Linux-5.1-rcX
> - Moved PATCH5 to PATCH2
> - Moved PATCH4 to PATCH3
> - The "Booting kernel from any 4KB aligned address" is now PATCH4
>
> Changes since v1:
> - Add kconfig option BOOT_PAGE_ALIGNED to enable 4KB aligned booting
> - Improved initial page table setup code to select best/biggest
>   possible mapping size based on load address alignment
> - Added PATCH4 to remove redundant trampoline page table
> - Added PATCH5 to fix memory reservation in setup_bootmem()
>
> Anup Patel (2):
>   RISC-V: Fix memory reservation in setup_bootmem()
>   RISC-V: Setup initial page tables in two stages
>
>  arch/riscv/include/asm/fixmap.h     |   5 +
>  arch/riscv/include/asm/pgtable-64.h |   5 +
>  arch/riscv/include/asm/pgtable.h    |   7 +
>  arch/riscv/kernel/head.S            |  17 +-
>  arch/riscv/kernel/setup.c           |   4 +-
>  arch/riscv/mm/init.c                | 327 ++++++++++++++++++++++------
>  6 files changed, 289 insertions(+), 76 deletions(-)
>
> --
> 2.17.1

Hi All,

Any comments on this patchset?

Regards,
Anup
