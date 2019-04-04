Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47176206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfDDFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:02:26 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:50037 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfDDFC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:02:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4A1D4100E86C4;
        Thu,  4 Apr 2019 05:02:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon02_14868edfea734
X-Filterd-Recvd-Size: 3217
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Apr 2019 05:02:20 +0000 (UTC)
Message-ID: <a302abb662c8c9fae44b5555cb5c7e1bffc20540.camel@perches.com>
Subject: Re: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 03 Apr 2019 22:02:19 -0700
In-Reply-To: <20190403210738.GA9173@ravnborg.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
         <20190403161735.GN5238@ulmo>
         <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
         <c2f6a9f0ea59dc1491a8429a51afe56e488dfb3c.camel@perches.com>
         <20190403210738.GA9173@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 23:07 +0200, Sam Ravnborg wrote:
> Hi Joe.
> 
> Thanks for your patch.
> 
> > ---
> >  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 210 +++++++++++++--------
> >  1 file changed, 136 insertions(+), 74 deletions(-)
> 
> Hmmm, add more lines than it deletes.

Yeah, I said that too.

> > -#define dsi_generic_write_seq(dsi, seq...) do {				\
> > -		static const u8 d[] = { seq };				\
> > -		int ret;						\
> > -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
> > -		if (ret < 0)						\
> > -			return ret;					\
> > -	} while (0)
> The above macro was the one triggering this patch.
> And frankly it looks nice and simple.
> 
> The old code is IMO more readable.
> - We have all the commands listed in the order they
>   are used and in a rahter compatch format.

This too.

> - It is obvious when we need delays.

Here too, also it allows an easy way to update
if there is another delay needed between 2 uses.

> - We have traditional #defines for the constants we know

And the values for the data for those constants are
separated from the constants themselves as well as
at least 1 missing constant.

> This is all to some extent bikeshedding,

Yup.  Still, I think what I suggested is more readable ;)

> but I suggest
> to keep the current code.
> It is simple and it is tested.

btw: The object code for either is the same size on x86-64

> Thanks for trying to come up with a better solution.

n/c.

cheers, Joe


