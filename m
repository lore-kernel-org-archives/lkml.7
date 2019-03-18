Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6820854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:48:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52087 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:48:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1h5vQp-00071e-Uc; Mon, 18 Mar 2019 17:48:11 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1h5vQp-0008RY-5b; Mon, 18 Mar 2019 17:48:11 +0100
Date:   Mon, 18 Mar 2019 17:48:11 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usb251xb: Remove unnecessary comparison of unsigned
 integer with >= 0
Message-ID: <20190318164811.quofap3b5mjlj5tc@pengutronix.de>
References: <20190318145024.GA572@embeddedor>
 <20190318153425.rxx3fwq2hi6tfocr@pengutronix.de>
 <f8785dc1-fa14-4e01-b89a-088cffdc350f@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8785dc1-fa14-4e01-b89a-088cffdc350f@skidata.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:43:29 up 58 days, 21:25, 51 users,  load average: 0.05, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 19-03-18 16:46, Richard Leitner wrote:
> Hi Marco, Hi Gustavo,
> thanks for the fix, please feel free to add
> 
> 	Reviewed-by: Richard Leitner <richard.leitner@skidata.com>
> 
> On 18/03/2019 16:34, Marco Felsch wrote:
> > Hi Silva,
> > 
> > On 19-03-18 09:50, Gustavo A. R. Silva wrote:
> > > There is no need to compare *port* with >= 0 because such comparison
> > > of an unsigned value is always true.
> > 
> > Absolutly.. It seems that it was an copy'n'paste failure. Thanks for
> > fixing that.
> 
> A small note on further improvement from my side:
> 
> According the datasheet, when you set swap-dx-lanes to 0 (-> setting port to
> 0 -> setting bit 0 of PRTSP) "   the upstream port DP/DM is swapped".

Yes I know that's not intuitve and may confuses the users.

> IMHO this is not straight-forward, so maybe we want to additionally
> 
> 	a) mention it somewhere in the documentation

IMHO this is the correct place.

> 	b) check on port >= 1

I think this isn't doable since we shouldn't break the existing dt.

Regards,
Marco

> 	c) something else?
> 
> Any opinions on that from your side? ... I'd prefer "a"...
> 
> regards;Richard.L
> 
> > 
> > Regards,
> > Marco
> > 
> > > Fix this by removing such comparison.
> > > 
> > > Addresses-Coverity-ID: 1443949 ("Unsigned compared against 0")
> > > Fixes: 02a50b875046 ("usb: usb251xb: add usb data lane port swap feature")
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   drivers/usb/misc/usb251xb.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> > > index 4d72b7d1d383..2c8e2cad7e10 100644
> > > --- a/drivers/usb/misc/usb251xb.c
> > > +++ b/drivers/usb/misc/usb251xb.c
> > > @@ -547,7 +547,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
> > >   	 */
> > >   	hub->port_swap = USB251XB_DEF_PORT_SWAP;
> > >   	of_property_for_each_u32(np, "swap-dx-lanes", prop, p, port) {
> > > -		if ((port >= 0) && (port <= data->port_cnt))
> > > +		if (port <= data->port_cnt)
> > >   			hub->port_swap |= BIT(port);
> > >   	}
> > > -- 
> > > 2.21.0
> > > 
> > > 
> > 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
