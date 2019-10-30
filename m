Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B3CA9EC3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733F120856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6VYehVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJ3ASP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 20:18:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37860 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfJ3ASP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:18:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id u9so269038pfn.4;
        Tue, 29 Oct 2019 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eL9nLhkFV+3fjZqHJucvMS1Z4avpEDieJP4rKaoqZys=;
        b=d6VYehVqNaBLztOnm+3wC0Y2Cp3OWS7oUyfmQU3cWBQlsNiwJyE0ktWOkED3EIadm3
         uheShic0KwVuxyjDgjUuT2kQhhyF5HVGhPA/jqlAJfycoSdfQ8kFbVKWhSCjJSsJoph2
         K4chyo/pgU81+3tgfMlrYy7ZvrwpHGoVJ+Ms8PNRRql6AYczh86QzTYwS4VhzG6IiZKe
         kxjc5ME/pSjJD3+PxHtJk5S/chLaPUZV1MFHhiSTheuPHK+cV/JDhaG4BNUrzgPEqv+o
         VlglM3QqZPomBtVA2mhSoUEdiECMpGQ3hrVRfB7Dk1IWHkZ9xfEnCIr7/jGWAxjXN90p
         GFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eL9nLhkFV+3fjZqHJucvMS1Z4avpEDieJP4rKaoqZys=;
        b=A0ZFZ4NWt/6/Iw9TUCnnT2D8zZrWWiy4qkslFyulDEX5dvqIhgJNIsCyw9Kq4t1nmn
         lxoXtExdgV48NQpNSRARS6ec0vaNv+k5JSVtBWMxYHanFoQ8NPVSGiyOasaG78Ot6lfg
         9FR2QzqugVPHUY5JhkLsPVu/PKIVotrkky4bpRFP/bS5oOvaByrLn+JSjkxSOizT+7PR
         YAhbdvAf3MR5dOBHYyPwqZ3D3FBKt9igU+VBs0YxHr1QGee1U3MGKLSV6xFVVfRhVgAI
         XtARmBe4ISoifHicQJwsZaAesuiyRL1E3r9WsucV6DE21muKtlGoBQCnwf1zYcqXOwcC
         Cymg==
X-Gm-Message-State: APjAAAWRm7/J7TdWCm+GQ+E2RYWHYrXUUur1E+JayC1Ocdpy5c53A+uS
        97yP34DIlT9+2pWOVnxqkbE=
X-Google-Smtp-Source: APXvYqw0eHqTFbOpxspUUagZHSV8qs2zbtP3YZq4SWaoOEZYjhzimcKl2o0Wtc6rf4wFJf7fMv8AMQ==
X-Received: by 2002:a63:b144:: with SMTP id g4mr12268618pgp.87.1572394694419;
        Tue, 29 Oct 2019 17:18:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g17sm334431pgn.37.2019.10.29.17.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 17:18:14 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:17:56 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_asrc: Add support for imx8qm
Message-ID: <20191030001756.GA19352@Asurada-Nvidia.nvidia.com>
References: <1572340629-20702-1-git-send-email-shengjiu.wang@nxp.com>
 <1572340629-20702-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572340629-20702-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:17:09PM +0800, Shengjiu Wang wrote:
> There are two asrc module in imx8qm, each module has different
> clock configuration, and the DMA type is EDMA.
> 
> So in this patch, we define the new clocks, refine the clock map,
> and include struct fsl_asrc_soc_data for different soc usage.
> 
> The EDMA channel is fixed with each dma request, one dma request
> corresponding to one dma channel. So we need to request dma
> channel with dma request of asrc module.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     | 91 +++++++++++++++++++++++++++++-------
>  sound/soc/fsl/fsl_asrc.h     | 65 +++++++++++++++++++++++++-
>  sound/soc/fsl/fsl_asrc_dma.c | 39 ++++++++++++----
>  3 files changed, 167 insertions(+), 28 deletions(-)

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index d6146de9acd2..dbb07a486504 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -199,19 +199,40 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  
>  	/* Get DMA request of Back-End */
>  	tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
> -	tmp_data = tmp_chan->private;
> -	pair->dma_data.dma_request = tmp_data->dma_request;
> -	dma_release_channel(tmp_chan);
> +	/* tmp_chan may be NULL for it is already allocated by Back-End */
> +	if (tmp_chan) {
> +		tmp_data = tmp_chan->private;
> +		if (tmp_data)
> +			pair->dma_data.dma_request = tmp_data->dma_request;

If this patch is supposed to add a !tmp_chan case for EDMA, we
probably shouldn't mute the !tmp_data case because dma_request
will be NULL, although the code previously didn't have a check
either. I mean we might need to error-out for !tmp_chan. Or...
is this intentional?

> +		dma_release_channel(tmp_chan);
> +	}
>  
>  	/* Get DMA request of Front-End */
>  	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
> -	tmp_data = tmp_chan->private;
> -	pair->dma_data.dma_request2 = tmp_data->dma_request;
> -	pair->dma_data.peripheral_type = tmp_data->peripheral_type;
> -	pair->dma_data.priority = tmp_data->priority;
> -	dma_release_channel(tmp_chan);
> +	if (tmp_chan) {
> +		tmp_data = tmp_chan->private;
> +		if (tmp_data) {

Same question here.

> +			pair->dma_data.dma_request2 = tmp_data->dma_request;
> +			pair->dma_data.peripheral_type =
> +				 tmp_data->peripheral_type;
> +			pair->dma_data.priority = tmp_data->priority;
> +		}
> +		dma_release_channel(tmp_chan);
> +	}
