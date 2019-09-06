Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A840206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392245AbfIFFKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:10:01 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39181
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389949AbfIFFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:10:01 -0400
X-IronPort-AV: E=Sophos;i="5.64,472,1559512800"; 
   d="scan'208";a="318467270"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 07:09:56 +0200
Date:   Fri, 6 Sep 2019 07:09:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     YueHaibing <yuehaibing@huawei.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, gregkh@linuxfoundation.org,
        swboyd@chromium.org, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
In-Reply-To: <20190906033006.17616-1-yuehaibing@huawei.com>
Message-ID: <alpine.DEB.2.21.1909060707330.2975@hadrien>
References: <20190906033006.17616-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Sep 2019, YueHaibing wrote:

> When do coccicheck, I get this error:
>
> spatch -D report --no-show-diff --very-quiet --cocci-file
> ./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
> --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
>  -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
>  -I ./include/uapi -I ./include/generated/uapi
>  --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
> minus: parse error:
>   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
>   around = '\(',
>   whole content = if ( ret \( < \| <= \) 0 )
>
> In commit e56476897448 ("fpga: Remove dev_err() usage
> after platform_get_irq()") log, I found the semantic patch,
> it fix this issue.

Thanks very much for reporting the problem.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


>
> Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  scripts/coccinelle/api/platform_get_irq.cocci | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
> index f6e1afc..06b6a95 100644
> --- a/scripts/coccinelle/api/platform_get_irq.cocci
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> @@ -21,7 +21,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  if (ret != -EPROBE_DEFER)
> @@ -47,7 +47,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  -if (ret != -EPROBE_DEFER)
> @@ -74,7 +74,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  if (ret != -EPROBE_DEFER)
> --
> 2.7.4
>
>
>
