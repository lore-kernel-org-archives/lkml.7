Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44394C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CCE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfEMJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:31:49 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41124
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfEMJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:31:48 -0400
X-IronPort-AV: E=Sophos;i="5.60,465,1549926000"; 
   d="scan'208";a="305790425"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 11:31:46 +0200
Date:   Mon, 13 May 2019 11:31:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 4/5] Coccinelle: put_device: Extend when constraints for
 two SmPL ellipses
In-Reply-To: <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
Message-ID: <alpine.DEB.2.20.1905131130530.3616@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 13 May 2019 09:47:17 +0200
>
> A SmPL ellipsis was specified for a search approach so that additional
> source code would be tolerated between an assignment to a local variable
> and the corresponding null pointer check.
>
> But such code should be restricted.
> * The local variable must not be reassigned there.
> * It must also not be forwarded to an other assignment target.
>
> Take additional casts for these code exclusion specifications into account
> together with optional parentheses.

NACK.  You don't need so many type metavariables.  Type metavariables in
the same ... can be the same.

julia

>
> Link: https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
> Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005620.html
> Fixes: da9cfb87a44da61f2403c4312916befcb6b6d7e8 ("coccinelle: semantic code search for missing put_device()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/free/put_device.cocci | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index aae79c02c1e0..28b0be53fb3f 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -13,13 +13,15 @@ virtual org
>  local idexpression id;
>  expression x,e,e1;
>  position p1,p2;
> -type T,T1,T2,T3;
> +type T,T1,T2,T3,T4,T5,T6;
>  @@
>
>  id = of_find_device_by_node@p1(x)
> -... when != e = id
> + ... when != e = (T4)(id)
> +     when != id = (T5)(e)
>  if (id == NULL || ...) { ... return ...; }
>  ... when != put_device(&id->dev)
> +    when != id = (T6)(e)
>      when != platform_device_put(id)
>      when != of_dev_put(id)
>      when != if (id) { ... put_device(&id->dev) ... }
> --
> 2.21.0
>
>
