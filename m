Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CEB20833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8jmJW5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLCVRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:17:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34682 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfLCVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:17:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so2235801pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Kk4eyKCQbt4LTkStrsOoT/hozp2/UamnwwPVxzjOwyI=;
        b=H8jmJW5pJiEjzdOMZSdg1bx0E/C360jxMUrruq85ya0JKjYxvN+el7+10FL+hUEaF+
         1nvKRDYVn0hZVAtfAhhiOsY1P/Ovq6P553TUm++Khc1+VSB/MG1augzEi/pKHQoPULf4
         a5ohbeoOE6kqo7oSL+Jh9hcoU4cU1dA0X8KIygDqg705h7PY2VtbNSxEIccwT434HDhh
         nlTlUeXvNoJ7LB7fz7SUbDIV6OwPx6TxF5m1XzfCDZstMNVhXqfHntvmZPqdk3zOBQ3P
         3Ri2mbzyGQt9SMh19zEjZ1Z6kg2NIVqiXsSyPiIty1LdyDYCOucdCZMBbO/9X9ozFwDx
         9Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Kk4eyKCQbt4LTkStrsOoT/hozp2/UamnwwPVxzjOwyI=;
        b=X8PF/dkkXJz+Iqz6nUQ6r8u2X3Axsegcc8nXGDDQAc173LFn3gha6vHcaw5V58r5qO
         ShD1cCxSNdgTmeAvS9IZ3eMrpowl8ICX7LPajGDS9U/kaSpUSp0xNyrlxIG39ZBMmPDt
         2F/tlQOeUa1rGsFl2JNuRqa69WJ4xEjJegk24TtCMKAwKy/iCpvnIPHf5MVkz9mJNpm8
         a+uSNt9u5VFhQq6kxNbcVsmh8DqayltFY6sDPCawM8NDxVdZEX/fVpyakPjjGYQNIPXQ
         khE3Iw8v45wIU81PcQjipIFZ6oXEqnST3Yrc3jPFZNS2x5o6lT9UVAb7jOJcRGoKO7AQ
         LO0g==
X-Gm-Message-State: APjAAAXoTmxHVaa0HIn4ukA6E5hPB/CCKMAd2zJkQ8gmT+xGJeoTmB6V
        XC+sp6WSlyrWevBC8fweZOBrsWMKdoM=
X-Google-Smtp-Source: APXvYqzw01Wl+qr7wtMKYsRbMWLY0Hhp5JdvCmC84Ol8MAygCNFhAHg9Mdr0O84mj4b+4Kw2Lg00uw==
X-Received: by 2002:a63:3404:: with SMTP id b4mr7479509pga.438.1575407859535;
        Tue, 03 Dec 2019 13:17:39 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id k9sm3938518pje.26.2019.12.03.13.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:17:39 -0800 (PST)
Date:   Tue, 03 Dec 2019 13:17:39 -0800 (PST)
X-Google-Original-Date: Tue, 03 Dec 2019 12:41:55 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v5 2/4] RISC-V: Add basic support for SBI v0.2
In-Reply-To: <20191126190503.19303-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        alexios.zavras@intel.com, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-7197c95a-ef02-46df-ba9b-ca1903dcd6ec@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:05:01 PST (-0800), Atish Patra wrote:
> The SBI v0.2 introduces a base extension which is backward compatible
> with v0.1. Implement all helper functions and minimum required SBI
> calls from v0.2 for now. All other base extension function will be
> added later as per need.
> As v0.2 calling convention is backward compatible with v0.1, remove
> the v0.1 helper functions and just use v0.2 calling convention.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/sbi.h | 139 ++++++++++----------
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/sbi.c      | 247 ++++++++++++++++++++++++++++++++++-
>  arch/riscv/kernel/setup.c    |   2 +
>  4 files changed, 315 insertions(+), 74 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 96aaee270ded..906438322932 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -9,93 +9,88 @@
>  #include <linux/types.h>
>
>  #ifdef CONFIG_RISCV_SBI
> -#define SBI_EXT_0_1_SET_TIMER 0x0
> -#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
> -#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
> -#define SBI_EXT_0_1_CLEAR_IPI 0x3
> -#define SBI_EXT_0_1_SEND_IPI 0x4
> -#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
> -#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
> -#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
> -#define SBI_EXT_0_1_SHUTDOWN 0x8
> +enum sbi_ext_id {
> +	SBI_EXT_0_1_SET_TIMER = 0x0,
> +	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> +	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> +	SBI_EXT_0_1_CLEAR_IPI = 0x3,
> +	SBI_EXT_0_1_SEND_IPI = 0x4,
> +	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> +	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> +	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> +	SBI_EXT_0_1_SHUTDOWN = 0x8,
> +	SBI_EXT_BASE = 0x10,
> +};
>
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
> -	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
> -	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
> -	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
> -	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);	\
> -	register uintptr_t a7 asm ("a7") = (uintptr_t)(which);	\
> -	asm volatile ("ecall"					\
> -		      : "+r" (a0)				\
> -		      : "r" (a1), "r" (a2), "r" (a3), "r" (a7)	\
> -		      : "memory");				\
> -	a0;							\
> -})
> +enum sbi_ext_base_fid {
> +	SBI_BASE_GET_SPEC_VERSION = 0,
> +	SBI_BASE_GET_IMP_ID,
> +	SBI_BASE_GET_IMP_VERSION,
> +	SBI_BASE_PROBE_EXT,
> +	SBI_BASE_GET_MVENDORID,
> +	SBI_BASE_GET_MARCHID,
> +	SBI_BASE_GET_MIMPID,
> +};
>
> -/* Lazy implementations until SBI is finalized */
> -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
> -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
> -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
> -#define SBI_CALL_3(which, arg0, arg1, arg2) \
> -		SBI_CALL(which, arg0, arg1, arg2, 0)
> -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
> -		SBI_CALL(which, arg0, arg1, arg2, arg3)
> +#define SBI_SPEC_VERSION_DEFAULT	0x1
> +#define SBI_SPEC_VERSION_MAJOR_OFFSET	24
> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
>
> -static inline void sbi_console_putchar(int ch)
> -{
> -	SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
> -}
> +/* SBI return error codes */
> +#define SBI_SUCCESS		0
> +#define SBI_ERR_FAILURE		-1
> +#define SBI_ERR_NOT_SUPPORTED	-2
> +#define SBI_ERR_INVALID_PARAM   -3
> +#define SBI_ERR_DENIED		-4
> +#define SBI_ERR_INVALID_ADDRESS -5
>
> -static inline int sbi_console_getchar(void)
> -{
> -	return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
> -}
> +extern unsigned long sbi_spec_version;
> +struct sbiret {
> +	long error;
> +	long value;
> +};
>
> -static inline void sbi_set_timer(uint64_t stime_value)
> -{
> -#if __riscv_xlen == 32
> -	SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
> -			  stime_value >> 32);
> -#else
> -	SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
> -#endif
> -}
> -
> -static inline void sbi_shutdown(void)
> -{
> -	SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
> -}
> +int sbi_init(void);
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +			unsigned long arg1, unsigned long arg2,
> +			unsigned long arg3, unsigned long arg4,
> +			unsigned long arg5);
>
> -static inline void sbi_clear_ipi(void)
> -{
> -	SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
> -}
> +void sbi_console_putchar(int ch);
> +int sbi_console_getchar(void);
> +void sbi_set_timer(uint64_t stime_value);
> +void sbi_shutdown(void);
> +void sbi_clear_ipi(void);
> +void sbi_send_ipi(const unsigned long *hart_mask);
> +void sbi_remote_fence_i(const unsigned long *hart_mask);
> +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +			   unsigned long start,
> +			   unsigned long size);
>
> -static inline void sbi_send_ipi(const unsigned long *hart_mask)
> -{
> -	SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
> -}
> +void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +				unsigned long start,
> +				unsigned long size,
> +				unsigned long asid);
> +int sbi_probe_extension(long ext);
>
> -static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
> +/* Check if current SBI specification version is 0.1 or not */
> +static inline int sbi_spec_is_0_1(void)
>  {
> -	SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
> +	return (sbi_spec_version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
>  }
>
> -static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> -					 unsigned long start,
> -					 unsigned long size)
> +/* Get the major version of SBI */
> +static inline unsigned long sbi_major_version(void)
>  {
> -	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
> -			  start, size);
> +	return (sbi_spec_version >> SBI_SPEC_VERSION_MAJOR_OFFSET) &
> +		SBI_SPEC_VERSION_MAJOR_MASK;
>  }
>
> -static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> -					      unsigned long start,
> -					      unsigned long size,
> -					      unsigned long asid)
> +/* Get the minor version of SBI */
> +static inline unsigned long sbi_minor_version(void)
>  {
> -	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> -			  start, size, asid);
> +	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>  }
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f40205cb9a22..56127dd359f1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -17,6 +17,7 @@ obj-y	+= irq.o
>  obj-y	+= process.o
>  obj-y	+= ptrace.o
>  obj-y	+= reset.o
> +obj-y	+= sbi.o
>  obj-y	+= setup.o
>  obj-y	+= signal.o
>  obj-y	+= syscall_table.o
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f6c7c3e82d28..a47e23c3a2e1 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -4,14 +4,257 @@
>  #include <linux/pm.h>
>  #include <asm/sbi.h>
>
> +/* default SBI version is 0.1 */
> +unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
> +EXPORT_SYMBOL(sbi_spec_version);
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +			unsigned long arg1, unsigned long arg2,
> +			unsigned long arg3, unsigned long arg4,
> +			unsigned long arg5)
> +{
> +	struct sbiret ret;
> +
> +	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> +	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> +	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +	asm volatile ("ecall"
> +		      : "+r" (a0), "+r" (a1)
> +		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> +		      : "memory");
> +	ret.error = a0;
> +	ret.value = a1;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(sbi_ecall);
> +
> +static int sbi_err_map_linux_errno(int err)
> +{
> +	switch (err) {
> +	case SBI_SUCCESS:
> +		return 0;
> +	case SBI_ERR_DENIED:
> +		return -EPERM;
> +	case SBI_ERR_INVALID_PARAM:
> +		return -EINVAL;
> +	case SBI_ERR_INVALID_ADDRESS:
> +		return -EFAULT;
> +	case SBI_ERR_NOT_SUPPORTED:
> +	case SBI_ERR_FAILURE:
> +	default:
> +		return -ENOTSUPP;
> +	};
> +}
> +
> +/**
> + * sbi_console_putchar() - Writes given character to the console device.
> + * @ch: The data to be written to the console.
> + *
> + * Return: None
> + */
> +void sbi_console_putchar(int ch)
> +{
> +	sbi_ecall(SBI_EXT_0_1_CONSOLE_PUTCHAR, 0, ch, 0, 0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_console_putchar);
> +
> +/**
> + * sbi_console_getchar() - Reads a byte from console device.
> + *
> + * Returns the value read from console.
> + */
> +int sbi_console_getchar(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_0_1_CONSOLE_GETCHAR, 0, 0, 0, 0, 0, 0, 0);
> +
> +	return ret.error;
> +}
> +EXPORT_SYMBOL(sbi_console_getchar);
> +
> +/**
> + * sbi_set_timer() - Program the timer for next timer event.
> + * @stime_value: The value after which next timer event should fire.
> + *
> + * Return: None
> + */
> +void sbi_set_timer(uint64_t stime_value)
> +{
> +#if __riscv_xlen == 32
> +	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> +			  stime_value >> 32, 0, 0, 0, 0);
> +#else
> +	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> +#endif
> +}
> +EXPORT_SYMBOL(sbi_set_timer);
> +
> +/**
> + * sbi_shutdown() - Remove all the harts from executing supervisor code.
> + *
> + * Return: None
> + */
> +void sbi_shutdown(void)
> +{
> +	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_shutdown);
> +
> +/**
> + * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> + *
> + * Return: None
> + */
> +void sbi_clear_ipi(void)
> +{
> +	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
> +}
> +
> +/**
> + * sbi_send_ipi() - Send an IPI to any hart.
> + * @hart_mask: A cpu mask containing all the target harts.
> + *
> + * Return: None
> + */
> +void sbi_send_ipi(const unsigned long *hart_mask)
> +{
> +	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> +			0, 0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_send_ipi);
> +
> +/**
> + * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
> + * @hart_mask: A cpu mask containing all the target harts.
> + *
> + * Return: None
> + */
> +void sbi_remote_fence_i(const unsigned long *hart_mask)
> +{
> +	sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
> +			0, 0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_fence_i);
> +
> +/**
> + * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
> + *			     harts for the specified virtual address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the virtual address
> + * @size: Total size of the virtual address range.
> + *
> + * Return: None
> + */
> +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +					 unsigned long start,
> +					 unsigned long size)
> +{
> +	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +			(unsigned long)hart_mask, start, size, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_sfence_vma);
> +
> +/**
> + * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
> + * remote harts for a virtual address range belonging to a specific ASID.
> + *
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the virtual address
> + * @size: Total size of the virtual address range.
> + * @asid: The value of address space identifier (ASID).
> + *
> + * Return: None
> + */
> +void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +					      unsigned long start,
> +					      unsigned long size,
> +					      unsigned long asid)
> +{
> +	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +			(unsigned long)hart_mask, start, size, asid, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
> +
> +/**
> + * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> + * @extid: The extension ID to be probed.
> + *
> + * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
> + */
> +int sbi_probe_extension(long extid)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_PROBE_EXT, extid, 0, 0, 0, 0, 0);
> +	if (!ret.error)
> +		if (ret.value)
> +			return ret.value;
> +
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL(sbi_probe_extension);
> +
> +static long sbi_get_spec_version(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_SPEC_VERSION,
> +			       0, 0, 0, 0, 0, 0);
> +	if (!ret.error)
> +		return ret.value;
> +	else
> +		return ret.error;
> +}
> +
> +static long sbi_get_firmware_id(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_IMP_ID,
> +			       0, 0, 0, 0, 0, 0);
> +	if (!ret.error)
> +		return ret.value;
> +	else
> +		return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +static long sbi_get_firmware_version(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_IMP_VERSION,
> +			       0, 0, 0, 0, 0, 0);
> +	if (!ret.error)
> +		return ret.value;
> +	else
> +		return sbi_err_map_linux_errno(ret.error);
> +}
> +
>  static void sbi_power_off(void)
>  {
>  	sbi_shutdown();
>  }
>
> -static int __init sbi_init(void)
> +int __init sbi_init(void)
>  {
> +	int ret;
> +
>  	pm_power_off = sbi_power_off;
> +	ret = sbi_get_spec_version();
> +	if (ret > 0)
> +		sbi_spec_version = ret;
> +
> +	pr_info("SBI specification v%lu.%lu detected\n",
> +		sbi_major_version(), sbi_minor_version());
> +	if (!sbi_spec_is_0_1())
> +		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
> +			sbi_get_firmware_id(), sbi_get_firmware_version());
>  	return 0;
>  }
> -early_initcall(sbi_init);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 365ff8420bfe..f0a3c51e3d1b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
>  #include <asm/smp.h>
> +#include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
>
> @@ -74,6 +75,7 @@ void __init setup_arch(char **cmdline_p)
>  	swiotlb_init(1);
>  #endif
>
> +	sbi_init();
>  #ifdef CONFIG_SMP
>  	setup_smp();
>  #endif

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
