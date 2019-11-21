Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BD0208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKUBpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:45:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:49098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfKUBpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:45:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="407025891"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2019 17:45:49 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v10 0/6] Enable split lock detection for real time and debug
Date:   Wed, 20 Nov 2019 16:53:17 -0800
Message-Id: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a stripped down version of the patch series.

Goals:
======
1) To provide a boot time option (default off) to enable split lock
   detection.
2) To ensure that kernel crashes cleanly if OS code executes an
   atomic instruction that crosses cache lines.
3) Enable for some existing CPUs that do not provide CPUID enumeration
   of the feature together with architectural enumeration for future CPUs.

Non-goals:
==========
1) Fancy methods to have the kernel recover/continue
2) Selective enabling (it is either "on" or "off").
3) /sys files to enable/disable at run time
4) Virtualization support (guests just SIGBUS)

Access to misaligned data across two cache lines in an atomic instruction
(a.k.a split lock) takes over 1000 extra cycles compared to an atomic
access within one cache line. Split lock degrades performance not only
on the current CPU but also on the whole system because during split lock
the instruction holds bus lock and prohibits any other memory access on
the bus.

Some real time environments cannot meet deadlines if the processor
is handling split locks.

On Intel Tremont and future processors, split lock is detected by
triggering #AC exception after setting bit 29 in the TEST_CTRL
MSR (0x33) [1].

When split lock detection is enabled, if split lock happens in the
kernel, the kernel panics. Otherwise, the user process is killed by
SIGBUS.

To get a split lock free real time system, kernel and user application
developers need to enable split lock detection and find and fix all
possible split lock issues.

The split lock detection is disabled by default because potential split
lock issues can cause kernel panic or kill user processes. It is enabled
only for real time or debug purpose through a kernel parameter
"split_lock_detect".

Enabling split lock detection already finds split lock issues in atomic
bit operations and some of the blocking issues are fixed in the tip tree:
https://lore.kernel.org/lkml/157384597983.12247.8995835529288193538.tip-bot2@tip-bot2/
https://lore.kernel.org/lkml/157384597947.12247.7200239597382357556.tip-bot2@tip-bot2/

[1] Please check the latest Intel 64 and IA-32 Architectures Software
Developer's Manual for more detailed information on the TEST_CTRL MSR
and the split lock detection bit and how to enumerate the feature.

==Changelog==
v10:
- Reduce the scope of this patch set to real time and debug usage only
  because this usage is requested by customers and is easier to be
  implemented than enabling the feature by default:
  1. Disable split lock detection by default and enable it only for
     real time or debug purpose.
  2. Kernel panics or kill user process in #AC for split lock
  3. Drop KVM and debugfs knobs.

v9:
Address Thomas Gleixner's comments:
- wrmsr() in split_lock_update_msr() to spare RMW
- Print warnings in atomic bit operations xxx_bit() if the address is
unaligned to unsigned long.
- When host enables split lock detection, forcing it enabled for guest.
- Using the msr_test_ctl_mask to decide which bits need to be switched in
atomic_switch_msr_test_ctl().
- Warn if addr is unaligned to unsigned long in atomic ops xxx_bit().

Address Ingo Molnar's comments:
- Follow right MSR register and bits naming convention
- Use right naming convention for variables and functions
- Use split_lock_debug for atomic opertions of WARN_ONCE in #AC handler
and split_lock_detect_wr();
- Move the sysfs interface to debugfs interface /sys/kernel/debug/x86/
split_lock_detect

Other fixes:
- update vmx->msr_test_ctl_mask when changing MSR_IA32_CORE_CAP.
- Support resume from suspend/hibernation

- The split lock fix patch (#0003) for wlcore wireless driver is
upstreamed. So remove the patch from this patch set.

v8:
Address issues pointed out by Thomas Gleixner:
- Remove all "clearcpuid=" related patches.
- Add kernel parameter "nosplit_lock_detect" patch.
- Merge definition and initialization of msr_test_ctl_cache into #AC
  handling patch which first uses the variable.
- Add justification for the sysfs knob and combine function and doc
  patches into one patch 0015.
- A few other adjustments.

v7:
- Add per cpu variable to cach MSR TEST_CTL. Suggested by Thomas Gleixner.
- Change a few other changes including locking, simplifying code, work
flow, KVM fixes, etc. Suggested by Thomas Gleixner.
- Fix KVM issues pointed out by Sean Christopherson.

v6:
- Fix #AC handler issues pointed out by Dave Hansen
- Add doc for the sysfs interface pointed out by Dave Hansen
- Fix a lock issue around wrmsr during split lock init, pointed out by Dave
  Hansen
- Update descriptions and comments suggested by Dave Hansen
- Fix __le32 issue in wlcore raised by Kalle Valo
- Add feature enumeration based on family/model/stepping for Icelake mobile

v5:
- Fix wlcore issue from Paolo Bonzini
- Fix b44 issue from Peter Zijlstra
- Change init sequence by Dave Hansen
- Fix KVM issues from Paolo Bonzini
- Re-order patch sequence

v4:
- Remove "setcpuid=" option
- Enable IA32_CORE_CAPABILITY enumeration for split lock
- Handle CPUID faulting by Peter Zijlstra
- Enable /sys interface to enable/disable split lock detection

v3:
- Handle split lock as suggested by Thomas Gleixner.
- Fix a few potential spit lock issues suggested by Thomas Gleixner.
- Support kernel option "setcpuid=" suggested by Dave Hanson and Thomas
Gleixner.
- Support flag string in "clearcpuid=" suggested by Dave Hanson and
Thomas Gleixner.

v2:
- Remove code that handles split lock issue in firmware and fix
x86_capability issue mainly based on comments from Thomas Gleixner and
Peter Zijlstra.

In previous version:
Comments from Dave Hansen:
- Enumerate feature in X86_FEATURE_SPLIT_LOCK_AC
- Separate #AC handler from do_error_trap
- Use CONFIG to configure inherit BIOS setting, enable, or disable split
  lock. Remove kernel parameter "split_lock_ac="
- Change config interface to debugfs from sysfs
- Fix a few bisectable issues
- Other changes.

Comment from Tony Luck and Dave Hansen:
- Dump right information in #AC handler

Comment from Alan Cox and Dave Hansen:
- Description of split lock in patch 0

Others:
- Remove tracing because we can trace split lock in existing
  sq_misc.split_lock.
- Add CONFIG to configure either panic or re-execute faulting instruction
  for split lock in kernel.
- other minor changes.

Fenghua Yu (6):
  x86/msr-index: Add two new MSRs
  x86/cpufeatures: Enumerate the IA32_CORE_CAPABILITIES MSR
  x86/split_lock: Enumerate split lock detection by the
    IA32_CORE_CAPABILITIES MSR
  x86/split_lock: Enumerate split lock detection if the
    IA32_CORE_CAPABILITIES MSR is not supported
  x86/split_lock: Handle #AC exception for split lock
  x86/split_lock: Enable split lock detection by kernel parameter

 .../admin-guide/kernel-parameters.txt         | 10 +++
 arch/x86/include/asm/cpu.h                    |  5 ++
 arch/x86/include/asm/cpufeatures.h            |  2 +
 arch/x86/include/asm/msr-index.h              |  8 +++
 arch/x86/include/asm/traps.h                  |  3 +
 arch/x86/kernel/cpu/common.c                  |  2 +
 arch/x86/kernel/cpu/intel.c                   | 72 +++++++++++++++++++
 arch/x86/kernel/traps.c                       | 22 +++++-
 8 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.19.1

