Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FC5206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfC0PRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfC0PRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FB96D4030;
        Wed, 27 Mar 2019 15:17:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 57BC96085B;
        Wed, 27 Mar 2019 15:16:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Mar 2019 16:16:59 +0100 (CET)
Date:   Wed, 27 Mar 2019 16:16:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] watchdog: Respect watchdog cpumask on CPU hotplug
Message-ID: <20190327151653.GA23811@redhat.com>
References: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Mar 2019 15:17:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26, Thomas Gleixner wrote:
>
> The rework of the watchdog core to use cpu_stop_work broke the watchdog
> cpumask on CPU hotplug.
>
> The watchdog_enable/disable() functions are now called unconditionally from
> the hotplug callback, i.e. even on CPUs which are not in the watchdog
> cpumask.
>
> Only invoke them when the plugged CPU is in the watchdog cpumask.
>
> Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  kernel/watchdog.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -547,13 +547,15 @@ static void softlockup_start_all(void)
>
>  int lockup_detector_online_cpu(unsigned int cpu)
>  {
> -	watchdog_enable(cpu);
> +	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
> +		watchdog_enable(cpu);
>  	return 0;
>  }
>
>  int lockup_detector_offline_cpu(unsigned int cpu)
>  {
> -	watchdog_disable(cpu);
> +	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
> +		watchdog_disable(cpu);
>  	return 0;
>  }

IIUC without this fix an NMI watchdog can too be enabled at boot time even
if the initial watchdog_cpumask = housekeeping_cpumask(HK_FLAG_TIMER) doesn't
include the plugged CPU.

And after that writing 0 to /proc/sys/kernel/nmi_watchdog clears
NMI_WATCHDOG_ENABLED but this can't disable NMI watchdog's outside of
watchdog_allowed_mask.

So may be this can explain the problem reported by Maxime ?
See https://lore.kernel.org/lkml/b99c5a25-a5fe-18dd-2f1d-bdd6834f03e5@redhat.com/

Oleg.

