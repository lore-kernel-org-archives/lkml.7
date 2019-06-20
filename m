Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E957220665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFTTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:12:22 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16227 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfFTTMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:12:22 -0400
X-IronPort-AV: E=Sophos;i="5.63,397,1557180000"; 
   d="scan'208";a="388396700"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 21:12:20 +0200
Date:   Thu, 20 Jun 2019 21:12:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of redundant
 dev_err() calls
In-Reply-To: <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de>
Message-ID: <alpine.DEB.2.21.1906202110310.3087@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de> <alpine.DEB.2.21.1906202046550.3087@hadrien> <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2019, Markus Elfring wrote:

> >> +@display depends on context@
> >> +expression e;
> >> +@@
> >> + e = devm_ioremap_resource(...);
> >> + if (IS_ERR(e))
> >> + {
> >> +*   dev_err(...);
> >> +    return (...);
> >> + }
> >
> > Why do you assume that there is exactly one dev_err and one return after
> > the test?
>
> I propose to start with the addition of a simple source code search pattern.
> Would you prefer to clarify a more advanced approach?

I think that something like

if (IS_ERR(e))
{
<+...
*dev_err(...)
...+>
}

would be more appropriate.  Whether there is a return or not doesn't
really matter.

>
>
> >> +@script:python to_do depends on org@
> >> +p << or.p;
> >> +@@
> >> +coccilib.org.print_todo(p[0],
> >> +                        "WARNING: An error message is probably not needed here because the previously called function contains appropriate error reporting.")
> >
> > "the previously called function" would be better as "devm_ioremap_resource".
>
> Would you like to get the relevant function name dynamically determined?

I have no idea what you consider "the relevant function name" to be.  If
it is always devm_ioremap_resource then it would seem that it does not
need to be dynamically determined.

julia
