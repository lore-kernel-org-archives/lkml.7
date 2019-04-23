Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE0320645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="k4OxyZlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfDWOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:01:53 -0400
Received: from onstation.org ([52.200.56.107]:35408 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDWOBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:01:52 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 135293EE68;
        Tue, 23 Apr 2019 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1556028111;
        bh=oYGR0hjvSNwgsPFOiD8HrQZMCp/hcytoqTsEFpcLUPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4OxyZlzeoTsqKH6nhE0RkZkexsX4lrkr4IX1sWZPCIM0aLlntZ7oALmegma/yAkG
         7KSyAtZ+FbfIa2YxocuGzsmwm46Z10KOIaN+0VHO8ZgnnvO0LELb+BYdAt2vg4vXC0
         jyvTlF7KsCR9H/1Obcz8hfB+TTqNiNsRO/WXdwxc=
Date:   Tue, 23 Apr 2019 10:01:50 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v5 3/3] backlight: lm3630a: add firmware node support
Message-ID: <20190423140150.GA10071@basecamp>
References: <20190418151143.26068-1-masneyb@onstation.org>
 <20190418151143.26068-4-masneyb@onstation.org>
 <dc20ab5d-8c44-78a8-3ebc-7fefe8aaf2d5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc20ab5d-8c44-78a8-3ebc-7fefe8aaf2d5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:49:20AM -0500, Dan Murphy wrote:
> > +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
> > +				     int default_led_sources)
> > +{
> > +	u32 sources[LM3630A_NUM_SINKS];
> > +	int ret, num_sources, i;
> > +
> > +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
> > +						     0);
> > +	if (num_sources < 0)
> > +		return default_led_sources;
> > +	else if (num_sources > ARRAY_SIZE(sources))
> > +		return -EINVAL;
> > +
> > +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
> > +					     num_sources);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < num_sources; i++) {
> > +		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
> > +			return -EINVAL;
> > +
> > +		ret |= BIT(sources[i]);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
> > +			      struct fwnode_handle *node, int *seen_led_sources)
> 
> Why is seen_led_sources passed in here?
> It is initialized on the stack in lm3630a_parse_node but the variable is never referenced in that API.

It's to see all of the led-sources that are configured across all of the
banks. If it is just in lm3630a_parse_bank(), then it won't catch the
following invalid configuration:

led@0 {
	reg = <0>;
	led-sources = <0 1>;
	label = "lcd-backlight";
	default-brightness = <200>;
};

led@1 {
	reg = <1>;
	default-brightness = <150>;
};

Brian
