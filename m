Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C63C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD944206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557125873;
	bh=hN6G2ENHyh3VmUi3lPFMPHogzMW+GhvWC+I5T928R/0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iG+KaWMqUZS4x7HXsmpxDjULAKW/bKCo+u68TvISVNxsckCKk/JO6t63rrF9+rWX6
	 0r2mSGAl4EskjzuFKZmIryCALSos6nfrH/+KSn+CxDUlpvgfhpwjdeHiLM1xL6oEpM
	 KWX4v2rBIWQlMbZ/niRZ0kMTt0nuvIH+3O0b2FY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFG5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:57:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:57:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so5432238wrq.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6iWT290E2JR6T3igYyiNh+USqSQP3gzvlqEL5UD9o98=;
        b=seiSWGdWqymGLOv1hQjIwsSl1ZlZzpvK/RDoSO6yfPmPt1VEWAjNBokXDrYhWVFoCs
         DOaePFVKujLFGLPanepWrDYSDeX4qTzxhhHkW4E12OANUaUUd0xkvGTCwPhZdade5+iv
         MwtEsqOgO3fzYI52iSqqQBtboh8mpT2J3G66vWmtVujDOX/SqiMO8arrfXhyCEPNEauC
         1KvESs2rUIwaDp9YKp6D3E78kMM+w8q2gUcmWXFV4F66gFlXTSFJubNQsCrxRu350AXi
         TzxgSBYPyCRZMXmKvjhO77dqeyqjPXEylHOkzsUfDCLfz/c2GW5YB/0qEHdkRuL6fqqa
         dc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6iWT290E2JR6T3igYyiNh+USqSQP3gzvlqEL5UD9o98=;
        b=f9gqU00IeHsEkkNHOYNG2fy9ZGFYmt3JWmmtPdpC2YLGyYMzSrsUvfz9T5Wcb4qL2H
         M4sgxI+bZtfDI2NJRA4/HAvAgc9suF0Io2wAnzmvWQgDvgVRfu1O59D1GRKkVsmzaNDR
         yxQwnWsU/OwUpntBs82T4YYSRKmIbyRAySOmo3TY4hOJGe78Z4+b4EZPKuq/lCFlJ903
         0VxTg+7qqlYEQdDaQQ8ZaiaamWN0JoAXTSi227ydFkO1aj13de2N5vc89A42CxXWGKpY
         jGq+lkMmD76YxytCpv06NBqZitfinN7F3cd7qrnXpNE93h+2mdlc30gJ08Bfpsnvf5Lm
         CNFQ==
X-Gm-Message-State: APjAAAWFCtYEfaVCbPnDwbOUe31VuJXBYUhgHEIWoJxBW8zu5Vq6Lp9a
        QZiEF5ktutzYwE2ngFhNsjc=
X-Google-Smtp-Source: APXvYqyVeTH66EEha866ziC/UClmUlYGD/EP9kxkdOQFda3tVQJkpI3qQnlXzCIUAJc2Stj8gB0chQ==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr16411674wrp.155.1557125869627;
        Sun, 05 May 2019 23:57:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z10sm4791544wrs.8.2019.05.05.23.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 23:57:48 -0700 (PDT)
Date:   Mon, 6 May 2019 08:57:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] core/mm changes for v5.2: Unify TLB flushing across
 architectures
Message-ID: <20190506065746.GA105888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-for-linus

   # HEAD: f6c6010a07734103a31faa0cc977641b358c45b0 mm/resource: Use resource_overlaps() to simplify region_intersects()

This tree contains the generic mmu_gather feature from Peter Zijlstra, 
which is an all-arch unification of TLB flushing APIs, via the following 
(broad) steps:

 - enhance the <asm-generic/tlb.h> APIs to cover more arch details

 - convert most TLB flushing arch implementations to the generic 
   <asm-generic/tlb.h> APIs.

 - remove leftovers of per arch implementations

After this series every single architecture makes use of the unified TLB 
flushing APIs.

 Thanks,

	Ingo

------------------>
Martin Schwidefsky (2):
      asm-generic/tlb: Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y
      s390/tlb: Convert to generic mmu_gather

Peter Zijlstra (17):
      asm-generic/tlb: Provide a comment
      asm-generic/tlb, arch: Provide CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
      asm-generic/tlb, arch: Provide generic VIPT cache flush
      asm-generic/tlb, arch: Provide generic tlb_flush() based on flush_tlb_range()
      asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()
      asm-generic/tlb, ia64: Conditionally provide tlb_migrate_finish()
      asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE
      arm/tlb: Convert to generic mmu_gather
      ia64/tlb: Convert to generic mmu_gather
      sh/tlb: Convert SH to generic mmu_gather
      um/tlb: Convert to generic mmu_gather
      arch/tlb: Clean up simple architectures
      asm-generic/tlb: Remove arch_tlb*_mmu()
      asm-generic/tlb: Remove CONFIG_HAVE_GENERIC_MMU_GATHER
      asm-generic/tlb: Remove tlb_flush_mmu_free()
      asm-generic/tlb: Remove tlb_table_flush()
      ia64/tlb: Eradicate tlb_migrate_finish() callback

Wei Yang (1):
      mm/resource: Use resource_overlaps() to simplify region_intersects()


 Documentation/core-api/cachetlb.rst |  10 --
 arch/Kconfig                        |   8 +-
 arch/alpha/Kconfig                  |   1 +
 arch/alpha/include/asm/tlb.h        |   6 -
 arch/arc/include/asm/tlb.h          |  32 ----
 arch/arm/include/asm/tlb.h          | 255 ++-----------------------------
 arch/arm64/Kconfig                  |   1 -
 arch/arm64/include/asm/tlb.h        |   1 +
 arch/c6x/Kconfig                    |   1 +
 arch/c6x/include/asm/tlb.h          |   2 -
 arch/h8300/include/asm/tlb.h        |   2 -
 arch/hexagon/include/asm/tlb.h      |  12 --
 arch/ia64/include/asm/machvec.h     |  13 --
 arch/ia64/include/asm/machvec_sn2.h |   2 -
 arch/ia64/include/asm/tlb.h         | 259 +-------------------------------
 arch/ia64/include/asm/tlbflush.h    |  25 ++++
 arch/ia64/mm/tlb.c                  |  23 ++-
 arch/ia64/sn/kernel/sn2/sn2_smp.c   |   7 -
 arch/m68k/Kconfig                   |   1 +
 arch/m68k/include/asm/tlb.h         |  14 --
 arch/microblaze/Kconfig             |   1 +
 arch/microblaze/include/asm/tlb.h   |   9 --
 arch/mips/include/asm/tlb.h         |  17 ---
 arch/nds32/include/asm/tlb.h        |  16 --
 arch/nds32/include/asm/tlbflush.h   |   1 -
 arch/nios2/Kconfig                  |   1 +
 arch/nios2/include/asm/tlb.h        |  14 +-
 arch/openrisc/Kconfig               |   1 +
 arch/openrisc/include/asm/tlb.h     |   8 +-
 arch/parisc/include/asm/tlb.h       |  18 ---
 arch/powerpc/Kconfig                |   2 +
 arch/powerpc/include/asm/tlb.h      |  18 +--
 arch/riscv/include/asm/tlb.h        |   1 +
 arch/s390/Kconfig                   |   2 +
 arch/s390/include/asm/tlb.h         | 130 +++++-----------
 arch/s390/mm/pgalloc.c              |  63 +-------
 arch/sh/include/asm/pgalloc.h       |   9 ++
 arch/sh/include/asm/tlb.h           | 132 +----------------
 arch/sparc/Kconfig                  |   1 +
 arch/sparc/include/asm/tlb_32.h     |  18 ---
 arch/um/include/asm/tlb.h           | 158 +-------------------
 arch/unicore32/Kconfig              |   1 +
 arch/unicore32/include/asm/tlb.h    |   7 +-
 arch/x86/Kconfig                    |   1 -
 arch/x86/include/asm/tlb.h          |   1 +
 arch/xtensa/include/asm/tlb.h       |  26 ----
 include/asm-generic/tlb.h           | 288 ++++++++++++++++++++++++++++++++----
 kernel/iomem.c                      |   4 +-
 kernel/resource.c                   |  11 +-
 kernel/sched/core.c                 |   1 -
 mm/huge_memory.c                    |   4 +-
 mm/hugetlb.c                        |   2 +-
 mm/madvise.c                        |   2 +-
 mm/memory.c                         |   6 +-
 mm/mmu_gather.c                     | 129 ++++++++--------
 55 files changed, 482 insertions(+), 1296 deletions(-)
