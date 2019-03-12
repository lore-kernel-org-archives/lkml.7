Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF905C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893EE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCLJiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:38:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54195 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfCLJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:38:07 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 650b777ef35c195b; Tue, 12 Mar 2019 10:37:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, nm@ti.com,
        sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix handling of multiple power domains
Date:   Tue, 12 Mar 2019 10:36:06 +0100
Message-ID: <1695972.KL8iO62iuq@aspire.rjw.lan>
In-Reply-To: <20190308043712.3aca6lygz2oya3lc@vireshk-i7>
References: <20190306040726.1930-1-rnayak@codeaurora.org> <20190308043712.3aca6lygz2oya3lc@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 8, 2019 5:37:12 AM CET Viresh Kumar wrote:
> On 06-03-19, 09:37, Rajendra Nayak wrote:
> > We seem to rely on the number of phandles specified in the
> > 'required-opps' property to identify cases where a device is
> > associated with multiple power domains and hence would have
> > multiple virtual devices that have to be dealt with.
> > 
> > In cases where we do have devices with multiple power domains
> > but with only one of them being scalable, this logic seems to
> > fail.
> > 
> > Instead read the number of power domains from DT to identify
> > such cases.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> >  drivers/opp/of.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 06f0f632ec47..443c305ae100 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -172,7 +172,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >  	struct opp_table **required_opp_tables;
> >  	struct device **genpd_virt_devs = NULL;
> >  	struct device_node *required_np, *np;
> > -	int count, i;
> > +	int count, count_pd, i;
> >  
> >  	/* Traversing the first OPP node is all we need */
> >  	np = of_get_next_available_child(opp_np, NULL);
> > @@ -185,7 +185,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >  	if (!count)
> >  		goto put_np;
> >  
> > -	if (count > 1) {
> > +	/*
> > +	 * Check the number of power-domains to know if we need to deal
> > +	 * with virtual devices. In some cases we have devices with multiple
> > +	 * power domains but with only one of them being scalable, hence
> > +	 * 'count' could be 1, but we still have to deal with multiple genpds
> > +	 * and virtual devices.
> > +	 */
> > +	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> > +					      "#power-domain-cells");
> > +	if (!count_pd)
> > +		goto put_np;
> > +
> > +	if (count_pd > 1) {
> >  		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> >  					GFP_KERNEL);
> >  		if (!genpd_virt_devs)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael, please pick this up for 5.1-rc2 directly. Thanks.

Done, thanks!

