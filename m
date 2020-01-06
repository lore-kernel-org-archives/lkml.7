Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFE7C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFABB2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgAFDbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:31:46 -0500
Received: from ozlabs.org ([203.11.71.1]:59061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:31:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47rgzM5PMRz9sNH;
        Mon,  6 Jan 2020 14:31:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1578281504;
        bh=XeP8e7qXes4HkHyMRiVW9bZkBg9wHSfCUbqH7aV7fWI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PseaXQkADJFYGx4SaZsY8sR8oWICr+mRYyYr5fMd+fnxepINCrjznL1PLsh6Nvlcn
         C1u/dXFf4MPhZL0D3/iqEg9lgO6lddEzi7k8X0HlcU7EhFoWF8V4KqQ1Ld2vrgfOmF
         8xJRGQoZEGXrYoUV/poOaGavJ6HBQ2pGlgOVg5ya1DWljIM/GdntvZDnnQIq1d0vrn
         hTzu3/amT42926Hf0wiuK4vD84ztJ5fo4OrAw0rbPyiT9uWXu/81Da9MUXvFi6V7H1
         lLmTIKEcYguwgRIibijKxb9zOk2IpkUFVNbaOcqwzS7oP1rsO6pmo5ALTydI/FzVoh
         lt/4slorVh1DA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
In-Reply-To: <20200102081059.GA12063@rapoport-lnx>
References: <20191209150908.6207-1-rppt@kernel.org> <20200102081059.GA12063@rapoport-lnx>
Date:   Mon, 06 Jan 2020 14:31:41 +1100
Message-ID: <87v9ppi7ky.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:
> Any updates on this?

It's very ... big, and kind of intrusive.

It's not an improvement as far as the powerpc code's readability is
concerned. I assume the plan is that the 5-level hack can eventually be
removed and so this conversion is a prerequisite for that?

cheers

> On Mon, Dec 09, 2019 at 05:09:08PM +0200, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>> 
>> Implement primitives necessary for the 4th level folding, add walks of p4d
>> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
>> 
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
>>  arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
>>  arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
>>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 58 ++++++++++--------
>>  arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
>>  arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
>>  arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
>>  .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
>>  arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
>>  arch/powerpc/include/asm/pgtable.h            |  8 +++
>>  arch/powerpc/kvm/book3s_64_mmu_radix.c        | 59 ++++++++++++++++---
>>  arch/powerpc/lib/code-patching.c              |  7 ++-
>>  arch/powerpc/mm/book3s32/mmu.c                |  2 +-
>>  arch/powerpc/mm/book3s32/tlb.c                |  4 +-
>>  arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
>>  arch/powerpc/mm/book3s64/radix_pgtable.c      | 19 ++++--
>>  arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
>>  arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
>>  arch/powerpc/mm/kasan/kasan_init_32.c         |  8 +--
>>  arch/powerpc/mm/mem.c                         |  4 +-
>>  arch/powerpc/mm/nohash/40x.c                  |  4 +-
>>  arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 +++--
>>  arch/powerpc/mm/pgtable.c                     | 25 +++++++-
>>  arch/powerpc/mm/pgtable_32.c                  | 28 +++++----
>>  arch/powerpc/mm/pgtable_64.c                  | 10 ++--
>>  arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
>>  arch/powerpc/mm/ptdump/ptdump.c               | 22 ++++++-
>>  arch/powerpc/xmon/xmon.c                      | 17 +++++-
>>  28 files changed, 284 insertions(+), 120 deletions(-)
