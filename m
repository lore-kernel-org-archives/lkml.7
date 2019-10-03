Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83DE222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iX25iQf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJCFSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:18:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44670 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJCFSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:18:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so1351522wrl.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SFU7QP3pWI0aJrQ1LBVYk0BXMjUssoTIenqbocU0FA=;
        b=iX25iQf0pHMOjERAg6UKVnJSyWO5j3LYO9bkNgxkFaiu9Sovp9Kg0tUoTMuZSxK5DH
         joZbrLtpV4SU0Fswv7cl2KyuvoZiH1VNAxNLHB1b3zQk/EYSuc8PbE4qRx2ZCnbJkG/g
         oNx2NYb3jTV0h+1jJtkWCJQSQfd169tRNDGXrnoak7/0BOTygLm7v5ydmPNtIDsW+h8O
         sWHHmx/kmLtsxS0RWQ3oGOrkxn9O75s7HMbpv02fT54pZzBfaNp0cwU7EhjXlPUJgdpa
         qtLaGdpJ7v1JErS5l+9awy7Ey5+MRoocMX7OAkMM90bbe9l2CuA+hSKvjXUG/2VDyhrs
         0UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SFU7QP3pWI0aJrQ1LBVYk0BXMjUssoTIenqbocU0FA=;
        b=Qs2G9A0WsBPvTnJ6f5cqCwgj2SrCcxD6gD1H2UocyCvOBjOXlNZtGVeBX8Iz1d1EK2
         dMHr/K/9Ybd/BgiziLSbroyYzDZaR6iUIv+5D1RZyb7bab+86rlW9G+Qg+I3/+eY241X
         ZXPeIv3d3rn7vi1CdHb8p7X4uR9IkS+k7Q843ZFv6Jtgkw4yIUN/+0671WIeTRoXdmf7
         BX3ve8e2J3f5If4mclAWe7rbRo1oUilwZIai6kGzqHT862Lse9eL/5U4LjgFhrfxMVa1
         QWwUW2E39OnE4fWRMgi+Rm/IwA7UiGr91TrCiVvHVfM+FI9tNDLbDpfGITdVmcnfYmyO
         CuYQ==
X-Gm-Message-State: APjAAAX82uAyi7esJuz/5hgtsfkr+Mm+3m5qlME/5W00pxB1imuXEEHD
        PXnEFKMDZtZOnbnx01BsUt8QI+/Z1I+8nDknDF8PcA==
X-Google-Smtp-Source: APXvYqzbhFgeZyc37BVq0hrJucB+tF7IhFcRa3iYTzG/A5FmTtYf66YJ0puCzapgdLZolJNg06Pg9WZtB031PW+daTo=
X-Received: by 2002:a5d:50c8:: with SMTP id f8mr2740740wrt.96.1570079915524;
 Wed, 02 Oct 2019 22:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190927000915.31781-1-atish.patra@wdc.com> <20190927000915.31781-3-atish.patra@wdc.com>
In-Reply-To: <20190927000915.31781-3-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 3 Oct 2019 10:48:23 +0530
Message-ID: <CAAhSdy0cH6_Ygdygj=QWVVi68PV=kf-_JEBDmMjyN6-heDLMqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] RISC-V: Add basic support for SBI v0.2
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> The SBI v0.2 introduces a base extension which is backward compatible
> with v0.1. Implement all helper functions and minimum required SBI
> calls from v0.2 for now. All other base extension function will be
> added later as per need.
> As v0.2 calling convention is backward compatible with v0.1, remove
> the v0.1 helper functions and just use v0.2 calling convention.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 139 ++++++++++----------
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/sbi.c      | 241 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c    |   2 +
>  4 files changed, 311 insertions(+), 72 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi.c
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2147f384fad0..279b7f10b3c2 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,93 +8,88 @@
>
>  #include <linux/types.h>
>
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
> +       SBI_EXT_0_1_SET_TIMER = 0x0,
> +       SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> +       SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> +       SBI_EXT_0_1_CLEAR_IPI = 0x3,
> +       SBI_EXT_0_1_SEND_IPI = 0x4,
> +       SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> +       SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> +       SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> +       SBI_EXT_0_1_SHUTDOWN = 0x8,
> +       SBI_EXT_BASE = 0x10,
> +};
>
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
> -       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
> -       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
> -       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
> -       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);   \
> -       register uintptr_t a7 asm ("a7") = (uintptr_t)(which);  \
> -       asm volatile ("ecall"                                   \
> -                     : "+r" (a0)                               \
> -                     : "r" (a1), "r" (a2), "r" (a3), "r" (a7)  \
> -                     : "memory");                              \
> -       a0;                                                     \
> -})
> +enum sbi_ext_base_fid {
> +       SBI_BASE_GET_SPEC_VERSION = 0,
> +       SBI_BASE_GET_IMP_ID,
> +       SBI_BASE_GET_IMP_VERSION,
> +       SBI_BASE_PROBE_EXT,
> +       SBI_BASE_GET_MVENDORID,
> +       SBI_BASE_GET_MARCHID,
> +       SBI_BASE_GET_MIMPID,
> +};
>
> -/* Lazy implementations until SBI is finalized */
> -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
> -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
> -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
> -#define SBI_CALL_3(which, arg0, arg1, arg2) \
> -               SBI_CALL(which, arg0, arg1, arg2, 0)
> -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
> -               SBI_CALL(which, arg0, arg1, arg2, arg3)
> +#define SBI_SPEC_VERSION_DEFAULT       0x1
> +#define SBI_SPEC_VERSION_MAJOR_OFFSET  24
> +#define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
>
> -static inline void sbi_console_putchar(int ch)
> -{
> -       SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
> -}
> +/* SBI return error codes */
> +#define SBI_SUCCESS            0
> +#define SBI_ERR_FAILURE                -1
> +#define SBI_ERR_NOT_SUPPORTED  -2
> +#define SBI_ERR_INVALID_PARAM   -3
> +#define SBI_ERR_DENIED         -4
> +#define SBI_ERR_INVALID_ADDRESS -5
>
> -static inline int sbi_console_getchar(void)
> -{
> -       return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
> -}
> -
> -static inline void sbi_set_timer(uint64_t stime_value)
> -{
> -#if __riscv_xlen == 32
> -       SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
> -                         stime_value >> 32);
> -#else
> -       SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
> -#endif
> -}
> +extern unsigned long sbi_spec_version;
> +struct sbiret {
> +       long error;
> +       long value;
> +};
>
> -static inline void sbi_shutdown(void)
> -{
> -       SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
> -}
> +void sbi_init(void);
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                             unsigned long arg1, unsigned long arg2,
> +                             unsigned long arg3);
> +int sbi_err_map_linux_errorno(int err);
>
> -static inline void sbi_clear_ipi(void)
> -{
> -       SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
> -}
> +void sbi_console_putchar(int ch);
> +int sbi_console_getchar(void);
> +void sbi_set_timer(uint64_t stime_value);
> +void sbi_shutdown(void);
> +void sbi_clear_ipi(void);
> +void sbi_send_ipi(const unsigned long *hart_mask);
> +void sbi_remote_fence_i(const unsigned long *hart_mask);
> +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +                          unsigned long start,
> +                          unsigned long size);
>
> -static inline void sbi_send_ipi(const unsigned long *hart_mask)
> -{
> -       SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
> -}
> +void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +                               unsigned long start,
> +                               unsigned long size,
> +                               unsigned long asid);
> +int sbi_probe_extension(long ext);
>
> -static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
> +/* Check if current SBI specification version is 0.1 or not */
> +static inline int sbi_spec_is_0_1(void)
>  {
> -       SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
> +       return (sbi_spec_version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
>  }
>
> -static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> -                                        unsigned long start,
> -                                        unsigned long size)
> +/* Get the major version of SBI */
> +static inline unsigned long sbi_major_version(void)
>  {
> -       SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
> -                         start, size);
> +       return (sbi_spec_version >> SBI_SPEC_VERSION_MAJOR_OFFSET) &
> +               SBI_SPEC_VERSION_MAJOR_MASK;
>  }
>
> -static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> -                                             unsigned long start,
> -                                             unsigned long size,
> -                                             unsigned long asid)
> +/* Get the minor version of SBI */
> +static inline unsigned long sbi_minor_version(void)
>  {
> -       SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> -                         start, size, asid);
> +       return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>  }
>
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 2420d37d96de..faf862d26924 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -17,6 +17,7 @@ obj-y += irq.o
>  obj-y  += process.o
>  obj-y  += ptrace.o
>  obj-y  += reset.o
> +obj-y  += sbi.o
>  obj-y  += setup.o
>  obj-y  += signal.o
>  obj-y  += syscall_table.o
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> new file mode 100644
> index 000000000000..315fcb925278
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <asm/sbi.h>
> +#include <linux/sched.h>
> +
> +/* default SBI version is 0.1 */
> +unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                             unsigned long arg1, unsigned long arg2,
> +                             unsigned long arg3)
> +{
> +       struct sbiret ret;
> +
> +       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +       asm volatile ("ecall"
> +                     : "+r" (a0), "+r" (a1)
> +                     : "r" (a2), "r" (a3), "r" (a6), "r" (a7)
> +                     : "memory");
> +       ret.error = a0;
> +       ret.value = a1;
> +
> +       return ret;
> +}
> +
> +int sbi_err_map_linux_errno(int err)
> +{
> +       switch (err) {
> +       case SBI_SUCCESS:
> +               return 0;
> +       case SBI_ERR_DENIED:
> +               return -EPERM;
> +       case SBI_ERR_INVALID_PARAM:
> +               return -EINVAL;
> +       case SBI_ERR_INVALID_ADDRESS:
> +               return -EFAULT;
> +       case SBI_ERR_NOT_SUPPORTED:
> +       case SBI_ERR_FAILURE:
> +       default:
> +               return -ENOTSUPP;
> +       };
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
> +       sbi_ecall(SBI_EXT_0_1_CONSOLE_PUTCHAR, 0, ch, 0, 0, 0);
> +}
> +
> +/**
> + * sbi_console_getchar() - Reads a byte from console device.
> + *
> + * Returns the value read from console.
> + */
> +int sbi_console_getchar(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_0_1_CONSOLE_GETCHAR, 0, 0, 0, 0, 0);
> +
> +       return ret.error;
> +}
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
> +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> +                         stime_value >> 32, 0, 0);
> +#else
> +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0);
> +#endif
> +}
> +
> +/**
> + * sbi_shutdown() - Remove all the harts from executing supervisor code.
> + *
> + * Return: None
> + */
> +void sbi_shutdown(void)
> +{
> +       sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0);
> +}
> +
> +/**
> + * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> + *
> + * Return: None
> + */
> +void sbi_clear_ipi(void)
> +{
> +       sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0);
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
> +       sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> +                       0, 0, 0);
> +}
> +
> +/**
> + * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
> + * @hart_mask: A cpu mask containing all the target harts.
> + *
> + * Return: None
> + */
> +void sbi_remote_fence_i(const unsigned long *hart_mask)
> +{
> +       sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
> +                       0, 0, 0);
> +}
> +
> +/**
> + * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
> + *                          harts for the specified virtual address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the virtual address
> + * @size: Total size of the virtual address range.
> + *
> + * Return: None
> + */
> +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +                                        unsigned long start,
> +                                        unsigned long size)
> +{
> +       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +                       (unsigned long)hart_mask, start, size, 0);
> +}
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
> +                                             unsigned long start,
> +                                             unsigned long size,
> +                                             unsigned long asid)
> +{
> +       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +                       (unsigned long)hart_mask, start, size, asid);
> +}
> +
> +/**
> + * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> + * @extid: The extension ID to be probed.
> + *
> + * Return: Extension specific nonzero value if yes, -ENOTSUPP otherwise.
> + */
> +int sbi_probe_extension(long extid)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_PROBE_EXT, 0, 0, 0, 0);
> +       if (!ret.error)
> +               if (ret.value)
> +                       return ret.value;
> +
> +       return -ENOTSUPP;
> +}

Please EXPORT() all public APIs of SBI.

The KVM RISC-V does not compile as module if these public APIs are not
exported.

Regards,
Anup

> +
> +static long sbi_get_spec_version(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_SPEC_VERSION,
> +                              0, 0, 0, 0);
> +       if (!ret.error)
> +               return ret.value;
> +       else
> +               return ret.error;
> +}
> +
> +static long sbi_get_firmware_id(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_IMP_ID,
> +                              0, 0, 0, 0);
> +       if (!ret.error)
> +               return ret.value;
> +       else
> +               return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +static long sbi_get_firmware_version(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_BASE, SBI_BASE_GET_IMP_VERSION,
> +                              0, 0, 0, 0);
> +       if (!ret.error)
> +               return ret.value;
> +       else
> +               return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +void sbi_init(void)
> +{
> +       int ret;
> +
> +       ret = sbi_get_spec_version();
> +       if (ret > 0)
> +               sbi_spec_version = ret;
> +
> +       pr_info("SBI specification v%lu.%lu detected\n",
> +               sbi_major_version(), sbi_minor_version());
> +       if (!sbi_spec_is_0_1())
> +               pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
> +                       sbi_get_firmware_id(), sbi_get_firmware_version());
> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a990a6cb184f..abf2b9ee5307 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -21,6 +21,7 @@
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
>  #include <asm/smp.h>
> +#include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
>
> @@ -70,6 +71,7 @@ void __init setup_arch(char **cmdline_p)
>         swiotlb_init(1);
>  #endif
>
> +       sbi_init();
>  #ifdef CONFIG_SMP
>         setup_smp();
>  #endif
> --
> 2.21.0
>
