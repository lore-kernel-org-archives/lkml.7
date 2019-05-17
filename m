Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9746120848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfEQJa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:30:29 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:19133 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfEQJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:30:29 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4H9ULi6090469;
        Fri, 17 May 2019 17:30:21 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 6A6869C38E176687E328;
        Fri, 17 May 2019 17:30:21 +0800 (CST)
In-Reply-To: <20190512151820.4f2dd9da@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw> <20190512151820.4f2dd9da@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
MIME-Version: 1.0
X-KeepSent: 074A1F06:5C1A58BE-482583FD:0031CD95;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 17 May 2019 17:30:21 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/17 PM 05:30:21,
        Serialize complete at 2019/05/17 PM 05:30:21
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x4H9ULi6090469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > +
> > +static void mxic_nand_select_chip(struct nand_chip *chip, int chipnr)
> 
> _select_target() is preferred now

Do you mean I implement mxic_nand_select_target() to control #CS ?

If so, I need to call mxic_nand_select_target( ) to control #CS ON
and then #CS OFF in _exec_op() due to nand_select_target()<in nand_base,c>
is still calling chip->legacy.select_chip ?

> 
> > +{
> > +   struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
> > +
> > +   switch (chipnr) {
> > +   case 0:
> > +   case 1:
> > +      writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
> > +      writel(HC_CFG_MAN_CS_ASSERT | readl(mxic->mfd->regs + HC_CFG),
> > +             mxic->mfd->regs + HC_CFG);
> 
> In both case I would prefer a:
> 
>         reg = readl(...);
>         reg &= ~xxx;
>    reg |= yyy;
>    writel(reg, ...);
> 
> Much easier to read.
> 
> > +      break;
> > +
> > +   case -1:
> > +      writel(~HC_CFG_MAN_CS_ASSERT & readl(mxic->mfd->regs + HC_CFG),
> > +             mxic->mfd->regs + HC_CFG);
> > +      writel(0, mxic->mfd->regs + HC_EN);
> > +      break;
> > +
> > +   default:
> 
> Error?
> 
> > +      break;
> > +   }
> > +}
> > +

> > +static int mx25f0a_nand_probe(struct platform_device *pdev)
> > +{
> > +   struct mtd_info *mtd;
> > +   struct mx25f0a_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
> > +   struct mxic_nand_ctlr *mxic;
> > +   struct nand_chip *nand_chip;
> > +   int err;
> > +
> > +   mxic = devm_kzalloc(&pdev->dev, sizeof(struct mxic_nand_ctlr),
> > +             GFP_KERNEL);
> 
> mxic for a NAND controller structure is probably not a name meaningful
> enough.
> 
> > +   if (!mxic)
> > +      return -ENOMEM;
> > +
> > +   nand_chip = &mxic->nand;
> > +   mtd = nand_to_mtd(nand_chip);
> > +   mtd->dev.parent = pdev->dev.parent;
> > +   nand_chip->ecc.priv = NULL;
> > +   nand_set_flash_node(nand_chip, pdev->dev.parent->of_node);
> > +   nand_chip->priv = mxic;
> > +
> > +   mxic->mfd = mfd;
> > +
> > +   nand_chip->legacy.select_chip = mxic_nand_select_chip;
> 
> Please don't implement legacy interfaces. You can check in
> marvell_nand.c how this is handled now:
> 
> b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
> 

Does it mean chip->legacy.select_chip() will phase-out ?


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

