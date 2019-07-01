Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D6C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D1E20673
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfGAIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:03:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:03:39 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hhrHd-0000IT-DL; Mon, 01 Jul 2019 10:03:29 +0200
Date:   Mon, 1 Jul 2019 10:03:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Li Wang <liwang@redhat.com>
cc:     ricardo.neri-calderon@linux.intel.com, pbonzini@redhat.com,
        kernellwp@gmail.com, ricardo.neri@intel.com, pengfei.xu@intel.com,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>
Subject: Re: [Kernel BUG?] SMSW operation get success on UMIP KVM guest
In-Reply-To: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907010959390.1802@nanos.tec.linutronix.de>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
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

On Mon, 1 Jul 2019, Li Wang wrote:

> Hello there,
> 
> LTP/umip_basic_test get failed on KVM UMIP system(kernel-v5.2-rc4.x86_64).
> The test is only trying to do
>      asm volatile("smsw %0\n" : "=m" (val));
> and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> unexpectedly.
> 
> ====================
> # grep CONFIG_X86_INTEL_UMIP /boot/config-5.2.0-0.rc4.x86_64
> CONFIG_X86_INTEL_UMIP=y
> 
> # lscpu |grep umip
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp
> lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq
> ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer
> aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch cpuid_fault
> invpcid_single pti ssbd ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2
> smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap clflushopt
> clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves arat umip
> pku ospke md_clear
> 
> # ./umip_basic_test
> ...
> umip_basic_test.c:68: INFO: TEST smsw, smsw result save at [0x7ffda00dca70]
> umip_basic_test.c:118: FAIL: Didn't receive SIGSEGV, child exited with
> exited with 0

SMSW is emulated and returns a constant value:

#define CR0_STATE       (X86_CR0_PE | X86_CR0_MP | X86_CR0_ET | \
                         X86_CR0_NE | X86_CR0_WP | X86_CR0_AM | \
                         X86_CR0_PG)

IIRC that is done to not break stuff like Wine. Ricardo should know the
details.

Thanks,

	tglx

