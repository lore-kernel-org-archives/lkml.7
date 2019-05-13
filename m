Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E437B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfEMJdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:33:33 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3026 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfEMJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:33:33 -0400
X-IronPort-AV: E=Sophos;i="5.60,465,1549926000"; 
   d="scan'208";a="382867991"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 11:33:32 +0200
Date:   Mon, 13 May 2019 11:33:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 2/5] Coccinelle: put_device: Add a cast to an expression
 for an assignment
In-Reply-To: <07e17d87-09ff-311f-015c-d201df053f56@web.de>
Message-ID: <alpine.DEB.2.20.1905131133150.3616@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <07e17d87-09ff-311f-015c-d201df053f56@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 May 2019 13:50:49 +0200
>
> Extend a when constraint in a SmPL rule so that an additional cast
> is optionally excluded from source code searches for an expression
> in assignments.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1902160934400.3212@hadrien/
> Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005592.html
> ---
>  scripts/coccinelle/free/put_device.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index 3ebebc064f10..120921366e84 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -24,7 +24,7 @@ if (id == NULL || ...) { ... return ...; }
>      when != of_dev_put(id)
>      when != if (id) { ... put_device(&id->dev) ... }
>      when != e1 = (T)id
> -    when != e1 = &id->dev
> +    when != e1 = (T)(&id->dev)
>      when != e1 = get_device(&id->dev)
>      when != e1 = (T1)platform_get_drvdata(id)
>  (
> --
> 2.21.0
>
>
