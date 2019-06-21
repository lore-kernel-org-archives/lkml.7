Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B067C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224BC2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFUREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:04:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:04:36 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heMxd-000217-6g; Fri, 21 Jun 2019 19:04:25 +0200
Date:   Fri, 21 Jun 2019 19:04:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, tipbuild@zytor.com, lkp@01.org
Subject: Re: [x86/hpet] 286b15db78: BUG:KASAN:wild-memory-access_in_t
In-Reply-To: <20190620032009.716-1-hdanton@sina.com>
Message-ID: <alpine.DEB.2.21.1906211902060.5503@nanos.tec.linutronix.de>
References: <20190620032009.716-1-hdanton@sina.com>
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

On Thu, 20 Jun 2019, Hillf Danton wrote:
> > 
> > +------------------------------------------+------------+------------+
> > |                                          | dfd001e50c | 286b15db78 |
> > +------------------------------------------+------------+------------+
> > | boot_successes                           | 14         | 0          |
> > | boot_failures                            | 0          | 16         |
> > | BUG:KASAN:wild-memory-access_in_t        | 0          | 16         |
> > | general_protection_fault:#[##]           | 0          | 16         |
> > | RIP:try_module_get                       | 0          | 16         |
> > | Kernel_panic-not_syncing:Fatal_exception | 0          | 16         |
> > +------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [    2.801166] BUG: KASAN: wild-memory-access in try_module_get+0x78/0x1bf
> > [    2.803334] Read of size 4 at addr 6b6b6b6b6b6b6b6b by task swapper/0

Yuck.

> > 
> Try to pump up module after checking it is valid only if .owner = THIS_MODULE
> does not help in the case of hpet.

Errrm?

> Hillf
> ---
>  kernel/time/tick-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 529143b..1b33215 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -311,7 +311,7 @@ void tick_check_new_device(struct clock_event_device *newdev)
>  	if (!tick_check_preferred(curdev, newdev))
>  		goto out_bc;
>  
> -	if (!try_module_get(newdev->owner))
> +	if (newdev->owner && !try_module_get(newdev->owner))

How does that prevent the above? That's not about a NULL pointer. Its
simply uninitialized memory.

Aside that the check is pointless as try_module_get() has a NULL pointer
check inside already.

Thanks,

	tglx

