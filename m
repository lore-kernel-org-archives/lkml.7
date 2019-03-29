Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A59C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D2720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="bRRvTGzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfC2JqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:46:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47238 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2JqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:46:01 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id DF6C625BECC;
        Fri, 29 Mar 2019 20:45:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553852759; bh=b7OhgqJWjxvsgy6acu36uEspRq9HvxkIimkFQXqyd3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRRvTGzivYC7+nPvCkQcHhngkoJKMw+doDQIUgCeWg1fGvEaYgW85IP4mYaO/Jfu1
         Z+oTYfnh6tUNu923MDThLwxUPlUw9hvkOCNdYahkV1uYOHO6gbP2V5Z1ohjcD9cvTt
         mwLGDV9SlegfDbpqUvCFNtGksvTMY57tLaRGPbCo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0829A940381; Fri, 29 Mar 2019 10:45:56 +0100 (CET)
Date:   Fri, 29 Mar 2019 10:45:56 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Message-ID: <20190329094556.wsdusg24ldy52ocw@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
 <20190315131435.GE9224@smile.fi.intel.com>
 <20190327135045.GE5345@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327135045.GE5345@kunai>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:50:45PM +0100, Wolfram Sang wrote:
> 
> > > > +		if (!ret)
> > > > +			timeout = 1;
> > > > +		else
> > > > +			timeout = 0;
> > > 
> > > 
> > > nit: the following might be cleaner
> > > 
> > > 		ret = !!timeout;
> > > 
> > 
> > Other way around, perhaps,
> > 
> >       timeout = !ret;
> 
> I saw that but didn't want to modify this patch. But yes, this is easy
> enough and looks a lot better.

Thanks, I don't think this needs to block progress.

