Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A859AC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB0620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHSKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:46:24 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36339 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:46:23 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id EC97E20035;
        Mon, 19 Aug 2019 12:46:17 +0200 (CEST)
Date:   Mon, 19 Aug 2019 12:46:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Togorean, Bogdan" <Bogdan.Togorean@analog.com>
Cc:     "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matt.redfearn@thinci.com" <matt.redfearn@thinci.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Message-ID: <20190819104616.GA15890@ravnborg.org>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
 <20190809141611.9927-3-bogdan.togorean@analog.com>
 <20190809152510.GA23265@ravnborg.org>
 <c99cfbd3dc45bb02618e7653c33022f3553e1cce.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99cfbd3dc45bb02618e7653c33022f3553e1cce.camel@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=-vBUGyUoSLmi7INXVdEA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan.

> > >  		adv7533_detach_dsi(adv7511);
> > >  	i2c_unregister_device(adv7511->i2c_cec);
> > >  	if (adv7511->cec_clk)
> > > @@ -1266,8 +1278,9 @@ static const struct i2c_device_id
> > > adv7511_i2c_ids[] = {
> > >  	{ "adv7511", ADV7511 },
> > >  	{ "adv7511w", ADV7511 },
> > >  	{ "adv7513", ADV7511 },
> > > -#ifdef CONFIG_DRM_I2C_ADV7533
> > > +#ifdef CONFIG_DRM_I2C_ADV753x
> > >  	{ "adv7533", ADV7533 },
> > > +	{ "adv7535", ADV7535 },
> > >  #endif
> > 
> > This ifdef may not be needed??
> > If we did not get this type we will not look it up.
> But if we have defined in DT adv7533/5 device but
> CONFIG_DRM_I2C_ADV753x not selected probe will fail with ENODEV. That
> would be ok?

What do we gain from this complexity in the end.
Why not let the driver always support all variants.

If this result in a simpler driver, and less choices in Kconfig
then it is a win-win.

	Sam
