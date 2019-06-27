Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33838C5B54D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D42133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF0WAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:00:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41717 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0WAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:00:39 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 55e063564d232bad; Fri, 28 Jun 2019 00:00:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        David Arcari <darcari@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pcc-cpufreq: Fail initialization if driver cannot be registered
Date:   Fri, 28 Jun 2019 00:00:37 +0200
Message-ID: <5175938.k7Tzu7MeQO@kreacher>
In-Reply-To: <20190607030546.7kjg466wbkzxfym4@vireshk-i7>
References: <20190606185052.71959-1-darcari@redhat.com> <20190607030546.7kjg466wbkzxfym4@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 7, 2019 5:05:46 AM CEST Viresh Kumar wrote:
> On 06-06-19, 14:50, David Arcari wrote:
> > Make pcc_cpufreq_init() return error codes when the driver cannot be
> > registered.  Otherwise the driver can shows up loaded via lsmod even
> > though it failed initialization.  This is confusing to the user.
> > 
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/pcc-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> > index 1e5e64643c3a..fdc767fdbe6a 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -582,10 +582,10 @@ static int __init pcc_cpufreq_init(void)
> >  
> >  	/* Skip initialization if another cpufreq driver is there. */
> >  	if (cpufreq_get_current_driver())
> > -		return 0;
> > +		return -EEXIST;
> >  
> >  	if (acpi_disabled)
> > -		return 0;
> > +		return -ENODEV;
> >  
> >  	ret = pcc_cpufreq_probe();
> >  	if (ret) {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!



