Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422CAC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C4B2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pExlI/QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfDYO33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:29:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29332 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:29:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44qfhP5GCMz9v06X;
        Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pExlI/QS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id V_UJf2bk2lNM; Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhP3ppvz9v06V;
        Thu, 25 Apr 2019 16:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556202565; bh=ZAk5oInFteIZFLfsYCErnhXj4xJ5HcEpKVF+oTA5mHo=;
        h=From:Subject:To:Cc:Date:From;
        b=pExlI/QSxTsT5a/b0I+Iga4XMKht5bLQs2e5x9FFnamAj2c/FCkoZpkhFGfCbf2fJ
         RkFqNMLBSlYe2lYx/FxzJtDZkc9ANmikQL6cE7nh4UcY0ZiCNPJhlNiHNqJqBJiZ+f
         Ykwn2pYBCpFK6bl/LyTi8UUf+SGzlShAxrvXN9dU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A4518B931;
        Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vHbBjXE-_eMi; Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E835A8B923;
        Thu, 25 Apr 2019 16:29:26 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 89E4266276; Thu, 25 Apr 2019 14:29:26 +0000 (UTC)
Message-Id: <cover.1556202028.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/11] Reduce ifdef mess in slice.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Apr 2019 14:29:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a split out of the v1 series "Reduce ifdef mess in hugetlbpage.c and slice.c".

It is also rebased after the series from Aneesh to reduce context size for Radix.

See http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/f263887b4ca31f4bb0fe77823e301c28ba27c796/ for wide compilation.

Christophe Leroy (11):
  powerpc/mm: fix erroneous duplicate slb_addr_limit init
  powerpc/mm: no slice for nohash/64
  powerpc/mm: hand a context_t over to slice_mask_for_size() instead of
    mm_struct
  powerpc/mm: move slice_mask_for_size() into mmu.h
  powerpc/mm: get rid of mm_ctx_slice_mask_xxx()
  powerpc/mm: remove unnecessary #ifdef CONFIG_PPC64
  powerpc/mm: remove a couple of #ifdef CONFIG_PPC_64K_PAGES in
    mm/slice.c
  powerpc/8xx: get rid of #ifdef CONFIG_HUGETLB_PAGE for slices
  powerpc/mm: define get_slice_psize() all the time
  powerpc/mm: define subarch SLB_ADDR_LIMIT_DEFAULT
  powerpc/mm: drop slice DEBUG

 arch/powerpc/include/asm/book3s/64/mmu.h     |  29 +++---
 arch/powerpc/include/asm/book3s/64/slice.h   |   2 +
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  51 +++++------
 arch/powerpc/include/asm/nohash/32/slice.h   |   2 +
 arch/powerpc/include/asm/nohash/64/slice.h   |  12 ---
 arch/powerpc/include/asm/slice.h             |   9 +-
 arch/powerpc/kernel/setup-common.c           |   6 --
 arch/powerpc/mm/hash_utils_64.c              |   2 +-
 arch/powerpc/mm/hugetlbpage.c                |   4 +-
 arch/powerpc/mm/slice.c                      | 132 ++++-----------------------
 arch/powerpc/mm/tlb_nohash.c                 |   4 +-
 arch/powerpc/platforms/Kconfig.cputype       |   4 +
 12 files changed, 69 insertions(+), 188 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/slice.h

-- 
2.13.3

