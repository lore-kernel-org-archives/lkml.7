Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17920C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E291C229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfGXKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:43:26 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:54892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfGXKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:43:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 423DB180A68A2;
        Wed, 24 Jul 2019 10:43:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lip98_a3a5877a904
X-Filterd-Recvd-Size: 3083
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 10:43:24 +0000 (UTC)
Message-ID: <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 03:43:22 -0700
In-Reply-To: <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
         <alpine.DEB.2.21.1907231546090.2551@hadrien>
         <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
         <alpine.DEB.2.21.1907232252260.2539@hadrien>
         <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
         <alpine.DEB.2.21.1907232326360.2539@hadrien>
         <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
         <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 10:28 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 24 July 2019 05:38
> > On Tue, 2019-07-23 at 23:27 -0500, Julia Lawall wrote:
> > > On Tue, 23 Jul 2019, Joe Perches wrote:
> > > > On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > > > > A seantic patch and the resulting output for the case where the third
> > > > > arugument is a constant is attached.  Likewise the resulting output on a
> > > > > recent linux-next.
[]
> > > > There is a problem with conversions with assignments
> > > > of strlcpy() so ideally the cocci script should make sure
> > > > any return value was not used before conversion.
> > > > 
> > > > This is not a provably good conversion:
> > > > 
> > > > drivers/s390/char/sclp_ftp.c
> > > > @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
> > > >         sccb->evbuf.mdd.ftp.length = ftp->len;
> > > >         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
> > > > 
> > > > -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> > > > -                     HMCDRV_FTP_FIDENT_MAX);
> > > > +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);
[]
> > Any use of the strlcpy return value should not be converted
> > because the logic after an assignment or use of the return value
> > can not be assured to have the same behavior.
> 
> Most of the code probably expects the length to be that copied
> (so is broken if the string is truncated).

Fortunately there are relatively few uses of the return
value of strlcpy so it's not a large problem set.

Slightly unrepresentative counts:

$ git grep -P "^\s+strlcpy\b" | wc -l
1681
$ git grep -P "=\s*strlcpy\b" | wc -l
28


