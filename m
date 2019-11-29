Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4457EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA04215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="h2rj20dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfK2EvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 23:51:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42460 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfK2EvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 23:51:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so33408548wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 20:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdY7u7a+XX1itabh0a1A9nGIb1MHBiIbHIevLAYYk5Y=;
        b=h2rj20dR38znKCTuxg59IvMUk0PO48rh3puB8qDg1myf9bccqDnbLYGdvIuR99sIwV
         zjiUHB1HCH9MykoXvG1ExvW7upNLiYNljTMFgc+cz/rZs8AhbnFAHYKg/Ku6w+/7gRc4
         vgBYuGl2Q4KWMVbtNQPeY2y/6+M7EpTsK+NYdMvUeA0H3RIiMCzm0GjQeLAEf3uf71qa
         gpEWZydczv8S/tealY+ojbmUE1gf5Q/0ZoFRFK5MbDQLBi7i+7YpHS9JRF2RoSovolkH
         1pdzwga7HLHLyxZoTc6yoyqaQt6i9xA5AtS5LbYB4cInO0bYEEM17dpuQCx38CRuDla4
         JYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdY7u7a+XX1itabh0a1A9nGIb1MHBiIbHIevLAYYk5Y=;
        b=sB19L6rNEg8dwHDe5Baxi/AxPWQgBUIpMEu/+9ge9RusE7Vb2BMc0HgxVjJ0QCIV3/
         MqyDKF0sD4JfbAuTr5aKwGq5yO1pJTWKdZD7aCWaeV9uaA7mODyox46ZvQhRLckP95ue
         OymfSh1gUlDUoT09MCHbdVHf9JrDWSOCwUciXmTbkuWuC0xNnlAIfgT5hiq+6A1Y4c2z
         HaLY0PfVRs81gz3lAC85gepsROJk1W3nQE113i1rAQZW8uxmuFM1S2fQIqDqFK4fLZmF
         RYb0ESceqgzUg/c9OSCplfl+aI93Np+umXLJhbjEfRxXieiyWJiWcJxpOFpjFgMNV+wk
         BF+Q==
X-Gm-Message-State: APjAAAVxAR8HB8a4sVxu0l3LdIReamzlZAS8pSWtmE4HBO0Lc3mPhG0W
        EfRhYIOigLKoUwx0hCoNwR6PHxf14VPB0XG0Uq6QhA==
X-Google-Smtp-Source: APXvYqyyrjGCKsDUFX4VK1UjxeVxbyyEAm4G7+57KA050ZsvTf4lx4SUE/Qs6eTmXEhiGhVH7wkItmhCOGCqI3ApNxQ=
X-Received: by 2002:adf:b746:: with SMTP id n6mr51390324wre.65.1575003075195;
 Thu, 28 Nov 2019 20:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20191126190503.19303-1-atish.patra@wdc.com> <20191126190503.19303-5-atish.patra@wdc.com>
In-Reply-To: <20191126190503.19303-5-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 Nov 2019 10:21:03 +0530
Message-ID: <CAAhSdy1WP0K+v-Nk9CJ9phVTiUR9RTUATwV-Qk_tTg6MjE_rrQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RISC-V: Implement new SBI v0.2 extensions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
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

Hi Atish,

Found few bugs while playing with this patch.

See below ....

On Wed, Nov 27, 2019 at 12:35 AM Atish Patra <atish.patra@wdc.com> wrote:
>
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
>         SBI_EXT_0_1_SHUTDOWN = 0x8,
>  #endif
>         SBI_EXT_BASE = 0x10,
> +       SBI_EXT_TIME = 0x54494D45,
> +       SBI_EXT_IPI = 0x735049,
> +       SBI_EXT_RFENCE = 0x52464E43,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -34,6 +37,24 @@ enum sbi_ext_base_fid {
>         SBI_BASE_GET_MIMPID,
>  };
>
> +enum sbi_ext_time_fid {
> +       SBI_EXT_TIME_SET_TIMER = 0,
> +};
> +
> +enum sbi_ext_ipi_fid {
> +       SBI_EXT_IPI_SEND_IPI = 0,
> +};
> +
> +enum sbi_ext_rfence_fid {
> +       SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> +       SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +       SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_OFFSET  24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> @@ -74,6 +95,20 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                                 unsigned long start,
>                                 unsigned long size,
>                                 unsigned long asid);
> +int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +                          unsigned long start,
> +                          unsigned long size);
> +int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> +                               unsigned long start,
> +                               unsigned long size,
> +                               unsigned long vmid);
> +int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +                          unsigned long start,
> +                          unsigned long size);
> +int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> +                               unsigned long start,
> +                               unsigned long size,
> +                               unsigned long asid);
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
> +       sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
> +                         stime_value >> 32, 0, 0, 0, 0);
> +#else
> +       sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value, 0,
> +                 0, 0, 0, 0);
> +#endif
> +}
> +
> +static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
> +{
> +       unsigned long hmask_val;
> +       struct sbiret ret = {0};
> +       int result;
> +
> +       if (!hart_mask)
> +               hmask_val = *(cpumask_bits(cpu_online_mask));
> +       else
> +               hmask_val = *hart_mask;
> +
> +       ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI, hmask_val,
> +                       0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_err("%s: failed with error [%d]\n", __func__,
> +                       sbi_err_map_linux_errno(ret.error));
> +               result = ret.error;
> +       } else
> +               result = ret.value;
> +
> +       return result;
> +}
> +
> +static int __sbi_rfence_v02(unsigned long extid, unsigned long fid,
> +                            const unsigned long *hart_mask,
> +                            unsigned long hbase, unsigned long start,
> +                            unsigned long size, unsigned long arg4,
> +                            unsigned long arg5)
> +{
> +       unsigned long hmask_val;
> +       struct sbiret ret = {0};
> +       int result;
> +       unsigned long ext = SBI_EXT_RFENCE;
> +
> +       if (!hart_mask)
> +               hmask_val = *(cpumask_bits(cpu_online_mask));
> +       else
> +               hmask_val = *hart_mask;
> +
> +       switch (fid) {
> +       case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, 0, 0, 0, 0);
> +               break;
> +       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, 0, 0);
> +               break;
> +       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, arg4, 0);
> +               break;
> +       /*TODO: Handle non zero hbase cases */
> +       case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, 0, 0);
> +               break;
> +       case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, arg4, 0);
> +               break;
> +       case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, 0, 0);
> +               break;
> +       case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
> +               ret = sbi_ecall(ext, fid, hmask_val, 0, start,
> +                               size, arg4, 0);
> +               break;
> +       default:
> +               pr_err("unknown function ID [%lu] for SBI extension [%lu]\n",
> +                       fid, ext);
> +               result = -EINVAL;
> +       }
> +
> +       if (ret.error) {
> +               pr_err("%s: failed with error [%d]\n", __func__,
> +                       sbi_err_map_linux_errno(ret.error));
> +               result = ret.error;
> +       } else
> +               result = ret.value;
> +
> +       return result;
> +}
> +
>  /**
>   * sbi_set_timer() - Program the timer for next timer event.
>   * @stime_value: The value after which next timer event should fire.
> @@ -237,7 +332,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
>   */
>  void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -       __sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, SBI_EXT_RFENCE_REMOTE_FENCE_I,
>                      hart_mask, 0, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
> @@ -255,7 +350,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>                                          unsigned long start,
>                                          unsigned long size)
>  {
> -       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA,
> +                    SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
>                      hart_mask, 0, start, size, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma);
> @@ -276,11 +372,93 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                                               unsigned long size,
>                                               unsigned long asid)
>  {
> -       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> +       __sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID,
> +                    SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
>                      hart_mask, 0, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>
> +/**
> + * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on given remote
> + *                        harts for the specified guest physical address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the guest physical address
> + * @size: Total size of the guest physical address range.
> + *
> + * Return: None
> + */
> +int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +                                        unsigned long start,
> +                                        unsigned long size)
> +{
> +       return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +                           hart_mask, 0, start, size, 0, 0);
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
> +                                             unsigned long start,
> +                                             unsigned long size,
> +                                             unsigned long vmid)
> +{
> +       return __sbi_rfence(SBI_EXT_RFENCE,
> +                           SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +                           hart_mask, 0, start, size, vmid, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
> +
> +/**
> + * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on given remote
> + *                          harts for the current guest virtual address range.
> + * @hart_mask: A cpu mask containing all the target harts.
> + * @start: Start of the current guest virtual address
> + * @size: Total size of the current guest virtual address range.
> + *
> + * Return: None
> + */
> +int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +                                        unsigned long start,
> +                                        unsigned long size)
> +{
> +       return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +                           hart_mask, 0, start, size, 0, 0);
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
> +                                             unsigned long start,
> +                                             unsigned long size,
> +                                             unsigned long asid)
> +{
> +       return __sbi_rfence(SBI_EXT_RFENCE,
> +                           SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +                           hart_mask, 0, start, size, asid, 0);
> +}
> +EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>   * @extid: The extension ID to be probed.
> @@ -356,11 +534,27 @@ int __init sbi_init(void)
>         if (!sbi_spec_is_0_1()) {
>                 pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
>                         sbi_get_firmware_id(), sbi_get_firmware_version());
> +               if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
> +                       __sbi_set_timer = __sbi_set_timer_v02;
> +                       pr_info("SBI v0.2 TIME extension detected\n");
> +               } else
> +                       __sbi_set_timer = __sbi_set_timer_dummy_warn;
This should be:

#if IS_ENABLED(RISCV_SBI_V01)
                       __sbi_rfence    = __sbi_set_timer_v01;
#else
                       __sbi_rfence    = __sbi_set_timer_dummy_warn;
#endif

> +               if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
> +                       __sbi_send_ipi  = __sbi_send_ipi_v02;
> +                       pr_info("SBI v0.2 IPI extension detected\n");
> +               } else
> +                       __sbi_send_ipi = __sbi_send_ipi_dummy_warn;
This should be:

#if IS_ENABLED(RISCV_SBI_V01)
                       __sbi_rfence    = __sbi_ipi_v01;
#else
                       __sbi_rfence    = __sbi_send_ipi_dummy_warn;
#endif

> +               if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
> +                       __sbi_rfence    = __sbi_rfence_v02;
> +                       pr_info("SBI v0.2 RFENCE extension detected\n");
> +               } else
> +                       __sbi_rfence    = __sbi_rfence_dummy_warn;
This should be:

#if IS_ENABLED(RISCV_SBI_V01)
                       __sbi_rfence    = __sbi_rfence_v01;
#else
                       __sbi_rfence    = __sbi_rfence_dummy_warn;
#endif

> +
> +       } else {
> +               __sbi_set_timer = __sbi_set_timer_v01;
> +               __sbi_send_ipi  = __sbi_send_ipi_v01;
> +               __sbi_rfence    = __sbi_rfence_v01;

This should be:

#if IS_ENABLED(RISCV_SBI_V01)
               __sbi_set_timer = __sbi_set_timer_v01;
               __sbi_send_ipi  = __sbi_send_ipi_v01;
               __sbi_rfence    = __sbi_rfence_v01;
#else
               __sbi_set_timer = __sbi_set_timer_dummy_warn;
               __sbi_send_ipi  = __sbi_send_ipi_dummy_warn;
               __sbi_rfence    = __sbi_rfence_dummy_warn;
#endif
>         }
>
> -       __sbi_set_timer = __sbi_set_timer_v01;
> -       __sbi_send_ipi  = __sbi_send_ipi_v01;
> -       __sbi_rfence    = __sbi_rfence_v01;
> -
>         return 0;
>  }
> --
> 2.23.0
>

Regards,
Anup
