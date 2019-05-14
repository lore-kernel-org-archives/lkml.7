Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE620873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENTr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:47:57 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62200
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfENTr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:47:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,469,1549926000"; 
   d="scan'208";a="306019229"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 21:47:54 +0200
Date:   Tue, 14 May 2019 21:47:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 2/3] Coccinelle: pci_free_consistent: Reduce a bit of
 duplicate SmPL code
In-Reply-To: <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
Message-ID: <alpine.DEB.2.21.1905142146560.2612@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 May 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 14 May 2019 17:18:24 +0200
>
> A return statement was specified with a known value for three branches
> of a SmPL disjunction.
> Reduce duplicate SmPL code there by using another disjunction for
> these return values.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NACK.  The goak is not to squeeze the most information into the fewest
number of characters.  The rule was fine as it was.

julia


> ---
>  scripts/coccinelle/free/pci_free_consistent.cocci | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
> index 2056d6680cb8..45bc14ece151 100644
> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> +++ b/scripts/coccinelle/free/pci_free_consistent.cocci
> @@ -25,11 +25,11 @@ if (id == NULL || ...) { ... return ...; }
>      when != e = (T)id
>      when exists
>  (
> -return 0;
> -|
> -return 1;
> -|
> -return id;
> + return
> +(0
> +|1
> +|id
> +);
>  |
>  return@p2 ...;
>  )
> --
> 2.21.0
>
>
