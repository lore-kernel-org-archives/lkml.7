Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B5C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74998214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572976918;
	bh=vnnrcriP9oKkMbbaFvJ7o6GE0WcKR3MpVZKSJb35Nco=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=CFaHVFDJrFcdRrOR5XVT2mvlFEq2/+mHTuvtD72vophtPs5qjNLdMe/V271+9bRfe
	 pKRqsZ69QXjxFM4QuMTkZuuIXvllyWZ0J5OwJYTwLHAxpgr0rq1GmZN3QmbFuzebJT
	 R5O+D9neq7bKNqgmB8l9EMjkkSPJ9cJxGgTIUg0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbfKESB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:01:57 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:45371 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389356AbfKESB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:01:57 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS39J-000357-0h; Tue, 05 Nov 2019 19:01:49 +0100
To:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 01/12] riscv: abstract out CSR names for supervisor vs  machine mode
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 19:11:09 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1911050956230.20606@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de>
 <20191028121043.22934-2-hch@lst.de>
 <alpine.DEB.2.21.9999.1911050956230.20606@viisi.sifive.com>
Message-ID: <b1e60fb42bc057e9901187bb866b7077@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, hch@lst.de, palmer@sifive.com, damien.lemoal@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2019-11-05 19:06, Paul Walmsley wrote:
> Jason, Marc, Thomas,
>
> On Mon, 28 Oct 2019, Christoph Hellwig wrote:
>
>> Many of the privileged CSRs exist in a supervisor and machine 
>> version
>> that are used very similarly.  Provide versions of the CSR names and
>> fields that map to either the S-mode or M-mode variant depending on
>> a new CONFIG_RISCV_M_MODE kconfig symbol.
>>
>> Contains contributions from Damien Le Moal <Damien.LeMoal@wdc.com>
>> and Paul Walmsley <paul.walmsley@sifive.com>.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Care to give a quick ack to the drivers/irqchip changes?

Sure, see below.

>
>
> thanks,
>
> - Paul
>
>
>> ---
>>  arch/riscv/Kconfig                 |  4 ++
>>  arch/riscv/include/asm/csr.h       | 72 
>> +++++++++++++++++++++++++----
>>  arch/riscv/include/asm/irqflags.h  | 12 ++---
>>  arch/riscv/include/asm/processor.h |  2 +-
>>  arch/riscv/include/asm/ptrace.h    | 16 +++----
>>  arch/riscv/include/asm/switch_to.h | 10 ++--
>>  arch/riscv/kernel/asm-offsets.c    |  8 ++--
>>  arch/riscv/kernel/entry.S          | 74 
>> +++++++++++++++++-------------
>>  arch/riscv/kernel/fpu.S            |  8 ++--
>>  arch/riscv/kernel/head.S           | 12 ++---
>>  arch/riscv/kernel/irq.c            | 17 ++-----
>>  arch/riscv/kernel/perf_callchain.c |  2 +-
>>  arch/riscv/kernel/process.c        | 17 +++----
>>  arch/riscv/kernel/signal.c         | 21 ++++-----
>>  arch/riscv/kernel/smp.c            |  2 +-
>>  arch/riscv/kernel/traps.c          | 16 +++----
>>  arch/riscv/lib/uaccess.S           | 12 ++---
>>  arch/riscv/mm/extable.c            |  4 +-
>>  arch/riscv/mm/fault.c              |  6 +--
>>  drivers/clocksource/timer-riscv.c  |  8 ++--
>>  drivers/irqchip/irq-sifive-plic.c  | 11 +++--
>>  21 files changed, 199 insertions(+), 135 deletions(-)

[...]

>> diff --git a/drivers/irqchip/irq-sifive-plic.c 
>> b/drivers/irqchip/irq-sifive-plic.c
>> index 7d0a12fe2714..8df547d2d935 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -181,7 +181,7 @@ static void plic_handle_irq(struct pt_regs 
>> *regs)
>>
>>  	WARN_ON_ONCE(!handler->present);
>>
>> -	csr_clear(sie, SIE_SEIE);
>> +	csr_clear(CSR_IE, IE_EIE);
>>  	while ((hwirq = readl(claim))) {
>>  		int irq = irq_find_mapping(plic_irqdomain, hwirq);
>>
>> @@ -191,7 +191,7 @@ static void plic_handle_irq(struct pt_regs 
>> *regs)
>>  		else
>>  			generic_handle_irq(irq);
>>  	}
>> -	csr_set(sie, SIE_SEIE);
>> +	csr_set(CSR_IE, IE_EIE);
>>  }
>>
>>  /*
>> @@ -252,8 +252,11 @@ static int __init plic_init(struct device_node 
>> *node,
>>  			continue;
>>  		}
>>
>> -		/* skip contexts other than supervisor external interrupt */
>> -		if (parent.args[0] != IRQ_S_EXT)
>> +		/*
>> +		 * Skip contexts other than external interrupts for our
>> +		 * privilege level.
>> +		 */
>> +		if (parent.args[0] != IRQ_EXT)
>>  			continue;
>>
>>  		hartid = plic_find_hart_id(parent.np);

For changes to this file:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
