Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FABC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73688206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dbGxvIl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfC2JpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:45:25 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47196 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfC2JpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:45:24 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 792B825BED6;
        Fri, 29 Mar 2019 20:45:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553852721; bh=OywDLxyqIBjQI7GrLCNaAwmWEHY6wcRC+Dapa+EDS1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbGxvIl6UHyFUy0az40hw3nDj50Z/GrIhsNra9iNCNHKnu8Jg/Jn0sCdAf1h1fjib
         YBcbFzFrtkEIQ7O9QECAFFwS9qGFTpKBEPcmj6gIjXgxkbp8y03xGv6wY/Go1myFhN
         65tYU+Eqbwd2+ids0UUC4g0B3YfyrczGqbmPfkeM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 881DB940381; Fri, 29 Mar 2019 10:45:19 +0100 (CET)
Date:   Fri, 29 Mar 2019 10:45:19 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Phil Reid <preid@electromag.com.au>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/7] i2c: core: introduce callbacks for atomic
 transfers
Message-ID: <20190329094519.nc2qwpcja3k4e5il@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
 <20190315122320.34yibpfhv2b6ptwl@verge.net.au>
 <20190327134751.GD5345@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327134751.GD5345@kunai>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Mar 27, 2019 at 02:47:51PM +0100, Wolfram Sang wrote:
> Hi Simon,
> 
> please delete unrelated text. I nearly missed the typo fix later.

Ack, will do.

> > > -	if (in_atomic() || irqs_disabled())
> > > +	if (in_atomic() || irqs_disabled()) {
> > > +		WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atomic,
> > > +		     "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->dev));
> > 
> > 		Is WARN_ONCE more appropriate here?
> 
> Why? It could be multiple adapters or clients causing this?

Good point. I am concerned about the presence of a case which
causes a logging storm.

...


