Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF4EC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCC921743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfEUCmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:42:09 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:10788 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEUCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:42:09 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x4L2g5BT004509;
        Tue, 21 May 2019 10:42:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id AC5567C4549EB1ADF305;
        Tue, 21 May 2019 10:42:05 +0800 (CST)
In-Reply-To: <20190520143438.46248bfc@xps13>
References: <1558076001-29579-1-git-send-email-masonccyang@mxic.com.tw> <20190520143438.46248bfc@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, vigneshr@ti.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v2] mtd: rawnand: Add Macronix NAND read retry support
MIME-Version: 1.0
X-KeepSent: DCB9EA90:C6F8EA4C-48258401:000981AF;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFDCB9EA90.C6F8EA4C-ON48258401.000981AF-48258401.000ED713@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 21 May 2019 10:42:06 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/21 AM 10:42:05,
        Serialize complete at 2019/05/21 AM 10:42:05
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x4L2g5BT004509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,
 
> > Add support for Macronix NAND read retry.
> > 
> > Macronix NANDs support specific read operation for data recovery,
> > which can be enabled/disabled with a SET/GET_FEATURE.
> > Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> > to see if this high-reliability function is supported.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/raw/nand_macronix.c | 57 
++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c 
b/drivers/mtd/nand/raw/
> nand_macronix.c
> > index e287e71..1a4dc92 100644
> > --- a/drivers/mtd/nand/raw/nand_macronix.c
> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > @@ -17,6 +17,62 @@
> > 
> >  #include "internals.h"
> > 
> > +#define MACRONIX_READ_RETRY_BIT BIT(0)
> > +#define MACRONIX_READ_RETRY_MODE 6
> 
> Can you name this define MACRONIX_NUM_READ_RETRY_MODES?

okay, will fix.

> 
> > +
> > +struct nand_onfi_vendor_macronix {
> > +   u8 reserved[1];
> 
> Do you need this "[1]" ?

okay, just u8 reserved;

> 
> > +   u8 reliability_func;
> > +} __packed;
> > +
> > +/*
> > + * Macronix NANDs support using SET/GET_FEATURES to enter/exit read 
retry mode
> > + */
> > +static int macronix_nand_setup_read_retry(struct nand_chip *chip, int 
mode)
> > +{
> > +   u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> > +   int ret, feature_addr = ONFI_FEATURE_ADDR_READ_RETRY;
> > +
> > +   if (chip->parameters.supports_set_get_features &&
> > +       test_bit(feature_addr, chip->parameters.set_feature_list) &&
> > +       test_bit(feature_addr, chip->parameters.get_feature_list)) {
> > +      feature[0] = mode;
> > +      ret =  nand_set_features(chip, feature_addr, feature);
> > +      if (ret)
> > +         pr_err("Failed to set read retry moded:%d\n", mode);
> 
> Do you have to call nand_get_features() on error?

okay

> 
> > +
> > +      ret =  nand_get_features(chip, feature_addr, feature);
> > +      if (ret || feature[0] != mode)
> > +         pr_err("Failed to verify read retry moded:%d(%d)\n",
> > +                mode, feature[0]);
> 
> if ret == 0 but feature[0] != mode, shouldn't you return an error?

okay, will fix.

> 
> > +   }
> > +
> > +   return ret;
> 
> This will produce a Warning at compile time (ret may be used
> uninitialized). Have you tested it?

Tool chain I used is "gcc-arm-linux-gnueabi" and no Warning at compile 
time.

Patch it to:
----------------------------------------------------------------------------->
 static int macronix_nand_setup_read_retry(struct nand_chip *chip, int 
mode)
 {
         u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
         int ret, feature_addr = ONFI_FEATURE_ADDR_READ_RETRY;

         if (chip->parameters.supports_set_get_features &&
             test_bit(feature_addr, chip->parameters.set_feature_list) &&
             test_bit(feature_addr, chip->parameters.get_feature_list)) {

                 feature[0] = mode;
                 ret =  nand_set_features(chip, feature_addr, feature);
                 if (ret) {
                         pr_err("Failed to set read retry moded:%d\n", 
mode);
                         goto err_out;
                 }

                 ret =  nand_get_features(chip, feature_addr, feature);
                 if (ret) {
                         pr_err("Failed to get read retry moded:%d\n", 
mode);
                         goto err_out;
                 } else if (feature[0] != mode) {
                         pr_err("Failed to verify read retry 
moded:%d(%d)\n",
                                 mode, feature[0]);
                         return -EIO;
                 }
         }

 err_out:
         return ret;
 }
-----------------------------------------------------------------------------<

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

