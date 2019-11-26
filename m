Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ACC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732F206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="KEZDFhU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKZEOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:14:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37369 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfKZEOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:14:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so1671662wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 20:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFemv6wCZalf/9FIJedyD8IoPPbwLyub0+LMLtADr4Y=;
        b=KEZDFhU/h0tVP//zt+DQk0efvcyC1ew9ggc6zktCUmLFBN++tWwfdUJmKxb7JaQAde
         m1xe+L87gsIxnNiFBifwR1LkP/RE7BwjTOaon14wr5XtxSI4I3OqoMimZlRpyO3BDK7I
         rhK7t1pqe/U8QJZK38U6g73BSJNlf7UgLng1G8qu05sjausIx8KOUkY0Rof2XTTP2g2M
         2/xhUi7BIBZjjW3Uo+LFuGYkVbB0OHJJUQwHkGdBFpBuOzHeml/twnCFK5Vg8sQJcYeL
         F6pvzLZuT/DSYKxyG4w2ZnKmQMgkadezNtLgWyZaNtq4Ecbmgbm+/6DLbHVwDr0XU1XJ
         +w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFemv6wCZalf/9FIJedyD8IoPPbwLyub0+LMLtADr4Y=;
        b=c51SqzHLocmDFjljwH04TWh3dUYYVWiWKP5jPtJrV6kxX9F9Dche5dj0BSvu1lCq2F
         99bsa8mAphjt+jDrn5t4OxwyOESdGwrm11RbWe+OlKTkO+xugeKwcl5jilZeAEYiMAEd
         FCewyqSbZlw/5rwHoL9qK5CKadhUxzTbFBUJtBFSpIo1nDwSwlN6dFUZppYL3XnjxOaa
         nVZHcsZw334qDJk42fmnmqzfuG9bxgURDZNtTHG2M8oNKXkIs8fGNoUtY/10LLPLgAEB
         W5UBSJewZC/KHwo8Zqw4/pHcinyssUMLyHE/MT560xjEgwAC5D1f01SxxR4ZEiXazPh4
         fbcw==
X-Gm-Message-State: APjAAAWcYrG1m44z6jxFYNANTnWe2p0ddzzUb8dVRLDIMemSkldZ96F9
        gRUQ+sqX0rovPYtcGwKNS9tUKWsg5PydKFRSwmiRxA==
X-Google-Smtp-Source: APXvYqzoA5B9vUcfyEmHKOBxoNoyUHVAz8idRDlq3cIlYOGg2WlGSZVoW5eBmsLK8Flb1AC0QGTgtEXEE47MYBSSJw8=
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr1987740wmf.103.1574741676457;
 Mon, 25 Nov 2019 20:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20191126032033.14825-1-atish.patra@wdc.com> <20191126032033.14825-4-atish.patra@wdc.com>
In-Reply-To: <20191126032033.14825-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Nov 2019 09:44:25 +0530
Message-ID: <CAAhSdy2icvYPfa5Dm+1qF9sr=22ErHVYr=ZmXYqu6dHZing81A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] RISC-V: Introduce a new config for SBI v0.1
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:50 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> We now have SBI v0.2 which is more scalable and extendable to handle
> future needs for RISC-V supervisor interfaces.
>
> Introduce a new config and move all SBI v0.1 code under that config.
> This allows to implement the new replacement SBI extensions cleanly
> and remove v0.1 extensions easily in future. Currently, the config
> is enabled by default. Once all M-mode software with v0.1 are no
> longer in use, this config option and all relevant code can be easily
> removed.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig           |   6 ++
>  arch/riscv/include/asm/sbi.h |   2 +
>  arch/riscv/kernel/sbi.c      | 154 +++++++++++++++++++++++++++++------
>  3 files changed, 138 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ca3b5541ae93..15c020d6837b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -304,6 +304,12 @@ config SECCOMP
>           and the task is only allowed to execute a few safe syscalls
>           defined by each seccomp mode.
>
> +config RISCV_SBI_V01
> +       bool "SBI v0.1 support"
> +       default y
> +       help
> +         This config allows kernel to use SBI v0.1 APIs. This will be
> +         deprecated in future once legacy M-mode software are no longer in use.
>  endmenu
>
>  menu "Boot options"
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 906438322932..cc82ae63f8e0 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -10,6 +10,7 @@
>
>  #ifdef CONFIG_RISCV_SBI
>  enum sbi_ext_id {
> +#ifdef CONFIG_RISCV_SBI_V01
>         SBI_EXT_0_1_SET_TIMER = 0x0,
>         SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
>         SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> @@ -19,6 +20,7 @@ enum sbi_ext_id {
>         SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
>         SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
>         SBI_EXT_0_1_SHUTDOWN = 0x8,
> +#endif
>         SBI_EXT_BASE = 0x10,
>  };
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 8b36269fa515..8574de1074c4 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -8,6 +8,14 @@
>  unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
>
> +void (*__sbi_set_timer)(uint64_t stime);
> +int (*__sbi_send_ipi)(const unsigned long *hart_mask);
> +int (*__sbi_rfence)(unsigned long extid, unsigned long fid,
> +                 const unsigned long *hart_mask,
> +                 unsigned long hbase, unsigned long start,
> +                 unsigned long size, unsigned long arg4,
> +                 unsigned long arg5);
> +

Make these function pointers static.

>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
>                         unsigned long arg3, unsigned long arg4,
> @@ -52,6 +60,32 @@ static int sbi_err_map_linux_errno(int err)
>         };
>  }
>
> +static inline void __sbi_set_timer_dummy_warn(uint64_t stime_value)

Don't make this function inline because you are assigning it to function
pointer below.

> +{
> +       pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
> +               sbi_major_version(), sbi_minor_version());
> +}
> +
> +static inline int __sbi_send_ipi_dummy_warn(const unsigned long *hart_mask)

Same as above.

> +{
> +       pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
> +               sbi_major_version(), sbi_minor_version());
> +       return 0;
> +}
> +
> +static inline int __sbi_rfence_dummy_warn(unsigned long extid,
> +                            unsigned long fid,
> +                            const unsigned long *hart_mask,
> +                            unsigned long hbase, unsigned long start,
> +                            unsigned long size, unsigned long arg4,
> +                            unsigned long arg5)

Same as above.

> +{
> +       pr_warn("remote fence extension is not available in SBI v%lu.%lu\n",
> +               sbi_major_version(), sbi_minor_version());
> +       return 0;
> +}
> +
> +#ifdef CONFIG_RISCV_SBI_V01
>  /**
>   * sbi_console_putchar() - Writes given character to the console device.
>   * @ch: The data to be written to the console.
> @@ -80,41 +114,106 @@ int sbi_console_getchar(void)
>  EXPORT_SYMBOL(sbi_console_getchar);
>
>  /**
> - * sbi_set_timer() - Program the timer for next timer event.
> - * @stime_value: The value after which next timer event should fire.
> + * sbi_shutdown() - Remove all the harts from executing supervisor code.
>   *
>   * Return: None
>   */
> -void sbi_set_timer(uint64_t stime_value)
> +void sbi_shutdown(void)
>  {
> -#if __riscv_xlen == 32
> -       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> -                         stime_value >> 32, 0, 0, 0, 0);
> -#else
> -       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> -#endif
> +       sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_set_timer);
>
>  /**
> - * sbi_shutdown() - Remove all the harts from executing supervisor code.
> + * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
>   *
>   * Return: None
>   */
> -void sbi_shutdown(void)
> +void sbi_clear_ipi(void)
>  {
> -       sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
> +       sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_shutdown);
>
>  /**
> - * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> + * sbi_set_timer_v01() - Program the timer for next timer event.
> + * @stime_value: The value after which next timer event should fire.
>   *
>   * Return: None
>   */
> -void sbi_clear_ipi(void)
> +static void __sbi_set_timer_v01(uint64_t stime_value)
>  {
> -       sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
> +#if __riscv_xlen == 32
> +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> +                 stime_value >> 32, 0, 0, 0, 0);
> +#else
> +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> +#endif
> +}
> +
> +static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +{
> +       sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> +                 0, 0, 0, 0, 0);
> +       return 0;
> +}
> +
> +static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
> +                            const unsigned long *hart_mask,
> +                            unsigned long hbase, unsigned long start,
> +                            unsigned long size, unsigned long arg4,
> +                            unsigned long arg5)
> +{
> +       switch (ext) {
> +       case SBI_EXT_0_1_REMOTE_FENCE_I:
> +               sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +                         (unsigned long)hart_mask, 0, 0, 0, 0, 0);
> +               break;
> +       case SBI_EXT_0_1_REMOTE_SFENCE_VMA:
> +               sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +                         (unsigned long)hart_mask, start, size,
> +                         0, 0, 0);
> +               break;
> +       case SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID:
> +               sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +                         (unsigned long)hart_mask, start, size,
> +                         arg4, 0, 0);
> +               break;
> +       default:
> +               pr_err("extid [%lu]not supported in SBI v0.1\n", ext);
> +       }
> +
> +       return 0;
> +}
> +#else
> +static void __sbi_set_timer_v01(uint64_t stime_value)
> +{
> +       __sbi_set_timer_dummy_warn(0);
> +}
> +static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +{
> +       return __sbi_send_ipi_dummy_warn(NULL);
> +}
> +static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
> +                            const unsigned long *hart_mask,
> +                            unsigned long hbase, unsigned long start,
> +                            unsigned long size, unsigned long arg4,
> +                            unsigned long arg5)
> +{
> +       return __sbi_rfence_dummy_warn(0, 0, 0, 0, 0, 0, 0, 0);
> +
> +}
> +#endif /* CONFIG_RISCV_SBI_V01 */
> +
> +/**
> + * sbi_set_timer() - Program the timer for next timer event.
> + * @stime_value: The value after which next timer event should fire.
> + *
> + * Return: None
> + */
> +void sbi_set_timer(uint64_t stime_value)
> +{
> +       __sbi_set_timer(stime_value);
>  }
>
>  /**
> @@ -125,11 +224,11 @@ void sbi_clear_ipi(void)
>   */
>  void sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -       sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> -                       0, 0, 0, 0, 0);
> +       __sbi_send_ipi(hart_mask);
>  }
>  EXPORT_SYMBOL(sbi_send_ipi);
>
> +
>  /**
>   * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
>   * @hart_mask: A cpu mask containing all the target harts.
> @@ -138,8 +237,8 @@ EXPORT_SYMBOL(sbi_send_ipi);
>   */
>  void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -       sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
> -                       0, 0, 0, 0, 0);
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +                    hart_mask, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
>
> @@ -156,8 +255,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>                                          unsigned long start,
>                                          unsigned long size)
>  {
> -       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> -                       (unsigned long)hart_mask, start, size, 0, 0, 0);
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +                    hart_mask, 0, start, size, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma);
>
> @@ -177,8 +276,8 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                                               unsigned long size,
>                                               unsigned long asid)
>  {
> -       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> -                       (unsigned long)hart_mask, start, size, asid, 0, 0);
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +                    hart_mask, 0, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>
> @@ -254,8 +353,15 @@ int __init sbi_init(void)
>
>         pr_info("SBI specification v%lu.%lu detected\n",
>                 sbi_major_version(), sbi_minor_version());
> -       if (!sbi_spec_is_0_1())
> +
> +       if (sbi_spec_is_0_1()) {
> +               __sbi_set_timer = __sbi_set_timer_v01;
> +               __sbi_send_ipi  = __sbi_send_ipi_v01;
> +               __sbi_rfence    = __sbi_rfence_v01;
> +       } else {
>                 pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
>                         sbi_get_firmware_id(), sbi_get_firmware_version());
> +       }
> +
>         return 0;
>  }
> --
> 2.23.0
>

Minor comments above otherwise looks good.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
