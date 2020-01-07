Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE282C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09A22073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAGRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:53:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58511 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:53:36 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iot2q-0000OS-Nf; Tue, 07 Jan 2020 18:53:32 +0100
Message-ID: <2dc7001f362358dfdcbef080118b23cabaa03a40.camel@pengutronix.de>
Subject: Re: [PATCH AUTOSEL 4.19 102/177] nvmem: imx-ocotp: reset error
 status on probe
From:   Lucas Stach <l.stach@pengutronix.de>
To:     =?ISO-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
Date:   Tue, 07 Jan 2020 18:53:32 +0100
In-Reply-To: <dd048e02-81f7-8aed-34a7-f95a70859391@armadeus.com>
References: <20191210213221.11921-1-sashal@kernel.org>
         <20191210213221.11921-102-sashal@kernel.org>
         <dd048e02-81f7-8aed-34a7-f95a70859391@armadeus.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sébastien,

On Di, 2020-01-07 at 15:50 +0100, Sébastien Szymanski wrote:
> On 12/10/19 10:31 PM, Sasha Levin wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > [ Upstream commit c33c585f1b3a99d53920bdac614aca461d8db06f ]
> > 
> > If software running before the OCOTP driver is loaded left the
> > controller with the error status pending, the driver will never
> > be able to complete the read timing setup. Reset the error status
> > on probe to make sure the controller is in usable state.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Link: https://lore.kernel.org/r/20191029114240.14905-6-srinivas.kandagatla@linaro.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/nvmem/imx-ocotp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> > index afb429a417fe0..926d9cc080cf4 100644
> > --- a/drivers/nvmem/imx-ocotp.c
> > +++ b/drivers/nvmem/imx-ocotp.c
> > @@ -466,6 +466,10 @@ static int imx_ocotp_probe(struct platform_device *pdev)
> >  	if (IS_ERR(priv->clk))
> >  		return PTR_ERR(priv->clk);
> >  
> > +	clk_prepare_enable(priv->clk);
> > +	imx_ocotp_clr_err_if_set(priv->base);
> > +	clk_disable_unprepare(priv->clk);
> > +
> >  	priv->params = of_device_get_match_data(&pdev->dev);
> >  	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
> >  	imx_ocotp_nvmem_config.dev = dev;
> > 
> 
> Hi,
> 
> This patch makes kernel 4.19.{92,93} hang at boot on my i.MX6ULL based
> board. It hanks at
> 
> [    3.730078] cpu cpu0: Linked as a consumer to regulator.2
> [    3.737760] cpu cpu0: Linked as a consumer to regulator.3
> 
> Full boot log is here: https://pastebin.com/TS8EFxkr
> 
> The config is imx_v6_v7_defconfig.
> 
> Reverting it makes the kernels boot again.

Can you check if it actually hangs in imx_ocotp_clr_err_if_set(), or if
the clk_disable_unprepare() is the culprit?

If the clock disable hangs the system there is a missing clock
reference somewhere else that we need to track down.

Regards,
Lucas

