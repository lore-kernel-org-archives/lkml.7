Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5822B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfHZJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:22:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45663 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:22:59 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 5f4a13a5f27ca4dc; Mon, 26 Aug 2019 11:22:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
Date:   Mon, 26 Aug 2019 11:22:56 +0200
Message-ID: <9030003.WlOONWmqy1@kreacher>
In-Reply-To: <b534e21b-af00-bbec-2a53-0c3bda8c8ce9@gmail.com>
References: <20190821231632.29133-1-f.fainelli@gmail.com> <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7> <b534e21b-af00-bbec-2a53-0c3bda8c8ce9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 22, 2019 6:21:20 PM CEST Florian Fainelli wrote:
> On 8/21/19 7:42 PM, Viresh Kumar wrote:
> > On 21-08-19, 16:16, Florian Fainelli wrote:
> >> Instead of printing the policy, which is incidentally a kernel pointer,
> >> so with limited interest, print the cpufreq driver name that failed to
> >> be suspend, which is more useful for debugging.
> >>
> >> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
> > 
> > I will drop this tag as this isn't a bug really.
> 
> Indeed, that was a bit too trigger happy on my side. Thanks!

Applied without the Fixes tag, thanks!

> > 
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index c28ebf2810f1..330d789f81fc 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
> >>  		}
> >>  
> >>  		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
> >> -			pr_err("%s: Failed to suspend driver: %p\n", __func__,
> >> -				policy);
> >> +			pr_err("%s: Failed to suspend driver: %s\n", __func__,
> >> +				cpufreq_driver->name);
> >>  	}
> >>  
> >>  suspend:
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> 
> 




