Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F19C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB621835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575645785;
	bh=UpWsZq5WNDwRxE6BRyTSnkx+GCLlc0rv9QoYB1DG0Xg=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=gEZdnQdfznkRmKLMPBHOfrhzNf13tMcjmZ8FAy6BAEubJVWLzjR8V2dZxP00DtEp9
	 W+CBzJzuAHaHRJ9Kq6hz9xak4hP7h2uvotB6+64oVn8XQRvrZ6ztgHW9VSu6sYLCmy
	 2AzemMopWD73aWVWYD4lHEEIfKUbAGwsOjrLhK/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLFPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:23:03 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33257 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbfLFPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:23:03 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1idFRX-0005L4-45; Fri, 06 Dec 2019 16:22:55 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 15:22:53 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <bvanassche@acm.org>, <peterz@infradead.org>,
        <mingo@redhat.com>
In-Reply-To: <1575642904-58295-2-git-send-email-john.garry@huawei.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
Message-ID: <e44ca3b9684277bb6659b2676ef72ad8@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: john.garry@huawei.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2019-12-06 14:35, John Garry wrote:
> Currently the cpu allowed mask for the threaded part of a threaded 
> irq
> handler will be set to the effective affinity of the hard irq.
>
> Typically the effective affinity of the hard irq will be for a single
> cpu. As such,
> the threaded handler would always run on the same cpu as the hard 
> irq.
>
> We have seen scenarios in high data-rate throughput testing that the 
> cpu
> handling the interrupt can be totally saturated handling both the 
> hard
> interrupt and threaded handler parts, limiting throughput.
>
> For when the interrupt is managed, allow the threaded part to run on 
> all
> cpus in the irq affinity mask.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  kernel/irq/manage.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1753486b440c..8e7f8e758a88 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -968,7 +968,11 @@ irq_thread_check_affinity(struct irq_desc *desc,
> struct irqaction *action)
>  	if (cpumask_available(desc->irq_common_data.affinity)) {
>  		const struct cpumask *m;
>
> -		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +		if (irqd_affinity_is_managed(&desc->irq_data))
> +			m = desc->irq_common_data.affinity;
> +		else
> +			m = irq_data_get_effective_affinity_mask(
> +					&desc->irq_data);
>  		cpumask_copy(mask, m);
>  	} else {
>  		valid = false;

Although I completely understand that there are cases where you
really want to let your thread roam all CPUs, I feel like changing
this based on a seemingly unrelated property is likely to trigger
yet another whack-a-mole episode. I'd feel much more comfortable
if there was a way to let the IRQ subsystem know about what is best.

Shouldn't the endpoint driver know better about it? Note that
I have no data supporting an approach or the other, hence playing
the role of the village idiot here.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
