Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEC8C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9440021726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564817253;
	bh=ISRX7+8TaI/SMx9RmJLbtByBVbP0icXdpWl2B0m8MZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rLtUSfho8++EFZEEonT2BPHn7tFD1HUhJ5J+8LvSrxjcddMASR+sKSKyi6THVAGmZ
	 CW39J3gPJpPON1rn3N4vUcvsu97uaMmCB26RcmCsanIq+SdlXcepVuLgYt++c9CsS9
	 FyyN5f/oKc+dBgdu0TxvJk3/XrLhO/XTzN1GtdGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHCH1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfHCH1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:27:32 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590052073D;
        Sat,  3 Aug 2019 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564817251;
        bh=ISRX7+8TaI/SMx9RmJLbtByBVbP0icXdpWl2B0m8MZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nulC3FIqa5lNy93JFklyXxDRF0TLm8KsjSGnLczzYa6JNpz21F9e+U4TDcA4Ekr1L
         HeEc+Ln5iATlOPAJuG17KDpo/kivCl8NyN2qczb/NwA1j3esT9XmPk3HefEbeESIZ3
         qT1yfmugnnlQzPVQvJOqtg+2ttJL9fuT5HUYfP2w=
Date:   Sat, 3 Aug 2019 09:27:25 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx8mq: Mark AHB clock as critical
Message-ID: <20190803072723.GB7597@X250>
References: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com>
 <20190625223223.3B8EC2053B@mail.kernel.org>
 <20190705085218.lvvqnqx6nfph2era@fsr-ub1664-175>
 <20190722212537.41C9121900@mail.kernel.org>
 <CAEnQRZAFdvSzh-pDJ-rsyaEJw83ymSVW0CC2+QZyWwAPeTOyBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAFdvSzh-pDJ-rsyaEJw83ymSVW0CC2+QZyWwAPeTOyBw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 09:30:57AM +0300, Daniel Baluta wrote:
> On Tue, Jul 23, 2019 at 6:17 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Abel Vesa (2019-07-05 01:52:19)
> > > On 19-06-25 15:32:22, Stephen Boyd wrote:
> > > > Quoting Abel Vesa (2019-06-25 02:01:56)
> > > > > Keep the AHB clock always on since there is no driver to control it and
> > > > > all the other clocks that use it as parent rely on it being always enabled.
> > > > >
> > > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > > ---
> > > > >  drivers/clk/imx/clk-imx8mq.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> > > > > index 5fbc2a7..b48268b 100644
> > > > > --- a/drivers/clk/imx/clk-imx8mq.c
> > > > > +++ b/drivers/clk/imx/clk-imx8mq.c
> > > > > @@ -398,7 +398,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
> > > > >         clks[IMX8MQ_CLK_NOC_APB] = imx8m_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
> > > > >
> > > > >         /* AHB */
> > > > > -       clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite("ahb", imx8mq_ahb_sels, base + 0x9000);
> > > > > +       clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
> > > >
> > > > Please add a comment into the code why it's critical.
> > >
> > > Comment explaining why the AHB bus clock is critical ?
> > > Isn't that self-explanatory ?
> >
> > Nope, it isn't self-explanatory, because nothing on this line says "bus"
> > and it could be that someone reading this code isn't well versed in the
> > concepts of ARM world AHB to connect the two.
> 
> Agree with Stephen. Commit message should try to give as much details
> as possible
> also maybe educate the readers who might not have that much knowledge.
> 
> Abel, I understand that for someone who works daily with this part of the kernel
> this change might look trivial.
> 
> Also, without this patch linux-next hangs on imx8mq.

How does that happen?  Mainline is fine there?

Shawn
