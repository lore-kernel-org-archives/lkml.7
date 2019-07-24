Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C5C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C2422387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfGXLp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:45:27 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39712 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbfGXLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:45:27 -0400
X-IronPort-AV: E=Sophos;i="5.64,302,1559512800"; 
   d="scan'208";a="393144701"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 13:45:24 +0200
Date:   Wed, 24 Jul 2019 06:45:23 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     David Laight <David.Laight@ACULAB.COM>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
In-Reply-To: <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907240644580.2560@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>  <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>  <alpine.DEB.2.21.1907231546090.2551@hadrien>  <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com> 
 <alpine.DEB.2.21.1907232252260.2539@hadrien>  <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>  <alpine.DEB.2.21.1907232326360.2539@hadrien>  <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>  <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
 <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2019, Joe Perches wrote:

> On Wed, 2019-07-24 at 10:28 +0000, David Laight wrote:
> > From: Joe Perches
> > > Sent: 24 July 2019 05:38
> > > On Tue, 2019-07-23 at 23:27 -0500, Julia Lawall wrote:
> > > > On Tue, 23 Jul 2019, Joe Perches wrote:
> > > > > On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > > > > > A seantic patch and the resulting output for the case where the third
> > > > > > arugument is a constant is attached.  Likewise the resulting output on a
> > > > > > recent linux-next.
> []
> > > > > There is a problem with conversions with assignments
> > > > > of strlcpy() so ideally the cocci script should make sure
> > > > > any return value was not used before conversion.
> > > > >
> > > > > This is not a provably good conversion:
> > > > >
> > > > > drivers/s390/char/sclp_ftp.c
> > > > > @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
> > > > >         sccb->evbuf.mdd.ftp.length = ftp->len;
> > > > >         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
> > > > >
> > > > > -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> > > > > -                     HMCDRV_FTP_FIDENT_MAX);
> > > > > +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);
> []
> > > Any use of the strlcpy return value should not be converted
> > > because the logic after an assignment or use of the return value
> > > can not be assured to have the same behavior.
> >
> > Most of the code probably expects the length to be that copied
> > (so is broken if the string is truncated).
>
> Fortunately there are relatively few uses of the return
> value of strlcpy so it's not a large problem set.
>
> Slightly unrepresentative counts:
>
> $ git grep -P "^\s+strlcpy\b" | wc -l
> 1681
> $ git grep -P "=\s*strlcpy\b" | wc -l
> 28

OK, it's easy to check for in any case.  Thanks.

julia
