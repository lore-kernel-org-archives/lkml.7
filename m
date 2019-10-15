Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F8420854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfJOGrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:47:42 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:57923 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJOGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:47:42 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x9F6lZp4062733;
        Tue, 15 Oct 2019 14:47:35 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 7FCE536401869601D56D;
        Tue, 15 Oct 2019 14:47:35 +0800 (CST)
In-Reply-To: <20191008170249.06bd45ce@xps13>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw> <1568793387-25199-2-git-send-email-masonccyang@mxic.com.tw>
        <20191007104511.5aa7b8f2@xps13> <20191007112442.783e4fbe@xps13> <OFEDE76FEE.8BC48D9E-ON4825848D.000BCC94-4825848D.000E0643@mxic.com.tw> <20191008170249.06bd45ce@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 2/3] mtd: rawnand: Add support Macronix Block Protection
 function
MIME-Version: 1.0
X-KeepSent: B4F10613:467EB346-48258494:0020403E;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFB4F10613.467EB346-ON48258494.0020403E-48258494.002550A2@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 15 Oct 2019 14:47:34 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/15 PM 02:47:35,
        Serialize complete at 2019/10/15 PM 02:47:35
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x9F6lZp4062733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > > > 
> > > > > Macronix AC series support using SET/GET_FEATURES to change
> > > > > Block Protection and Unprotection.
> > > > > 
> > > > > MTD default _lock/_unlock function replacement by manufacturer
> > > > > postponed initialization. 
> > > > 
> > > > Why would we do that?
> > > > 
> > > > Anyway your solution looks overkill, if we ever decide to
> > > > implement these hooks for raw nand, it is better just to not
> > > > overwrite them in nand_scan_tail() if they have been filled
> > > > previously (ie. by the manufacturer code). 
> > > 
> > > Actually you should add two NAND hooks that do the interface with 
the
> > > MTD hooks. In the NAND hooks, check that the request is to lock all 
the
> > > device, otherwise return -ENOTSUPP. 
> > 
> > sorry, can't get your point.
> > 
> > Because the NAND entire chip will be protected if PT(protection) pin 
> > is active high at power-on.
> 
> In your implementation of the locking, you should check that the
> locking request is over the entire device, unless you can lock a
> smaller portion of course.

yes, I can lock a smaller portion.
And at the power-on of device with PT pin at high voltage, all blocks are 
locked.
They have to be unlocked by set feature command.

> 
> > 
> > > 
> > > Then fill-in these two hooks from the manufacturer code, without the
> > > postponed init.
> > > 
> > 
> > But in the final of nand_scan_tail(), mtd->_lock/_unlock will be
> > filled by NULL, right ?
> 
> The NAND core should set mtd->_lock/_unlock() to NAND specific hooks so
> that the MTD layer is abstracted and and drivers do not see it. Then,
> in the NAND helper, either there is no specific hook defined by a
> manufacturer driver and you return -ENOTSUPP, or you execute the
> defined hook.

okay, patch specific manufacturer _lock/_unlock driver
in nand_manufacturer_init();

and in the final of nand_scan_tail()
if (!mtd->_lock)
        mtd->_lock = NULL;
if (!mtd->_unlock)
        mtd->_unlock = NULL;

thanks for your time and comments.
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

