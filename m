Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974CF217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbfEXHlE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:41:04 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:58264 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfEXHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:41:03 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4O7euXb008092;
        Fri, 24 May 2019 15:40:56 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 2CB04E329FEC00A82B3B;
        Fri, 24 May 2019 15:40:57 +0800 (CST)
In-Reply-To: <20190521104713.4b3a7769@xps13>
References: <1558076001-29579-1-git-send-email-masonccyang@mxic.com.tw> <20190520143438.46248bfc@xps13>
        <OFDCB9EA90.C6F8EA4C-ON48258401.000981AF-48258401.000ED713@mxic.com.tw> <20190521104713.4b3a7769@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, vigneshr@ti.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v2] mtd: rawnand: Add Macronix NAND read retry support
MIME-Version: 1.0
X-KeepSent: 2FAE9766:C611328F-48258404:0029BF19;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF2FAE9766.C611328F-ON48258404.0029BF19-48258404.002A337A@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 24 May 2019 15:40:57 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/24 PM 03:40:57,
        Serialize complete at 2019/05/24 PM 03:40:57
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG3.macronix.com x4O7euXb008092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,


> > > 
> > > > +
> > > > +      ret =  nand_get_features(chip, feature_addr, feature);
> > > > +      if (ret || feature[0] != mode)
> > > > +         pr_err("Failed to verify read retry moded:%d(%d)\n",
> > > > +                mode, feature[0]); 
> > > 
> > > if ret == 0 but feature[0] != mode, shouldn't you return an error? 
> > 
> > okay, will fix.
> > 
> > > 
> > > > +   }
> > > > +
> > > > +   return ret; 
> > > 
> > > This will produce a Warning at compile time (ret may be used
> > > uninitialized). Have you tested it? 
> > 
> > Tool chain I used is "gcc-arm-linux-gnueabi" and no Warning at compile 

> > time.
> 
> What's the output of:
> gcc-arm-linux-gnueabi -v
> ?
> 

Oops, it's gcc 4.8.3 20131111 and kind of obsolete.
That's why no Warning at compile time.

> > 
> > Patch it to:
> > 
-----------------------------------------------------------------------------> 
 
> >  static int macronix_nand_setup_read_retry(struct nand_chip *chip, int 

> > mode)
> >  {
> >          u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> >          int ret, feature_addr = ONFI_FEATURE_ADDR_READ_RETRY;
> > 
> >          if (chip->parameters.supports_set_get_features &&
> >              test_bit(feature_addr, chip->parameters.set_feature_list) 
&&
> >              test_bit(feature_addr, 
chip->parameters.get_feature_list)) {
> > 
> >                  feature[0] = mode;
> >                  ret =  nand_set_features(chip, feature_addr, 
feature);
> 
>                          ^ extra space, please be careful with the
>                          typos, and run checkpatch.pl --strict before
>                          sending patches.
> 
> >                  if (ret) {
> >                          pr_err("Failed to set read retry moded:%d\n", 

> > mode);
> >                          goto err_out;
> >                  }
> > 
> >                  ret =  nand_get_features(chip, feature_addr, 
feature);
> >                  if (ret) {
> >                          pr_err("Failed to get read retry moded:%d\n", 

> > mode);
> >                          goto err_out;
> >                  } else if (feature[0] != mode) {
> >                          pr_err("Failed to verify read retry 
> > moded:%d(%d)\n",
> >                                  mode, feature[0]);
> >                          return -EIO;
> 
> That's not what I meant. You can keep the former condition but if !ret
> then ret = -EIO for instance.
> 
> >                  }
> >          }
> > 
> >  err_out:
> >          return ret;
> 
> Again, do not jump to a single return call, directly do the return from
> the point where you want to quit the function.
> 
> The problem should be that ret may be used uninitialized, the compiler
> should tell you that.

got it and thanks for your review.

> 
> Thanks,
> Miquèl

best regards,
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

