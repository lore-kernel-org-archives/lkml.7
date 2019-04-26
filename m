Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4766EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDZJhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:37:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55123 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:37:35 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hJxIK-0004Mr-LY; Fri, 26 Apr 2019 11:37:24 +0200
Message-ID: <1556271442.2584.29.camel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Apr 2019 11:37:22 +0200
In-Reply-To: <1556270196.9298.16.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
         <1556269635.2584.23.camel@pengutronix.de>
         <1556270196.9298.16.camel@nxp.com>
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

Am Freitag, den 26.04.2019, 09:22 +0000 schrieb Robin Gong:
> On 2019-04-26 at 11:07 +0200, Lucas Stach wrote:
> > 
> > Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
> > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)
> > >  {
> > > +     u32 tx_wml = 0;
> > > +
> > 
> > With a wml of 0 you might set the maxburst of the TX dma channel to
> > fifosize to minimize the performance impact of this workaround.
> > 
> > Regards,
> > Lucas
> 
> Unfortunately, this is a MUST part of errata which cause performance
> drop.

I'm not talking about changing the WML, but when the WML must be 0 you
can safely increase the DMA burst size without overflowing the FIFO,
which might recover some of of the performance loss.

Regards,
Lucas
