Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1016B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDHMYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:24:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDHMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:24:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so14096315wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdH/eVjOF5vJubpcVL00uT0hsMhVuQ70Ri1ks9OE+zo=;
        b=cf1JDrzgvDe78FX1p6Ozqh7ELkeeueqaHim278HYEFfohuLYjKt/SnMN/ztss4FwY+
         ak+fbrFIllhEEX6xWznZaLT+TYxxNJs/H++G/Y0HPqy/ssKwxpmGvyCgB6UGVrlzQCN+
         LcAxJ96lwJUbyAwal1KNlhvkD4yjZty1kXZ1h2hoqawzVaRHek7AIJGKfocKBoWMGEnk
         17GezSBmpQzou18S8o52IPryaIaojzweyqhhcG9CE3Lb5a6igDT9R54SvbCfcQD4VlrY
         nXdK3tmC7yJgjthzysB7p3Mj6ZkGw61wrUoUvuYTfegRw3eu7M4t7BDV4+CODEQZn8Wc
         PWng==
X-Gm-Message-State: APjAAAX2c1A3TEOiS5o3ZCOb1C5hc8EiVuFqCSL9C6sjhJH/h9Mi78DO
        6RzlL/xm17AxESnbtnu1kOW4ig==
X-Google-Smtp-Source: APXvYqzG02kKB25fQioCE8HbB19hFJB4jzB5CiK6+cXUSU+GoWbaXIMiHhtYbkmzM78uYu5/sqGnNg==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr17851706wmj.29.1554726290933;
        Mon, 08 Apr 2019 05:24:50 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id x205sm12866725wmg.9.2019.04.08.05.24.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:24:50 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] trace,x86: Add nmi to the irq_vectors class
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
 <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
 <alpine.DEB.2.21.1904052323200.1802@nanos.tec.linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <9fc0399e-ab53-1074-623a-a826e2466277@redhat.com>
Date:   Mon, 8 Apr 2019 14:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904052323200.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 11:50 PM, Thomas Gleixner wrote:
> On Mon, 1 Apr 2019, Daniel Bristot de Oliveira wrote:
>> Currently, the irq_vector class of tracepoints does not include the NMI
>> entry. The NMI was in the first set of tracepoints for IRQs, but it was
>> dropped off because of the logic of switching IDT when enabling trace[1].
>> However, as the switching IDT logic was removed [2], it is possible to add
> 
> Well, not really. tracepoints inside of do_nmi() have been there for a long
> time.
> 
> The nasty part was that the irq_vector patches injected the tracepoints way
> down in the low level entry code, which caused more problems than it solved
> including the extra IDT switcheroo.

humm... the benefits of having the tracepoints at the very begin/end of the
handler is that it captures better the amount of interference/overhead it caused
in the current thread (and IRQ too in the case of NMIs).

>> the NMI tracepoints back.
> 
> So again we have two tracepoints. One for the entry and one for the
> handlers. Do we really need both? If so please provide some rationale.

For example:

  f-4447  [000] d.Z.  1253.162036: nmi_entry: vector=2
  f-4447  [000] d.Z.  1253.162038: nmi_handler: nmi_cpu_backtrace_handler()
delta_ns: 354 handled: 0
  f-4447  [000] d.Z.  1253.162267: nmi_exit: vector=2

The nmi_handler tracepoint points to an interference of 354 ns, what is very
good! But the difference of time between the two irq_vectors tracepoint is:

  1253.162267-1253.162036 = 231 us!

The number looks really odd, but tracing with function tracer, we see this:

Thread running:
  f-4447  [000] d.Z.  1487.689288: rcu_nmi_enter <-do_nmi
  f-4447  [000] d.Z.  1487.689289: rcu_dynticks_curr_cpu_in_eqs <-rcu_nmi_enter

NMI starts:
  f-4447  [000] d.Z.  1487.689290: nmi_entry: vector=2
  f-4447  [000] d.Z.  1487.689291: default_do_nmi <-do_nmi
  f-4447  [000] d.Z.  1487.689291: nmi_handle <-default_do_nmi
  f-4447  [000] d.Z.  1487.689291: nmi_cpu_backtrace_handler <-nmi_handle

It handles very fast:
  f-4447  [000] d.Z.  1487.689292: nmi_handler: nmi_cpu_backtrace_handler()
delta_ns: 780 handled: 0

But some other functions continues running in the NMI context:
[Dazed and confused, but trying to continue message ]
  f-4447  [000] d.Z.  1487.689292: _raw_spin_trylock <-default_do_nmi
  f-4447  [000] d.Z.  1487.689566: unknown_nmi_error <-default_do_nmi
  f-4447  [000] d.Z.  1487.689566: nmi_handle <-unknown_nmi_error
  f-4447  [000] d.Z.  1487.689567: printk <-unknown_nmi_error
  f-4447  [000] d.Z.  1487.689567: vprintk_func <-printk
  f-4447  [000] d.Z.  1487.689567: printk_safe_log_store <-vprintk_func
  f-4447  [000] d.Z.  1487.689569: arch_irq_work_raise <-irq_work_queue
  f-4447  [000] d.Z.  1487.689569: default_send_IPI_self <-arch_irq_work_raise
  f-4447  [000] d.Z.  1487.689569: __default_send_IPI_shortcut
<-default_send_IPI_self
  f-4447  [000] d.Z.  1487.689585: native_apic_wait_icr_idle <-arch_irq_work_raise
  f-4447  [000] d.Z.  1487.689588: printk <-unknown_nmi_error
  f-4447  [000] d.Z.  1487.689588: vprintk_func <-printk
  f-4447  [000] d.Z.  1487.689588: printk_safe_log_store <-vprintk_func
  f-4447  [000] d.Z.  1487.689588: printk <-unknown_nmi_error.cold.13
  f-4447  [000] d.Z.  1487.689588: vprintk_func <-printk
  f-4447  [000] d.Z.  1487.689588: printk_safe_log_store <-vprintk_func

Handler finishes:
  f-4447  [000] d.Z.  1487.689589: nmi_exit: vector=2
  f-4447  [000] d.Z.  1487.689589: rcu_nmi_exit <-do_nmi
  f-4447  [000] d.Z.  1487.689589: rcu_irq_exit <-rcu_nmi_exit

And it was actually also (potentially) delaying an timer:
  f-4447  [000] d...  1487.689590: smp_irq_work_interrupt <-irq_work_interrupt

So, the nmi_handle tracepoint would not make suspicious that the NMI caused the
delay, but the irq_vectors would (because of their position).

Finally, we would have to enable a single class of tracepoints to monitor all
interrupts.

PS: I am using the vanilla kernel in a vm, so the numbers are higher, but still,
they have the same scale in the bare metal.

Thoughts?

-- Daniel

>> The tracepoints looks like:
>>           <idle>-0     [000] d.Z.   179.594315: nmi_entry: vector=2
>>           <idle>-0     [000] d.Z.   179.594396: nmi_exit: vector=2
>>
>> [1] trace,x86: irq vector tracepoint support
>>     https://lwn.net/Articles/555465/
> 
> Please use https://lkml.kernel.org/r/$MESSAGE-ID
> 
>> [2] commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")
>>
>> Changes from V1:
>>   - Fix a compilation problem when CONFIG_X86_LOCAL_APIC is not set (kbuild test)
> 
> Please put changes below the '---' separator. They are not part of the
> final changelog and having them below spares the maintainer the time to
> remove them manually.
> 
> Thanks,
> 
> 	tglx
> 

