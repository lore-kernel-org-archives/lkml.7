Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA6C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A44206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfIJWBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 18:01:21 -0400
Received: from namei.org ([65.99.196.166]:43858 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfIJWBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 18:01:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x8AM1CcG023503;
        Tue, 10 Sep 2019 22:01:12 GMT
Date:   Tue, 10 Sep 2019 15:01:12 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Subject: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
Message-ID: <alpine.LRH.2.21.1909101402230.20291@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the latest iteration of the kernel lockdown patchset, from Matthew 
Garrett, David Howells and others.

From the original description:

  This patchset introduces an optional kernel lockdown feature, intended 
  to strengthen the boundary between UID 0 and the kernel. When enabled, 
  various pieces of kernel functionality are restricted. Applications that 
  rely on low-level access to either hardware or the kernel may cease 
  working as a result - therefore this should not be enabled without
  appropriate evaluation beforehand.

  The majority of mainstream distributions have been carrying variants of 
  this patchset for many years now, so there's value in providing a 
  doesn't meet every distribution requirement, but gets us much closer to 
  not requiring external patches.

There are two major changes since this was last proposed for mainline:

1. Separating lockdown from EFI secure boot. Background discussion is 
covered here: https://lwn.net/Articles/751061/

2. Implementation as an LSM, with a default stackable lockdown LSM module. 
This allows the lockdown feature to be policy-driven, rather than encoding 
an implicit policy within the mechanism.

A new locked_down LSM hook is provided to

  allow LSMs to make a policy decision around whether kernel functionality 
  that would allow tampering with or examining the runtime state of the 
  kernel should be permitted.

The included lockdown LSM provides an implementation with a simple policy 
intended for general purpose use. This policy provides a coarse level of 
granularity, controllable via the kernel command line:

  lockdown={integrity|confidentiality}

  Enable the kernel lockdown feature. If set to integrity, kernel features 
  that allow userland to modify the running kernel are disabled. If set to 
  confidentiality, kernel features that allow userland to extract 
  confidential information from the kernel are also disabled.

This may also be controlled via /sys/kernel/security/lockdown and 
overriden by kernel configuration.

New or existing LSMs may implement finer-grained controls of the lockdown 
features.  Refer to the lockdown_reason documentation in 
include/linux/security.h for details.

The lockdown feature has had signficant design feedback and review across 
many subsystems.  This code has been in linux-next for some weeks, with a 
few fixes applied along the way.

Stephen Rothwell noted that commit 9d1f8be5cf42 ("bpf: Restrict bpf when 
kernel lockdown is in confidentiality mode") is missing a Signed-off-by 
from its author. Matthew responded that he is providing this under 
category (c) of the DCO.

Several simple conflicts have been identified by Stephen in linux-next:

vfs tree:
  https://www.lkml.org/lkml/2019/8/12/21

Linus' tree:
  https://www.lkml.org/lkml/2019/8/12/26
  https://lkml.org/lkml/2019/8/20/1415
  https://lore.kernel.org/lkml/20190821130513.0038df28@canb.auug.org.au/
  https://lore.kernel.org/lkml/20190821130957.407d9c10@canb.auug.org.au/

Keys tree:
  https://lore.kernel.org/lkml/20190829150609.7ae3c4ee@canb.auug.org.au/

Please consider merging for v5.4.


The following changes since commit 
0ecfebd2b52404ae0c54a878c872bb93363ada36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown

for you to fetch changes up to 45893a0abee6b5fd52994a3a1095735aeaec472b:

  kexec: Fix file verification on S390 (2019-09-10 13:27:51 +0100)

----------------------------------------------------------------
Dave Young (1):
      lockdown: Copy secure_boot flag in boot params across kexec reboot

David Howells (10):
      lockdown: Enforce module signatures if the kernel is locked down
      lockdown: Prohibit PCMCIA CIS storage when the kernel is locked down
      lockdown: Lock down TIOCSSERIAL
      lockdown: Lock down module params that specify hardware parameters (eg. ioport)
      x86/mmiotrace: Lock down the testmmiotrace module
      lockdown: Lock down /proc/kcore
      lockdown: Lock down tracing and perf kprobes when in confidentiality mode
      bpf: Restrict bpf when kernel lockdown is in confidentiality mode
      lockdown: Lock down perf when in confidentiality mode
      debugfs: Restrict debugfs when the kernel is locked down

Jiri Bohac (2):
      kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
      kexec_file: Restrict at runtime if the kernel is locked down

Josh Boyer (2):
      hibernate: Disable when the kernel is locked down
      acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down

Linn Crosetto (1):
      acpi: Disable ACPI table override if the kernel is locked down

Matthew Garrett (15):
      security: Support early LSMs
      security: Add a "locked down" LSM hook
      security: Add a static lockdown policy LSM
      lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down
      kexec_load: Disable at runtime if the kernel is locked down
      PCI: Lock down BAR access when the kernel is locked down
      x86: Lock down IO port access when the kernel is locked down
      x86/msr: Restrict MSR access when the kernel is locked down
      ACPI: Limit access to custom_method when the kernel is locked down
      kexec: Allow kexec_file() with appropriate IMA policy when locked down
      tracefs: Restrict tracefs when the kernel is locked down
      efi: Restrict efivar_ssdt_load when the kernel is locked down
      lockdown: Print current->comm in restriction messages
      security: constify some arrays in lockdown LSM
      kexec: Fix file verification on S390

 Documentation/admin-guide/kernel-parameters.txt |   9 ++
 arch/arm64/Kconfig                              |   6 +-
 arch/s390/Kconfig                               |   2 +-
 arch/s390/configs/debug_defconfig               |   2 +-
 arch/s390/configs/defconfig                     |   2 +-
 arch/s390/configs/performance_defconfig         |   2 +-
 arch/s390/kernel/kexec_elf.c                    |   4 +-
 arch/s390/kernel/kexec_image.c                  |   4 +-
 arch/s390/kernel/machine_kexec_file.c           |   4 +-
 arch/x86/Kconfig                                |  20 ++-
 arch/x86/boot/compressed/acpi.c                 |  19 ++-
 arch/x86/include/asm/acpi.h                     |   9 ++
 arch/x86/include/asm/x86_init.h                 |   2 +
 arch/x86/kernel/acpi/boot.c                     |   5 +
 arch/x86/kernel/ima_arch.c                      |   4 +-
 arch/x86/kernel/ioport.c                        |   7 +-
 arch/x86/kernel/kexec-bzimage64.c               |   1 +
 arch/x86/kernel/msr.c                           |   8 +
 arch/x86/kernel/x86_init.c                      |   1 +
 arch/x86/mm/testmmiotrace.c                     |   5 +
 crypto/asymmetric_keys/verify_pefile.c          |   4 +-
 drivers/acpi/custom_method.c                    |   6 +
 drivers/acpi/osl.c                              |  14 +-
 drivers/acpi/tables.c                           |   6 +
 drivers/char/mem.c                              |   7 +-
 drivers/firmware/efi/efi.c                      |   6 +
 drivers/pci/pci-sysfs.c                         |  16 ++
 drivers/pci/proc.c                              |  14 +-
 drivers/pci/syscall.c                           |   4 +-
 drivers/pcmcia/cistpl.c                         |   5 +
 drivers/tty/serial/serial_core.c                |   5 +
 fs/debugfs/file.c                               |  30 ++++
 fs/debugfs/inode.c                              |  32 +++-
 fs/proc/kcore.c                                 |   6 +
 fs/tracefs/inode.c                              |  42 +++++-
 include/asm-generic/vmlinux.lds.h               |   8 +-
 include/linux/acpi.h                            |   6 +
 include/linux/ima.h                             |   9 ++
 include/linux/kexec.h                           |   4 +-
 include/linux/lsm_hooks.h                       |  13 ++
 include/linux/security.h                        |  59 ++++++++
 init/Kconfig                                    |   5 +
 init/main.c                                     |   1 +
 kernel/events/core.c                            |   7 +
 kernel/kexec.c                                  |   8 +
 kernel/kexec_file.c                             |  68 +++++++--
 kernel/module.c                                 |  37 ++++-
 kernel/params.c                                 |  21 ++-
 kernel/power/hibernate.c                        |   3 +-
 kernel/trace/bpf_trace.c                        |  10 ++
 kernel/trace/trace_kprobe.c                     |   5 +
 security/Kconfig                                |  11 +-
 security/Makefile                               |   2 +
 security/integrity/ima/Kconfig                  |   2 +-
 security/integrity/ima/ima.h                    |   2 +
 security/integrity/ima/ima_main.c               |   4 +-
 security/integrity/ima/ima_policy.c             |  50 +++++++
 security/lockdown/Kconfig                       |  47 ++++++
 security/lockdown/Makefile                      |   1 +
 security/lockdown/lockdown.c                    | 191 ++++++++++++++++++++++++
 security/security.c                             |  56 ++++++-
 61 files changed, 864 insertions(+), 79 deletions(-)
 create mode 100644 security/lockdown/Kconfig
 create mode 100644 security/lockdown/Makefile
 create mode 100644 security/lockdown/lockdown.c
