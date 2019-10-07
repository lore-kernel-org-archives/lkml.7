Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD84C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804E206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oth-regensburg.de header.i=@oth-regensburg.de header.b="W0z8xUom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfJGQoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:44:44 -0400
Received: from mta01.hs-regensburg.de ([194.95.104.11]:51660 "EHLO
        mta01.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfJGQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:44:44 -0400
Received: from E16S02.hs-regensburg.de (e16s02.hs-regensburg.de [IPv6:2001:638:a01:8013::92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S02", Issuer "E16S02" (not verified))
        by mta01.hs-regensburg.de (Postfix) with ESMTPS id 46n5tK0C7vzy7G;
        Mon,  7 Oct 2019 18:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1570466681;
        bh=LI14XXmY5N0/ZKqBuiM/47tXsF6+5WROUnMT6MIIpM4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=W0z8xUomVrZ+IpEX4Z82fLeVCh+uQdL52gYkIL+ab1TAzEdkYVCXJLCGAADUtXmrK
         ee4saD8P/F1UKHyHmGzIbsE12poGLenyxvZcdgaoL4d/90tTm+luVDlilcIhKYUBYt
         F0MhGjhGEQb2jYvoAZgJLEc9LvBTtnDYEOt1GpD1ZoIpyP/UKhZPo0C226CagIhaPh
         +rovYiuN35bGFR7cybkR7O9w65YRyoQ6yYPM/jpajDQ1rNBVVYcKs9a078glw6jNY5
         zamLN3cZ8Lj/e1znOkTLWnJGxuWggUq04dgJYkHYCQddr+2unGGKvxvhEfOhH+OtVp
         sDY1p0R4pS9Dw==
Received: from [IPv6:2a01:598:b900:3f4c:904e:cc61:5355:8726]
 (2001:638:a01:8013::138) by E16S02.hs-regensburg.de (2001:638:a01:8013::92)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 7 Oct 2019
 18:44:40 +0200
Subject: Re: [PATCH v5 2/2] x86/jailhouse: Only enable platform UARTs if
 available
To:     Borislav Petkov <bp@alien8.de>
CC:     Jan Kiszka <jan.kiszka@siemens.com>, <x86@kernel.org>,
        <jailhouse-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
 <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
 <20191007162636.GD24289@zn.tnic>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Autocrypt: addr=ralf.ramsauer@oth-regensburg.de; keydata=
 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
 RncIIYr0LjXAAzY=
Message-ID: <85502467-d13b-084e-cdb8-d891178e97d8@oth-regensburg.de>
Date:   Mon, 7 Oct 2019 18:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007162636.GD24289@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:638:a01:8013::138]
X-ClientProxiedBy: E16S01.hs-regensburg.de (2001:638:a01:8013::91) To
 E16S02.hs-regensburg.de (2001:638:a01:8013::92)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/19 6:26 PM, Borislav Petkov wrote:
> On Mon, Oct 07, 2019 at 02:38:19PM +0200, Ralf Ramsauer wrote:
>> ACPI tables aren't available if Linux runs as guest of the hypervisor
>> Jailhouse. This makes the 8250 driver probe for all platform UARTs as
>> it assumes that all platform are present in case of !ACPI. Jailhouse
> 
> I think you mean s/platform/UARTs/ here.
> 
>> will stop execution of Linux guest due to port access violation.
>>
>> So far, these access violations could be solved by tuning the
>> 8250.nr_uarts parameter but it has limitations: We can, e.g., only map
> 
> Another "We" you can get rid of.
> 
>> consecutive platform UARTs to Linux, and only in the sequence 0x3f8,
>> 0x2f8, 0x3e8, 0x2e8.
>>
>> Beginning from setup_data version 2, Jailhouse will place information of
>> available platform UARTs in setup_data. This allows for selective
>> activation of platform UARTs.
>>
>> This patch queries the setup_data version and activates only available
> 
> s/This patch queries/Query/
> 
>> UARTS. It comes with backward compatibility, and will still support
>> older setup_data versions. In this case, Linux falls back to the old
>> behaviour.
>>
>> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
>> ---
>>  arch/x86/include/uapi/asm/bootparam.h |  3 +
>>  arch/x86/kernel/jailhouse.c           | 83 +++++++++++++++++++++++----
>>  2 files changed, 74 insertions(+), 12 deletions(-)
> 
> ...
> 
>> @@ -138,6 +147,53 @@ static int __init jailhouse_pci_arch_init(void)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_SERIAL_8250
>> +static bool jailhouse_uart_enabled(unsigned int uart_nr)
>> +{
>> +	return setup_data.v2.flags & BIT(uart_nr);
>> +}
>> +
>> +static void jailhouse_serial_fixup(int port, struct uart_port *up,
>> +				   u32 *capabilities)
>> +{
>> +	static const u16 pcuart_base[] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
>> +	unsigned int n;
>> +
>> +	for (n = 0; n < ARRAY_SIZE(pcuart_base); n++) {
>> +		if (pcuart_base[n] != up->iobase)
>> +			continue;
>> +
>> +		if (jailhouse_uart_enabled(n)) {
>> +			pr_info("Enabling UART%u (port 0x%lx)\n", n,
>> +				up->iobase);
>> +			jailhouse_setup_irq(up->irq);
>> +		} else {
>> +			/* Deactivate UART if access isn't allowed */
>> +			up->iobase = 0;
>> +		}
>> +		break;
>> +	}
>> +}
> 
> WARNING: vmlinux.o(.text+0x4fdb0): Section mismatch in reference from the function jailhouse_serial_fixup() to the variable .init.data:can_use_brk_pgt
> The function jailhouse_serial_fixup() references
> the variable __initdata can_use_brk_pgt.
> This is often because jailhouse_serial_fixup lacks a __initdata 
> annotation or the annotation of can_use_brk_pgt is wrong.
> 

Yep, jailhouse_serial_fixup can become __init, I didn't see that, but
you're right, thanks. I'm curious, how did you find that? "We" didn't
notice yet. :-)

BTW, we refers to the Jailhouse folks, but I will rewrite that.

Thanks
  Ralf
