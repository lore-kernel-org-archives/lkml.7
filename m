Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40948C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2482075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389560AbfHCLPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 07:15:09 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:53510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389458AbfHCLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 07:15:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D179F180A76E1;
        Sat,  3 Aug 2019 11:15:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boat09_83f32473a9e60
X-Filterd-Recvd-Size: 2184
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Aug 2019 11:15:06 +0000 (UTC)
Message-ID: <6ff800ceda4b1c1f1d9e519aac13db42dc703294.camel@perches.com>
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     isdn@linux-pingi.de, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 03 Aug 2019 04:15:05 -0700
In-Reply-To: <20190803063246.GA10186@kroah.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
         <20190803063246.GA10186@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-03 at 08:32 +0200, Greg KH wrote:
> On Fri, Aug 02, 2019 at 07:56:02PM +0000, Jose Carlos Cazarin Filho wrote:
> > Fix checkpath error:
> > CHECK: spaces preferred around that '*' (ctx:WxV)
> > +extern hysdn_card *card_root;        /* pointer to first card */
[]
> > diff --git a/drivers/staging/isdn/hysdn/hysdn_defs.h b/drivers/staging/isdn/hysdn/hysdn_defs.h
[]
> > @@ -220,7 +220,7 @@ typedef struct hycapictrl_info hycapictrl_info;
> >  /*****************/
> >  /* exported vars */
> >  /*****************/
> > -extern hysdn_card *card_root;	/* pointer to first card */
> > +extern hysdn_card * card_root;	/* pointer to first card */
> 
> The original code here is correct, checkpatch must be reporting this
> incorrectly.

Here checkpatch thinks that hydsn_card is an identifier rather
than a typedef.

It's defined as:
	typedef struct HYSDN_CARD {
	...
	} hysdn_card;

And that confuses checkpatch.

kernel source code style would not use a typedef for a struct.

A change would be to remove the typedef and declare this as:
	struct hysdn_card {
		...
	};

And then do a global:
	sed 's/\bhysdn_card\b/struct hysdn_card/g'

But that's not necessary as the driver is likely to be removed.


