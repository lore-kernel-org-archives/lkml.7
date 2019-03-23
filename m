Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77105C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4213E218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCWNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:41:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10966 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfCWNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:41:09 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549926000"; 
   d="scan'208";a="375419243"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 14:41:07 +0100
Date:   Sat, 23 Mar 2019 14:41:07 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wen Yang <wen.yang99@zte.com.cn>
cc:     yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Subject: Re: [PATCH] coccinelle: put_device: reduce false positives
In-Reply-To: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1903231440480.2566@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Mar 2019, Wen Yang wrote:

> Don't complain about a return when this function returns "&pdev->dev".
>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> CC: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  scripts/coccinelle/free/put_device.cocci | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index 7395697..c9f071b 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -32,6 +32,7 @@ if (id == NULL || ...) { ... return ...; }
>  (    id
>  |    (T2)dev_get_drvdata(&id->dev)
>  |    (T3)platform_get_drvdata(id)
> +|    &id->dev
>  );
>  | return@p2 ...;
>  )
> --
> 2.9.5
>
>
