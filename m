Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4BA20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfDBIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:43:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46308 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfDBIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:43:26 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id bcab5ef04fc160bb; Tue, 2 Apr 2019 10:43:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Wenkai Du <wenkai.du@intel.com>,
        Justin TerAvest <teravest@chromium.org>
Subject: Re: [PATCH] PM / wakeup: Use pm_pr_dbg() instead of pr_debug()
Date:   Tue, 02 Apr 2019 10:41:19 +0200
Message-ID: <4534427.J6G7dtiVmp@aspire.rjw.lan>
In-Reply-To: <20190325172456.227190-1-swboyd@chromium.org>
References: <20190325172456.227190-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 25, 2019 6:24:56 PM CEST Stephen Boyd wrote:
> These prints are useful if we're doing PM suspend debugging. Having them
> at pr_debug() level means that we need to either enable DEBUG in this
> file, or compile the kernel with dynamic debug capabilities. Both of
> these options have drawbacks like custom compilation or opting into all
> debug statements being included into the kernel image. Given that we
> already have infrastructure to collect PM debugging information with
> CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
> pm_pr_dbg() instead so we can collect the wakeup information in the
> kernel logs.
> 
> Cc: Wenkai Du <wenkai.du@intel.com>
> Cc: Justin TerAvest <teravest@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index bb1ae175fae1..23c243a4c675 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -804,7 +804,7 @@ void pm_print_active_wakeup_sources(void)
>  	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>  		if (ws->active) {
> -			pr_debug("active wakeup source: %s\n", ws->name);
> +			pm_pr_dbg("active wakeup source: %s\n", ws->name);
>  			active = 1;
>  		} else if (!active &&
>  			   (!last_activity_ws ||
> @@ -815,7 +815,7 @@ void pm_print_active_wakeup_sources(void)
>  	}
>  
>  	if (!active && last_activity_ws)
> -		pr_debug("last active wakeup source: %s\n",
> +		pm_pr_dbg("last active wakeup source: %s\n",
>  			last_activity_ws->name);
>  	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
> @@ -845,7 +845,7 @@ bool pm_wakeup_pending(void)
>  	raw_spin_unlock_irqrestore(&events_lock, flags);
>  
>  	if (ret) {
> -		pr_debug("Wakeup pending, aborting suspend\n");
> +		pm_pr_dbg("Wakeup pending, aborting suspend\n");
>  		pm_print_active_wakeup_sources();
>  	}
>  
> 

Applied, thanks!


