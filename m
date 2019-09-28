Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478012081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfI1MoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 08:44:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8747 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfI1MoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 08:44:04 -0400
X-IronPort-AV: E=Sophos;i="5.64,559,1559512800"; 
   d="scan'208";a="320939417"
Received: from unknown (HELO hadrien) ([12.206.46.62])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2019 14:43:59 +0200
Date:   Sat, 28 Sep 2019 05:43:57 -0700 (PDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     YueHaibing <yuehaibing@huawei.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, maennich@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
In-Reply-To: <20190928094245.45696-1-yuehaibing@huawei.com>
Message-ID: <alpine.DEB.2.21.1909280542490.2168@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Sep 2019, YueHaibing wrote:

> Run make coccicheck, I got this:
>
> spatch -D patch --no-show-diff --very-quiet --cocci-file
>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>  -I ./arch/x86/include -I ./arch/x86/include/generated
>  -I ./include -I ./arch/x86/include/uapi
>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>  --jobs 192 --chunksize 1
>
> virtual rule patch not supported
> coccicheck failed
>
> It seems add_namespace.cocci cannot be called in coccicheck.

Could you explain the issue better?  Does the current state cause make
coccicheck to fail?  Or is it just silently not being called?

thanks,
julia

>
> Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  scripts/{coccinelle/misc => }/add_namespace.cocci | 0
>  scripts/nsdeps                                    | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename scripts/{coccinelle/misc => }/add_namespace.cocci (100%)
>
> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/add_namespace.cocci
> similarity index 100%
> rename from scripts/coccinelle/misc/add_namespace.cocci
> rename to scripts/add_namespace.cocci
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index ac2b6031dd13..0f743b76e501 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -23,7 +23,7 @@ fi
>
>  generate_deps_for_ns() {
>  	$SPATCH --very-quiet --in-place --sp-file \
> -		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +		$srctree/scripts/add_namespace.cocci -D ns=$1 $2
>  }
>
>  generate_deps() {
> --
> 2.20.1
>
>
>
