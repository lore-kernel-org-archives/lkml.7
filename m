Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B8CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHZXsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:48:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34906 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfHZXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:48:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so10806204plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 16:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zd7cywiAkoUWcRfVHCpRZTgeWdfgqowuSFCwN1bZj2Y=;
        b=rDPMTnN3JBIxI/HF+j6s4oCVb9Tav6gpqVsa5Vau8X7SfJ/GL9KZpdAAj8j2c4NBL2
         YjJUf4SFMwxVI3cvXYqyl02gupM45QrNbdjQuz9wboY7K2Y9xTI1F/rOnVUrwm+BWMRf
         5lPwcLHtmqSNkzv9lQMvlXaZpPomWCb/jZBsP86jBG8BtJdgZRUmDKKK5kc6G8cFMHur
         rNrY7zZqvx6O/gHRAgKbvioebN20z0MQb39evPfa9m5i0zmms9krTfqAPqHRhUjJAidT
         ZmvxlpaHueJFvH5SQn0xYWyDRVABmOiChOyUJ3agbXHf8pk/aGRtLRNNifE28TNdBwPv
         NwXA==
X-Gm-Message-State: APjAAAWdFi7cixpZbINOZf2AdjYZV0UXKu4jXYTFgKgYaYY6QOWXq8CV
        jicdReO/HtlQTYsw3nYdLEijqg==
X-Google-Smtp-Source: APXvYqwyXgUsc5NoBh5QUb4SDP9eiKr+6nVJJzX04PkAKM0NdwIJMpxpTcIRtFf4265JDbAiP0IQAA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr9391336pls.158.1566863283326;
        Mon, 26 Aug 2019 16:48:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r75sm18127613pfc.18.2019.08.26.16.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:48:02 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:48:02 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 16:44:31 PDT (-0700)
Subject:     Re: [PATCH v2 1/5] RISC-V: Remove per cpu clocksource
In-Reply-To: <089a5ee46759074af391c50f5e9d28344b429de4.camel@wdc.com>
CC:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Anup Patel <Anup.Patel@wdc.com>,
        Greg KH <gregkh@linuxfoundation.org>, info@metux.net,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, allison@lohutok.net, johan@kernel.org,
        alexios.zavras@intel.com, tglx@linutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-6a5026a2-d727-4c08-969d-712b303903df@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 11:55:14 PDT (-0700), Atish Patra wrote:
> On Fri, 2019-08-16 at 17:09 +0200, Daniel Lezcano wrote:
>> On 31/07/2019 03:24, Atish Patra wrote:
>> > There is only one clocksource in RISC-V. The boot cpu initializes
>> > that clocksource. No need to keep a percpu data structure.
>> 
>> That is not what is stated in the initial patch [1].
>> 
>> Can you clarify that ?
>> 
> 
> I think what I meant to say was "There is only one clocksource used in
> RISC-V Linux" as it is guranteed that all the timers across all the
> harts are synchronized within one tick of each other [2]. 
> Apologies for not being verbose here.
> 
> However, reading the privilege specification(1.12-draft) 
> 
> Section. 3.1.10 states that 
> 
> "Accurate real-time clocks (RTCs) are relatively expensive to provide
> (requiring a crystal or MEMS oscillator) and have to run even when the
> rest of system is powered down, and so there is usually only one in a
> system located in a different frequency/voltage domain from the
> processors. Hence, the RTC must be shared by all the harts in a system"
> 
> This is different from the commit text in [1].
> 
> Perhaps I misunderstood something. @Palmer ?

This is one of those places the ISA has drifted around a bit: in the user ISA 
there is a time CSR, and CSRs are all per-hart state so logically there is a 
timer per hart.  We used to actually build systems this way (with an SOC agent 
what would actively increment each CSR whenever the RTC fired), but it ended up 
being impractical for a bunch of reasons.  There was never a way to actually 
write these time CSRs from supervisor mode, but machine-mode software could 
write them so it would have been possible to build system that had different 
time values on different harts.

As a result we ended up with per-CPU timers in Linux, but they never actually 
worked correctly: there's a bunch of per-CPU state in the driver, but nothing 
to actually enforce that timer reads go to the correct hart.  For example, get 
the time on hart 0 you'd have to IPI over to that hart, do a local CSR read, 
and then IPI the time back.  As a result the per-CPU state never really made 
any sense, but it kind of just hung around because it worked fine on the 
systems we were building (which always had time synced up anyway) and was 
closer to what the spec allowed -- we didn't IPI over because time was always 
synchronized on systems that actually existed and the IPIs are super slow, but 
the scaffolding stuck around.

As part of cleaning up the privileged ISA for ratification we decided to 
mandate that the time CSRs on every hart are always within a single tick of 
each other, effectively mandating a single time across the system.  This was 
partially motivated by Linux, but mostly by a new approach we were taking to 
the hypervisor specification -- rather than a hypervisor mode, we decided to 
just extend supervisor mode to support fast nested virtualization, which means 
we now have "htimedelta" (a per-hart timer offset) rather than per-hart timers.  
This is more efficient because the per-state stays constant so we don't need to 
actively tick it, and since it makes the per-hart time state unnecessary we 
decided to drop that extra state.

The change to global time on RISC-V systems rendered the per-CPU timers 
defunct, but since they weren't really doing anything they just stuck around.  
The cleanup seems perfectly reasonable to me, modulo the issue I've pointed out 
below...

> 
> 
> [2] 
> https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/clocksource/timer-riscv.c#L44
> 
>> Thanks
>> 
>>   -- Daniel
>> 
>> [1] https://lkml.org/lkml/2018/8/4/51
>> 
>> 
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > ---
>> >  drivers/clocksource/timer-riscv.c | 6 ++----
>> >  1 file changed, 2 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/drivers/clocksource/timer-riscv.c
>> > b/drivers/clocksource/timer-riscv.c
>> > index 5e6038fbf115..09e031176bc6 100644
>> > --- a/drivers/clocksource/timer-riscv.c
>> > +++ b/drivers/clocksource/timer-riscv.c
>> > @@ -55,7 +55,7 @@ static u64 riscv_sched_clock(void)
>> >  	return get_cycles64();
>> >  }
>> >  
>> > -static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
>> > +static struct clocksource riscv_clocksource = {
>> >  	.name		= "riscv_clocksource",
>> >  	.rating		= 300,
>> >  	.mask		= CLOCKSOURCE_MASK(64),
>> > @@ -92,7 +92,6 @@ void riscv_timer_interrupt(void)
>> >  static int __init riscv_timer_init_dt(struct device_node *n)
>> >  {
>> >  	int cpuid, hartid, error;
>> > -	struct clocksource *cs;
>> >  
>> >  	hartid = riscv_of_processor_hartid(n);
>> >  	if (hartid < 0) {
>> > @@ -112,8 +111,7 @@ static int __init riscv_timer_init_dt(struct
>> > device_node *n)
>> >  
>> >  	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>> >  	       __func__, cpuid, hartid);
>> > -	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>> > -	error = clocksource_register_hz(cs, riscv_timebase);
>> > +	error = clocksource_register_hz(&riscv_clocksource,
>> > riscv_timebase);

Someone's client has mangled the patches, but I think there's an issue here: 
we're still calling the init code for every "riscv" DT entry, but there's now 
only a single "struct clocksource".  This will result in a single clocksource 
being initialized multiple times, which I assume is an issue.

>> >  	if (error) {
>> >  		pr_err("RISCV timer register failed [%d] for cpu =
>> > [%d]\n",
>> >  		       error, cpuid);
>> > 
>> 
>> 
> 
