Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAF4C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3622084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:17:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCYORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:17:13 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8QPK-0006In-0K; Mon, 25 Mar 2019 15:16:58 +0100
Date:   Mon, 25 Mar 2019 15:16:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     lantianyu1986@gmail.com
cc:     mingo@kernel.org, konrad.wilk@oracle.com, jpoimboe@redhat.com,
        peterz@infraded.org, mojha@codeaurora.org, peterz@infradead.org,
        jkosina@suse.cz, riel@surriel.com, luto@kernel.org,
        Tianyu.Lan@microsoft.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Fix PATCH] cpu/hotplug: Fix bug report when add "nosmt" parameter
 with CONFIG_HOTPLUG_CPU=N
In-Reply-To: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com>
Message-ID: <alpine.DEB.2.21.1903251455160.1656@nanos.tec.linutronix.de>
References: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu,

On Mon, 25 Mar 2019, lantianyu1986@gmail.com wrote:

thanks for tracking this down.

A few nit picks vs. the subject first:

> Subject: [Fix PATCH] cpu/hotplug: Fix bug report when add "nosmt" parameter with CONFIG_HOTPLUG_CPU=N

[PATCH] is sufficient. The extra 'Fix' has no real value. 'Fix bug report'
is weird. Bug reports cannot be fixed, only bugs can be fixed. Also please
avoid overly long subjects. Subjects should be concise and describe the
problem/change as precise as it goes.

> When add "nosmt" parameter, kernel still boots up all logical cpus once
> and set CR4.MCE on each CPU. This is to avoid shutting down machine
> when a broadacasted MCE is observed CR4.MCE=0b. (Detail please see comment
> in the cpu_smt_allowed()). Smt cpus will bring up and bring down during
> kernel boot with "nosmt" parameter.
> 
> When CONFIG_HOTPLUG_CPU=Y, CPU_DYING callbacks will be called inside
> stop-machine and irq is disabled. This happens in the take_cpu_down()
> callback. When CONFIG_HOTPLUG_CPU=N,CPU_DYING callbacks will be called
> with irq enabled.

Yes, that's bad.

> smpcfd_dying_cpu() is one of CPU_DYING callbacks and it assumes to be
> called when irq is disabled. smpcfd_dying_cpu() calls flush_smp_call_
> function_queue() which requires to be called with irq disabled.
> 
> When CONFIG_HOTPLUG_CPU=N and add "nosmt" parameter, smpcfd_dying_cpu()
> is called with irq enalbed and this triggers BUG_ON(!irqs_disabled())
> in the irq_work_run_list(). This patch is to fix the issue.

That's not a fix, it's papering over the root cause. As you figured out
already, the DYING callbacks should be called with interrupts disabled.

So rather than "fixing" that particular callback we need to look at the
reason why these callbacks are invoked with interrupts enabled and fix
that.

> Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")

That has nothing to do with 'nosmt'. It's a general bug in the rollback
code when HOTPLUG_CPU=n. 'nosmt' is using the rollback mechanism and is
just a reliable way to trigger the problem. This happens in the same way
when the bringup of a CPU fails for any other reason. That bug was there
way before 0cc3cd21657b.

I'll have a look, but I fear that needs some surgery to fix.

Thanks,

	tglx
