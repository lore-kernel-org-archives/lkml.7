Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38E120879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfEVNXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:23:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:23:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505BD80D;
        Wed, 22 May 2019 06:23:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B7EA3F575;
        Wed, 22 May 2019 06:23:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, davem@davemloft.net, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, herbert@gondor.apana.org.au,
        ink@jurassic.park.msu.ru, jhogan@kernel.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, palmer@sifive.com, paul.burton@mips.com,
        paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net,
        stable@vger.kernel.org, tglx@linutronix.de, tony.luck@intel.com,
        vgupta@synopsys.com
Subject: [PATCH 00/18] locking/atomic: atomic64 type cleanup
Date:   Wed, 22 May 2019 14:22:32 +0100
Message-Id: <20190522132250.26499-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently architectures return inconsistent types for atomic64 ops. Some return
long (e..g. powerpc), some return long long (e.g. arc), and some return s64
(e.g. x86).

This is a bit messy, and causes unnecessary pain (e.g. as values must be cast
before they can be printed [1]).

This series reworks all the atomic64 implementations to use s64 as the base
type for atomic64_t (as discussed [2]), and to ensure that this type is
consistently used for parameters and return values in the API, avoiding further
problems in this area.

This series (based on v5.1-rc1) can also be found in my atomics/type-cleanup
branch [3] on kernel.org.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20190310183051.87303-1-cai@lca.pw
[2] https://lkml.kernel.org/r/20190313091844.GA24390@hirez.programming.kicks-ass.net
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/type-cleanup

Mark Rutland (18):
  locking/atomic: crypto: nx: prepare for atomic64_read() conversion
  locking/atomic: s390/pci: prepare for atomic64_read() conversion
  locking/atomic: generic: use s64 for atomic64
  locking/atomic: alpha: use s64 for atomic64
  locking/atomic: arc: use s64 for atomic64
  locking/atomic: arm: use s64 for atomic64
  locking/atomic: arm64: use s64 for atomic64
  locking/atomic: ia64: use s64 for atomic64
  locking/atomic: mips: use s64 for atomic64
  locking/atomic: powerpc: use s64 for atomic64
  locking/atomic: riscv: fix atomic64_sub_if_positive() offset argument
  locking/atomic: riscv: use s64 for atomic64
  locking/atomic: s390: use s64 for atomic64
  locking/atomic: sparc: use s64 for atomic64
  locking/atomic: x86: use s64 for atomic64
  locking/atomic: use s64 for atomic64_t on 64-bit
  locking/atomic: crypto: nx: remove redundant casts
  locking/atomic: s390/pci: remove redundant casts

 arch/alpha/include/asm/atomic.h       | 20 +++++------
 arch/arc/include/asm/atomic.h         | 41 +++++++++++-----------
 arch/arm/include/asm/atomic.h         | 50 +++++++++++++-------------
 arch/arm64/include/asm/atomic_ll_sc.h | 20 +++++------
 arch/arm64/include/asm/atomic_lse.h   | 34 +++++++++---------
 arch/ia64/include/asm/atomic.h        | 20 +++++------
 arch/mips/include/asm/atomic.h        | 22 ++++++------
 arch/powerpc/include/asm/atomic.h     | 44 +++++++++++------------
 arch/riscv/include/asm/atomic.h       | 44 ++++++++++++-----------
 arch/s390/include/asm/atomic.h        | 38 ++++++++++----------
 arch/s390/pci/pci_debug.c             |  2 +-
 arch/sparc/include/asm/atomic_64.h    |  8 ++---
 arch/x86/include/asm/atomic64_32.h    | 66 +++++++++++++++++------------------
 arch/x86/include/asm/atomic64_64.h    | 38 ++++++++++----------
 drivers/crypto/nx/nx-842-pseries.c    |  6 ++--
 include/asm-generic/atomic64.h        | 20 +++++------
 include/linux/types.h                 |  2 +-
 lib/atomic64.c                        | 32 ++++++++---------
 18 files changed, 252 insertions(+), 255 deletions(-)

-- 
2.11.0

