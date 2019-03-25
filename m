Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1EBC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBED520879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553544760;
	bh=+YtJAzMwVrQKVqNDxH5zf87X6cik+yHaqvGJ7C6urKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B71uXKup85HwGNvgKyN7kBA6KlBNzcItg3dCmsS3m7SrpQAe7Nm1Sh1naFM+5m5DU
	 L/9ehDwseCnJnnpbITLZGcC2ZcT1uRPP35DTKm9z/rwPvt3MZ20OX2X6rLXVzqrjDt
	 AW665Gei9MVdueEgMcjymM5aXS26vbZHXiXYqEUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfCYUMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:12:38 -0400
Received: from localhost (unknown [218.237.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD8F2087C;
        Mon, 25 Mar 2019 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553544757;
        bh=+YtJAzMwVrQKVqNDxH5zf87X6cik+yHaqvGJ7C6urKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2jqTnS/qt63TU/pW06pRHyY3CP1t+2zymRi6bVai16JJCf0+U/6yxPMk9pGNuEd6
         wzhrpauxe55fV1SuccYQnl+twaUJnSUMXDNruNjhgO+Qaurl/syqbbYgzKrpeM9k6q
         kBBW0Q7GMU8YIz4bIy5iboAIcvBDr3tsU1Ux3o1E=
Date:   Tue, 26 Mar 2019 04:31:13 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lantianyu1986@gmail.com
Cc:     tglx@linutronix.de, mingo@kernel.org, konrad.wilk@oracle.com,
        jpoimboe@redhat.com, peterz@infraded.org, mojha@codeaurora.org,
        peterz@infradead.org, jkosina@suse.cz, riel@surriel.com,
        luto@kernel.org, Tianyu.Lan@microsoft.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Fix PATCH] cpu/hotplug: Fix bug report when add "nosmt"
 parameter with CONFIG_HOTPLUG_CPU=N
Message-ID: <20190325193113.GA14852@kroah.com>
References: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:51:23PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
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
> 
> smpcfd_dying_cpu() is one of CPU_DYING callbacks and it assumes to be
> called when irq is disabled. smpcfd_dying_cpu() calls flush_smp_call_
> function_queue() which requires to be called with irq disabled.
> 
> When CONFIG_HOTPLUG_CPU=N and add "nosmt" parameter, smpcfd_dying_cpu()
> is called with irq enalbed and this triggers BUG_ON(!irqs_disabled())
> in the irq_work_run_list(). This patch is to fix the issue.
> 
> Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
