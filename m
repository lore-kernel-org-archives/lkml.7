Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC8A22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404513AbfGYN7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:59:06 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55024 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404488AbfGYN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:59:02 -0400
X-IronPort-AV: E=Sophos;i="5.64,306,1559512800"; 
   d="scan'208";a="393304252"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 15:59:00 +0200
Date:   Thu, 25 Jul 2019 08:58:58 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     David Laight <David.Laight@ACULAB.COM>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
In-Reply-To: <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907250856450.2555@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>   <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>   <alpine.DEB.2.21.1907231546090.2551@hadrien>   <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
   <alpine.DEB.2.21.1907232252260.2539@hadrien>   <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>   <alpine.DEB.2.21.1907232326360.2539@hadrien>   <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>   <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
  <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>  <alpine.DEB.2.21.1907242040490.10108@hadrien> <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2019, Joe Perches wrote:

> On Wed, 2019-07-24 at 20:42 -0500, Julia Lawall wrote:
> > New version.  I check for non-use of the return value of strlcpy and
> > address some issues that affected the matching of the case where the first
> > argument involves a pointer dereference.  Actually, an isomorphism now
> > takes care of that case, so it doesn't show up in the semantic patch
> > explicitly any more.
> >
> > julia
>
> Nice x 2, thanks again.

Not quite nice due to the ignoring of rule 2 noticed by Markus.  There is
actually currently no guarantee that the size is right.  I'm testing a new
version.

>
> More comments:
>
> @@
> identifier f,i2,i1;
> struct i1 e1;
> expression e2;
> local idexpression x;
> position r.p;
> @@
> (
> -x = strlcpy
> +stracpy
>   (e1.f, e2
> -    , i2
>   )@p;
>   ... when != x
>
> Just for completeness and correctness, as I at
> least don't find an existing use:
>
> Perhaps this "x =" should also include += and +
> and the various other operators that are possible
> or does SmPL grammar already do that?

I could do this.  One might though think that if someone went to the
trouble of computing +=, these would be cases that we don't want to
change?  Still, it's not problem to add all assignment operators.

> Also, it might be nice to include the trivial
> conversion with sizeof(e1) and ARRAY_SIZE(e1)
> so a single script could be run over the kernel.

Sure, I'll do that when all this is working.  I didn't want those results
to drown out these ones.

thanks,
julia

>
> I'll see about adding that and try it myself
> so an automated conversion should be possible.
>
>
>
