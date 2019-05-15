Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE48C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578232084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEOBaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:30:10 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:60746 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOBaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:30:06 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4F1U0ch051830;
        Wed, 15 May 2019 09:30:00 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id A36C041D2DF341FE82B2;
        Wed, 15 May 2019 09:30:00 +0800 (CST)
In-Reply-To: <20190514094100.34d2a6ba@windsurf.home>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>  <20190510153704.33de9568@windsurf.home>
        <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw> <20190513114059.3934b0bb@windsurf.home>
        <OFB5D53BFC.6B44E7E0-ON482583FA.00090982-482583FA.000A5E93@mxic.com.tw> <20190514094100.34d2a6ba@windsurf.home>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
MIME-Version: 1.0
X-KeepSent: 337888B3:25F9D561-482583FB:00070B62;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF337888B3.25F9D561-ON482583FB.00070B62-482583FB.00083D9C@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 15 May 2019 09:30:01 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/15 AM 09:30:00,
        Serialize complete at 2019/05/15 AM 09:30:00
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x4F1U0ch051830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

> 
> > > > 
-------------------------------------------------------------------
> > > >  static void macronix_nand_onfi_init(struct nand_chip *chip)
> > > >  {
> > > >           struct nand_parameters *p = &chip->parameters;
> > > >           struct nand_onfi_vendor_macronix *mxic = (void 
> > > > *)p->onfi->vendor; 
> > > 
> > > Why cast to void*, instead of casting directly to struct
> > > nand_onfi_vendor_macronix * ? 
> > 
> > Due to got a warning:
> > 
> >  warning: initialization from incompatible pointer type
> >   struct nand_onfi_vendor_macronix *mxic = p->onfi->vendor;
> 
> You didn't look at my code, I suggested:
> 
>    mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;

Oops, sorry that I did not pay attention to it.

Will patch it by your comments.

  static void macronix_nand_onfi_init(struct nand_chip *chip)
  {
          struct nand_parameters *p = &chip->parameters;
          struct nand_onfi_vendor_macronix *mxic;
 
          if (!p->onfi)
                  return;
 
          mxic = (struct nand_onfi_vendor_macronix *) p->onfi->vendor;
          if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
                  return;
 
          chip->read_retries = MACRONIX_READ_RETRY_MODE;
          chip->setup_read_retry = macronix_nand_setup_read_retry;
 
          if (p->supports_set_get_features) {
                  bitmap_set(p->set_feature_list,
                             ONFI_FEATURE_ADDR_READ_RETRY, 1);
                  bitmap_set(p->get_feature_list,
                             ONFI_FEATURE_ADDR_READ_RETRY, 1);
          }
  }


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

