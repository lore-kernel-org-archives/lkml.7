Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54600ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DC42053B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfJGPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:22:12 -0400
Received: from gecko.sbs.de ([194.138.37.40]:47925 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:22:11 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x97FLk7N003194
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 17:21:46 +0200
Received: from [139.23.77.210] ([139.23.77.210])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x97FKInq030040;
        Mon, 7 Oct 2019 17:20:18 +0200
Subject: Re: [PATCH v5 2/2] x86/jailhouse: Only enable platform UARTs if
 available
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
 <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <26021872-8be0-566f-870e-bddbaf2b0dd4@siemens.com>
Date:   Mon, 7 Oct 2019 17:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.19 14:38, Ralf Ramsauer wrote:
> ACPI tables aren't available if Linux runs as guest of the hypervisor
> Jailhouse. This makes the 8250 driver probe for all platform UARTs as
> it assumes that all platform are present in case of !ACPI. Jailhouse
> will stop execution of Linux guest due to port access violation.
> 
> So far, these access violations could be solved by tuning the
> 8250.nr_uarts parameter but it has limitations: We can, e.g., only map
> consecutive platform UARTs to Linux, and only in the sequence 0x3f8,
> 0x2f8, 0x3e8, 0x2e8.
> 
> Beginning from setup_data version 2, Jailhouse will place information of
> available platform UARTs in setup_data. This allows for selective
> activation of platform UARTs.
> 
> This patch queries the setup_data version and activates only available
> UARTS. It comes with backward compatibility, and will still support
> older setup_data versions. In this case, Linux falls back to the old
> behaviour.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
>  arch/x86/include/uapi/asm/bootparam.h |  3 +
>  arch/x86/kernel/jailhouse.c           | 83 +++++++++++++++++++++++----
>  2 files changed, 74 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 43be437c9c71..db1e24e56e94 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -152,6 +152,9 @@ struct jailhouse_setup_data {
>  		__u8	standard_ioapic;
>  		__u8	cpu_ids[255];
>  	} __attribute__((packed)) v1;
> +	struct {
> +		__u32	flags;
> +	} __attribute__((packed)) v2;
>  } __attribute__((packed));
>  
>  /* The so-called "zeropage" */
> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> index b9647add0063..95550c08ab23 100644
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi_pmtmr.h>
>  #include <linux/kernel.h>
>  #include <linux/reboot.h>
> +#include <linux/serial_8250.h>
>  #include <asm/apic.h>
>  #include <asm/cpu.h>
>  #include <asm/hypervisor.h>
> @@ -23,9 +24,22 @@
>  
>  static __initdata struct jailhouse_setup_data setup_data;
>  #define SETUP_DATA_V1_LEN	(sizeof(setup_data.hdr) + sizeof(setup_data.v1))
> +#define SETUP_DATA_V2_LEN	(SETUP_DATA_V1_LEN + sizeof(setup_data.v2))
>  
>  static unsigned int precalibrated_tsc_khz;
>  
> +static void jailhouse_setup_irq(unsigned int irq)
> +{
> +	struct mpc_intsrc mp_irq = {
> +		.type		= MP_INTSRC,
> +		.irqtype	= mp_INT,
> +		.irqflag	= MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
> +		.srcbusirq	= irq,
> +		.dstirq		= irq,
> +	};
> +	mp_save_irq(&mp_irq);
> +}
> +
>  static uint32_t jailhouse_cpuid_base(void)
>  {
>  	if (boot_cpu_data.cpuid_level < 0 ||
> @@ -79,11 +93,6 @@ static void __init jailhouse_get_smp_config(unsigned int early)
>  		.type = IOAPIC_DOMAIN_STRICT,
>  		.ops = &mp_ioapic_irqdomain_ops,
>  	};
> -	struct mpc_intsrc mp_irq = {
> -		.type = MP_INTSRC,
> -		.irqtype = mp_INT,
> -		.irqflag = MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
> -	};
>  	unsigned int cpu;
>  
>  	jailhouse_x2apic_init();
> @@ -100,12 +109,12 @@ static void __init jailhouse_get_smp_config(unsigned int early)
>  	if (setup_data.v1.standard_ioapic) {
>  		mp_register_ioapic(0, 0xfec00000, gsi_top, &ioapic_cfg);
>  
> -		/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
> -		mp_irq.srcbusirq = mp_irq.dstirq = 3;
> -		mp_save_irq(&mp_irq);
> -
> -		mp_irq.srcbusirq = mp_irq.dstirq = 4;
> -		mp_save_irq(&mp_irq);
> +		if (IS_ENABLED(CONFIG_SERIAL_8250) &&
> +		    setup_data.hdr.version < 2) {
> +			/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
> +			jailhouse_setup_irq(3);
> +			jailhouse_setup_irq(4);
> +		}
>  	}
>  }
>  
> @@ -138,6 +147,53 @@ static int __init jailhouse_pci_arch_init(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SERIAL_8250
> +static bool jailhouse_uart_enabled(unsigned int uart_nr)
> +{
> +	return setup_data.v2.flags & BIT(uart_nr);
> +}
> +
> +static void jailhouse_serial_fixup(int port, struct uart_port *up,
> +				   u32 *capabilities)
> +{
> +	static const u16 pcuart_base[] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
> +	unsigned int n;
> +
> +	for (n = 0; n < ARRAY_SIZE(pcuart_base); n++) {
> +		if (pcuart_base[n] != up->iobase)
> +			continue;
> +
> +		if (jailhouse_uart_enabled(n)) {
> +			pr_info("Enabling UART%u (port 0x%lx)\n", n,
> +				up->iobase);
> +			jailhouse_setup_irq(up->irq);
> +		} else {
> +			/* Deactivate UART if access isn't allowed */
> +			up->iobase = 0;
> +		}
> +		break;
> +	}
> +}
> +
> +static void jailhouse_serial_workaround(void)
> +{
> +	/*
> +	 * There are flags inside setup_data that indicate availability of
> +	 * platform UARTs since setup data version 2.
> +	 *
> +	 * In case of version 1, we don't know which UARTs belong Linux. In
> +	 * this case, unconditionally register 1:1 mapping for legacy UART IRQs
> +	 * 3 and 4.
> +	 */
> +	if (setup_data.hdr.version > 1)
> +		serial8250_set_isa_configurator(jailhouse_serial_fixup);
> +}
> +#else /* !CONFIG_SERIAL_8250 */
> +static inline void jailhouse_serial_workaround(void)
> +{
> +}
> +#endif /* CONFIG_SERIAL_8250 */
> +
>  static void __init jailhouse_init_platform(void)
>  {
>  	u64 pa_data = boot_params.hdr.setup_data;
> @@ -188,7 +244,8 @@ static void __init jailhouse_init_platform(void)
>  	if (setup_data.hdr.version == 0 ||
>  	    setup_data.hdr.compatible_version !=
>  		JAILHOUSE_SETUP_REQUIRED_VERSION ||
> -	    (setup_data.hdr.version >= 1 && header.len < SETUP_DATA_V1_LEN))
> +	    (setup_data.hdr.version == 1 && header.len < SETUP_DATA_V1_LEN) ||
> +	    (setup_data.hdr.version >= 2 && header.len < SETUP_DATA_V2_LEN))
>  		goto unsupported;
>  
>  	pmtmr_ioport = setup_data.v1.pm_timer_address;
> @@ -204,6 +261,8 @@ static void __init jailhouse_init_platform(void)
>  	 * are none in a non-root cell.
>  	 */
>  	disable_acpi();
> +
> +	jailhouse_serial_workaround();
>  	return;
>  
>  unsupported:
> 

This was missing yet:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
