Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493FFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268D220867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbfJYDLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:11:21 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:50495 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfJYDLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:11:20 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x9P3BEmp012087;
        Fri, 25 Oct 2019 11:11:14 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 868335503C09C5A1BD4E;
        Fri, 25 Oct 2019 11:11:14 +0800 (CST)
In-Reply-To: <20191008092832.54492696@dhcp-172-31-174-146.wireless.concordia.ca>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw> <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
        <20191007104501.1b4ed8ed@xps13> <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw> <20191008092832.54492696@dhcp-172-31-174-146.wireless.concordia.ca>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        "Miquel Raynal" <miquel.raynal@bootlin.com>, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down mode
MIME-Version: 1.0
X-KeepSent: DC1EA65D:196421DA-4825849E:000FBB73;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFDC1EA65D.196421DA-ON4825849E.000FBB73-4825849E.001181F2@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 25 Oct 2019 11:11:13 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/25 AM 11:11:14,
        Serialize complete at 2019/10/25 AM 11:11:14
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x9P3BEmp012087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> 
> Subject
> 
> Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down mode
> 
> On Tue, 8 Oct 2019 10:06:50 +0800
> masonccyang@mxic.com.tw wrote:
> 
> > > > +   nand_select_target(chip, 0); 
> > > 
> > > On several NAND controllers there is no way to act on the CS line
> > > without actually writing bytes to the NAND chip. So basically this
> > > is very likely to not work. 
> > 
> > any other way to make it work ? GPIO ?
> > or just have some comments description here.
> > i.e,.
> > 
> > /* The NAND chip will exit the deep power down mode with #CS toggling, 

> >  * please refer to datasheet for the timing requirement of tCRDP and 
tRDP.
> >  */
> > 
> 
> Good luck with that. As Miquel said, on most NAND controllers
> select_target() is a dummy operation that just assigns nand_chip->target
> to the specified value but doesn't assert the CS line. You could send a
> dummy command here, like a READ_ID, but I guess you need CS to be
> asserted for at least 20ns before asserting any other signals (CLE/ALE)
> which might be an issue.
> 

I have validated & checked w/ designer that NANDs device just need CS# 
line
toggling and don't care of CLE/WE#/RE#. That is raw NAND controller 
sending
a command nand_status_op() or nand_power_down_op() will exit the deep 
power down too. The first command(just CS# line toggling) to NAND device 
in deep power down mode will not be recognized. We may publish the 
application notes or update the datasheet later.

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

