Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F71C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BFA21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCOH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:29:53 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:58373
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbfCOH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:29:53 -0400
X-IronPort-AV: E=Sophos;i="5.58,481,1544482800"; 
   d="scan'208";a="299328918"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 08:29:50 +0100
Date:   Fri, 15 Mar 2019 08:29:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wen Yang <wen.yang99@zte.com.cn>
cc:     wang.yi59@zte.com.cn, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: semantic patch for missing of_node_put
In-Reply-To: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1903150824150.3668@hadrien>
References: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Mar 2019, Wen Yang wrote:

> Looking for places where there is an of_node_put on some paths
> but not on others. This SmPL checks that there is a put of the
> same data elsewhere in the function, so perhaps that will
> alleviate the concern about puts where they are not needed,
> while still making it possible to find the ones that are needed.
>
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
> ---
>  scripts/coccinelle/free/of_node_put.cocci | 57 +++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 scripts/coccinelle/free/of_node_put.cocci
>
> diff --git a/scripts/coccinelle/free/of_node_put.cocci b/scripts/coccinelle/free/of_node_put.cocci
> new file mode 100644
> index 0000000..6a29830
> --- /dev/null
> +++ b/scripts/coccinelle/free/of_node_put.cocci
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Find missing of_node_put
> +///
> +// Confidence: Moderate
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@r exists@
> +local idexpression struct device_node *x;
> +identifier f;
> +statement S,S1,S2;
> +expression e,e1;
> +position p1,p2;
> +type T,T1;
> +@@
> +
> +(
> +x = f@p1(...);
> +... when != e = (T)x

I suggest the following:

(
if (x) { ... of_node_put(x) ... }
|
> +if (x == NULL || ...) S1
> +else S2
> +... when != of_node_put(x)
> + when != if (x) { ... of_node_put(x) ... }
> + when != e1 = (T1)x
> +(
> +return x;
> +|
> +return@p2 ...;
> +)
)

If the first test is for success of the allocation and may lead to an
of_node_put, then you can stop.  Perhaps


if (x) { ... when forall
         of_node_put(x) ... }

there would be better, to check if there is always a put.  This could also
be done on the other if (x)

> +&
> +x = f(...)
> +...
> +if (<+...x...+>) S
> +...
> +of_node_put(x);

There is actually an opportunity here for more reports.  Perhaps we can
assume that if the function calls of_node_put on anything, then it is
needed on everything.  So this could be of_node_put(...).  But the
downside of that is that the original x = f(...) may now let through
things that are not reference counted.  So you would want two rules, first
this one where the function is f and there is a of_node_put on the result
of the function, and another one where you consider a known set of
functions, and then allow a subsequent of_node_put on anything.

It would take some care to ensure that there is only one report per call
site.

julia

> +)
> +
> +@script:python depends on report@
> +p1 << r.p1;
> +p2 << r.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +			     "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
> +			     + p1[0].line
> +			     + ", but without a corresponding object release within this function.")
> +
> +@script:python depends on org@
> +p1 << r.p1;
> +p2 << r.p2;
> +@@
> +
> +cocci.print_main("acquired a node pointer with refcount incremented", p1)
> +cocci.print_secs("needed of_node_put", p2)
> --
> 2.9.5
>
>
