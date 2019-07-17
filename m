Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BBC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C7E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbX7R/Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfGQCwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:52:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34476 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfGQCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:52:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so11154102plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wuLqDfULAB39YnZgj7k2QkDp3/RJGX96MN015DTBiZc=;
        b=mbX7R/Y+HcSnVUJoumXkghmrx0t/XVHfKQJQxJC6eEUDONiWV6YG/TyT4FMw1JvsRo
         Xh7hVU/BQr52QZMk6EGRO6OLHW8/JNG9TXBBsJuXZvwk6DoXuU/+yKfVlGuKc8X8wHQu
         CdauH0erBit85KKhWgSkcXvRN3ATEwHK2pGQ6N9NMkl+HMmBzg16MXIjzYbg3io5YE7O
         JbuqhaXObx0BSp5zT4XGURP9BQdRO7NMg95Su55vtYHvhuzErBPeP6hwKaVk66onEBGS
         H/c2bL3X3NK8m3M8SPBIzUTKfk71dFzc9cbIK/iuk3fpeOforZs1Ln+sKntlwiGzbKow
         Ndjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wuLqDfULAB39YnZgj7k2QkDp3/RJGX96MN015DTBiZc=;
        b=kngaeM6uQebRgYGo5yg1w6Aqzd5koQ8z54eUgc2WZ8ofQoa6gQdo8Vct2CeWODJKj3
         P0/6nZrusjgoiqZq4yHjeuihXUnSaBFcEA0no1FUoC9Hr/BNbItZgF18hqnUcpVYNW6L
         cgptWIQvsPCXofCPtdSkF9Ideod03NOkDIGKQOdY65IIVq9kG4mruLHBATjKQWuhwe94
         VOZEcCLtrlkah9dLNw+nKCf9RIK3wwec+WYFX229xB5mnV50pZw1R0i049mhNF+Vak2B
         +/geXC03T/FU2JyT4+DuZy4DunjtMhToDeYyUHKyL4bl7Fh5lZsEBfqj6wQT/9tYb547
         aZeg==
X-Gm-Message-State: APjAAAVbXTBLYJjwBsHfjEbhAOUamNNVZc1YgTWyUQQBghiKldBZdTQv
        BhcGE5zNYc3ZiCRUuq8Sez45TA==
X-Google-Smtp-Source: APXvYqwxnQ1mFrdFRTTHdBHioQD0o56X9gJ6F7T6d2RGVvDbh2Msrrxo1WT6eUlBcVDRxXfZ1kdWxg==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr5778512plr.202.1563331940824;
        Tue, 16 Jul 2019 19:52:20 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id b190sm8122147pga.37.2019.07.16.19.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 19:52:19 -0700 (PDT)
Date:   Wed, 17 Jul 2019 08:22:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190717025217.ne5tf2le2lj7oxbf@vireshk-i7>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <20190716104354.GA13780@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716104354.GA13780@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-19, 12:43, Niklas Cassel wrote:
> On Mon, Jul 08, 2019 at 11:30:11AM +0530, Viresh Kumar wrote:
> > The cpufreq drivers don't need to do runtime PM operations on the
> > virtual devices returned by dev_pm_domain_attach_by_name() and so the
> > virtual devices weren't shared with the callers of
> > dev_pm_opp_attach_genpd() earlier.
> > 
> > But the IO device drivers would want to do that. This patch updates the
> > prototype of dev_pm_opp_attach_genpd() to accept another argument to
> > return the pointer to the array of genpd virtual devices.
> > 
> > Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > @Rajendra: Can you please test this one ? I have only compile tested it.
> > 
> >  drivers/opp/core.c     | 5 ++++-
> >  include/linux/pm_opp.h | 4 ++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2958cc7bbb58..07b6f1187b3b 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >   * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
> >   * @dev: Consumer device for which the genpd is getting attached.
> >   * @names: Null terminated array of pointers containing names of genpd to attach.
> > + * @virt_devs: Pointer to return the array of virtual devices.
> >   *
> >   * Multiple generic power domains for a device are supported with the help of
> >   * virtual genpd devices, which are created for each consumer device - genpd
> > @@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >   * This helper needs to be called once with a list of all genpd to attach.
> >   * Otherwise the original device structure will be used instead by the OPP core.
> >   */
> > -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> > +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> > +		const char **names, struct device ***virt_devs)
> >  {
> >  	struct opp_table *opp_table;
> >  	struct device *virt_dev;
> > @@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
> >  		name++;
> >  	}
> >  
> > +	*virt_devs = opp_table->genpd_virt_devs;
> 
> Could we perhaps only do this if (virt_devs), that way callers can send in
> NULL if they don't care about the genpd virtual devices.

That was the idea and I failed to add it :(

-- 
viresh
