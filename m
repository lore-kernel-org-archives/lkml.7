Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD05C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE06F21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbfISMAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:00:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42909 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388613AbfISMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:00:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAv6u-000652-IR; Thu, 19 Sep 2019 14:00:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAv6s-00046r-NC; Thu, 19 Sep 2019 14:00:30 +0200
Date:   Thu, 19 Sep 2019 14:00:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     festevam@gmail.com, fugang.duan@nxp.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, jslaby@suse.com,
        yibin.gong@nxp.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH v2] serial: imx: adapt rx buffer and dma periods
Message-ID: <20190919120030.oie2id4womd4lcp5@pengutronix.de>
References: <20190919102628.23621-1-philipp.puschmann@emlix.com>
 <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
 <9923d405-a62d-0c6a-6039-f4a7bc3bf2e8@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9923d405-a62d-0c6a-6039-f4a7bc3bf2e8@emlix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:40:03PM +0200, Philipp Puschmann wrote:
> Hi Uwe
> 
> Am 19.09.19 um 13:22 schrieb Uwe Kleine-König:
> > On Thu, Sep 19, 2019 at 12:26:28PM +0200, Philipp Puschmann wrote:
> >> Using only 4 DMA periods for UART RX is very few if we have a high
> >> frequency of small transfers - like in our case using Bluetooth with
> >> many small packets via UART - causing many dma transfers but in each
> >> only filling a fraction of a single buffer. Such a case may lead to
> >> the situation that DMA RX transfer is triggered but no free buffer is
> >> available. While we have addressed the dma handling already with
> >> "dmaengine: imx-sdma: fix dma freezes" we still want to avoid
> > 
> > Is this statement still true now that you split this patch out of your
> > bigger series?
> Yes. The dma patches care about stopping DMA channel. This patch tries to
> avoid that the channel runs out of usable buffers (aka dma periods).
> 
> > 
> >> UART RX FIFO overrun. So we decrease the size of the buffers and
> >> increase their number and the total buffer size.
> > 
> > What happens when such an RX FIFO overrun happens? Are characters lost?
> > Or only time?
> Good question. In explanation i have missed an important point:
> When using HW flowcontrol via RTS/CTS and the buffer is full CTS is used to
> tell the remote device - here the Bluetooth chip - to stop sending data.
> For a while this prevents losing of characters. But then the remote device
> comes into trouble as its internal TX buffers runs over. Depends on the
> device how it handles this case and if it recovers if data flow is enabled
> again.
> 
> In case without HW flow control characters would be lost. Depends on the upper
> layer what happens then.
> 
> > Does your change have an influence if I do fewer but
> > bigger transfers?
> Don't think so. The dma periods are raw data buffers. If one is full the next one
> is being used. For the performance i don't see a significant difference between
> using 1 kB buffers or 4 kB buffers.

Would be great to add these infos to the commit log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
