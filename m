Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A520659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJUIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:41:03 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:14747 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:41:03 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x9L8esDg027209;
        Mon, 21 Oct 2019 16:40:54 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 26C9B593DD362C20AD47;
        Mon, 21 Oct 2019 16:40:55 +0800 (CST)
In-Reply-To: <20191021094435.78f4b16e@collabora.com>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw> <1568793387-25199-2-git-send-email-masonccyang@mxic.com.tw>
        <20191007104511.5aa7b8f2@xps13> <20191007112442.783e4fbe@xps13> <OFEDE76FEE.8BC48D9E-ON4825848D.000BCC94-4825848D.000E0643@mxic.com.tw>
        <20191008170249.06bd45ce@xps13> <OFB4F10613.467EB346-ON48258494.0020403E-48258494.002550A2@LocalDomain>
        <OF894937F3.4B6774EB-ON4825849A.0027B2DF-4825849A.0028A53F@mxic.com.tw> <20191021094435.78f4b16e@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        "Miquel Raynal" <miquel.raynal@bootlin.com>, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 2/3] mtd: rawnand: Add support Macronix Block Protection
 function
MIME-Version: 1.0
X-KeepSent: 94EDFFB1:AFAD9C25-4825849A:002E2815;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF94EDFFB1.AFAD9C25-ON4825849A.002E2815-4825849A.002FB1CE@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 21 Oct 2019 16:40:57 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/21 PM 04:40:55,
        Serialize complete at 2019/10/21 PM 04:40:55
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x9L8esDg027209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

 
> > > > > > Then fill-in these two hooks from the manufacturer code, 
without 
> > the
> > > > > > postponed init.
> > > > > > 
> > > > > 
> > > > > But in the final of nand_scan_tail(), mtd->_lock/_unlock will be
> > > > > filled by NULL, right ? 
> > > > 
> > > > The NAND core should set mtd->_lock/_unlock() to NAND specific 
hooks 
> > so
> > > > that the MTD layer is abstracted and and drivers do not see it. 
Then,
> > > > in the NAND helper, either there is no specific hook defined by a
> > > > manufacturer driver and you return -ENOTSUPP, or you execute the
> > > > defined hook. 
> > > 
> > > okay, patch specific manufacturer _lock/_unlock driver
> > > in nand_manufacturer_init();
> > > 
> > > and in the final of nand_scan_tail()
> > > if (!mtd->_lock)
> > >  mtd->_lock = NULL;
> > > if (!mtd->_unlock)
> > >  mtd->_unlock = NULL; 
> > 
> > 
> > I'm still considering of post_init() in nand_scan_tail() for
> > MTD layer default call-back function replacement because
> > there would be more call-back functions need it.
> > i.e., 
> > MTD->_lock/_unlokc
> > MTD->_suspend/_resume
> 
> Again, that's something that needs to be abstracted so that both the
> NAND manufacturer driver and the NAND controller driver can take
> appropriate actions on suspend/resume operations.
> 
> > NTD->_point/_unpoint
> 
> ->_point/_unpoint() are irrelevant for a NAND chip.
> 
> > ...
> > 
> > 
> > actually, my patch series are including MTD->_locl/_unlock and 
> > MTD->_suspend/_resume. how do you think ?
> 
> Miquel was suggesting to add nand_chip->{lock,unlock,is_locked}()
> methods that would be implemented by the NAND manufacturer drivers, and
> have generic wrappers implemented in nand_base.c:
> 
> static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> {
>    struct nand_chip *chip = mtd_to_nand(mtd);
> 
>    if (!chip->lock)
>       return -ENOTSUPP;
> 
>    return chip->lock(chip, ofs, len);
> }
> 
> ...
> 
> If you do that, you won't need this post_init() hook.

got it, but ... 
user space program flash_lock/flash_unlock are calling 
mtd_lock() & mtd_unlock().
i.e.,
int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
{
         if (!mtd->_lock)
                 return -EOPNOTSUPP;
         if (ofs < 0 || ofs >= mtd->size || len > mtd->size - ofs)
                 return -EINVAL;
         if (!len)
                 return 0;
         return mtd->_lock(mtd, ofs, len);
}


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

