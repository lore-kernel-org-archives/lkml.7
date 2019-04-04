Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99810C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBC320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfDDORe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:17:34 -0400
Received: from muru.com ([72.249.23.125]:44372 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:17:33 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E886580D4;
        Thu,  4 Apr 2019 14:17:47 +0000 (UTC)
Date:   Thu, 4 Apr 2019 07:17:30 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190404141730.GE49658@atomide.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327081142.GA11034@lenoch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
> Hello Nathan,
> 
> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
> > Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
> > omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
> > static because its prototype was not defined in a header. Unfortunately,
> > this causes a build warning on multi_v7_defconfig because this function
> > is not used anywhere in this translation unit:
> > 
> > drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
> > 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
> > 
> > In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
> > commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
> > prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
> > Make unexported functions static"), which is probably where this should
> > have happened.
> 
> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
> function being removed here). It is a part of an attempt to add event capture
> for OMAP. Of course I would like this functionality to be implemented, but
> as I do not have a time to continue, I cannot really object removing this
> function.
> 
> Just in case you'd be interested in finishing this task ;-)

Well seems like no other takers :) We can always find the missing
function in git history when needed, so I suggest we apply this.

Adding Keerthy to Cc as he just posted a similar patch.

Regards,

Tony
