Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F4C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A7C206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfJHCG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:06:57 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:16597 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJHCG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:06:57 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x9826pJC066253;
        Tue, 8 Oct 2019 10:06:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id EF62EBD39E374C19369C;
        Tue,  8 Oct 2019 10:06:50 +0800 (CST)
In-Reply-To: <20191007104501.1b4ed8ed@xps13>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw> <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw> <20191007104501.1b4ed8ed@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down mode
MIME-Version: 1.0
X-KeepSent: 147D635A:8968CD6B-4825848D:00088AD5;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 8 Oct 2019 10:06:50 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/08 AM 10:06:50,
        Serialize complete at 2019/10/08 AM 10:06:51,
        Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/10/08 AM 10:06:51
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x9826pJC066253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,


 
> > +int nand_power_down_op(struct nand_chip *chip)
> > +{
> > +   int ret;
> > +
> > +   if (nand_has_exec_op(chip)) {
> > +      struct nand_op_instr instrs[] = {
> > +         NAND_OP_CMD(NAND_CMD_POWER_DOWN, 0),
> > +      };
> > +
> > +      struct nand_operation op = NAND_OPERATION(chip->cur_cs, 
instrs);
> > +
> > +      ret = nand_exec_op(chip, &op);
> > +      if (ret)
> > +         return ret;
> > +
> > +   } else {
> > +      chip->legacy.cmdfunc(chip, NAND_CMD_POWER_DOWN, -1, -1);
> > +   }
> > +
> > +   return 0;
> > +}
> > +
> > +static int mxic_nand_suspend(struct mtd_info *mtd)
> > +{
> > +   struct nand_chip *chip = mtd_to_nand(mtd);
> > +
> > +   mutex_lock(&chip->lock);
> > +
> > +   nand_select_target(chip, 0);
> > +   nand_power_down_op(chip);
> > +   nand_deselect_target(chip);
> > +
> > +   chip->suspend = 1;
> > +   mutex_unlock(&chip->lock);
> > +
> > +   return 0;
> > +}
> > +
> > +static void mxic_nand_resume(struct mtd_info *mtd)
> > +{
> > +   struct nand_chip *chip = mtd_to_nand(mtd);
> > +
> > +   mutex_lock(&chip->lock);
> > +   // toggle #CS pin to resume NAND device
> 
> C++ style comments are forbidden in code.

okay, got it. thanks.

> 
> > +   nand_select_target(chip, 0);
> 
> On several NAND controllers there is no way to act on the CS line
> without actually writing bytes to the NAND chip. So basically this
> is very likely to not work.

any other way to make it work ? GPIO ?
or just have some comments description here.
i.e,.

/* The NAND chip will exit the deep power down mode with #CS toggling, 
 * please refer to datasheet for the timing requirement of tCRDP and tRDP.
 */

> 
> > +   ndelay(20);
> 
> Is this delay known somewhere? Is this purely experimental?

it's timing requirement tCRDP 20 ns(min) to release device
from deep power-down mode. 
You may download datasheet at
https://www.macronix.com/zh-tw/products/NAND-Flash/SLC-NAND-Flash/Pages/spec.aspx?p=MX30LF4G28AD&m=SLC%20NAND&n=PM2579 


> 
> > +   nand_deselect_target(chip);
> > +
> > +   if (chip->suspend)
> > +      chip->suspended = 0;
> > +   else
> > +      pr_err("%s call for a chip which is not in suspended state\n",
> > +             __func__);
> > +   mutex_unlock(&chip->lock);
> > +}

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

