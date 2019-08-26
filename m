Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE1C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379F22186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IA9lp4gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfHZV3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:29:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43916 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfHZV3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:29:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id h13so28359667edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=irmPiXV6xMb94N1TWBMVdjC+CksYI3/837tqSXMotXI=;
        b=IA9lp4gQRx2gyfXmziKHHZV62IJhQFfo3kge7R70TpohrPCjPv7YE+m0odk8ubx6XZ
         T8/hjPQCSndGhCg4mTs2oY+QMBVRf6pzG2/MdXlYwANI6YD3OEz5cN19N+bsMwJsy8L+
         iccZKGeT5vRw50zWuXvTpih7FW3dPIDNZn8s4CCrxTHo3Rq4QRwd5v2d+OszIQuHmdpG
         37y9qRIRCVI6/n7EQ0GxLvLHx5I8o9FYqm0rRAQRKTSJPMpebsQxltuLWMSV4oU6HvE2
         HmcskH5P4lXTXv1SMXmIMXoRX8eWVYeWZm46/rq4aIoFO07sLNH47vgZk7jW0DBX5taZ
         d1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=irmPiXV6xMb94N1TWBMVdjC+CksYI3/837tqSXMotXI=;
        b=kzio4OiFOUDFWP98cv0osCGLO5JM0K7bN28P35KNJ4uA8n/iFylkzF+X/Yi/oao8tz
         VIaEsaAg3U0UsppU6UqRv3f+OiM1m3NUb6r513uRiugpgmCvT7B0PHE1O+RlCnK3IAWh
         ZJ2eWFJft6d8DVIp95VTxPL1jVj0AQI+4SmheGhWJ5e1ZgLEe94mih6cwNvl2wNtK3B+
         zncE230/nxLZS6wuOGJfmxAjbRx2pzZGpfxtu+MWO47sWQ62Ghjc4xXYSO2ujN6rkkwy
         YgY/LLxu+Te3U/XPGSRuolcT9JGG3SBAuNPznpl9F+CbExfTiEGKgCC8bfuqErZ+ozK2
         XdGw==
X-Gm-Message-State: APjAAAVfjjIrHguxXjUvvO+XnKvVPpMFshroLbh0G7NGSqJvpB1d+XfH
        YtLkaI5NwHnZeNyV/5muM8VmCTsBSFO8pJlTO6sWFA==
X-Google-Smtp-Source: APXvYqyPUbPVLPRVGlxnyfKkABjtJwt/nypaoGxZPNMI7YKzSdzC8N2ue4PDBfXMa7J57EnWz0DzMTk4z4qERx/JCcw=
X-Received: by 2002:a50:9ea1:: with SMTP id a30mr21320762edf.304.1566854976172;
 Mon, 26 Aug 2019 14:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190826190056.27854-1-pasha.tatashin@soleen.com> <20190826190056.27854-6-pasha.tatashin@soleen.com>
In-Reply-To: <20190826190056.27854-6-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 26 Aug 2019 17:29:25 -0400
Message-ID: <CA+CK2bDXpoRV=1hD50E6FKJry=hRcyxkwbf4fq_PdFRPYCM3UQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] rqchip/gic-v3-its: move reset pending table
 outside of allocator
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch requires a small fix (which I will do in later revisions):

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ffdb3927549..c9faeac4b3a8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2182,7 +2182,8 @@ static void its_cpu_init_lpis(void)
                paddr &= GENMASK_ULL(51, 16);

                WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
-               its_free_pending_table(gic_data_rdist()->pend_page);
+               if (efi_enabled(EFI_CONFIG_TABLES))
+                       its_free_pending_table(gic_data_rdist()->pend_page);
                gic_data_rdist()->pend_page = NULL;

                goto out;

reserved-memory does not need to be freed. However, I am confused why
it is needed to be freed in EFI case. Marc, can you please explain
this to me?

Thank you,
Pasha

On Mon, Aug 26, 2019 at 3:01 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Allow to use reserved memory for interrupt controller tables.
>
> Currently, it is not possible to do kexec reboots without possible memory
> corruption using device tree and GICv3 interrupt controller.
>
> GICv3 can be configured once during boot, and location of tables cannot
> be changed thereafter.
>
> The fix is to allow to reserve memory region in interrupt controller device
> property, and use it to do allocations.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 82 ++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index d5f3508ca11f..aeda8760cc4e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -47,6 +47,54 @@
>
>  static u32 lpi_id_bits;
>
> +/*
> + * Describes reserved memory region in interrupt controller.
> + * The memory reserved: [pa_start, pa_end)
> + */
> +struct of_resv {
> +       unsigned long pa_start;
> +       unsigned long pa_end;
> +};
> +
> +static struct page __init *get_of_page(struct of_resv *resv, unsigned long size)
> +{
> +       unsigned long pa = ALIGN(resv->pa_start, size);
> +       unsigned long pa_next = pa + size;
> +
> +       /* Check if there is enough memory reserved to do another allocation */
> +       if (pa_next > resv->pa_end)
> +               return NULL;
> +
> +       resv->pa_start = pa_next;
> +       memset(phys_to_virt(pa), 0, size);
> +
> +       return phys_to_page(pa);
> +}
> +
> +/*
> + * Memory controller might have a reserved memory region to be used for table
> + * allocations. This is a requirement for kexec reboots.
> + */
> +static void __init its_of_mem_region(struct device_node *node,
> +                                    struct of_resv **resv,
> +                                    struct of_resv *resv_buf)
> +{
> +       struct device_node *np = of_parse_phandle(node, "memory-region", 0);
> +       struct resource mem_res;
> +
> +       if (!np)
> +               return;
> +
> +       if (of_address_to_resource(np, 0, &mem_res)) {
> +               pr_warn("%pOF: address to resource failed\n", np);
> +               return;
> +       }
> +
> +       resv_buf->pa_start = mem_res.start;
> +       resv_buf->pa_end = mem_res.start + resource_size(&mem_res);
> +       *resv = resv_buf;
> +}
> +
>  /*
>   * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
>   * deal with (one configuration byte per interrupt). PENDBASE has to
> @@ -1665,7 +1713,7 @@ static int gic_reserve_range(phys_addr_t addr, unsigned long size)
>         return 0;
>  }
>
> -static int __init its_setup_lpi_prop_table(void)
> +static int __init its_setup_lpi_prop_table(struct of_resv *resv)
>  {
>         if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
>                 unsigned long pa;
> @@ -1676,7 +1724,10 @@ static int __init its_setup_lpi_prop_table(void)
>                 lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
>
>                 pa = val & GENMASK_ULL(51, 12);
> -               va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
> +               if (resv)
> +                       va = phys_to_virt(pa);
> +               else
> +                       va = memremap(pa, LPI_PROPBASE_SZ, MEMREMAP_WB);
>                 gic_rdists->prop_table_pa = pa;
>                 gic_rdists->prop_table_va = va;
>         } else {
> @@ -1685,7 +1736,10 @@ static int __init its_setup_lpi_prop_table(void)
>                 lpi_id_bits = min_t(u32,
>                                     GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
>                                     ITS_MAX_LPI_NRBITS);
> -               page = its_allocate_prop_table(GFP_NOWAIT);
> +               if (resv)
> +                       page = get_of_page(resv, LPI_PROPBASE_SZ);
> +               else
> +                       page = its_allocate_prop_table(GFP_NOWAIT);
>                 if (!page) {
>                         pr_err("Failed to allocate PROPBASE\n");
>                         return -ENOMEM;
> @@ -2009,7 +2063,8 @@ static void its_free_pending_table(struct page *pt)
>
>  /*
>   * Booting with kdump and LPIs enabled is generally fine. Any other
> - * case is wrong in the absence of firmware/EFI support.
> + * case is wrong in the absence of firmware/EFI support or reserve-memory
> + * in device tree for interrupt controller.
>   */
>  static bool enabled_lpis_allowed(void)
>  {
> @@ -2023,7 +2078,7 @@ static bool enabled_lpis_allowed(void)
>         return gic_check_reserved_range(addr, LPI_PROPBASE_SZ);
>  }
>
> -static int __init allocate_lpi_tables(void)
> +static int __init allocate_lpi_tables(struct of_resv *resv)
>  {
>         u64 val;
>         int err, cpu;
> @@ -2039,7 +2094,7 @@ static int __init allocate_lpi_tables(void)
>                 pr_info("GICv3: Using preallocated redistributor tables\n");
>         }
>
> -       err = its_setup_lpi_prop_table();
> +       err = its_setup_lpi_prop_table(resv);
>         if (err)
>                 return err;
>
> @@ -2051,7 +2106,10 @@ static int __init allocate_lpi_tables(void)
>         for_each_possible_cpu(cpu) {
>                 struct page *pend_page;
>
> -               pend_page = its_allocate_pending_table(GFP_NOWAIT);
> +               if (resv)
> +                       pend_page = get_of_page(resv, LPI_PENDBASE_SZ);
> +               else
> +                       pend_page = its_allocate_pending_table(GFP_NOWAIT);
>                 if (!pend_page) {
>                         pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
>                         return -ENOMEM;
> @@ -3957,16 +4015,20 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>                     struct irq_domain *parent_domain)
>  {
>         struct device_node *of_node;
> +       struct of_resv resv_buf;
> +       struct of_resv *resv = NULL;
>         struct its_node *its;
>         bool has_v4 = false;
>         int err;
>
>         its_parent = parent_domain;
>         of_node = to_of_node(handle);
> -       if (of_node)
> +       if (of_node) {
>                 its_of_probe(of_node);
> -       else
> +               its_of_mem_region(of_node, &resv, &resv_buf);
> +       } else {
>                 its_acpi_probe();
> +       }
>
>         if (list_empty(&its_nodes)) {
>                 pr_warn("ITS: No ITS available, not enabling LPIs\n");
> @@ -3975,7 +4037,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>
>         gic_rdists = rdists;
>
> -       err = allocate_lpi_tables();
> +       err = allocate_lpi_tables(resv);
>         if (err)
>                 return err;
>
> --
> 2.23.0
>
