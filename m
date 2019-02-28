Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4359AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02162218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEB/jTmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfB1XYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:24:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfB1XYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3OTMvqIsgBsJKRphPPB6sZbG3KA1MawSCRk7xDbyzX0=; b=mEB/jTmqBGbWZjLxTYyDNXKDKy
        BTKsbKJHVI846klJqeDouvMnSlYtWxup0/+NzX7AHpweGS8a/6B2qBOB6AcUvd0M5w7Ausl8EEGd/
        Fyl/RqsSFNs5UAktQWJE6FsLHc3GOSuHfIyVmHjSYNeBTagY/mY7QGggwRf2k1cxQEIy1Ai3fHm9X
        MOoEfn+HW4RDttvgDV5LCTtOVCE29wq5BtUcVFvln9o0VhRKGPUgaSwkxI4HMV1cklcZxJGQ4XyXs
        rlr5a60gMzXYkhy6z4vUoAOnL/VmF5fprFz6beSeeVyvLMO043wH+x8IrHAKpeLbmqERtE+fGxE5Q
        38KRN1sQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzV2l-0001oM-3f; Thu, 28 Feb 2019 23:24:47 +0000
Subject: Re: [PULL REQUEST] Lock down patches
To:     Matthew Garrett <mjg59@google.com>, jmorris@namei.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6826f3fa-487e-ca4e-0433-9160f38cd901@infradead.org>
Date:   Thu, 28 Feb 2019 15:24:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 1:28 PM, Matthew Garrett wrote:
> Hi James,
> 
> David is low on cycles at the moment, so I'm taking over for this time
> round. This patchset introduces an optional kernel lockdown feature,
> intended to strengthen the boundary between UID 0 and the kernel. When
> enabled and active (by enabling the config option and passing the
> "lockdown" option on the kernel command line), various pieces of
> kernel functionality are restricted. Applications that rely on
> low-level access to either hardware or the kernel may cease working as
> a result - therefore this should not be enabled without appropriate
> evaluation beforehand.

Documentation/process/submitting-patches.rst says (IMO) that these
patches should also have Signed-of-by: <you>.

"The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path."

Also, the sysrq key usage should be documented in
Documentation/admin-guide/sysrq.rst.

> The majority of mainstream distributions have been carrying variants
> of this patchset for many years now, so there's value in providing a
> unified upstream implementation to reduce the delta. This PR probably
> doesn't meet every distribution requirement, but gets us much closer
> to not requiring external patches.
> 
> This PR is mostly the same as the previous attempt, but with the
> following changes:
> 
> 1) The integration between EFI secure boot and the lockdown state has
> been removed
> 2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
> which will always enable lockdown regardless of the kernel command
> line
> 3) The integration with IMA has been dropped for now. Requiring the
> use of the IMA secure boot policy when lockdown is enabled isn't
> practical for most distributions at the moment, as there's still not a
> great deal of infrastructure for shipping packages with appropriate
> IMA signatures, and it makes it complicated for end users to manage
> custom IMA policies.
> 
> The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:
> 
>   Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/mjg59/linux lock_down
> 
> for you to fetch changes up to 43e004ecae91bf9159b8e91cd1d613e58b8f63f8:
> 
>   lockdown: Print current->comm in restriction messages (2019-02-28
> 11:19:23 -0800)
> 
> ----------------------------------------------------------------
> Dave Young (1):
>       Copy secure_boot flag in boot params across kexec reboot
> 
> David Howells (12):
>       Add the ability to lock down access to the running kernel image
>       Enforce module signatures if the kernel is locked down
>       Prohibit PCMCIA CIS storage when the kernel is locked down
>       Lock down TIOCSSERIAL
>       Lock down module params that specify hardware parameters (eg. ioport)
>       x86/mmiotrace: Lock down the testmmiotrace module
>       Lock down /proc/kcore
>       Lock down kprobes
>       bpf: Restrict kernel image access functions when the kernel is locked down
>       Lock down perf
>       debugfs: Restrict debugfs when the kernel is locked down
>       lockdown: Print current->comm in restriction messages
> 
> Jiri Bohac (2):
>       kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
>       kexec_file: Restrict at runtime if the kernel is locked down
> 
> Josh Boyer (2):
>       hibernate: Disable when the kernel is locked down
>       acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down
> 
> Kyle McMartin (1):
>       Add a SysRq option to lift kernel lockdown
> 
> Linn Crosetto (2):
>       acpi: Disable ACPI table override if the kernel is locked down
>       acpi: Disable APEI error injection if the kernel is locked down
> 
> Matthew Garrett (7):
>       Restrict /dev/{mem,kmem,port} when the kernel is locked down
>       kexec_load: Disable at runtime if the kernel is locked down
>       uswsusp: Disable when the kernel is locked down
>       PCI: Lock down BAR access when the kernel is locked down
>       x86: Lock down IO port access when the kernel is locked down
>       x86/msr: Restrict MSR access when the kernel is locked down
>       ACPI: Limit access to custom_method when the kernel is locked down
> 
>  arch/x86/Kconfig                       |  20 ++++++++++++-----
>  arch/x86/include/asm/setup.h           |   2 ++
>  arch/x86/kernel/ioport.c               |   6 ++++--
>  arch/x86/kernel/kexec-bzimage64.c      |   1 +
>  arch/x86/kernel/msr.c                  |  10 +++++++++
>  arch/x86/mm/testmmiotrace.c            |   3 +++
>  crypto/asymmetric_keys/verify_pefile.c |   4 +++-
>  drivers/acpi/apei/einj.c               |   3 +++
>  drivers/acpi/custom_method.c           |   3 +++
>  drivers/acpi/osl.c                     |   2 +-
>  drivers/acpi/tables.c                  |   5 +++++
>  drivers/char/mem.c                     |   2 ++
>  drivers/input/misc/uinput.c            |   1 +
>  drivers/pci/pci-sysfs.c                |   9 ++++++++
>  drivers/pci/proc.c                     |   9 +++++++-
>  drivers/pci/syscall.c                  |   3 ++-
>  drivers/pcmcia/cistpl.c                |   3 +++
>  drivers/tty/serial/serial_core.c       |   6 ++++++
>  drivers/tty/sysrq.c                    |  19 +++++++++++------
>  fs/debugfs/file.c                      |  28 ++++++++++++++++++++++++
>  fs/debugfs/inode.c                     |  30 ++++++++++++++++++++++++--
>  fs/proc/kcore.c                        |   2 ++
>  include/linux/ima.h                    |   6 ++++++
>  include/linux/input.h                  |   5 +++++
>  include/linux/kernel.h                 |  17 +++++++++++++++
>  include/linux/kexec.h                  |   4 ++--
>  include/linux/security.h               |   9 +++++++-
>  include/linux/sysrq.h                  |   8 ++++++-
>  kernel/bpf/syscall.c                   |   3 +++
>  kernel/debug/kdb/kdb_main.c            |   2 +-
>  kernel/events/core.c                   |   5 +++++
>  kernel/kexec.c                         |   7 ++++++
>  kernel/kexec_file.c                    |  56
> ++++++++++++++++++++++++++++++++++++++++++------
>  kernel/kprobes.c                       |   3 +++
>  kernel/module.c                        |  56
> ++++++++++++++++++++++++++++++++++++------------
>  kernel/params.c                        |  26 ++++++++++++++++++-----
>  kernel/power/hibernate.c               |   2 +-
>  kernel/power/user.c                    |   3 +++
>  security/Kconfig                       |  24 +++++++++++++++++++++
>  security/Makefile                      |   3 +++
>  security/lock_down.c                   | 106
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  41 files changed, 466 insertions(+), 50 deletions(-)
>  create mode 100644 security/lock_down.c
> 


-- 
~Randy
