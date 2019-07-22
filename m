Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C0AC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA742199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfGVS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:58:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGVS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUX-0002OL-GV; Mon, 22 Jul 2019 20:56:57 +0200
Message-Id: <20190722104705.550071814@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 00/25] x86/apic: Support for IPI shorthands
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is merily a refresh of V2.

Changes vs. V2 (https://lkml.kernel.org/r/20190704155145.617706117@linutronix.de)

  - Fix the NMI_VECTOR/VECTOR_NMI typo in kgdb

  - Remove the misleading vector 0-31 wording

It applies on top of:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/ipi

Thanks,

	tglx

8<------------
 a/arch/x86/include/asm/apic_flat_64.h |    8 -
 a/arch/x86/include/asm/ipi.h          |  109 ---------------------
 a/arch/x86/kernel/apic/x2apic.h       |    9 -
 arch/x86/include/asm/apic.h           |   11 +-
 arch/x86/include/asm/bugs.h           |    2 
 arch/x86/include/asm/processor.h      |    2 
 arch/x86/include/asm/smp.h            |    1 
 arch/x86/kernel/apic/apic.c           |  157 +++++++++++++++++++------------
 arch/x86/kernel/apic/apic_flat_64.c   |   66 ++-----------
 arch/x86/kernel/apic/apic_noop.c      |   18 ---
 arch/x86/kernel/apic/apic_numachip.c  |    8 -
 arch/x86/kernel/apic/bigsmp_32.c      |    9 -
 arch/x86/kernel/apic/ipi.c            |  170 +++++++++++++++++++++++++---------
 arch/x86/kernel/apic/probe_32.c       |   41 --------
 arch/x86/kernel/apic/probe_64.c       |   21 ----
 arch/x86/kernel/apic/x2apic_cluster.c |   20 +---
 arch/x86/kernel/apic/x2apic_phys.c    |   25 ++---
 arch/x86/kernel/apic/x2apic_uv_x.c    |   30 +-----
 arch/x86/kernel/cpu/bugs.c            |    2 
 arch/x86/kernel/cpu/common.c          |   11 ++
 arch/x86/kernel/kgdb.c                |    2 
 arch/x86/kernel/nmi.c                 |    3 
 arch/x86/kernel/reboot.c              |    7 -
 arch/x86/kernel/smp.c                 |   44 --------
 arch/x86/kernel/smpboot.c             |   13 ++
 b/arch/x86/kernel/apic/local.h        |   68 +++++++++++++
 include/linux/bitmap.h                |   23 ++++
 include/linux/cpumask.h               |   16 +++
 kernel/cpu.c                          |   11 +-
 lib/bitmap.c                          |   20 ++++
 30 files changed, 450 insertions(+), 477 deletions(-)



