Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0576C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906420873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560862803;
	bh=DH5P8RwITKpz+5OhRwTGjbtFNcshKGlhFZA5nFAj+Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vOuYc2fhxNM+7CunE0lBUOU6dk+M5YbEZ2fESuxOXcCjt3uLaBAOBgWmqtErVOi7x
	 sYLDrUfKgFERMDBpCNcHtKaVVFBOGl4VjkXhPDAusYIcXjAR7GO1QPVVPe7x7Q7uJZ
	 5i9SmgVx2atadjLCfESQOtsFn73acKKU/7SY3Tkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfFRNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfFRNAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:00:02 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1BB20665;
        Tue, 18 Jun 2019 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560862800;
        bh=DH5P8RwITKpz+5OhRwTGjbtFNcshKGlhFZA5nFAj+Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAtwl7Y9Crn3H8eqFQgpO4Eq5xocFt2+9mo8ybrrJC4ZXOmFfJe+DMHRNMgEpGMZC
         h1wFukzt45WpJPXhKlf8S4rGt1yM1Z/9g0E60cm0+JyLY/FMLrU5QLW8wWCuzwwgT+
         Fvf95vBbtGzs1imPvLn/aG6GTU6QHzoKwhRxlds0=
Date:   Tue, 18 Jun 2019 20:59:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Message-ID: <20190618125902.GN29881@dragon>
References: <20190611013125.3434-1-Anson.Huang@nxp.com>
 <20190618070334.GD29881@dragon>
 <DB3PR0402MB391691EEF083BA6BEF445235F5EA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391691EEF083BA6BEF445235F5EA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:24:59AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Tuesday, June 18, 2019 3:04 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > Leonard Crestez <leonard.crestez@nxp.com>; viresh.kumar@linaro.org;
> > Abel Vesa <abel.vesa@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] soc: imx: Add i.MX8MN SoC driver support
> > 
> > On Tue, Jun 11, 2019 at 09:31:25AM +0800, Anson.Huang@nxp.com wrote:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > >
> > > This patch adds i.MX8MN SoC driver support:
> > >
> > > root@imx8mnevk:~# cat /sys/devices/soc0/family Freescale i.MX
> > >
> > > root@imx8mnevk:~# cat /sys/devices/soc0/machine NXP i.MX8MNano
> > DDR4
> > > EVK board
> > >
> > > root@imx8mnevk:~# cat /sys/devices/soc0/soc_id i.MX8MN
> > >
> > > root@imx8mnevk:~# cat /sys/devices/soc0/revision
> > > 1.0
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/soc/imx/soc-imx8.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> > > index 3842d09..02309a2 100644
> > > --- a/drivers/soc/imx/soc-imx8.c
> > > +++ b/drivers/soc/imx/soc-imx8.c
> > > @@ -55,7 +55,12 @@ static u32 __init imx8mm_soc_revision(void)
> > >  	void __iomem *anatop_base;
> > >  	u32 rev;
> > >
> > > -	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
> > > +	if (of_machine_is_compatible("fsl,imx8mm"))
> > > +		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-
> > anatop");
> > > +	else if (of_machine_is_compatible("fsl,imx8mn"))
> > > +		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-
> > anatop");
> > 
> > Can we have this anatop compatible in imx8_soc_data, so that we may save
> > the call to of_machine_is_compatible()?
> 
> Do you mean adding a variable like " const char *anatop_compat " in imx8_soc_date structure,
> then initialize it according to SoC type, and in imx8mm_soc_revision(), get to soc_data's anatio_compat to
> find the anatop node? If yes, we have to add some code to get the soc_data in this function, or maybe
> we can pass anatop compatible name as .soc_revision's parameter?
> 
> static const struct imx8_soc_data imx8mn_soc_data = {
>          .name = "i.MX8MN",
>          .soc_revision = imx8mm_soc_revision,
>          .anatop_compat = "fsl,imx8mn-anatop",
> };

Okay, just realized that we only want to handle imx8mn with imx8mm
function.  It makes less sense to add anatop compatible into
imx8_soc_data just for that.

So it looks like that imx8mn is highly compatible with imx8mm, including
anatop block?  If that's the case, maybe we can have compatible of
imx8mn anatop like below, so that we can save above changes?

	compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";

Shawn
