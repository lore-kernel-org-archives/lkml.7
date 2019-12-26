Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ECC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB6B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/32oSRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfLZIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 03:22:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbfLZIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577348529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u45QA5kCb8jrjmgaYWpglaRd6gLeB/6uNoKzc4qAeGU=;
        b=g/32oSRg03wCb7pREbkQs2I23byv7wn7mSI3B4K7E7+OXNho4AipPoq7GjSMclhqAdJS7c
        0DALcQ0kDiAKQRFN+Y9Neq//4mLqY9nEl3SSPD2/L/f5NpiLhxHmkqCB4za+PzXFWj+aib
        zroTWpX/+jANzZa8DK3aCclK9k/RN7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-sRz-L4G-PJmsjKa8Bg2BjQ-1; Thu, 26 Dec 2019 03:22:08 -0500
X-MC-Unique: sRz-L4G-PJmsjKa8Bg2BjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05A2F107ACC5;
        Thu, 26 Dec 2019 08:22:06 +0000 (UTC)
Received: from [10.72.12.162] (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEA5E108130C;
        Thu, 26 Dec 2019 08:21:15 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <24ef34fd-f4fe-f0eb-33e1-42fad623eee9@redhat.com>
Date:   Thu, 26 Dec 2019 16:21:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> The x86 platform currently only supports specific MSI/MSI-x for PCI
> devices. To enable MSI to the platform devices such as virtio-mmio
> device, this patch enhances x86 with platform MSI by leveraging the
> already built-in platform-msi driver (drivers/base/platform-msi.c)
> and makes it as a configurable option.
>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>   arch/x86/Kconfig                 |  6 ++++
>   arch/x86/include/asm/hw_irq.h    |  5 +++
>   arch/x86/include/asm/irqdomain.h |  9 +++++
>   arch/x86/kernel/apic/msi.c       | 74 +++++++++++++++++++++++++++++++=
+++++++++
>   drivers/base/platform-msi.c      |  4 +--
>   include/linux/msi.h              |  1 +
>   6 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e89499..c1178f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1074,6 +1074,12 @@ config X86_IO_APIC
>   	def_bool y
>   	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
>  =20
> +config X86_PLATFORM_MSI
> +	def_bool y
> +	depends on X86_LOCAL_APIC && X86_64
> +	select GENERIC_MSI_IRQ
> +	select GENERIC_MSI_IRQ_DOMAIN
> +
>   config X86_REROUTE_FOR_BROKEN_BOOT_IRQS
>   	bool "Reroute for broken boot IRQs"
>   	depends on X86_IO_APIC
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_ir=
q.h
> index 4154bc5..5c96b49 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -113,6 +113,11 @@ struct irq_alloc_info {
>   			struct msi_desc *desc;
>   		};
>   #endif
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +		struct {
> +			irq_hw_number_t	platform_msi_hwirq;
> +		};
> +#endif
>   	};
>   };
>  =20
> diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/ir=
qdomain.h
> index c066ffa..b53f51f 100644
> --- a/arch/x86/include/asm/irqdomain.h
> +++ b/arch/x86/include/asm/irqdomain.h
> @@ -56,4 +56,13 @@ extern void mp_irqdomain_deactivate(struct irq_domai=
n *domain,
>   static inline void arch_init_msi_domain(struct irq_domain *domain) { =
}
>   #endif
>  =20
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +extern struct irq_domain *platform_msi_get_def_irq_domain(void);
> +#else
> +static inline struct irq_domain *platform_msi_get_def_irq_domain(void)
> +{
> +	return NULL;
> +}
> +#endif
> +
>   #endif
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 7f75334..ef558c7 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -22,6 +22,10 @@
>   #include <asm/irq_remapping.h>
>  =20
>   static struct irq_domain *msi_default_domain;
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +static struct irq_domain *platform_msi_default_domain;
> +static struct msi_domain_info platform_msi_domain_info;
> +#endif
>  =20
>   static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg=
 *msg)
>   {
> @@ -146,6 +150,17 @@ void __init arch_init_msi_domain(struct irq_domain=
 *parent)
>   	}
>   	if (!msi_default_domain)
>   		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +	fn =3D irq_domain_alloc_named_fwnode("PLATFORM-MSI");
> +	if (fn) {
> +		platform_msi_default_domain =3D
> +			platform_msi_create_irq_domain(fn,
> +				&platform_msi_domain_info, parent);
> +		irq_domain_free_fwnode(fn);
> +	}
> +	if (!platform_msi_default_domain)
> +		pr_warn("failed to initialize irqdomain for PLATFORM-MSI.\n");
> +#endif
>   }
>  =20
>   #ifdef CONFIG_IRQ_REMAP
> @@ -384,3 +399,62 @@ int hpet_assign_irq(struct irq_domain *domain, str=
uct hpet_channel *hc,
>   	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
>   }
>   #endif
> +
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +static void platform_msi_mask_irq(struct irq_data *data)
> +{
> +}
> +
> +static void platform_msi_unmask_irq(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip platform_msi_controller =3D {
> +	.name			=3D "PLATFORM-MSI",
> +	.irq_mask		=3D platform_msi_mask_irq,
> +	.irq_unmask		=3D platform_msi_unmask_irq,
> +	.irq_ack		=3D irq_chip_ack_parent,
> +	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
> +	.irq_compose_msi_msg	=3D irq_msi_compose_msg,
> +	.flags			=3D IRQCHIP_SKIP_SET_WAKE,


Except for irq_msi_compose_msg all the rest were arch independent. Can=20
we have allow arch to specify irq_compose_msi_msg then we can unfiy the=20
rest for all archs?


> +};
> +
> +static int platform_msi_prepare(struct irq_domain *domain, struct devi=
ce *dev,
> +				int nvec, msi_alloc_info_t *arg)
> +{
> +	memset(arg, 0, sizeof(*arg));
> +	return 0;
> +}
> +
> +static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_de=
sc *desc)
> +{
> +	arg->platform_msi_hwirq =3D platform_msi_calc_hwirq(desc);
> +}
> +
> +static irq_hw_number_t platform_msi_get_hwirq(struct msi_domain_info *=
info,
> +					      msi_alloc_info_t *arg)
> +{
> +	return arg->platform_msi_hwirq;
> +}
> +
> +static struct msi_domain_ops platform_msi_domain_ops =3D {
> +	.msi_prepare	=3D platform_msi_prepare,
> +	.set_desc	=3D platform_msi_set_desc,
> +	.get_hwirq	=3D platform_msi_get_hwirq,
> +};
> +
> +static struct msi_domain_info platform_msi_domain_info =3D {
> +	.flags          =3D MSI_FLAG_USE_DEF_DOM_OPS |
> +			  MSI_FLAG_USE_DEF_CHIP_OPS |
> +			  MSI_FLAG_ACTIVATE_EARLY,
> +	.ops            =3D &platform_msi_domain_ops,
> +	.chip           =3D &platform_msi_controller,
> +	.handler        =3D handle_edge_irq,
> +	.handler_name   =3D "edge",
> +};


Is this better to have a virtio-mmio specific domain and irq_chip? It=20
looks to me the advantages are:

- works for all archs
- allow virtio-mmio specific method to do e.g mask/unmask.

Thanks


> +
> +struct irq_domain *platform_msi_get_def_irq_domain(void)
> +{
> +	return platform_msi_default_domain;
> +}
> +#endif
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8da314b..45752f1 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -31,12 +31,11 @@ struct platform_msi_priv_data {
>   /* The devid allocator */
>   static DEFINE_IDA(platform_msi_devid_ida);
>  =20
> -#ifdef GENERIC_MSI_DOMAIN_OPS
>   /*
>    * Convert an msi_desc to a globaly unique identifier (per-device
>    * devid + msi_desc position in the msi_list).
>    */
> -static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>   {
>   	u32 devid;
>  =20
> @@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct=
 msi_desc *desc)
>   	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
>   }
>  =20
> +#ifdef GENERIC_MSI_DOMAIN_OPS
>   static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_d=
esc *desc)
>   {
>   	arg->desc =3D desc;
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..ee5f566 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *do=
main, unsigned int virq,
>   void platform_msi_domain_free(struct irq_domain *domain, unsigned int=
 virq,
>   			      unsigned int nvec);
>   void *platform_msi_get_host_data(struct irq_domain *domain);
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
>   #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  =20
>   #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN

