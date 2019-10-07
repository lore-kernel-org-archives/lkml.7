Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439B206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I3AvTecs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfJGQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:26:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGQ0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:26:43 -0400
Received: from zn.tnic (p200300EC2F06420085D86D94306C6599.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4200:85d8:6d94:306c:6599])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55BE21EC0C2B;
        Mon,  7 Oct 2019 18:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570465598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XL20VwtPRbGDGcN+4iS4qA165VAWOZtyxaE4mR0KPqk=;
        b=I3AvTecs4eP6o5KdbyyhNC4S4MrvUdz5MO4eMukYm2UnIcTrZgtcZ4BlNfq8MaZaFUJMgA
        ntCTOpufgkSXaOa2uo5mI8ar+4UGwigbYTgucjveMEno3JL8bb5GdSGp+k86irNkFFVkA4
        NlnaELXPydx9bBNZ3xoty6FfdykmjwQ=
Date:   Mon, 7 Oct 2019 18:26:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 2/2] x86/jailhouse: Only enable platform UARTs if
 available
Message-ID: <20191007162636.GD24289@zn.tnic>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
 <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:38:19PM +0200, Ralf Ramsauer wrote:
> ACPI tables aren't available if Linux runs as guest of the hypervisor
> Jailhouse. This makes the 8250 driver probe for all platform UARTs as
> it assumes that all platform are present in case of !ACPI. Jailhouse

I think you mean s/platform/UARTs/ here.

> will stop execution of Linux guest due to port access violation.
> 
> So far, these access violations could be solved by tuning the
> 8250.nr_uarts parameter but it has limitations: We can, e.g., only map

Another "We" you can get rid of.

> consecutive platform UARTs to Linux, and only in the sequence 0x3f8,
> 0x2f8, 0x3e8, 0x2e8.
> 
> Beginning from setup_data version 2, Jailhouse will place information of
> available platform UARTs in setup_data. This allows for selective
> activation of platform UARTs.
> 
> This patch queries the setup_data version and activates only available

s/This patch queries/Query/

> UARTS. It comes with backward compatibility, and will still support
> older setup_data versions. In this case, Linux falls back to the old
> behaviour.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
>  arch/x86/include/uapi/asm/bootparam.h |  3 +
>  arch/x86/kernel/jailhouse.c           | 83 +++++++++++++++++++++++----
>  2 files changed, 74 insertions(+), 12 deletions(-)

...

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

WARNING: vmlinux.o(.text+0x4fdb0): Section mismatch in reference from the function jailhouse_serial_fixup() to the variable .init.data:can_use_brk_pgt
The function jailhouse_serial_fixup() references
the variable __initdata can_use_brk_pgt.
This is often because jailhouse_serial_fixup lacks a __initdata 
annotation or the annotation of can_use_brk_pgt is wrong.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
