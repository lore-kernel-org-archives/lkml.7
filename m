Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1267C46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CBD218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGDQeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59609 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfGDQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gG-0005eY-DV; Thu, 04 Jul 2019 18:33:56 +0200
Message-Id: <20190704155145.617706117@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 00/25] x86/apic: Support for IPI shorthands
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent discussion about using HPET as NMI watchdog made me look into
IPI shorthand support. Also Nadav wanted to look into shorthands to speed
up certain TLB operations.

The support for IPI shorthands is rather limited right now and basically
got rendered useless by making it depend on CPU_HOTPLUG=n.

The reason for this is that shorthands are broadcasted and in case that not
all present CPUs have been brought up this might end up with a similar
effect as the dreaded MCE broadcast.

But this can be handled smarter than just preventing shorthands if CPU
hotplug is enabled. The kernel already deals with the MCE broadcast issue
for the 'nosmt' case. It brings up all present CPUs and then shuts down the
SMT siblings right away after they did the basic initialization and set
CR4.MCE.

The core CPU hotplug code keeps track of that information already, so it
can be used to decide whether IPI shorthands can be used safely or not.

If all present CPUs have been brought up at least once it's safe to switch
to IPI shorthand mode. The switch over is done with a static key and can be
prevented completely with the existing (so far 32bit only) command line
option.

As a offlined CPU still receives IPIs the offline code is changed to soft
disable the local APIC so the offline CPU will not be bothered by shorthand
based IPIs. In soft disabled state the APIC still handles NMI, INIT, SIPI
so onlining will work as before.

To support NMI based shorthand IPIs the NMI handler gets a new check right
at the beginning of the handler code which lets the handler ignore the NMI
on a offline CPU and not call through the whole spaghetti maze of NMI
handling.

Soft disabling the local APIC on the offlined CPU unearthed a KVM APIC
emulation issue which is only relevant for CPU0 hotplug testing. The fix is
in the KVM tree already, but there is no need to have this dependency here.
(0-day folks are aware of it).

The APIC setup function has also a few minor issues which are addressed in
this series as well.

Part of the series is also a consolidation of the APIC code which was
necessary to not spread all the shorthand implementation details to header
files etc.

It survived testing on a range of different machines including NMI
shorthand IPIs. Aside of the KVM APIC issue, which is only relevant in
combination with CPU0 hotplug testing, there are no known side effects.

Changes vs. V1(https://lkml.kernel.org/r/20190703105431.096822793@linutronix.de)

	- Fix an 11 years old bug in kgdb

	- Move the shorthand decision logic into the callers (Nadav)

	- Make native_send_call_func_ipi() smarter (Nadav)

	- Consolidate more duplicated code 

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



