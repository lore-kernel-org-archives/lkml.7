Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5416FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF621855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDEVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:50:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49968 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDEVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:50:18 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWj1-0005X6-5r; Fri, 05 Apr 2019 23:50:15 +0200
Date:   Fri, 5 Apr 2019 23:50:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 2/2] trace,x86: Add nmi to the irq_vectors class
In-Reply-To: <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
Message-ID: <alpine.DEB.2.21.1904052323200.1802@nanos.tec.linutronix.de>
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com> <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
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

On Mon, 1 Apr 2019, Daniel Bristot de Oliveira wrote:
> Currently, the irq_vector class of tracepoints does not include the NMI
> entry. The NMI was in the first set of tracepoints for IRQs, but it was
> dropped off because of the logic of switching IDT when enabling trace[1].
> However, as the switching IDT logic was removed [2], it is possible to add

Well, not really. tracepoints inside of do_nmi() have been there for a long
time.

The nasty part was that the irq_vector patches injected the tracepoints way
down in the low level entry code, which caused more problems than it solved
including the extra IDT switcheroo.

> the NMI tracepoints back.

So again we have two tracepoints. One for the entry and one for the
handlers. Do we really need both? If so please provide some rationale.

> The tracepoints looks like:
>           <idle>-0     [000] d.Z.   179.594315: nmi_entry: vector=2
>           <idle>-0     [000] d.Z.   179.594396: nmi_exit: vector=2
> 
> [1] trace,x86: irq vector tracepoint support
>     https://lwn.net/Articles/555465/

Please use https://lkml.kernel.org/r/$MESSAGE-ID

> [2] commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")
> 
> Changes from V1:
>   - Fix a compilation problem when CONFIG_X86_LOCAL_APIC is not set (kbuild test)

Please put changes below the '---' separator. They are not part of the
final changelog and having them below spares the maintainer the time to
remove them manually.

Thanks,

	tglx
