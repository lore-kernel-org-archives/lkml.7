Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E95C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDA32082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfIEHvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:51:32 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1268 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731162AbfIEHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:51:31 -0400
X-IronPort-AV: E=Sophos;i="5.64,469,1559512800"; 
   d="scan'208";a="400347690"
Received: from unknown (HELO hadrien) ([132.227.124.24])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 09:51:28 +0200
Date:   Thu, 5 Sep 2019 09:51:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, tacingiht@gmail.com
Subject: Re: [RFC PATCH] coccinelle: check for integer overflow in binary
 search
In-Reply-To: <8916c9d9-bdf5-51c2-b5cb-49898e14a00c@linux.com>
Message-ID: <alpine.DEB.2.21.1909050950100.2357@hadrien>
References: <20190904221223.5281-1-efremov@linux.com> <alpine.DEB.2.21.1909050816370.2815@hadrien> <8916c9d9-bdf5-51c2-b5cb-49898e14a00c@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Sep 2019, Denis Efremov wrote:

>
>
> On 05.09.2019 09:20, Julia Lawall wrote:
> >
> >
> > On Thu, 5 Sep 2019, Denis Efremov wrote:
> >
> >> This is an RFC. I will resend the patch after feedback. Currently
> >> I'm preparing big patchset with bsearch warnings fixed. The rule will
> >> be a part of this patchset if it will be considered good enough for
> >> checking.
> >>
> >> There is a known integer overflow error [1] in the binary search
> >> algorithm. Google faced it in 2006 [2]. This rule checks midpoint
> >> calculation in binary search for overflow, i.e., (l + h) / 2.
> >> Not every match is an actual error since the array could be small
> >> enough. However, a custom implementation of binary search is
> >> error-prone and it's better to use the library function (lib/bsearch.c)
> >> or to apply defensive programming for midpoint calculation.
> >>
> >> [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
> >> [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
> >>
> >> Signed-off-by: Denis Efremov <efremov@linux.com>
> >> ---
> >>  scripts/coccinelle/misc/bsearch.cocci | 80 +++++++++++++++++++++++++++
> >>  1 file changed, 80 insertions(+)
> >>  create mode 100644 scripts/coccinelle/misc/bsearch.cocci
> >>
> >> diff --git a/scripts/coccinelle/misc/bsearch.cocci b/scripts/coccinelle/misc/bsearch.cocci
> >> new file mode 100644
> >> index 000000000000..a99d9a8d3ee5
> >> --- /dev/null
> >> +++ b/scripts/coccinelle/misc/bsearch.cocci
> >> @@ -0,0 +1,80 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/// Check midpoint calculation in binary search algorithm for integer overflow
> >> +/// error [1]. Google faced it in 2006 [2]. Not every match is an actual error
> >> +/// since the array can be small enough. However, a custom implementation of
> >> +/// binary search is error-prone and it's better to use the library function
> >> +/// (lib/bsearch.c) or to apply defensive programming for midpoint calculation.
> >> +///
> >> +/// [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
> >> +/// [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
> >> +//
> >> +// Confidence: Medium
> >> +// Copyright: (C) 2019 Denis Efremov, ISPRAS
> >> +// Comments:
> >> +// Options: --no-includes --include-headers
> >> +
> >> +virtual report
> >> +virtual org
> >> +
> >> +@r depends on org || report@
> >> +identifier l, h, m;
> >> +statement S;
> >> +position p;
> >> +// to match 1 in <<
> >> +// to match 2 in /
> >> +// Can't use exact values, e.g. 2, because it fails to match 2L.
> >> +// TODO: Is there an isomorphism for 2, 2L, 2U, 2UL, 2ULL, etc?
> >> +constant c;
> >
> > As far as I can see, you aren't checking for 2 at all at the moment?
>
> Yes, there are no false positives even without pinning constants to 1, 2.
> However, it's better to express this in the rule.
>
> > You
> > should be able to say constant c = {2, 2L, etc};.  Actually, we do
> > consider several variants of 0, so it could be reasonable to allow eg 2 to
> > match other variants as well.
>
> It looks like integer literals aren't fully supported. When I'm trying to write
> 'constant c = {2L}; ' it fails with int_of_string error.

Oops.  I'll fix it, but since people may be using older versions of
Coccinelle, perhaps it is not worth taking this strategy in this case.
Could you make a disjunction, or check for the proper value in the python
code?

julia
