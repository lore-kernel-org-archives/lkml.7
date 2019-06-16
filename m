Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A533C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E280A20862
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssBlxHSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFPPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:54:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfFPPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cWGqACHvAup6UgRHhMdUnua3Y51Q0grdOJ4fNKpJskM=; b=ssBlxHSXxr5qDr/CKTVjzXUc7Z
        u8UDUyIZNKmqDZcSnViZj7lc8vVWFI6KYcFRgjttXC1FIe57k2+ufRKRyYdUXGk7LX4vD2Il6UMS8
        wwjFgUxm/BXBHROKzsZYpD+CKrqoaFLv5i3rgoiJrg7O1oO0U3c1Ym87+cffyF4awOuzlH0kJcEmc
        FL7dm+VWhQHlGhdFkgFihBSFTd90Wh/xKD5Bo9vmpeii2p+T/lQH5lBduGSkaRPjX6FAvadZG46NE
        bDIRY3ScrpVp9ptowMaiQ0/CA9TAbE6iNyEEnnsMtti8mgk/1fMCIkD8xx5jNI35re1RxFxhqD1KC
        EoBd9Xuw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcXUB-0007fB-VM; Sun, 16 Jun 2019 15:54:28 +0000
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for FSGSBASE
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ca2aa50-ed07-c59f-2fec-bf9596281f30@infradead.org>
Date:   Sun, 16 Jun 2019 08:54:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/13/19 11:54 PM, Thomas Gleixner wrote:
> 
> 8<------------------
> From: Thomas Gleixner <tglx@linutronix.de>
> Subject: Documentation/x86/64: Add documentation for GS/FS addressing mode
> Date: Thu,  13 Jun 2019 22:04:24 +0300
> 
> 
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/x86/x86_64/fsgs.rst  |  200 +++++++++++++++++++++++++++++++++++++
>  Documentation/x86/x86_64/index.rst |    1 
>  2 files changed, 201 insertions(+)
>  create mode 100644 Documentation/x86/fsgs.txt
> 
> --- /dev/null
> +++ b/Documentation/x86/x86_64/fsgs.rst
> @@ -0,0 +1,200 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Using FS and GS segments in user space applications
> +===================================================
> +
> +The x86 architecture supports segmentation. Instructions which access
> +memory can use segment register based addressing mode. The following
> +notation is used to address a byte within a segment:
> +
> +  Segment-register:Byte-address
> +
> +The segment base address is added to the Byte-address to compute the
> +resulting virtual address which is accessed. This allows to access multiple
> +instances of data with the identical Byte-address, i.e. the same code. The
> +selection of a particular instance is purely based on the base-address in
> +the segment register.
> +
> +In 32-bit mode the CPU provides 6 segments, which also support segment
> +limits. The limits can be used to enforce address space protections.
> +
> +In 64-bit mode the CS/SS/DS/ES segments are ignored and the base address is
> +always 0 to provide a full 64bit address space. The FS and GS segments are
> +still functional in 64-bit mode.
> +
> +Common FS and GS usage
> +------------------------------
> +
> +The FS segment is commonly used to address Thread Local Storage (TLS). FS
> +is usually managed by runtime code or a threading library. Variables
> +declared with the '__thread' storage class specifier are instantiated per
> +thread and the compiler emits the FS: address prefix for accesses to these
> +variables. Each thread has its own FS base address so common code can be
> +used without complex address offset calculations to access the per thread
> +instances. Applications should not use FS for other purposes when they use
> +runtimes or threading libraries which manage the per thread FS.
> +
> +The GS segment has no common use and can be used freely by
> +applications. There is no storage class specifier similar to __thread which
> +would cause the compiler to use GS based addressing modes. Newer versions
> +of GCC and Clang support GS based addressing via address space identifiers.
> +
> +
> +Reading and writing the FS/GS base address
> +------------------------------------------
> +
> +There exist two mechanisms to read and write the FS/FS base address:

should this be...                                   FS/GS


> +
> + - the arch_prctl() system call
> +
> + - the FSGSBASE instruction family
> +
> +Accessing FS/GS base with arch_prctl()
> +--------------------------------------
> +
> + The arch_prctl(2) based mechanism is available on all 64bit CPUs and all
> + kernel versions.
> +
> + Reading the base:
> +
> +   arch_prctl(ARCH_GET_FS, &fsbase);
> +   arch_prctl(ARCH_GET_GS, &gsbase);
> +
> + Writing the base:
> +
> +   arch_prctl(ARCH_SET_FS, fsbase);
> +   arch_prctl(ARCH_SET_GS, gsbase);
> +
> + The ARCH_SET_GS prctl may be disabled depending on kernel configuration
> + and security settings.
> +
> +Accessing FS/GS base with the FSGSBASE instructions
> +---------------------------------------------------
> +
> + With the Ivy Bridge CPU generation Intel introduced a new set of
> + instructions to access the FS and GS base registers directly from user
> + space. These instructions are also supported on AMD Family 17H CPUs. The
> + following instructions are available:
> +
> +  =============== ===========================
> +  RDFSBASE %reg   Read the FS base register
> +  RDGSBASE %reg   Read the GS base register
> +  WRFSBASE %reg   Write the FS base register
> +  WRGSBASE %reg   Write the GS base register
> +  =============== ===========================
> +
> + The instructions avoid the overhead of the arch_prctl() syscall and allow
> + more flexible usage of the FS/GS addressing modes in user space
> + applications. This does not prevent conflicts between threading libraries
> + and runtimes which utilize FS and applications which want to use it for
> + their own purpose.
> +
> +FSGSBASE instructions enablement
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> + The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
> + available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
> +
> + The availability of the instructions is not enabling them

prefer:                                  does not enable them

> + automatically. The kernel has to enable them explicitely in CR4. The

typo:                                            explicitly

> + reason for this is that older kernels make assumptions about the values in
> + the GS register and enforce them when GS base is set via
> + arch_prctl(). Allowing user space to write arbitrary values to GS base
> + would violate these assumptions and cause malfunction.
> +
> + On kernels which do not enable FSGSBASE the execution of the FSGSBASE
> + instructions will fault with a #UD exception.
> +
> + The kernel provides reliable information about the enabled state in the
> + ELF AUX vector. If the HWCAP2_FSGSBASE bit is set in the AUX vector, the
> + kernel has FSGSBASE instructions enabled and applications can use them.
> + The following code example shows how this detection works::
> +
> +   #include <sys/auxv.h>
> +   #include <elf.h>
> +
> +   /* Will be eventually in asm/hwcap.h */
> +   #ifndef HWCAP2_FSGSBASE
> +   #define HWCAP2_FSGSBASE        (1 << 1)
> +   #endif
> +
> +   ....
> +
> +   unsigned val = getauxval(AT_HWCAP2);
> +
> +   if (val & HWCAP2_FSGSBASE)
> +        printf("FSGSBASE enabled\n");
> +
> +FSGSBASE instructions compiler support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +GCC version 6 and newer provide instrinsics for the FSGSBASE
> +instructions. Clang supports them as well.
> +
> +  =================== ===========================
> +  _readfsbase_u64()   Read the FS base register
> +  _readfsbase_u64()   Read the GS base register
> +  _writefsbase_u64()  Write the FS base register
> +  _writegsbase_u64()  Write the GS base register
> +  =================== ===========================
> +
> +To utilize these instrinsics <immintrin.h> must be included in the source
> +code and the compiler option -mfsgsbase has to be added.
> +
> +Compiler support for FS/GS based addressing
> +-------------------------------------------
> +
> +GCC version 6 and newer provide support for FS/GS based addressing via
> +Named Address Spaces. GCC implements the following address space
> +identifiers for x86:
> +
> +  ========= ====================================
> +  __seg_fs  Variable is addressed relative to FS
> +  __seg_gs  Variable is addressed relative to GS
> +  ========= ====================================
> +
> +The preprocessor symbols __SEG_FS and __SEG_GS are defined when these
> +address spaces are supported. Code which implements fallback modes should
> +check whether these symbols are defined. Usage example::
> +
> +  #ifdef __SEG_GS
> +
> +  long data0 = 0;
> +  long data1 = 1;
> +
> +  long __seg_gs *ptr;
> +
> +  /* Check whether FSGSBASE is enabled by the kernel (HWCAP2_FSGSBASE) */
> +  ....
> +
> +  /* Set GS to point to data0 */
> +  _writegsbase_u64(&data0);
> +
> +  /* Access offset 0 of GS */
> +  ptr = 0;
> +  print("data0 = %ld\n", *ptr);
> +
> +  /* Set GS to point to data1 */
> +  _writegsbase_u64(&data1);
> +  /* ptr still addresses offset 0! */
> +  print("data1 = %ld\n", *ptr);
> +
> +
> +Clang does not provide these address space identifiers, but it provides
> +an attribute based mechanism:
> +
> + ==================================== =====================================
> +  __attribute__((address_space(256))  Variable is addressed relative to GS
> +  __attribute__((address_space(257))  Variable is addressed relative to FS
> + ==================================== =====================================
> +
> +FS/GS based addressing with inline assembly
> +-------------------------------------------
> +
> +In case the compiler does not support address spaces, inline assembly can
> +be used for FS/GS based addressing mode::
> +
> +	mov %fs:offset, %reg
> +	mov %gs:offset, %reg
> +
> +	mov %reg, %fs:offset
> +	mov %reg, %gs:offset


-- 
~Randy
