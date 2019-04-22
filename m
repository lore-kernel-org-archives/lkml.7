Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F1DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CB4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHZTd83F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDVCtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:49:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42895 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfDVCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:49:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so766188pln.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 19:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=44t5V0Va2hRnLgBaCtoI5tEHwfneD2rckQNHjjpXMhg=;
        b=cHZTd83Fw7HdPvqNJXw8/4Jq+Wpb37fiJO1sNRwpw3KRZKJA1yzudr5pyIEFyzxfOI
         AvbQP51dtZ2Rt5am5m8id7y12s3fjclxCgil5XopAPX9oufM17K5PStZ8Krw+P+Z/NuS
         d4I1jm7cMDg/s/azMKZIRJlchPqGP7Ssp7JqS7eVEtJmR0rnzcHYLjYXSK9Noma57d64
         DP6J8wuxSATbrDMWRoic62g2okOlNEae9VA7dniddKP+rvsEft9y/BXPNZhLoaZJO9Bz
         Je32fxTCoaB9ZZGfjhOHW/jCU1JQp7D77ZnMn1J9ENbfRCxsF4v15TySOdJBSZoretH2
         guFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=44t5V0Va2hRnLgBaCtoI5tEHwfneD2rckQNHjjpXMhg=;
        b=JNUMeXABfFfsifXi+NGmfRWx3TI27TUE+U16UZTYfmY3hTvbk6ZjyPq6rlf/eruDKx
         BzgZvz00zh5X2FZ7ogQmIPAVuv1olXf+NsF4PCctZX/lscYBBPiaHxSFWnjqIn6xIpHq
         c2squvVMW5wMhDK831sMgebZgNAVIJljlLXQ2lDnieVmXiTmdz+fB/7La2YuI112GKuA
         JyeA92Z/PmS/FngANbUt3QHU/LpJXeeDTgQJ35HU4YlsziQvo++RgURCUUn7Hw+lnCjd
         hwIV9MLv9KsnJ2ofi/eJ0kxgPwgN2A/AYhxpPONp167ByKc7RUIEhy/BB1GXDzw4vw7D
         og0g==
X-Gm-Message-State: APjAAAVSpSmUpAHPvRAPJGG6Fi0NWuYvSqk4vL0dsGiGs/sqplQHzFIE
        hrIO2BLN1cZu9mQrwy/sgRE=
X-Google-Smtp-Source: APXvYqykwUTfzLAv7lWudCjeJiurB76tBpVB+neVUYDb3myJ++ktsdAqkhD5lb61YkYx/lrGlkIoRw==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr17751238plt.194.1555901363343;
        Sun, 21 Apr 2019 19:49:23 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id n5sm12727190pgp.80.2019.04.21.19.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 19:49:22 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:49:16 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Message-ID: <20190422024915.GA9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:32:32AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is (1/24, 8). In the driver

Should be [1/24, 8].

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
> 
> Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
> output sample rate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0b937924d2e4..ea035c12a325 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -282,8 +282,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	if ((outrate > 8000 && outrate < 30000) &&
> -	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> +	if ((outrate >= 8000 && outrate <= 30000) &&
> +	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
>  		pair_err("exceed supported ratio range [1/24, 8] for \
>  				inrate/outrate: %d/%d\n", inrate, outrate);
>  		return -EINVAL;
> -- 
> 1.9.1
> 
