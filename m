Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDE1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B362184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfGSImU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:42:20 -0400
Received: from foss.arm.com ([217.140.110.172]:40254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:42:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCF95337;
        Fri, 19 Jul 2019 01:42:18 -0700 (PDT)
Received: from [10.1.36.145] (c02yf087jhd5.cambridge.arm.com [10.1.36.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E19E3F71A;
        Fri, 19 Jul 2019 01:42:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
 <156342863822.8565.7624877983728871995.stgit@devnote2>
 <20190718062215.GG14271@linux.ibm.com> <20190718092022.GA3625@blommer>
 <20190718233133.146065f668da6297e57e52ef@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <536ba068-50de-963e-c3a7-0440da56943a@arm.com>
Date:   Fri, 19 Jul 2019 09:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190718233133.146065f668da6297e57e52ef@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/18/19 3:31 PM, Masami Hiramatsu wrote:
> On Thu, 18 Jul 2019 10:20:23 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
>>> On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
>>>> Remove rcu_read_lock()/rcu_read_unlock() from debug exception
>>>> handlers since the software breakpoint can be hit on idle task.
>>
>> Why precisely do we need to elide these? Are we seeing warnings today?
> 
> Yes, unfortunately, or fortunately. Naresh reported that warns when
> ftracetest ran. I confirmed that happens if I probe on default_idle_call too.
> 
> /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events
> /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable
> /sys/kernel/debug/tracing # [  135.122237]
> [  135.125035] =============================
> [  135.125310] WARNING: suspicious RCU usage

> [  135.132224] Call trace:
> [  135.132491]  dump_backtrace+0x0/0x140
> [  135.132806]  show_stack+0x24/0x30
> [  135.133133]  dump_stack+0xc4/0x10c
> [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
> [  135.134171]  call_break_hook+0x170/0x178
> [  135.134486]  brk_handler+0x28/0x68
> [  135.134792]  do_debug_exception+0x90/0x150
> [  135.135051]  el1_dbg+0x18/0x8c
> [  135.135260]  default_idle_call+0x0/0x44
> [  135.135516]  cpu_startup_entry+0x2c/0x30
> [  135.135815]  rest_init+0x1b0/0x280
> [  135.136044]  arch_call_rest_init+0x14/0x1c
> [  135.136305]  start_kernel+0x4d4/0x500

>>> The exception entry and exit use irq_enter() and irq_exit(), in this
>>> case, correct?  Otherwise RCU will be ignoring this CPU.
>>
>> This is missing today, which sounds like the underlying bug.
> 
> Agreed. I'm not so familier with how debug exception is handled on arm64,
> would it be a kind of NMI or IRQ?

Debug exceptions can interrupt both SError (think: machine check) and 
pseudo-NMI, which both in turn interrupt interrupt-masked code. So they 
are a kind of NMI. But, be careful not to call 'nmi_enter()' twice, see 
do_serror() for how we work around this...


> Anyway, it seems that normal irqs are also not calling irq_enter/exit
> except for arch/arm64/kernel/smp.c
drivers/irqchip/irq-gic.c:gic_handle_irq() either calls 
handle_domain_irq() or handle_IPI(). The enter/exit calls live in those 
functions.


Thanks,

James
