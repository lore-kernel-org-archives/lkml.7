Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487FC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BbnFOFST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCDMU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:20:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36224 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:20:29 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED1D1322;
        Mon,  4 Mar 2019 13:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702027;
        bh=UUt7uxYVF+P4/h6B+6jShHNIZvXptTdwrd75a0yc2js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbnFOFSTgPy3aOlER6Ia45QvtsOh2N5FzlvoDBH1oPK+5qRlpra5SfOLxSe+scdlb
         A0XxI7rrfkc66nYowMkGUsOUeTDLgK7wG++UvMW4K7W4Ksxax5BEJB/mxcZXshl3hj
         vb3odFVozf/iUIJRhOzlV+ei3jBQs5hdjS5BvZ74=
Date:   Mon, 4 Mar 2019 14:20:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] drm/bridge: tc358767: Simplify tc_stream_clock_calc()
Message-ID: <20190304122021.GD6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <CGME20190226193632epcas4p139e0002746989958fef4913a0af9fc0d@epcas4p1.samsung.com>
 <20190226193609.9862-3-andrew.smirnov@gmail.com>
 <bad3c902-8ead-dbe4-fa77-e365dd29e6f2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bad3c902-8ead-dbe4-fa77-e365dd29e6f2@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 04, 2019 at 10:42:20AM +0100, Andrzej Hajda wrote:
> On 26.02.2019 20:36, Andrey Smirnov wrote:
> > Drop the use of tc_write() as well as "magicly" used "ret" and "err:"
> > and replace it with a simple call to regmap_write(). No functional
> > change intended.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index b0f8264a1285..86ebd49194b7 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -504,7 +504,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
> >  
> >  static int tc_stream_clock_calc(struct tc_data *tc)
> >  {
> > -	int ret;
> >  	/*
> >  	 * If the Stream clock and Link Symbol clock are
> >  	 * asynchronous with each other, the value of M changes over
> > @@ -520,11 +519,7 @@ static int tc_stream_clock_calc(struct tc_data *tc)
> >  	 * M/N = f_STRMCLK / f_LSCLK
> >  	 *
> >  	 */
> > -	tc_write(DP0_VIDMNGEN1, 32768);
> > -
> > -	return 0;
> > -err:
> > -	return ret;
> > +	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
> 
> 
> The patch looks semantically correct, but you are dropping here custom
> accessor (tc_write) in favor of regmap API.
> 
> I think the best would be consistent across the whole driver: either use
> only  accessors, either drop them entirely and use regmap API.

I agree with this. The tc_write macro with its goto err is pretty nasty,
and I'd like to see it removed from the whole driver, or at least
replaced with an accessor that wouldn't hide the goto.

> And it would be good to have comment of the original authors about this
> change.
> 
> >  }
> >  
> >  static int tc_aux_link_setup(struct tc_data *tc)

-- 
Regards,

Laurent Pinchart
