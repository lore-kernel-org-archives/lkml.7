Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4608AC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147302075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h336gUMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKYT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:27:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfKYT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sfxOALDlPRJzuV8ITquVtH6b6PPr9YPhpIFDV53VIrQ=; b=h336gUMaE4iSaArMS18qdnigwH
        Ku4RZx1k3ZzxEEZrFwcK3NRnEp08SrDm4dKoZZjZgJ2eVGDFJAoBQwft9gJoLdg2vX6K76diH5d/7
        HxSAbd3zBd/jVe55hG1NK3TtSsjBW/JpeHbZFas5Lz6PInmr/k143vDm5q5JyNPU8jks/w2W4ERWI
        zXGUXFGVK+5c7ZRASCjn85g8NF9ox/8yJm9VJa5hBEkjkeIRZIVR22VYadU2TYpvDs3H7az0eCdIw
        5KtpOpbV7GZulcfP7e0//Wokxpd2j1Ke+zYG+01GEjvLH1wC/CRk5BTki2wz1+mcVR8Q5+jG8vC1t
        32PJUycA==;
Received: from [2001:4bb8:180:2f38:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZK1e-0008GN-OX; Mon, 25 Nov 2019 19:27:59 +0000
Date:   Mon, 25 Nov 2019 20:27:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] generic ioremap for 5.5
Message-ID: <20191125192758.GA13913@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this pull requests add the remaining bits for an entirely generic ioremap
and iounmap to lib/ioremap.c, and to facilitate that cleans up the giant
mess of weird ioremap variants we had with no users outside the arch
code.  For now just the three newest ports use the code, but there is
more than a handful others that can be converted without too much work.

There are two conflicts with the riscv tree - one is a trivial makefile
context one with the nommu support, and the other is the split of the
riscv <asm/io.h> which means that the removals in this pull request need
to be applied to the new location that they were moved to in the riscv
tree.

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/ioremap.git tags/ioremap-5.5

for you to fetch changes up to eafee59440623e06b0ce4a0e49f814a8cf31d8ca:

  nds32: use generic ioremap (2019-11-12 11:37:58 +0100)

----------------------------------------------------------------
generic ioremap support

 - clean up various obsolete ioremap and iounmap variants
 - add a new generic ioremap implementation and switch csky, nds32 and
   riscv over to it

----------------------------------------------------------------
Christoph Hellwig (21):
      arm: remove ioremap_cached
      unicore32: remove ioremap_cached
      ia64: rename ioremap_nocache to ioremap_uc
      hexagon: clean up ioremap
      alpha: remove the unused __ioremap wrapper
      nios2: remove __ioremap
      parisc: remove __ioremap
      x86: Clean up ioremap()
      xtensa: clean up ioremap
      asm-generic: ioremap_uc should behave the same with and without MMU
      asm-generic: don't provide ioremap for CONFIG_MMU
      arch: rely on asm-generic/io.h for default ioremap_* definitions
      m68k: rename __iounmap and mark it static
      hexagon: remove __iounmap
      nios2: remove __iounmap
      sh: remove __iounmap
      lib: provide a simple generic ioremap implementation
      riscv: use the generic ioremap code
      csky: remove ioremap_cache
      csky: use generic ioremap
      nds32: use generic ioremap

 arch/alpha/include/asm/io.h         |   6 ---
 arch/arc/include/asm/io.h           |   4 --
 arch/arm/include/asm/io.h           |   7 ---
 arch/arm/mm/ioremap.c               |   4 --
 arch/arm/mm/mmu.c                   |   2 +-
 arch/arm/mm/nommu.c                 |   4 --
 arch/arm64/include/asm/io.h         |   2 -
 arch/csky/Kconfig                   |   1 +
 arch/csky/include/asm/io.h          |  11 ++--
 arch/csky/include/asm/pgtable.h     |   4 ++
 arch/csky/mm/ioremap.c              |  52 -------------------
 arch/hexagon/include/asm/io.h       |  18 ++-----
 arch/hexagon/kernel/hexagon_ksyms.c |   4 +-
 arch/hexagon/mm/ioremap.c           |   4 +-
 arch/ia64/include/asm/io.h          |   5 +-
 arch/ia64/mm/ioremap.c              |   4 +-
 arch/m68k/include/asm/kmap.h        |   1 -
 arch/m68k/mm/kmap.c                 | 100 ++++++++++++++++++------------------
 arch/microblaze/include/asm/io.h    |   3 --
 arch/nds32/Kconfig                  |   1 +
 arch/nds32/include/asm/io.h         |   3 +-
 arch/nds32/include/asm/pgtable.h    |   4 +-
 arch/nds32/mm/Makefile              |   3 +-
 arch/nds32/mm/ioremap.c             |  62 ----------------------
 arch/nios2/include/asm/io.h         |  25 +--------
 arch/nios2/mm/ioremap.c             |  23 +++------
 arch/openrisc/include/asm/io.h      |   1 -
 arch/parisc/include/asm/io.h        |  11 +---
 arch/parisc/mm/ioremap.c            |  10 ++--
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/io.h         |  13 -----
 arch/riscv/include/asm/pgtable.h    |   6 +++
 arch/riscv/mm/Makefile              |   1 -
 arch/riscv/mm/ioremap.c             |  84 ------------------------------
 arch/s390/include/asm/io.h          |   4 --
 arch/sh/include/asm/io.h            |   9 +---
 arch/sh/mm/ioremap.c                |   4 +-
 arch/sparc/include/asm/io_32.h      |   1 +
 arch/unicore32/include/asm/io.h     |   4 +-
 arch/unicore32/mm/ioremap.c         |   8 ---
 arch/x86/include/asm/io.h           |   7 +--
 arch/x86/mm/ioremap.c               |   8 +--
 arch/x86/mm/pageattr.c              |   4 +-
 arch/xtensa/include/asm/io.h        |  12 +----
 include/asm-generic/io.h            |  89 +++++++++++++-------------------
 lib/Kconfig                         |   3 ++
 lib/ioremap.c                       |  39 ++++++++++++++
 47 files changed, 189 insertions(+), 487 deletions(-)
 delete mode 100644 arch/nds32/mm/ioremap.c
 delete mode 100644 arch/riscv/mm/ioremap.c
