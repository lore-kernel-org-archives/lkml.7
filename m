Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9BEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FEE206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwuPqr84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfLDSwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:52:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36674 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:52:04 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so182452pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9Tp/KtJNwVzuaJhEOKKVEZwK56R14CCcKq5xNubP4Co=;
        b=DwuPqr84p4+FJr9TyN6ybvcrSN9g8GFTQTaPu0QJAS9DprKQ+ZaexV9RMk+hiT/57Q
         yW3ugbxNLTzltni9ye+5xwLA05Ha0yVW6LsPWETeW+MyTIfLraFssPHqWBVdIV8Oy0gm
         o+UPneTVvzOuREkJyAlGhIfJbATf7c9QnVjG4jmEhJnpkzNQjdu9BXPpM7cihs0LPdR6
         osbNd8pDtus+twW1HWzgMFCOuIufKALkxjeoOVvvEgBqoNP9E/J3GKvDg4gEhNIZrRgm
         tLa8eXaZK9sxakEnCUU315s3UNB11s3NTRw6krQV2gZvyJ9YikZFQq63xgGzv7LKhKKQ
         h/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9Tp/KtJNwVzuaJhEOKKVEZwK56R14CCcKq5xNubP4Co=;
        b=FYUEL2aDQsp2A0k5PM7oyzPqkaglslfZSRSKH+TuOqUBGl0b0L8EvgSHzxlBsWeNsM
         GDb9YHiuHV7KTHnPtC4QYYlnM/9GHeO0kHXrof6RBWs0FGVhcBFE0ace4EJoCKGxRGRW
         ZuVdOq9oZOzOc0JXrjFhHauv+F3ICitGBtDIkBMJ8HDo8a/bf2HdOljmTm7OpT8e/86P
         Zc7DZQt9ZblYfEK/56hPiEOR+RrOA+sBhV9X1hAcs3Kk3+gwDN/X20D7vIn0N9otmIKQ
         9uR6pl9uiceo69rjATw6oqKtmYkEJuh73ajJpAltNgzJHZ8ntsEpc8q8VNdGjxC7Ri7c
         kTow==
X-Gm-Message-State: APjAAAUNfEWIDFk9IrKPzH6a8/61lLfvnt/bpPQk0kAyyCrzPvWhaJdx
        D7ssvUoom/OVdMlO/KQV5IVE+M6lQZs=
X-Google-Smtp-Source: APXvYqx8efjNP0bbSiQb/kICwMxp8ATbICvyJViJl/7zRxpZX6Bv07cYTFgUdIRAWRSrArtBiwmlgA==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr4716849plo.96.1575485522724;
        Wed, 04 Dec 2019 10:52:02 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id 8sm9303792pfu.21.2019.12.04.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:52:02 -0800 (PST)
Date:   Wed, 04 Dec 2019 10:52:02 -0800 (PST)
X-Google-Original-Date: Wed, 04 Dec 2019 10:36:22 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v5 3/4] RISC-V: Introduce a new config for SBI v0.1
In-Reply-To: <20191126190503.19303-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        alexios.zavras@intel.com, anup@brainfault.org, rppt@linux.ibm.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        han_mao@c-sky.com
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-7f24a6d6-86bd-4e53-a6ec-62687802801d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:05:02 PST (-0800), Atish Patra wrote:
> We now have SBI v0.2 which is more scalable and extendable to handle
> future needs for RISC-V supervisor interfaces.
>
> Introduce a new config and move all SBI v0.1 code under that config.
> This allows to implement the new replacement SBI extensions cleanly
> and remove v0.1 extensions easily in future. Currently, the config
> is enabled by default. Once all M-mode software with v0.1 are no

I'd say "software is", not "software are".  There's at least one more instance
of this.

> longer in use, this config option and all relevant code can be easily
> removed.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
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
>  	  and the task is only allowed to execute a few safe syscalls
>  	  defined by each seccomp mode.
>
> +config RISCV_SBI_V01
> +	bool "SBI v0.1 support"

I don't think presenting this to users as "v0.1" is correct.  I'd expect that
to disable probing and assume the legacy extension always exists, while this
just allows the legacy extension to be used in a v0.2 style.  For example: it's
checking the SBI version, which doesn't exist in v0.1.

There should really be two options here: one to allow the legacy extension set
and one to be compatible with SBI v0.1.  We can deprecate the v0.1 support much
sooner than the legacy extension set.

> +	default y
> +	help
> +	  This config allows kernel to use SBI v0.1 APIs. This will be
> +	  deprecated in future once legacy M-mode software are no longer in use.
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
>  	SBI_EXT_0_1_SET_TIMER = 0x0,
>  	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
>  	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> @@ -19,6 +20,7 @@ enum sbi_ext_id {
>  	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
>  	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
>  	SBI_EXT_0_1_SHUTDOWN = 0x8,
> +#endif
>  	SBI_EXT_BASE = 0x10,
>  };
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index a47e23c3a2e1..ee710bfe0b0e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -8,6 +8,14 @@
>  unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
>
> +static void (*__sbi_set_timer)(uint64_t stime);
> +static int (*__sbi_send_ipi)(const unsigned long *hart_mask);
> +static int (*__sbi_rfence)(unsigned long extid, unsigned long fid,
> +		  const unsigned long *hart_mask,
> +		  unsigned long hbase, unsigned long start,
> +		  unsigned long size, unsigned long arg4,
> +		  unsigned long arg5);
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
> @@ -52,6 +60,32 @@ static int sbi_err_map_linux_errno(int err)
>  	};
>  }
>
> +static void __sbi_set_timer_dummy_warn(uint64_t stime_value)
> +{
> +	pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
> +		sbi_major_version(), sbi_minor_version());
> +}
> +
> +static int __sbi_send_ipi_dummy_warn(const unsigned long *hart_mask)
> +{
> +	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
> +		sbi_major_version(), sbi_minor_version());
> +	return 0;
> +}
> +
> +static int __sbi_rfence_dummy_warn(unsigned long extid,
> +			     unsigned long fid,
> +			     const unsigned long *hart_mask,
> +			     unsigned long hbase, unsigned long start,
> +			     unsigned long size, unsigned long arg4,
> +			     unsigned long arg5)
> +{
> +	pr_warn("remote fence extension is not available in SBI v%lu.%lu\n",
> +		sbi_major_version(), sbi_minor_version());
> +	return 0;
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
> -	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> -			  stime_value >> 32, 0, 0, 0, 0);
> -#else
> -	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> -#endif
> +	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
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
> -	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
> +	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
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
> -	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
> +#if __riscv_xlen == 32
> +	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> +		  stime_value >> 32, 0, 0, 0, 0);
> +#else
> +	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> +#endif
> +}
> +
> +static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +{
> +	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> +		  0, 0, 0, 0, 0);
> +	return 0;
> +}
> +
> +static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
> +			     const unsigned long *hart_mask,
> +			     unsigned long hbase, unsigned long start,
> +			     unsigned long size, unsigned long arg4,
> +			     unsigned long arg5)
> +{
> +	switch (ext) {
> +	case SBI_EXT_0_1_REMOTE_FENCE_I:
> +		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +			  (unsigned long)hart_mask, 0, 0, 0, 0, 0);
> +		break;
> +	case SBI_EXT_0_1_REMOTE_SFENCE_VMA:
> +		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +			  (unsigned long)hart_mask, start, size,
> +			  0, 0, 0);
> +		break;
> +	case SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID:
> +		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +			  (unsigned long)hart_mask, start, size,
> +			  arg4, 0, 0);
> +		break;
> +	default:
> +		pr_err("extid [%lu]not supported in SBI v0.1\n", ext);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static void __sbi_set_timer_v01(uint64_t stime_value)
> +{
> +	__sbi_set_timer_dummy_warn(0);
> +}
> +static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +{
> +	return __sbi_send_ipi_dummy_warn(NULL);
> +}
> +static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
> +			     const unsigned long *hart_mask,
> +			     unsigned long hbase, unsigned long start,
> +			     unsigned long size, unsigned long arg4,
> +			     unsigned long arg5)
> +{
> +	return __sbi_rfence_dummy_warn(0, 0, 0, 0, 0, 0, 0, 0);
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
> +	__sbi_set_timer(stime_value);
>  }
>
>  /**
> @@ -125,11 +224,11 @@ void sbi_clear_ipi(void)
>   */
>  void sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> -			0, 0, 0, 0, 0);
> +	__sbi_send_ipi(hart_mask);
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
> -	sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
> -			0, 0, 0, 0, 0);
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +		     hart_mask, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
>
> @@ -156,8 +255,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  					 unsigned long start,
>  					 unsigned long size)
>  {
> -	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> -			(unsigned long)hart_mask, start, size, 0, 0, 0);
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +		     hart_mask, 0, start, size, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma);
>
> @@ -177,8 +276,8 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  					      unsigned long size,
>  					      unsigned long asid)
>  {
> -	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> -			(unsigned long)hart_mask, start, size, asid, 0, 0);
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +		     hart_mask, 0, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>
> @@ -253,8 +352,15 @@ int __init sbi_init(void)
>
>  	pr_info("SBI specification v%lu.%lu detected\n",
>  		sbi_major_version(), sbi_minor_version());
> -	if (!sbi_spec_is_0_1())
> +
> +	if (!sbi_spec_is_0_1()) {
>  		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
>  			sbi_get_firmware_id(), sbi_get_firmware_version());
> +	}
> +
> +	__sbi_set_timer = __sbi_set_timer_v01;
> +	__sbi_send_ipi	= __sbi_send_ipi_v01;
> +	__sbi_rfence	= __sbi_rfence_v01;
> +
>  	return 0;
>  }
