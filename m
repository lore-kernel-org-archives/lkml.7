Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661EC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:21:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:21:32 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h47ZG-0007Gg-QX; Wed, 13 Mar 2019 18:21:26 +0100
Message-ID: <1552497686.2453.49.camel@pengutronix.de>
Subject: Re: [PATCH] regulator: Use of_node_name_eq for node name comparisons
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Mar 2019 18:21:26 +0100
In-Reply-To: <20181205195050.4759-21-robh@kernel.org>
References: <20181205195050.4759-21-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, hi Mark,

Am Mittwoch, den 05.12.2018, 13:50 -0600 schrieb Rob Herring:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
[...]
> diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
> index 65eb1e0350cf..2243138d8a58 100644
> --- a/drivers/regulator/mc13xxx-regulator-core.c
> +++ b/drivers/regulator/mc13xxx-regulator-core.c
> @@ -186,7 +186,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
> >  		for (i = 0; i < num_regulators; i++) {
> >  			if (!regulators[i].desc.name)
> >  				continue;
> > -			if (!of_node_cmp(child->name,
> > +			if (of_node_name_eq(child,
> >  					 regulators[i].desc.name))
> > 

Unfortunately this change causes a regression on systems with MC13xxx
regulators. The desc.name field is filled with an uppercase name of the
regulator, while the existing DTs (as far as I know) all use lowercase
node names, so the matching in the function above doesn't work anymore.

Any opinions about how to proceed here?

Regards,
Lucas
