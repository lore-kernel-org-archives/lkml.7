Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FF22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbfGYLeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:34:46 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:22257
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391940AbfGYLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:34:45 -0400
X-IronPort-AV: E=Sophos;i="5.64,306,1559512800"; 
   d="scan'208";a="314683334"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 13:34:40 +0200
Date:   Thu, 25 Jul 2019 06:34:38 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
In-Reply-To: <e3a37d93-0353-ebed-948a-991add184616@web.de>
Message-ID: <alpine.DEB.2.21.1907250632500.2535@hadrien>
References: <alpine.DEB.2.21.1907242040490.10108@hadrien> <e3a37d93-0353-ebed-948a-991add184616@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2088688034-1564054482=:2535"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2088688034-1564054482=:2535
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 25 Jul 2019, Markus Elfring wrote:

> > New version.  I check for non-use of the return value of strlcpy and
> > address some issues that affected the matching of the case where the first
> > argument involves a pointer dereference.
>
> I suggest to take another look at corresponding implementation details
> of the shown SmPL script.
>
>
> > \(strscpy\|strlcpy\)(e1.f, e2, i2)@p
>
> Can the data access operator “->” (arrow) matter also here?

What did my email say about isomorphisms?

>
>
> > @@
> > identifier r.i1,r.i2;
> > type T;
> > @@
> > struct i1 { ... T i1[i2]; ... }
>
> Will an additional SmPL rule name be helpful for this part?

Yes, sorry, it would seem that that is necessary.  I will fix and resend
the results.

>
>
> > @@
> > (
> > -x = strlcpy
> > +stracpy
> >   (e1.f, e2
> > -    , i2
> >   )@p;
> >   ... when != x
> >
> > |
>
> I wonder about the deletion of the assignment target.
> Should the setting of such a variable be usually preserved?

If it is a local variable and never subsequently used, it doesn't seem
very useful.

julia
--8323329-2088688034-1564054482=:2535--
