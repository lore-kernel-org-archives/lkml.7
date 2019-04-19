Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59545C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296F5222EB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwCw9SHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfDSSRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:17:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfDSSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:17:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so2886896pfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DHK4rYDwWPVNuuRQozpzQhPs53i6eTIw/NWHTPBpUw=;
        b=SwCw9SHkBEdf0FNwY3ddHfVt/5MXgvQz8yLP6w+50L7rBCJTPluD7bwwgk4+1Wl1Kz
         5IAjZaOb6rtGAjK9pbFCcTXW3IrwKt+9noZyd+6mQ/5kGe/c9dUp3EwlqSwS1ywQMsSD
         QZY6XymID6Nl8Pq01a9OmT64PczfAR1cF6Xn/fM/sdubY9RfrCT6hqElx/m8RJDQkoYW
         /iRoT07AnZ1mvW6PSt0sgl7Ab56eLwwj3lvm+lubyo65xPl+UEI1dASI32AsYQAfMKIN
         xYLabW3+MuWY3sQHXKl+knWnBgRmj59ZaM7HhzJI6bplqm8AYTlO6tpEm0GImFXLTvKS
         c3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DHK4rYDwWPVNuuRQozpzQhPs53i6eTIw/NWHTPBpUw=;
        b=bzFPy0+fr6BDbPb0VFRJQZxIGB/VgmrU+yb3iOijG8V89OhNVplarHeeGNuTWnlCaC
         8mMt/gSFdY5K/s900orJgfFO56DIbtoMf5XSDk7Z7lL0Tym9Nm6uT0AOK4c6Ek4QkW44
         uS3nCAbgltJOkrLLIVBZVN2xODPotDPktJx0BRcuEpU1b3DD2yZR5xDhZzUiP45CgJNd
         moI2JnKOyhFWwccbd72fSn2wH5FlwvGysUqZ8WJa1sp5mFJ0btYte6CU3+UArBTZSNb/
         csnOBfnVDdb4hE4PnSeuv0RVgl9RLCdI+8zJ/jUaDFsvZH26xEIhJDsyoge0RPkFku3R
         ubHg==
X-Gm-Message-State: APjAAAVSsPqPxvEbqhdJ5obj8cFWg4cJrUHG8jk2YYffn2U6HGvA74b2
        tLx+ZU2dNQqjVgA5a1wkLnQ=
X-Google-Smtp-Source: APXvYqxXTtMHqYYynxTETSbHUOU21HgptNIMEddHodFNpZQSo9L8d6bCM19EOo6YY03u1fW/a6agzg==
X-Received: by 2002:a63:d84a:: with SMTP id k10mr5084606pgj.441.1555697409412;
        Fri, 19 Apr 2019 11:10:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i129sm9382006pfc.163.2019.04.19.11.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:10:09 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:10:03 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Message-ID: <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:23:50AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is (1/24, 8). In the driver
> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
> 
> Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
> output sample rate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0b937924d2e4..5b8adc7fb117 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -282,10 +282,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	if ((outrate > 8000 && outrate < 30000) &&
> -	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> -		pair_err("exceed supported ratio range [1/24, 8] for \
> -				inrate/outrate: %d/%d\n", inrate, outrate);
> +	if ((outrate >= 8000 && outrate <= 30000) &&
> +	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
> +		pair_err("exceed supported ratio range (1/24, 8) for inrate/outrate: %d/%d\n",

Using one of the conditions:
	if (inrate > 8 * outrate)
		pair_err();

This means:
	if (inrate <= 8 * outrate)
		/* Everything is fine */

So the supported ratio range is still [1/24, 8] right?

Thanks
