Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B20C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B0720650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJPG4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:56:00 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:50462 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfJPG4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:56:00 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x9G6trgN044342;
        Wed, 16 Oct 2019 14:55:53 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 0FAB2E5F2E903446FFBA;
        Wed, 16 Oct 2019 14:55:53 +0800 (CST)
In-Reply-To: <20191015095637.142e6db7@xps13>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw> <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
        <20191007104501.1b4ed8ed@xps13> <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw>
        <20191008092832.54492696@dhcp-172-31-174-146.wireless.concordia.ca>     <OF6D5429CF.876DE422-ON48258494.000D641F-48258494.000E0D4C@mxic.com.tw> <20191015095637.142e6db7@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        frieder.schrempf@kontron.de, gregkh@linuxfoundation.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down mode
MIME-Version: 1.0
X-KeepSent: 7A229151:50591C54-48258495:00249AAF;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF7A229151.50591C54-ON48258495.00249AAF-48258495.002612F1@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 16 Oct 2019 14:55:52 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/16 PM 02:55:53,
        Serialize complete at 2019/10/16 PM 02:55:53
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x9G6trgN044342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > 
> > > > > > +   nand_select_target(chip, 0); 
> > > > > 
> > > > > On several NAND controllers there is no way to act on the CS 
line
> > > > > without actually writing bytes to the NAND chip. So basically 
this
> > > > > is very likely to not work. 
> > > > 
> > > > any other way to make it work ? GPIO ?
> > > > or just have some comments description here.
> > > > i.e,.
> > > > 
> > > > /* The NAND chip will exit the deep power down mode with #CS 
toggling, 
> > 
> > > >  * please refer to datasheet for the timing requirement of tCRDP 
and 
> > tRDP.
> > > >  */
> > > > 
> > > 
> > > Good luck with that. As Miquel said, on most NAND controllers
> > > select_target() is a dummy operation that just assigns 
nand_chip->target
> > > to the specified value but doesn't assert the CS line. You could 
send a
> > > dummy command here, like a READ_ID, but I guess you need CS to be
> > > asserted for at least 20ns before asserting any other signals 
(CLE/ALE)
> > > which might be an issue. 
> > 
> > okay, got it.
> > But if possible, I think adding CS line control in 
nand_select_target()
> > is a simple and generic way for MTD and all raw NAND controllers.
> 
> The problem is not that we do not want to; the problem is that
> controllers are not capable of doing it reliably if no byte is sent
> over the NAND bus.

okay,  it's kind of pity even though our raw NAND controller is capable of 

doing it with no byte is sent over the NAND bus.

As you mentioned that other controllers are not capable of doing it 
reliably 
if no byte is sent over the NAND bus.
if so, does it work by adding a NAND_OP_DUMMY_INSTR ? (as Boris's 
comments)

thanks for your time & comments.

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

