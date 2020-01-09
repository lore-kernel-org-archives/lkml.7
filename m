Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE09C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03EB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgAIUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:15:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgAIUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:15:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipeDV-0007Uk-G0; Thu, 09 Jan 2020 21:15:41 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BF026105BCE; Thu,  9 Jan 2020 21:15:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] reboot: hotplug cpus in migrate_to_reboot_cpu()
In-Reply-To: <20191009232655.48583-1-hsinyi@chromium.org>
Date:   Thu, 09 Jan 2020 21:15:40 +0100
Message-ID: <87blrcbd3n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> @@ -220,8 +221,6 @@ void migrate_to_reboot_cpu(void)
>  	/* The boot cpu is always logical cpu 0 */
>  	int cpu = reboot_cpu;
>  
> -	cpu_hotplug_disable();
> -
>  	/* Make certain the cpu I'm about to reboot on is online */
>  	if (!cpu_online(cpu))
>  		cpu = cpumask_first(cpu_online_mask);
> @@ -231,6 +230,11 @@ void migrate_to_reboot_cpu(void)
>  
>  	/* Make certain I only run on the appropriate processor */
>  	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +	/* Hotplug other cpus if possible */
> +#ifdef CONFIG_HOTPLUG_CPU
> +	offline_secondary_cpus(cpu);
> +#endif

In general I like the idea, but shouldn't this remove the architecture
code as a follow up?

Also this needs to be explicitely enabled per architecture (opt-in) and
not as an unconditional operation for all architectures which support
CPU hotplug.

Thanks,

        tglx
