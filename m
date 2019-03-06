Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D5C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38D020663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PV3z7Cl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCFX7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:21 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42059 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFX7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:21 -0500
Received: by mail-pg1-f202.google.com with SMTP id e1so13999636pgs.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CPSUFA3na+TLT+JtqPFNPs1xF45RX8llg9yvflKWgnM=;
        b=PV3z7Cl9jqY6IDRSsEQiXSr3MLMVxLIJmMswBGcPDvP2kByMmvMTZy/qQ4oNdtXc4Y
         b4bPTTqTDEYzAoiLoaDve00Et9ZyO1xzc8nYOnjfct7JjNCZUdpOb7Qt76YxsrLIU9sl
         XmeBvbvOw9MZj4ZZGh/qDx2Zl+jzVxT5X1j4Tp6JkfL8pOpub7irpQlN5yEK8Qc+yCMM
         h46HrcXz5l8x73BL7ktNPkxDHHVU2AD7B1dW1Wfk12sFYOaxBNVnX1tITkyqbGwRchhj
         ZLIVSHmr2W+NZe6ThqsaaIRTI0HBCVXaUX4LFW+xRDTMFoJDP9jPwSOplkAbP0imSGLf
         I2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CPSUFA3na+TLT+JtqPFNPs1xF45RX8llg9yvflKWgnM=;
        b=YkAy2CPhEaeqocYavYTGWrQEye71URtGOykn+r/2DFO2H36g6+Zq7SYEuEahn84Oc3
         1+Fuo7+7Zq6SsGs4sXXDuveA1lZLSnsg5OCEMBY8Dw3TNpVtXeP7QH3UbTgtITf5QsLu
         dV3Yi5fiTXxt0+IXtV23qM2fMBYMwXYy4P+N5CbUZlW7zYNpN4j/wZQqUTgx0pqTWes4
         HQ4sG+/OuETnWoP6ikM7i4wvL8EDWC341mfpF8Q+4FVJJgnmXvvbvCWFv2oTN8mlAZPd
         i46wKWLbV+gaoZ/lxUB21vuUMhuP5I8pWMp58IsiCel4YuELB6bXdn05AjpG0SbBKxzH
         uJrQ==
X-Gm-Message-State: APjAAAVQf14EKGjlsnqXs7URz77JP45Q/ikyu5rf7ZUUdCCXp1dRLLdx
        uCt/vn9Gik+uRFoKggRRhNlXyjcy11krK15MOGQreg==
X-Google-Smtp-Source: APXvYqwNQumdXsBgQdMceSbEzpfebs4A0hvt9sgQ65a/sfxkP9weZNrHnKlgqHJh1GK+jK002rS7mugpTKtlbYPPgO/1rg==
X-Received: by 2002:a62:d2c4:: with SMTP id c187mr3877706pfg.133.1551916759835;
 Wed, 06 Mar 2019 15:59:19 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:46 -0800
Message-Id: <20190306235913.6631-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PULL REQUEST] Kernel lockdown patches for 5.2
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

This patchset introduces an optional kernel lockdown feature,
intended to strengthen the boundary between UID 0 and the kernel. When
enabled and active (by enabling the config option and passing the
"lockdown" option on the kernel command line), various pieces of
kernel functionality are restricted. Applications that rely on
low-level access to either hardware or the kernel may cease working as
a result - therefore this should not be enabled without appropriate
evaluation beforehand.

The majority of mainstream distributions have been carrying variants
of this patchset for many years now, so there's value in providing a
unified upstream implementation to reduce the delta. This PR probably
doesn't meet every distribution requirement, but gets us much closer
to not requiring external patches.

This PR is mostly the same as the previous attempt, but with the
following changes:

1) The integration between EFI secure boot and the lockdown state has
been removed
2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
which will always enable lockdown regardless of the kernel command
line
3) The integration with IMA has been dropped for now. IMA is in the
process of adding support for architecture-specific policies that will
interact correctly with the lockdown feature, and a followup patch will
integrate that so we don't end up with an ordering dependency on the
merge

The following changes since commit 468e91cecb3218afd684b8c422490dfebe0691bb:

  keys: fix missing __user in KEYCTL_PKEY_QUERY (2019-03-04 15:48:37 -0800)

are available in the Git repository at:

  https://github.com/mjg59/linux lock_down

for you to fetch changes up to 3d53449e0ac1df8cfdcc1ec48dc9cb622f220300:

  lockdown: Print current->comm in restriction messages (2019-03-06 13:32:19 -0800)

----------------------------------------------------------------
Dave Young (1):
      Copy secure_boot flag in boot params across kexec reboot

David Howells (12):
      Add the ability to lock down access to the running kernel image
      Enforce module signatures if the kernel is locked down
      Prohibit PCMCIA CIS storage when the kernel is locked down
      Lock down TIOCSSERIAL
      Lock down module params that specify hardware parameters (eg. ioport)
      x86/mmiotrace: Lock down the testmmiotrace module
      Lock down /proc/kcore
      Lock down kprobes
      bpf: Restrict kernel image access functions when the kernel is locked down
      Lock down perf
      debugfs: Restrict debugfs when the kernel is locked down
      lockdown: Print current->comm in restriction messages

Jiri Bohac (2):
      kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
      kexec_file: Restrict at runtime if the kernel is locked down

Josh Boyer (2):
      hibernate: Disable when the kernel is locked down
      acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down

Kyle McMartin (1):
      Add a SysRq option to lift kernel lockdown

Linn Crosetto (2):
      acpi: Disable ACPI table override if the kernel is locked down
      acpi: Disable APEI error injection if the kernel is locked down

Matthew Garrett (7):
      Restrict /dev/{mem,kmem,port} when the kernel is locked down
      kexec_load: Disable at runtime if the kernel is locked down
      uswsusp: Disable when the kernel is locked down
      PCI: Lock down BAR access when the kernel is locked down
      x86: Lock down IO port access when the kernel is locked down
      x86/msr: Restrict MSR access when the kernel is locked down
      ACPI: Limit access to custom_method when the kernel is locked down

 arch/x86/Kconfig                       |  20 +++++--
 arch/x86/include/asm/setup.h           |   2 +
 arch/x86/kernel/ioport.c               |   6 +-
 arch/x86/kernel/kexec-bzimage64.c      |   1 +
 arch/x86/kernel/msr.c                  |  10 ++++
 arch/x86/mm/testmmiotrace.c            |   3 +
 crypto/asymmetric_keys/verify_pefile.c |   4 +-
 drivers/acpi/apei/einj.c               |   3 +
 drivers/acpi/custom_method.c           |   3 +
 drivers/acpi/osl.c                     |   2 +-
 drivers/acpi/tables.c                  |   5 ++
 drivers/char/mem.c                     |   2 +
 drivers/input/misc/uinput.c            |   1 +
 drivers/pci/pci-sysfs.c                |   9 +++
 drivers/pci/proc.c                     |   9 ++-
 drivers/pci/syscall.c                  |   3 +-
 drivers/pcmcia/cistpl.c                |   3 +
 drivers/tty/serial/serial_core.c       |   6 ++
 drivers/tty/sysrq.c                    |  19 ++++--
 fs/debugfs/file.c                      |  28 +++++++++
 fs/debugfs/inode.c                     |  30 +++++++++-
 fs/proc/kcore.c                        |   2 +
 include/linux/input.h                  |   5 ++
 include/linux/kernel.h                 |  17 ++++++
 include/linux/kexec.h                  |   4 +-
 include/linux/security.h               |   9 ++-
 include/linux/sysrq.h                  |   8 ++-
 kernel/bpf/syscall.c                   |   3 +
 kernel/debug/kdb/kdb_main.c            |   2 +-
 kernel/events/core.c                   |   5 ++
 kernel/kexec.c                         |   7 +++
 kernel/kexec_file.c                    |  54 ++++++++++++++---
 kernel/kprobes.c                       |   3 +
 kernel/module.c                        |  39 +++++++++---
 kernel/params.c                        |  26 ++++++--
 kernel/power/hibernate.c               |   2 +-
 kernel/power/user.c                    |   3 +
 security/Kconfig                       |  24 ++++++++
 security/Makefile                      |   3 +
 security/lock_down.c                   | 106 +++++++++++++++++++++++++++++++++
 40 files changed, 447 insertions(+), 44 deletions(-)
 create mode 100644 security/lock_down.c


