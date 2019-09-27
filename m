Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4B52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpG9HcKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfI0VZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:25:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0VZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/9cgJd4p9eb9aWJznrGVvVuTAiQn5zDbLuYD5xF9ZsU=; b=lpG9HcKPyz0/gINWLajI4KKCm
        FDEaPLQKad/8cQag1+eXnXFayPSc88NKdqo55pnTrpQnSR3JWV1oow42PMZ8fowenFNSDFXd5AbLM
        8B1o4DEDw1lF1nGiv3J9nA/372f6/VSyExK0b19OHFekmwiKMKp2idAH9lYkLvxRepo7dhfDVE3oX
        SZnU8D6sr9Fh135RQF7EQAXj9PuqjJG5QVYDYSxlEloEf7kXdclFbW90KDGeiSvJfYnQkTEYgRpYn
        lOFE4Ie/x0Y5scxx1BgkzXIWheaO9W25DB/SZLRSergZJUZGuCJn3bDMaewe548oZ2LNPZpM7pvRg
        DTgKCHdLg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDxk9-0006Zl-5Z; Fri, 27 Sep 2019 21:25:37 +0000
Subject: Re: [PATCH v8 17/17] Documentation/x86/64: Add documentation for
 GS/FS addressing mode
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
 <1568318818-4091-18-git-send-email-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3942a0ed-2aa5-ff31-5f71-dcfa546e9def@infradead.org>
Date:   Fri, 27 Sep 2019 14:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568318818-4091-18-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Some doc comments/fixes below...

On 9/12/19 1:06 PM, Chang S. Bae wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Explain how the GS/FS based addressing can be utilized in user space
> applications along with the differences between the generic prctl() based
> GS/FS base control and the FSGSBASE version available on newer CPUs.
> 
> ---
> 
> Changes from v7:
> * Rewritten the documentation and changelog by Thomas
> * Included compiler version info additionally
> ---
>  Documentation/x86/x86_64/fsgs.rst  | 200 +++++++++++++++++++++++++++++++++++++
>  Documentation/x86/x86_64/index.rst |   1 +
>  2 files changed, 201 insertions(+)
>  create mode 100644 Documentation/x86/x86_64/fsgs.rst
> 
> diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
> new file mode 100644
> index 0000000..791063c
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

                                                    FS/GS

> +
> + - the arch_prctl() system call
> +
> + - the FSGSBASE instruction family
> +
> +Accessing FS/GS base with arch_prctl()
> +--------------------------------------
> +
> + The arch_prctl(2) based mechanism is available on all 64bit CPUs and all

                                                          64-bit

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
> + automatically. The kernel has to enable them explicitly in CR4. The
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
> +GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
> +instructions. Clang 5 supports them as well.
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
> +an attribute based mechanism in Clang 2.6 and newer versions:
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
> \ No newline at end of file
oops.

-- 
~Randy
