Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A928C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13620656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFTSs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:48:26 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4891 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfFTSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:48:26 -0400
X-IronPort-AV: E=Sophos;i="5.63,397,1557180000"; 
   d="scan'208";a="388394882"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 20:48:23 +0200
Date:   Thu, 20 Jun 2019 20:48:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: Re: [PATCH] Coccinelle: Add a SmPL script for the reconsideration
 of redundant dev_err() calls
In-Reply-To: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Message-ID: <alpine.DEB.2.21.1906202046550.3087@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1240475580-1561056503=:3087"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1240475580-1561056503=:3087
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 20 Jun 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 20 Jun 2019 19:12:53 +0200
>
> The function “devm_ioremap_resource” contains appropriate error reporting.
> Thus it can be questionable to present another error message
> at other places.
>
> Provide design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  .../coccinelle/misc/redundant_dev_err.cocci   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/redundant_dev_err.cocci
>
> diff --git a/scripts/coccinelle/misc/redundant_dev_err.cocci b/scripts/coccinelle/misc/redundant_dev_err.cocci
> new file mode 100644
> index 000000000000..aeb228280276
> --- /dev/null
> +++ b/scripts/coccinelle/misc/redundant_dev_err.cocci
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Reconsider a function call for redundant error reporting.
> +//
> +// Keywords: dev_err redundant device error messages
> +// Confidence: Medium
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@display depends on context@
> +expression e;
> +@@
> + e = devm_ioremap_resource(...);
> + if (IS_ERR(e))
> + {
> +*   dev_err(...);
> +    return (...);
> + }

Why do you assume that there is exactly one dev_err and one return after
the test?

> +
> +@deletion depends on patch@
> +expression e;
> +@@
> + e = devm_ioremap_resource(...);
> + if (IS_ERR(e))
> +-{
> +-   dev_err(...);
> +    return (...);
> +-}
> +
> +@or depends on org || report@
> +expression e;
> +position p;
> +@@
> + e = devm_ioremap_resource(...);
> + if (IS_ERR(e))
> + {
> +    dev_err@p(...);
> +    return (...);
> + }
> +
> +@script:python to_do depends on org@
> +p << or.p;
> +@@
> +coccilib.org.print_todo(p[0],
> +                        "WARNING: An error message is probably not needed here because the previously called function contains appropriate error reporting.")

"the previously called function" would be better as
"devm_ioremap_resource".

julia

> +
> +@script:python reporting depends on report@
> +p << or.p;
> +@@
> +coccilib.report.print_report(p[0],
> +                             "WARNING: An error message is probably not needed here because the previously called function contains appropriate error reporting.")
> --
> 2.22.0
>
>
--8323329-1240475580-1561056503=:3087--
