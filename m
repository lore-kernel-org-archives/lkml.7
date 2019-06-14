Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72420C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C782168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFNUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:53:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfFNUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:53:44 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbtCf-00060Z-Fp; Fri, 14 Jun 2019 22:53:41 +0200
Date:   Fri, 14 Jun 2019 22:53:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Adric Blake <promarbler14@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH] x86/microcode, cpuhotplug: Add a microcode loader CPU
 hotplug callback
In-Reply-To: <20190614182317.29292-1-bp@alien8.de>
Message-ID: <alpine.DEB.2.21.1906142253230.1760@nanos.tec.linutronix.de>
References: <20190614182317.29292-1-bp@alien8.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Adric Blake reported the following warning during suspend-resume:
> 
>   Enabling non-boot CPUs ...
>   x86: Booting SMP configuration:
>   smpboot: Booting Node 0 Processor 1 APIC 0x2
>   unchecked MSR access error: WRMSR to 0x10f (tried to write 0x0000000000000000) \
>    at rIP: 0xffffffff8d267924 (native_write_msr+0x4/0x20)
>   Call Trace:
>    intel_set_tfa
>    intel_pmu_cpu_starting
>    ? x86_pmu_dead_cpu
>    x86_pmu_starting_cpu
>    cpuhp_invoke_callback
>    ? _raw_spin_lock_irqsave
>    notify_cpu_starting
>    start_secondary
>    secondary_startup_64
>   microcode: sig=0x806ea, pf=0x80, revision=0x96
>   microcode: updated to revision 0xb4, date = 2019-04-01
>   CPU1 is up
> 
> The MSR in question is MSR_TFA_RTM_FORCE_ABORT and that MSR is emulated
> by microcode. The log above shows that the microcode loader callback
> happens after the PMU restoration, leading to the conjecture that
> because the microcode hasn't been updated yet, that MSR is not present
> yet, leading to the #GP.
> 
> Add a microcode loader-specific hotplug vector which comes before
> the PERF vectors and thus executes earlier and makes sure the MSR is
> present.
> 
> Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
> Reported-by: Adric Blake <promarbler14@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203637

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
