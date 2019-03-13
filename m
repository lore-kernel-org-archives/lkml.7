Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F9C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDBD2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMJ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:58:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47421 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:58:33 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id de74e06d03276472; Wed, 13 Mar 2019 10:58:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        jorge.ramirez-ortiz@linaro.org, "v5 . 0" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / OPP: Update performance state when freq == old_freq
Date:   Wed, 13 Mar 2019 10:56:44 +0100
Message-ID: <12337613.44RoPr5aty@aspire.rjw.lan>
In-Reply-To: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
References: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 12, 2019 5:57:18 AM CET Viresh Kumar wrote:
> At boot up, CPUfreq core performs a sanity check to see if the system is
> running at a frequency defined in the frequency table of the CPU. If so,
> we try to find a valid frequency (lowest frequency greater than the
> currently programmed frequency) from the table and set it. When the call
> reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
> &old_freq) to find the previously configured OPP and this call also
> updates the old_freq. This eventually sets the old_freq == freq (new
> target requested by cpufreq core) and we skip updating the performance
> state in this case.
> 
> Fix this by also updating the performance state when the old_freq ==
> freq.
> 
> Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
> Cc: v5.0 <stable@vger.kernel.org> # v5.0
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d7f97167cac3..0420f7e8ad5b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -760,7 +760,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		old_freq, freq);
>  
>  	/* Scaling up? Configure required OPPs before frequency */
> -	if (freq > old_freq) {
> +	if (freq >= old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);
>  		if (ret)
>  			goto put_opp;
> 

Applied, thanks!


