Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4747C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF2C23BEF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE2PTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:19:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42348 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:19:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0M0-0004kL-Mp; Wed, 29 May 2019 09:19:00 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0Lu-0000aq-LT; Wed, 29 May 2019 09:19:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190523003916.20726-2-ebiederm@xmission.com>
        <20190529131503.F2AC221871@mail.kernel.org>
Date:   Wed, 29 May 2019 10:18:50 -0500
In-Reply-To: <20190529131503.F2AC221871@mail.kernel.org> (Sasha Levin's
        message of "Wed, 29 May 2019 13:15:03 +0000")
Message-ID: <87zhn51e79.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hW0Lu-0000aq-LT;;;mid=<87zhn51e79.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+yBPPQRbR4rIZSc+oUb7PentKgOHUWF5E=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 01/26] signal: Correct namespace fixups of si_pid and si_uid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 6588c1e3ff014 signals: SI_USER: Masquerade si_pid when crossing pid ns boundary.
>
> The bot has tested the following trees: v5.1.4, v5.0.18, v4.19.45, v4.14.121, v4.9.178, v4.4.180, v3.18.140.
>
> v5.1.4: Build OK!
> v5.0.18: Build OK!
> v4.19.45: Failed to apply! Possible dependencies:
>     4cd2e0e70af68 ("signal: Introduce copy_siginfo_from_user and use it's return value")
>     ae7795bc6187a ("signal: Distinguish between kernel_siginfo and siginfo")
>     efc463adbccf7 ("signal: Simplify tracehook_report_syscall_exit")
>
> v4.14.121: Failed to apply! Possible dependencies:
>     212a36a17efe4 ("signal: Unify and correct copy_siginfo_from_user32")
>     3eb0f5193b497 ("signal: Ensure every siginfo we send has all bits initialized")
>     3f7c86b2382ea ("arm64: Update fault_info table with new exception types")
>     526c3ddb6aa27 ("signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS")
>     532826f3712b6 ("arm64: Mirror arm for unimplemented compat syscalls")
>     6b4f3d01052a4 ("usb, signal, security: only pass the cred, not the secid, to kill_pid_info_as_cred and security_task_kill")
>     92ff0674f5d80 ("arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info")
>     ae7795bc6187a ("signal: Distinguish between kernel_siginfo and siginfo")
>     af40ff687bc9d ("arm64: signal: Ensure si_code is valid for all fault signals")
>     b713da69e4c91 ("signal: unify compat_siginfo_t")
>     ea64d5acc8f03 ("signal: Unify and correct copy_siginfo_to_user32")
>     efc463adbccf7 ("signal: Simplify tracehook_report_syscall_exit")
>
> v4.9.178: Failed to apply! Possible dependencies:
>     359566faefa85 ("kernel_wait4()/kernel_waitid(): delay copying status to userland")
>     4c48abe91be03 ("waitid(): switch copyout of siginfo to unsafe_put_user()")
>     4e2648db9c5f7 ("ARM: remove indirection of asm/mach-types.h")
>     4f4ddad395b04 ("nios2: put setup.h in uapi")
>     53d3eaa315082 ("posix_cpu_timers: Move the add_device_randomness() call to a proper place")
>     67d7ddded322d ("waitid(2): leave copyout of siginfo to syscall itself")
>     6bc51cbaa9d75 ("signal: Remove non-uapi <asm/siginfo.h>")
>     7e95a225901a5 ("move compat wait4 and waitid next to native variants")
>     80dce5e374930 ("signal/ia64: Document a conflict with SI_USER with SIGFPE")
>     8f95c90ceb541 ("sched/wait, RCU: Introduce rcuwait machinery")
>     96a8fae0fe094 ("ARM: convert to generated system call tables")
>     ae7795bc6187a ("signal: Distinguish between kernel_siginfo and siginfo")
>     b9253a43370e8 ("signal: Move copy_siginfo_to_user to <linux/signal.h>")
>     cc731525f26af ("signal: Remove kernel interal si_code magic")
>     cc9f72e474a4d ("signal/sparc: Document a conflict with SI_USER with SIGFPE")
>     ce72a16fa705f ("wait4(2)/waitid(2): separate copying rusage to userland")
>     d08477aa975e9 ("fcntl: Don't use ambiguous SIG_POLL si_codes")
>     e2bd64d92a10f ("signal/alpha: Document a conflict with SI_USER for SIGTRAP")
>     ea1b75cf91380 ("signal/mips: Document a conflict with SI_USER with SIGFPE")
>     ea64d5acc8f03 ("signal: Unify and correct copy_siginfo_to_user32")
>
> v4.4.180: Failed to apply! Possible dependencies:
>     2b5e869ecfcb3 ("MIPS: ELF: Interpret the NAN2008 file header flag")
>     4f4acc9472e54 ("parisc: Fix SIGSYS signals in compat case")
>     5050e91fa650e ("MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel")
>     5fa393c857195 ("MIPS: Break down cacheops.h definitions")
>     6846351052e68 ("x86/signal: Add SA_{X32,IA32}_ABI sa_flags")
>     694977006a7ba ("MIPS: Use enums to make asm/pgtable-bits.h readable")
>     745f355878462 ("MIPS: mm: Unify pte_page definition")
>     780602d740fc0 ("MIPS: mm: Standardise on _PAGE_NO_READ, drop _PAGE_READ")
>     7939469da29a8 ("MIPS64: signal: Fix o32 sigaction syscall")
>     7b2cb64f91f25 ("MIPS: mm: Fix MIPS32 36b physical addressing (alchemy, netlogic)")
>     80dce5e374930 ("signal/ia64: Document a conflict with SI_USER with SIGFPE")
>     97f2645f358b4 ("tree-wide: replace config_enabled() with IS_ENABLED()")
>     a4455082dc6f0 ("x86/signals: Add missing signal_compat code for x86 features")
>     a60ae81e5e591 ("MIPS: CM: Fix mips_cm_max_vp_width for UP kernels")
>     ae7795bc6187a ("signal: Distinguish between kernel_siginfo and siginfo")
>     b1b4fad5cc678 ("MIPS: seccomp: Support compat with both O32 and N32")
>     b27873702b060 ("mips, thp: remove infrastructure for handling splitting PMDs")
>     b2edcfc814017 ("MIPS: Loongson: Add Loongson-3A R2 basic support")
>     cc731525f26af ("signal: Remove kernel interal si_code magic")
>     cc9f72e474a4d ("signal/sparc: Document a conflict with SI_USER with SIGFPE")
>     e2bd64d92a10f ("signal/alpha: Document a conflict with SI_USER for SIGTRAP")
>     ea1b75cf91380 ("signal/mips: Document a conflict with SI_USER with SIGFPE")
>     ea64d5acc8f03 ("signal: Unify and correct copy_siginfo_to_user32")
>
> v3.18.140: Failed to apply! Possible dependencies:
>     1a3d59579b9f4 ("MIPS: Tidy up FPU context switching")
>     304acb717e5b6 ("MIPS: Set `si_code' for SIGFPE signals sent from emulation too")
>     4227a2d4efc9c ("MIPS: Support for hybrid FPRs")
>     443c44032a54f ("MIPS: Always clear FCSR cause bits after emulation")
>     4a7c2371823a4 ("MIPS: Reindent R6 RI exception emulation")
>     53f037b08b5be ("ia64: Sync struct siginfo with general version")
>     5a1aca4469fdc ("MIPS: Fix FCSR Cause bit handling for correct SIGFPE issue")
>     5f9f41c474bef ("MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6")
>     7c151d3d5d7a0 ("MIPS: Make use of the ERETNC instruction on MIPS R6")
>     80dce5e374930 ("signal/ia64: Document a conflict with SI_USER with SIGFPE")
>     9cc719ab3f4f6 ("MIPS: MSA: bugfix - disable MSA correctly for new threads/processes.")
>     ae7795bc6187a ("signal: Distinguish between kernel_siginfo and siginfo")
>     b0a668fb2038d ("MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6")
>     cc5e9097c9aad ("arm64: add SIGSYS siginfo for compat task")
>     cc731525f26af ("signal: Remove kernel interal si_code magic")
>     e2bd64d92a10f ("signal/alpha: Document a conflict with SI_USER for SIGTRAP")
>     ea1b75cf91380 ("signal/mips: Document a conflict with SI_USER with SIGFPE")
>     ea64d5acc8f03 ("signal: Unify and correct copy_siginfo_to_user32")
>     ed2d72c1eb364 ("MIPS: Respect the FCSR exception mask for `si_code'")
>     f51246efee2b6 ("MIPS: Get rid of finish_arch_switch().")
>     fad0bfdb893ac ("MIPS: mips-r2-to-r6-emul.h: Inline empty `mipsr2_decoder'")
>
>
> How should we proceed with this patch?

I have not had any reports of anyone having problems, and this
only triggers when signals traverse a pid or a user namespace
boundary.

So while this is indeed a fix I think the usual best effort backport
will be fine.

If backporting further is desired it looks like the only real dependency
is the addition of the function siginfo_layout.  So it should not be as
difficult as the automated scripts suggests.

Eric

