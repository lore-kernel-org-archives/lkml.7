Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0906C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7704021882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/ZuoxHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfKIKVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 05:21:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKIKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 05:21:32 -0500
Received: from zn.tnic (p200300EC2F1EA70018ABFAC8D0403DA5.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:a700:18ab:fac8:d040:3da5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CF101EC0D0F;
        Sat,  9 Nov 2019 11:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573294886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MyC6e9vomysMP7lwrjTJBZVkQlL0RL+jwPk7ArLmGqo=;
        b=S/ZuoxHqssosqiAVZspsuqbnYPsyDb8FAdpJFKG0gOf3cehu/b631AvidW6VeFtGO7fDgn
        9/KmYMRmKZJtACGLvC+ephPtd29rCJXthG+HcyaLPjRLxg69tPwizfWflHklJ5NtWDE+YU
        9DcT3QcJTZjUeNwZ8nuZqz4FAqCy7to=
Date:   Sat, 9 Nov 2019 11:21:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 07/20] EDAC, mc: Rename iterator variable to idx
Message-ID: <20191109102127.GC2699@zn.tnic>
References: <20191106093239.25517-1-rrichter@marvell.com>
 <20191106093239.25517-8-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106093239.25517-8-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 09:33:16AM +0000, Robert Richter wrote:
> Rename iterator variable to idx. The name is more handy, esp. when
> searching it in the code.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/edac/edac_mc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 3dc1c5afabce..f76252b7a787 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -330,14 +330,14 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	 * Calculate the total amount of dimms and csrows/cschannels while
>  	 * in the old API emulation mode
>  	 */
> -	for (i = 0; i < n_layers; i++) {
> -		tot_dimms *= layers[i].size;
> -		if (layers[i].is_virt_csrow)
> -			tot_csrows *= layers[i].size;
> +	for (idx = 0; idx < n_layers; idx++) {
> +		tot_dimms *= layers[idx].size;
> +		if (layers[idx].is_virt_csrow)
> +			tot_csrows *= layers[idx].size;
>  		else
> -			tot_channels *= layers[i].size;
> +			tot_channels *= layers[idx].size;
>  
> -		if (layers[i].type == EDAC_MC_LAYER_CHIP_SELECT)
> +		if (layers[idx].type == EDAC_MC_LAYER_CHIP_SELECT)
>  			per_rank = true;
>  	}
>  
> -- 

Merging that one with 2/20 where you already are converting to "idx" in
the same function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
