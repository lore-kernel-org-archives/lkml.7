Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A54EC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105F7214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfGXE1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:27:23 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43076
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfGXE1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:27:21 -0400
X-IronPort-AV: E=Sophos;i="5.64,300,1559512800"; 
   d="scan'208";a="314532027"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:27:19 +0200
Date:   Tue, 23 Jul 2019 23:27:17 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
In-Reply-To: <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907232326360.2539@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>  <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>  <alpine.DEB.2.21.1907231546090.2551@hadrien>  <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com> 
 <alpine.DEB.2.21.1907232252260.2539@hadrien> <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jul 2019, Joe Perches wrote:

> On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > A seantic patch and the resulting output for the case where the third
> > arugument is a constant is attached.  Likewise the resulting output on a
> > recent linux-next.
> >
> > julia
>
> Nice.  Thanks Julia
>
> A couple issues:
>
> There is a problem with conversions with assignments
> of strlcpy() so ideally the cocci script should make sure
> any return value was not used before conversion.
>
> This is not a provably good conversion:
>
> drivers/s390/char/sclp_ftp.c
> @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
>         sccb->evbuf.mdd.ftp.length = ftp->len;
>         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
>
> -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> -                     HMCDRV_FTP_FIDENT_MAX);
> +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);

Sorry, I don't understand the issue here.  What specifically should I be
looking for?

>
> And:
>
> I would have expected the bit below to find and convert uses like
> 	drivers/hwmon/adc128d818.c:     strlcpy(info->type, "adc128d818", I2C_NAME_SIZE);
> but it seems none of those were converted.

OK, thanks.  I will check on it.

julia

> I don't know why.
>
> //------------------------------------------
> @r1@
> struct i1 *e1;
> expression e2;
> identifier f,i1,i2;
> position p;
> @@
> \(strscpy\|strlcpy\)(e1->f, e2, i2)@p
>
> @@
> identifier r1.i1,r1.i2;
> type T;
> @@
> struct i1 { ... T i1[i2]; ... }
>
> @@
> identifier f,i2;
> expression e1,e2;
> position r1.p;
> @@
> (
> -strscpy
> +stracpy
> |
> -strlcpy
> +stracpy
> )(e1->f, e2
> -    , i2
>   )@p
> //------------------------------------------
>
> to find
>
>
