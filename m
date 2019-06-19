Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA82C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E326B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfFSFjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:39:25 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36419 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:39:24 -0400
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DE71124000B;
        Wed, 19 Jun 2019 05:39:07 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH RESEND 0/8] Fix mmap base in bottom-up mmap
Date:   Wed, 19 Jun 2019 01:38:58 -0400
Message-Id: <20190619053906.5900-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the previous interrupted series) 

This series fixes the fallback of the top-down mmap: in case of
failure, a bottom-up scheme can be tried as a last resort between
the top-down mmap base and the stack, hoping for a large unused stack
limit.

Lots of architectures and even mm code start this fallback
at TASK_UNMAPPED_BASE, which is useless since the top-down scheme
already failed on the whole address space: instead, simply use
mmap_base.

Along the way, it allows to get rid of of mmap_legacy_base and
mmap_compat_legacy_base from mm_struct.

Note that arm and mips already implement this behaviour.

Alexandre Ghiti (8):
  s390: Start fallback of top-down mmap at mm->mmap_base
  sh: Start fallback of top-down mmap at mm->mmap_base
  sparc: Start fallback of top-down mmap at mm->mmap_base
  x86, hugetlbpage: Start fallback of top-down mmap at mm->mmap_base
  mm: Start fallback top-down mmap at mm->mmap_base
  parisc: Use mmap_base, not mmap_legacy_base, as low_limit for
    bottom-up mmap
  x86: Use mmap_*base, not mmap_*legacy_base, as low_limit for bottom-up
    mmap
  mm: Remove mmap_legacy_base and mmap_compat_legacy_code fields from
    mm_struct

 arch/parisc/kernel/sys_parisc.c  |  8 +++-----
 arch/s390/mm/mmap.c              |  2 +-
 arch/sh/mm/mmap.c                |  2 +-
 arch/sparc/kernel/sys_sparc_64.c |  2 +-
 arch/sparc/mm/hugetlbpage.c      |  2 +-
 arch/x86/include/asm/elf.h       |  2 +-
 arch/x86/kernel/sys_x86_64.c     |  4 ++--
 arch/x86/mm/hugetlbpage.c        |  7 ++++---
 arch/x86/mm/mmap.c               | 20 +++++++++-----------
 include/linux/mm_types.h         |  2 --
 mm/debug.c                       |  4 ++--
 mm/mmap.c                        |  2 +-
 12 files changed, 26 insertions(+), 31 deletions(-)

-- 
2.20.1

