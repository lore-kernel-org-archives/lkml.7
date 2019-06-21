Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA24C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE720679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFUOwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:52:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:12950
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfFUOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:52:32 -0400
X-IronPort-AV: E=Sophos;i="5.63,400,1557180000"; 
   d="scan'208";a="311013097"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 16:52:19 +0200
Date:   Fri, 21 Jun 2019 16:52:16 +0200 (CEST)
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
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of redundant
 dev_err() calls
In-Reply-To: <452fc5f1-bcaa-c9a5-9600-0278594e5e6f@web.de>
Message-ID: <alpine.DEB.2.20.1906211651550.3740@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de> <alpine.DEB.2.21.1906202046550.3087@hadrien> <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de> <alpine.DEB.2.21.1906202110310.3087@hadrien> <13890878-9e5f-f297-7f7c-bcc1212d83b7@web.de>
 <alpine.DEB.2.20.1906211119430.3740@hadrien> <452fc5f1-bcaa-c9a5-9600-0278594e5e6f@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Jun 2019, Markus Elfring wrote:

> > I still don't see the point of specifying return.  Why not just S, where S
> > is a statement metavariable?
>
> Do you find the following SmPL change specification more appropriate?

It looks better.

>
> @deletion depends on patch@
> expression e;
> statement s;
> @@
>  e = devm_ioremap_resource(...);
>  if (IS_ERR(e))
> (
> -{
> -   dev_err(...);
>     s
> -}
> |
>  {
>  <+...
> -   dev_err(...);
>  ...+>
>  }
> )
