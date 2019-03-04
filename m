Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2052070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v8ZV2+Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCDMbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:31:00 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36336 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:31:00 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 019FF322;
        Mon,  4 Mar 2019 13:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702658;
        bh=9xEi0WezvKlK4ejlIY7sMBrrIicoJR8kBKwDzClZIJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8ZV2+Te/0DyqeuyXhfiYJCmEwB0oJ/pBkRWLNoHbFcQoYRsBYpj8jIFJgGUAcZsw
         P6HpNS3QCK4rSIMvnEq96f7mmsH8cNdNQKz8GNpqtcpc63+orwgedgu7vIIlnnRQoj
         D2E6Nfe2POatzk8CWx5HxCJke1CuZFQMW12qWvZ4=
Date:   Mon, 4 Mar 2019 14:30:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] drm/bridge: tc358767: Simplify polling in
 tc_link_training()
Message-ID: <20190304123052.GG6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-6-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-6-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:05AM -0800, Andrey Smirnov wrote:
> Replace explicit polling in tc_link_training() with equivalent call to
> regmap_read_poll_timeout() for simplicity. No functional change
> intended (not including slightly altered debug output).
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 6455e6484722..ea30cec4a0c3 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -735,7 +735,6 @@ static int tc_link_training(struct tc_data *tc, int pattern)
>  	const char * const *errors;
>  	u32 srcctrl = tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
>  		      DP0_SRCCTRL_AUTOCORRECT;
> -	int timeout;
>  	int retry;
>  	u32 value;
>  	int ret;
> @@ -765,20 +764,17 @@ static int tc_link_training(struct tc_data *tc, int pattern)
>  		tc_write(DP0CTL, DP_EN);
>  
>  		/* wait */
> -		timeout = 1000;
> -		do {
> -			tc_read(DP0_LTSTAT, &value);
> -			udelay(1);
> -		} while ((!(value & LT_LOOPDONE)) && (--timeout));
> -		if (timeout == 0) {
> +		ret = regmap_read_poll_timeout(tc->regmap, DP0_LTSTAT, value,
> +					       value & LT_LOOPDONE, 1, 1000);
> +		if (ret) {
>  			dev_err(tc->dev, "Link training timeout!\n");
>  		} else {
>  			int pattern = (value >> 11) & 0x3;
>  			int error = (value >> 8) & 0x7;
>  
>  			dev_dbg(tc->dev,
> -				"Link training phase %d done after %d uS: %s\n",
> -				pattern, 1000 - timeout, errors[error]);
> +				"Link training phase %d done: %s\n",
> +				pattern, errors[error]);

It's probably not a big deal in this specific case, but in general it
can be useful to know how long the poll took. Any hope to enhance
regmap_read_poll_timeout() to return either the elapsed time or the
remaining timeout instead of 0 on success ?

>  			if (pattern == DP_TRAINING_PATTERN_1 && error == 0)
>  				break;
>  			if (pattern == DP_TRAINING_PATTERN_2) {

-- 
Regards,

Laurent Pinchart
