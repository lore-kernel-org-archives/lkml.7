Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E32C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6766620661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZi4AFAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfLDSwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:52:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39244 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfLDSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:52:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so286901pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tk0l43v3xQFR8poBPdR9szu82nMHPp8tNpA1HzPeXDY=;
        b=DZi4AFAb2uBtHuixQF7vrcYqx0B2nqX2w2D5pUSh9HKy3g5llkuJu6xBqnQ8be76FB
         TDB/UOYKXr/dmWRYtfPIWaD4dVfUg6wP371ZraLk4xG2uctzABKrXAX/+vBj9aLG0A2j
         6xjnodN2WCWJZ6zBs7tPVdMSYKUcKIjRzfkgnGhuglUpRq8Gp/9fNNduDvt9jvNA3K96
         3yQQBmojUunwo9FvnF2OtxTGEFLGHpHqsmf+GbDkTXIlbDeBZWDNV/PkGG37caYTz55k
         U0od8M4BAZ8pf8bicZa/piJU4kaBdPR/cl4UNwa2oacXGHBPRuz7U+i3afcjMdC0bAxO
         t72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tk0l43v3xQFR8poBPdR9szu82nMHPp8tNpA1HzPeXDY=;
        b=uL8Rs5JNdKIq3+eqaubM6Oo7dKkFdJMOxi+Jm9jJf9oTYo+aMGT+TMNnJ3k/pV8vdu
         F7pdOSj7u5i9HEYfcrWFwahjnXx8S3L6gsKyQ1um7ywN+d0dtl2Vfm+KpkChbbds7kBw
         Uf3qfd/x77dE4dic9H1/ihE8TWCB4R2HWXT/VF5/IHTY6SZSgekrMpUsQjrU1P4n+Wrb
         G9UIyDh/d/i7dlOm8ZtIiNpU0qahGqM8M0o8yNBXMFCY1AzOz6bpb6LZg8K++In0YNh+
         GG9nwFTfAqhn6t74ILaflXZKsigdII+ArAs+xoXEIMwG7HX5TGkCIWJjVZ0qL89EFGH4
         NCgw==
X-Gm-Message-State: APjAAAVgk04Qzir1QfBwElj2QQv2vIqD81G80q4VGFcPp5YoIx3Q1Cre
        5rDKPv1i/jorMMRSJNtnJrg1BvcAbTs=
X-Google-Smtp-Source: APXvYqyzdXG/BqcQ8L0TqiD8c3lnOD3dMhQrVlyNFcQGHDqUdDrBadenq6Sr4XrU4rt60XjLojIGGQ==
X-Received: by 2002:aa7:8a83:: with SMTP id a3mr5042698pfc.54.1575485524169;
        Wed, 04 Dec 2019 10:52:04 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id 2sm8284963pgo.79.2019.12.04.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:52:03 -0800 (PST)
Date:   Wed, 04 Dec 2019 10:52:03 -0800 (PST)
X-Google-Original-Date: Wed, 04 Dec 2019 10:51:52 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v5 4/4] RISC-V: Implement new SBI v0.2 extensions
In-Reply-To: <20191126190503.19303-5-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        alexios.zavras@intel.com, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-2ab00082-1bc9-47bd-907a-3caeda9e7502@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:05:03 PST (-0800), Atish Patra wrote:
> Few v0.1 SBI calls are being replaced by new SBI calls that follows
> v0.2 calling convention. The specification changes can be found at
>
> riscv/riscv-sbi-doc#27
>
> Implement the replacement extensions and few additional new SBI
> function calls that makes way for a better SBI interface in future.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/sbi.h |  35 ++++++
>  arch/riscv/kernel/sbi.c      | 208 +++++++++++++++++++++++++++++++++--
>  2 files changed, 236 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index cc82ae63f8e0..54ba9eebec11 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -22,6 +22,9 @@ enum sbi_ext_id {
>  	SBI_EXT_0_1_SHUTDOWN = 0x8,
>  #endif
>  	SBI_EXT_BASE = 0x10,
> +	SBI_EXT_TIME = 0x54494D45,
> +	SBI_EXT_IPI = 0x735049,
> +	SBI_EXT_RFENCE = 0x52464E43,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -34,6 +37,24 @@ enum sbi_ext_base_fid {
>  	SBI_BASE_GET_MIMPID,
>  };
>
> +enum sbi_ext_time_fid {
> +	SBI_EXT_TIME_SET_TIMER = 0,
> +};
> +
> +enum sbi_ext_ipi_fid {
> +	SBI_EXT_IPI_SEND_IPI = 0,
> +};
> +
> +enum sbi_ext_rfence_fid {
> +	SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> +	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_OFFSET	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> @@ -74,6 +95,20 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  				unsigned long start,
>  				unsigned long size,
>  				unsigned long asid);
> +int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +			   unsigned long start,
> +			   unsigned long size);
> +int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> +				unsigned long start,
> +				unsigned long size,
> +				unsigned long vmid);
> +int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +			   unsigned long start,
> +			   unsigned long size);
> +int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> +				unsigned long start,
> +				unsigned long size,
> +				unsigned long asid);
>  int sbi_probe_extension(long ext);
>
>  /* Check if current SBI specification version is 0.1 or not */
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index ee710bfe0b0e..af3d5f8d8af7 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -205,6 +205,101 @@ static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
>  }
>  #endif /* CONFIG_RISCV_SBI_V01 */
>
> +static void __sbi_set_timer_v02(uint64_t stime_value)
> +{
> +#if __riscv_xlen == 32
> +	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
> +			  stime_value >> 32, 0, 0, 0, 0);
> +#else
> +	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value, 0,
> +		  0, 0, 0, 0);
> +#endif
> +}
> +
> +static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
> +{
> +	unsigned long hmask_val;
> +	struct sbiret ret = {0};
> +	int result;
> +
> +	if (!hart_mask)
> +		hmask_val = *(cpumask_bits(cpu_online_mask));
> +	else
> +		hmask_val = *hart_mask;
> +
> +	ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI, hmask_val,
> +			0, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_err("%s: failed with error [%d]\n", __func__,
> +			sbi_err_map_linux_errno(ret.error));
> +		result = ret.error;
> +	} else
> +		result = ret.value;
> +
> +	return result;
> +}
> +
> +static int __sbi_rfence_v02(unsigned long extid, unsigned long fid,
> +			     const unsigned long *hart_mask,
> +			     unsigned long hbase, unsigned long start,
> +			     unsigned long size, unsigned long arg4,
> +			     unsigned long arg5)
> +{
> +	unsigned long hmask_val;
> +	struct sbiret ret = {0};
> +	int result;
> +	unsigned long ext = SBI_EXT_RFENCE;
> +
> +	if (!hart_mask)
> +		hmask_val = *(cpumask_bits(cpu_online_mask));

This needs to map from CPUs to harts.  Even if we're frobbing all of the harts
they might still be different.

> +	else
> +		hmask_val = *hart_mask;
> +
> +	switch (fid) {
> +	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, 0, 0, 0, 0);
> +		break;
> +	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, 0, 0);
> +		break;
> +	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, arg4, 0);
> +		break;
> +	/*TODO: Handle non zero hbase cases */
> +	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, 0, 0);
> +		break;
> +	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, arg4, 0);
> +		break;
> +	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, 0, 0);
> +		break;
> +	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
> +		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +				size, arg4, 0);
> +		break;
> +	default:
> +		pr_err("unknown function ID [%lu] for SBI extension [%lu]\n",
> +			fid, ext);
> +		result = -EINVAL;
> +	}
> +
> +	if (ret.error) {
> +		pr_err("%s: failed with error [%d]\n", __func__,
> +			sbi_err_map_linux_errno(ret.error));
> +		result = ret.error;
> +	} else
> +		result = ret.value;
> +
> +	return result;
> +}
> +
>  /**
>   * sbi_set_timer() - Program the timer for next timer event.
>   * @stime_value: The value after which next timer event should fire.
> @@ -237,7 +332,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
>   */
>  void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, SBI_EXT_RFENCE_REMOTE_FENCE_I,
>  		     hart_mask, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
> @@ -255,7 +350,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  					 unsigned long start,
>  					 unsigned long size)
>  {
> -	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA,
> +		     SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
>  		     hart_mask, 0, start, size, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma);
> @@ -276,11 +372,93 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  					      unsigned long size,
>  					      unsigned long asid)
>  {
> -	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID,
> +		     SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
>  		     hart_mask, 0, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>
> +/**
> + * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on given remote
> + *			   harts for the specified guest physical address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the guest physical address
> + * @size: Total size of the guest physical address range.
> + *
> + * Return: None
> + */
> +int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +					 unsigned long start,
> +					 unsigned long size)
> +{
> +	return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +			    hart_mask, 0, start, size, 0, 0);
> +}
> +EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
> +
> +/**
> + * sbi_remote_hfence_gvma_vmid() - Execute HFENCE.GVMA instructions on given
> + * remote harts for a guest physical address range belonging to a specific VMID.
> + *
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the guest physical address
> + * @size: Total size of the guest physical address range.
> + * @vmid: The value of guest ID (VMID).
> + *
> + * Return: 0 if success, Error otherwise.
> + */
> +int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> +					      unsigned long start,
> +					      unsigned long size,
> +					      unsigned long vmid)
> +{
> +	return __sbi_rfence(SBI_EXT_RFENCE,
> +			    SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +			    hart_mask, 0, start, size, vmid, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
> +
> +/**
> + * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on given remote
> + *			     harts for the current guest virtual address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the current guest virtual address
> + * @size: Total size of the current guest virtual address range.
> + *
> + * Return: None
> + */
> +int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +					 unsigned long start,
> +					 unsigned long size)
> +{
> +	return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +			    hart_mask, 0, start, size, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_hfence_vvma);
> +
> +/**
> + * sbi_remote_hfence_vvma_asid() - Execute HFENCE.VVMA instructions on given
> + * remote harts for current guest virtual address range belonging to a specific
> + * ASID.
> + *
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the current guest virtual address
> + * @size: Total size of the current guest virtual address range.
> + * @asid: The value of address space identifier (ASID).
> + *
> + * Return: None
> + */
> +int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> +					      unsigned long start,
> +					      unsigned long size,
> +					      unsigned long asid)
> +{
> +	return __sbi_rfence(SBI_EXT_RFENCE,
> +			    SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +			    hart_mask, 0, start, size, asid, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>   * @extid: The extension ID to be probed.
> @@ -356,11 +534,27 @@ int __init sbi_init(void)
>  	if (!sbi_spec_is_0_1()) {
>  		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
>  			sbi_get_firmware_id(), sbi_get_firmware_version());
> +		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
> +			__sbi_set_timer = __sbi_set_timer_v02;
> +			pr_info("SBI v0.2 TIME extension detected\n");
> +		} else
> +			__sbi_set_timer = __sbi_set_timer_dummy_warn;
> +		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
> +			__sbi_send_ipi	= __sbi_send_ipi_v02;
> +			pr_info("SBI v0.2 IPI extension detected\n");
> +		} else
> +			__sbi_send_ipi = __sbi_send_ipi_dummy_warn;
> +		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
> +			__sbi_rfence	= __sbi_rfence_v02;
> +			pr_info("SBI v0.2 RFENCE extension detected\n");
> +		} else
> +			__sbi_rfence	= __sbi_rfence_dummy_warn;
> +
> +	} else {
> +		__sbi_set_timer = __sbi_set_timer_v01;
> +		__sbi_send_ipi	= __sbi_send_ipi_v01;
> +		__sbi_rfence	= __sbi_rfence_v01;
>  	}
>
> -	__sbi_set_timer = __sbi_set_timer_v01;
> -	__sbi_send_ipi	= __sbi_send_ipi_v01;
> -	__sbi_rfence	= __sbi_rfence_v01;
> -
>  	return 0;
>  }

This will have to change around when disentangling the legacy vs v0.1 stuff.
