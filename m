Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F45FC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5DF21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfGVLZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:25:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbfGVLZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6863CAF0D;
        Mon, 22 Jul 2019 11:25:44 +0000 (UTC)
Date:   Mon, 22 Jul 2019 13:25:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] printk: Allow architecture-specific timestamping
 function
Message-ID: <20190722112543.5quvqgerpyvfgbxq@pathway.suse.cz>
References: <20190722103330.255312-1-marc.zyngier@arm.com>
 <20190722103330.255312-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722103330.255312-2-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-22 11:33:28, Marc Zyngier wrote:
> printk currently relies on local_clock to time-stamp the kernel
> messages. In order to allow the timestamping (and only that)
> to be overridden by architecture-specific code, let's declare
> a new timestamp_clock() function, which gets used by the printk
> code. Architectures willing to make use of this facility will
> have to define CONFIG_ARCH_HAS_TIMESTAMP_CLOCK.
>
> The default is of course to return local_clock(), so that the
> existing behaviour stays unchanged.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/linux/sched/clock.h | 13 +++++++++++++
>  kernel/printk/printk.c      |  4 ++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
> index 867d588314e0..3cf4b2a8ce18 100644
> --- a/include/linux/sched/clock.h
> +++ b/include/linux/sched/clock.h
> @@ -98,4 +98,17 @@ static inline void enable_sched_clock_irqtime(void) {}
>  static inline void disable_sched_clock_irqtime(void) {}
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_TIMESTAMP_CLOCK
> +/* Special need architectures can provide their timestamping function */

The commit message and the above comment should be more specific
about what are the special needs.

It must be clear how and why the clock differs from the other
clocks, especially from lock_clock().

Also the first mail says that timestamp_clock() might be
unstable. Is this true only during the early boot or all
the time?

The timestamp helps to order the events. An unstable clock
might be better than nothing during the boot. But it would
look strange to use it all the time, especially when it was
unrelated to any other clock used by the system.

Best Regards,
Petr
