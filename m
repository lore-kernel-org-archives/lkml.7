Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898BCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44832190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfKCTj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:39:29 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18136 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbfKCTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:39:29 -0500
X-IronPort-AV: E=Sophos;i="5.68,264,1569276000"; 
   d="scan'208";a="410075222"
Received: from abo-45-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.45])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 20:39:26 +0100
Date:   Sun, 3 Nov 2019 20:39:26 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Coccinelle: zalloc-simple: Adjust a message
 construction
In-Reply-To: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
Message-ID: <alpine.DEB.2.21.1911032039150.2557@hadrien>
References: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Nov 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 3 Nov 2019 20:00:30 +0100
>
> * Simplify a message construction in a Python script rule
>   for the semantic patch language.

The benefit is what?

julia

>
> * Delete also a duplicate space character then.
>
> Fixes: dfd32cad146e3624970eee9329e99d2c6ef751b3 ("dma-mapping: remove dma_zalloc_coherent()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 26cda3f48f01..c14eae1f3010 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -217,8 +217,10 @@ p << r2.p;
>  x << r2.x;
>  @@
>
> -msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
> -coccilib.report.print_report(p[0], msg)
> +coccilib.report.print_report(p[0],
> +                             "WARNING: dma_alloc_coherent use in "
> +                             + x
> +                             + " already zeroes out memory. Thus memset is not needed.")
>
>  //-----------------------------------------------------------------
>  @r3 depends on org || report@
> --
> 2.23.0
>
>
