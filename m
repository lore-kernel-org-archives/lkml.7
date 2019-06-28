Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D882C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CB62053B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfF1Ici (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:32:38 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:51313 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1Ici (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:32:38 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x5S8VFLX077566;
        Fri, 28 Jun 2019 16:31:15 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id AE28135DC1DE6750D845;
        Fri, 28 Jun 2019 16:31:15 +0800 (CST)
In-Reply-To: <20190628091836.3148d450@xps13>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw> <1561443056-13766-2-git-send-email-masonccyang@mxic.com.tw>
        <20190627193635.29abff43@xps13> <OFDDC43C05.7B4092B5-ON48258427.001EE57E-48258427.002122D1@mxic.com.tw> <20190628091836.3148d450@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add Macronix Raw NAND controller
MIME-Version: 1.0
X-KeepSent: 2EDB7089:FAD92F61-48258427:002D122A;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF2EDB7089.FAD92F61-ON48258427.002D122A-48258427.002ECEF3@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 28 Jun 2019 16:31:16 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/28 PM 04:31:15,
        Serialize complete at 2019/06/28 PM 04:31:15
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x5S8VFLX077566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > 
> > > > Add a driver for Macronix raw NAND controller. 
> > > 
> > > Could you pass userspace major MTD tests and can you 
attach/mount/edit
> > > a UBI/UBIFS storage? 
> > 
> > mtd_debug passed and using dd utility to read and write 
> > with md5sum checking passed.
> 
> Please don't use dd, use nanddump/nandwrite/flasherase/nandbiterrs and
> run the other tests from the mtd-utils test suite (available in
> Buildroot for instance).
> 

Got it.

But may I know why 'dd' utility is not preferences ?
I generate a random data file and write to Flash by
using dd with bs=page size and read data back from Flash.
Checking data by md5sum.
The write and read testing data size is easily adjustable.


> > 
> > > > +static int mxic_nfc_clk_enable(struct mxic_nand_ctlr *nfc)
> > > > +{
> > > > +   int ret;
> > > > +
> > > > +   ret = clk_prepare_enable(nfc->send_clk);
> > > > +   if (ret)
> > > > +      return ret;
> > > > +
> > > > +   ret = clk_prepare_enable(nfc->send_dly_clk);
> > > > +   if (ret)
> > > > +      goto err_send_dly_clk; 
> > > 
> > > I'm not sure why you only enable 2 out of 3 clocks and also why ou
> > > handle two of them here (which is great, I prefer having a separate
> > > helper for that) and the other one elsewhere?
> > > 
> > 
> > send_clk and send_dly_clk are device domain clocks.
> > 
> > send_clk is clock without phase delay to ps_clk, used for sending 
device
> > signals except for SIO[7:0].
> > send_dly_clk is clock with phase delay to ps_clk, used for sending 
> > SIO[7:0]
> > 
> > ps_clk is system domain clock and it's a source clock of send_clk and 
> > send_dly_clk.
> 
> And why is that explaining the fact that you configure them in
> different places? You can explain this with a nice comment at the top
> of the function, but I would rather prefer that you handle all three
> clocks in one go if possible.
> 

okay, will patch it.

> > > > +static int mxic_nfc_data_xfer(struct mxic_nand_ctlr *nfc, const 
void 
> > *txbuf,
> > > > +               void *rxbuf, unsigned int len)
> > > > +{
> > > > +   unsigned int pos = 0;
> > > > +
> > > > +   while (pos < len) {
> > > > +      unsigned int nbytes = len - pos;
> > > > +      u32 data = 0xffffffff;
> > > > +      u32 sts;
> > > > +      int ret;
> > > > +
> > > > +      if (nbytes > 4)
> > > > +         nbytes = 4;
> > > > +
> > > > +      if (txbuf)
> > > > +         memcpy(&data, txbuf + pos, nbytes);
> > > > +
> > > > +      ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > > +                sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
> > > > +      if (ret)
> > > > +         return ret;
> > > > +
> > > > +      writel(data, nfc->regs + TXD(nbytes % 4));
> > > > +
> > > > +      if (rxbuf) {
> > > > +         ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > > +                   sts & INT_TX_EMPTY, 0,
> > > > +                   USEC_PER_SEC);
> > > > +         if (ret)
> > > > +            return ret;
> > > > +
> > > > +         ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > > +                   sts & INT_RX_NOT_EMPTY, 0,
> > > > +                   USEC_PER_SEC);
> > > > +         if (ret)
> > > > +            return ret;
> > > > +
> > > > +         data = readl(nfc->regs + RXD);
> > > > +         data >>= (8 * (4 - nbytes));
> > > > +         memcpy(rxbuf + pos, &data, nbytes);
> > > > +         WARN_ON(readl(nfc->regs + INT_STS) & INT_RX_NOT_EMPTY);
> > > > +      } else {
> > > > +         readl(nfc->regs + RXD);
> > > > +      }
> > > > +      WARN_ON(readl(nfc->regs + INT_STS) & INT_RX_NOT_EMPTY); 
> > > 
> > > WARN_ON() is maybe a bit overkill here? 
> > 
> > should I remove it ?
> 
> I would stick to regular dev_warn.

Got it, will patch it.

thanks & best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

