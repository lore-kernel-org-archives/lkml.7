Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F93E206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfHBE3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:29:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51441 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfHBE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:29:46 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1htPCI-0004kg-U4; Fri, 02 Aug 2019 06:29:42 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1htPCG-0000hC-To; Fri, 02 Aug 2019 06:29:40 +0200
Date:   Fri, 2 Aug 2019 06:29:40 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, jassisinghbrar@gmail.com,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] mailbox: imx: add support for imx v1 mu
Message-ID: <20190802042940.5rhmrwr3dxona4kr@pengutronix.de>
References: <1564563107-23736-1-git-send-email-hongxing.zhu@nxp.com>
 <CAEnQRZBJTCMYXwBz9pDVGD+7-gE_Jba-5kwXYC8qOPkEBiVT=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBJTCMYXwBz9pDVGD+7-gE_Jba-5kwXYC8qOPkEBiVT=g@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:27:45 up 76 days, 10:45, 46 users,  load average: 0.05, 0.03,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:54:27AM +0300, Daniel Baluta wrote:
> One more thing. See below:
> 
> On Wed, Jul 31, 2019 at 12:14 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> 
> <snip>
> 
> > -/* Control Register */
> > -#define IMX_MU_xCR             0x24
> >  /* General Purpose Interrupt Enable */
> >  #define IMX_MU_xCR_GIEn(x)     BIT(28 + (3 - (x)))
> >  /* Receive Interrupt Enable */
> > @@ -44,6 +36,13 @@ enum imx_mu_chan_type {
> >         IMX_MU_TYPE_RXDB,       /* Rx doorbell */
> >  };
> >
> > +struct imx_mu_dcfg {
> 
> Can you rename this into imx_mu_regs ?

I decided not blame this part. Otherwise adding other type of quirks
will lead to more refactoring work.

> > +       u32     xTR[4];         /* Transmit Registers */
> > +       u32     xRR[4];         /* Receive Registers */
> > +       u32     xSR;            /* Status Register */
> > +       u32     xCR;            /* Control Register */
> > +};
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
