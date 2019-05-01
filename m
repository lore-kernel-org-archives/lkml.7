Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60E320866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fz3LLeMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEAAL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:11:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:11:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so7594253pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=n90B8MYDWGqupHdVkvG3Sa9M/75lyqhQ0w6dVuFCRvQ=;
        b=fz3LLeMXyIc9PDobBtlU4B9pqlr0EaTXxaCBg/lt6J4NWYK5WAuaD9QH8xyaLon1ox
         l38C2RASV64lMgKvkO095dM6uV89n2zcJCHv9thNFJjvL7mAq8rHpYtugPzKXr/EMDs6
         sqEpPqrqY20GvD33mNaSiJXIDJY38HjYrggp9aIHYOdR9QI1AbL/IPKdA/tl7salfe+G
         9ocTqRTQXG/1e7AbXLPXZhgjMh8TlSMbXMJ/dV6GID2Y1oUaHDtGt78EMoOUO4RBIKWX
         OwZDqEACwVvEMWIqOyq6Jo2MTW5Gk3dC1uRNTUkZ4b3gdL7U3sl90LWdkkKLlzOKILse
         wz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=n90B8MYDWGqupHdVkvG3Sa9M/75lyqhQ0w6dVuFCRvQ=;
        b=WF9aUXDVuGhUA+mnrNlRe2ImZIuhU6ATaPPkb8IcfPmZfG3bhNM4QYzUSgfhJ1AmB4
         PNi/2h2/j/9aB3U6yFmfiy0BYmwszJhrIPwo5gNhjGWCalIvSrY0BFdET2kc6vRC3Aua
         HnxZ7sWr4HnYTTur43D45xKOmh6KWIoZfn2YRb3kmHxUTQ3ZA9XTc91MJJpwOsPm0HyJ
         Bo1UgN2dYiA2Bd/dc/XJpo1FvfR+HJCKVoBVDJSuZfL6zkMbOeJ0vTr4usLxEv16gdNy
         8RQeT9zB47kCygrOqRiu4zhQMklF7+q9kqJ95fZN3M37IwOPbHGKIz5ZNikIf4oW7Qqa
         NBDA==
X-Gm-Message-State: APjAAAXjnRVLtBtk+6dBLoYm75Al4mjQc2wzOXhmdluFvEhPdLTNgQ44
        nMxJeJEcc3Gyki92dW5O+5kkcg==
X-Google-Smtp-Source: APXvYqyQJKCDVen4UiKbxaLdRXz5TcfXtBE/ILtaCQBt1hhXy3q9y4DPQBNpfL97OLTwcq7//696Gg==
X-Received: by 2002:a62:e043:: with SMTP id f64mr17920095pfh.76.1556669488429;
        Tue, 30 Apr 2019 17:11:28 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x6sm17984783pfm.114.2019.04.30.17.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 17:11:27 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:11:27 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Apr 2019 17:06:59 PDT (-0700)
Subject:     Re: [PATCH v6 0/3] Allow accessing CSR using CSR number
In-Reply-To: <20190425083804.11991-1-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-c3baf15e-decb-4b3f-91c3-87642f14c3e4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 01:38:24 PDT (-0700), Anup Patel wrote:
> This patch series adds support to access CSR using both CSR name and
> CSR numbers.
> 
> Also, we should prefer accessing CSRs using their CSR numbers because:
> 1. It compiles fine with older toolchains.
> 2. We can use latest CSR names in #define macro names of CSR numbers
>    as-per RISC-V spec. (e.g. sptbr => CSR_SATP, sbadaddr => CSR_STVAL, etc.)
> 3. We can access newly added CSRs even if toolchain does not recognize
>    newly addes CSRs by name. (e.g. BSSTATUS, BSIE, SSIP, etc.)
> 
> The patchset can be found in riscv_csr_number_v6 branch of
> https//github.com/avpatel/linux.git
> 
> Changes since v5:
>  - Drop redundant INTERRUPT_CAUSE_FLAG from kernel/irq.c
> 
> Changes since v4:
>  - Express SCAUSE_IRQ_FLAG in-terms of __riscv_xlen
> 
> Changes since v3:
>  - Keep old INTERRUPT_xyz defines in kernel/irq.c for PATCH2
> 
> Changes since v2:
>  - Dropped PATCH1 which added asm/encoding.h
>  - Added new PATCH1 which beautifies asm/csr.h by using tabs to
>    align macro values
> 
> Changes since v1:
>  - Squash PATCH2 into cpatch3
>  - Added new PATCH2 to add interrupt related SCAUSE defines
>    in asm/encoding.h
> 
> Anup Patel (3):
>   RISC-V: Use tabs to align macro values in asm/csr.h
>   RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
>   RISC-V: Access CSRs using CSR numbers
> 
>  arch/riscv/include/asm/csr.h         | 123 +++++++++++++++++----------
>  arch/riscv/include/asm/irqflags.h    |  10 +--
>  arch/riscv/include/asm/mmu_context.h |   7 +-
>  arch/riscv/kernel/entry.S            |  22 ++---
>  arch/riscv/kernel/head.S             |  12 +--
>  arch/riscv/kernel/irq.c              |  16 +---
>  arch/riscv/kernel/perf_event.c       |   4 +-
>  arch/riscv/kernel/smp.c              |   2 +-
>  arch/riscv/kernel/traps.c            |   6 +-
>  arch/riscv/mm/fault.c                |   6 +-
>  10 files changed, 111 insertions(+), 97 deletions(-)
> 
> --
> 2.17.1

Thanks.  I've added these to for-next with a minor merge conflict, but I think
I managed to avoid screwing it up!
