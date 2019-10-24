Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48B20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5YqqPZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437184AbfJXC4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:56:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39759 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406392AbfJXC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:56:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so14155701pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dvriWE0Ri4yYKecmkqo5B7W02zBCeLQpMBsjbMKD0G0=;
        b=J5YqqPZRn+eJUvJ5pbTJ3bZ4gZKxBfm6hBNiQppjyOW+oeSQIMtuB6Djo8gpXWhoAF
         we4rAteiGbAkMxNxUAxdNQybrSq/gAcnZY5h4EYuxebgHkvxpfthDK3F8HSUPAv1YuSL
         pbwmjPiZxteiZyD/YURN/9LrN3/OEfYHftB9y0vbZiBKW8KDB49XBD4XskhZyrHdN5cg
         ilFrOToPHpGG33kt3XwBbDEXqAWse8detK3j9lZRKJ0JXEJDUHa4RfNoVPFKy6JAnpse
         oM7bau9C3bfAuTZfBFWtSYko2W8SQV0fRzsBRp27w24xXUhAxRKJcZ1LEXQp46gXjrAz
         LM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dvriWE0Ri4yYKecmkqo5B7W02zBCeLQpMBsjbMKD0G0=;
        b=QWLVlocAXdG5ZioIldG7YcVZpH6qEHjhw+JI6FimYIb4/Jk2o+FngGjAnXvO5vJgx4
         5DQKGql1oarbJsbMKptoKeZKUnjRU98KFfTB4iTAEaEjh30bOKD0qK7niVYYetzVq+Qp
         tLFCGiFXUrTqcCXDePzKKpvUJwTylpRI2FMQYGUavS3CMeN3Nc3yA3qclRSIZqmzTwij
         k90gRF/5/2jODh7vGxdvtF2LkL5umw21A64LAWnJbzok4J+vioDN2pDzdYKghGg938/0
         zSrAfR7aBP/RxzpjxTEcm8l3645/HsjNoN4IheZh4FGsWgFReeQCKHThERQfmA7jJW17
         cTDw==
X-Gm-Message-State: APjAAAV8PUfmrWf4Dxn6pnSHn8neM7IJJk5zAdU2qwKY9NC3Vhhb8m7Q
        LLa3G0WqgGUyfQ9GlGMlOCZDZRRPKTI=
X-Google-Smtp-Source: APXvYqzmHErqih0DgWYtOnVVI91j5+trwCMTyuODEk/82Va7y1F65b+vIxAdFCcs1rQ+6SL84KK0rQ==
X-Received: by 2002:a17:90a:22c6:: with SMTP id s64mr4227508pjc.15.1571885808199;
        Wed, 23 Oct 2019 19:56:48 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y126sm8847533pfg.74.2019.10.23.19.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 19:56:47 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:26:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "v5 . 0+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: of: drop incorrect lockdep_assert_held()
Message-ID: <20191024025641.dknawrtzap4qwcm4@vireshk-i7>
References: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
 <20191023053005.m4y4bcebgi4km35q@vireshk-i7>
 <20191023120137.GA18078@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023120137.GA18078@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 14:01, Niklas Cassel wrote:
> On Wed, Oct 23, 2019 at 11:00:05AM +0530, Viresh Kumar wrote:
> > On 10-10-19, 16:00, Viresh Kumar wrote:
> > > _find_opp_of_np() doesn't traverse the list of OPP tables but instead
> > > just the entries within an OPP table and so only requires to lock the
> > > OPP table itself.
> > > 
> > > The lockdep_assert_held() was added there by mistake and isn't really
> > > required.
> > > 
> > > Fixes: 5d6d106fa455 ("OPP: Populate required opp tables from "required-opps" property")
> > > Cc: v5.0+ <stable@vger.kernel.org> # v5.0+
> > > Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/opp/of.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > index 1813f5ad5fa2..6dc41faf74b5 100644
> > > --- a/drivers/opp/of.c
> > > +++ b/drivers/opp/of.c
> > > @@ -77,8 +77,6 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
> > >  {
> > >  	struct dev_pm_opp *opp;
> > >  
> > > -	lockdep_assert_held(&opp_table_lock);
> > > -
> > >  	mutex_lock(&opp_table->lock);
> > >  
> > >  	list_for_each_entry(opp, &opp_table->opp_list, node) {
> > 
> > @Niklas, any inputs from your side  here would be appreciated :)
> 
> Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> 
> After this patch, there is still a single lockdep_assert_held()
> left, inside _find_table_of_opp_np(), since you kept this,
> I assume that that one is still needed?

Yeah, that one is required as we are traversing the list of OPP tables
there.

-- 
viresh
