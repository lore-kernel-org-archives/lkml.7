Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0CC47E49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EDA21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572991577;
	bh=See5wz+7if6C3fK8/2K7nL+NWbg82EFf8asNdVJR8gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eTGt5SnRcCVg+5z1xUa6tBC2Y6+ZGpAtT2zFRTipSLrddbBwN3pWq59mCi1YFAurY
	 MGQf05m9T/sb0eFej8VRGaejwbX0PkGdnbqEcx2gVlmQWt0c6hC4o9ifhKUlvj0el/
	 stryG/LsnMswuKLc3BWAhRUbc1P0CxC8kUL5k70M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfKEWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:06:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39083 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfKEWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:06:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id e17so10525757otk.6;
        Tue, 05 Nov 2019 14:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gisrq4TxhtoP8Q30cWa1tTfB7XNXHFmOi8fXi53w+bM=;
        b=GRQF93AAf4vA0NeBM254Kb1dou2954S9PsRrK5eU1h4qncEm2xbqeTqBjbyDcOJcQl
         qTHG3sKg29Tohm/fyjIqoB1h16tgRoVHj49SnzMwgV4e9+4zvQO+OoAmbMtIkf8oCFFd
         vDusJH8KhbfLSPNLOKFIpZ4kvjMaXv0bfEiFHIvuiOvpxPp0C1z/z3cC1lhhDeJciUu+
         bcOc6n1eg1ffdBT6/s3vsm1UH4bBQ3SsV5PTF1fKnXwpoQgY6RhnCD+4A8McU2FXhy+Q
         PR7ztZKPJZb8GMIjMo1KwiP/AeDTFGrgrhg+W2HGnuiynBTBL0EVH4ZZ6J9YMq1yWRoY
         WiRA==
X-Gm-Message-State: APjAAAW8hGCZlY0bR8GfYd2HEAEpZwDYZez+PSsLoYHRxQKVsRZ019rk
        0K71Up2tx4grOAy1FMNPQCO+1gw=
X-Google-Smtp-Source: APXvYqziXsft0r6jrafQ9WzZOixRtOGMfgoIJWpJT32hv2BnJtDlqlWeelJ4ao+H8Pht1CzipcEy0A==
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr5137307otn.370.1572991575309;
        Tue, 05 Nov 2019 14:06:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm5910543oie.52.2019.11.05.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:06:14 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:06:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm
Message-ID: <20191105220614.GA12397@bogus>
References: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 07:41:26PM +0800, Shengjiu Wang wrote:
> In order to support the two asrc modules in imx8qm, we need to
> add compatible string "fsl,imx8qm-asrc0" and "fsl,imx8qm-asrc1"

Are the blocks different in some way?

If not, why do you need to distinguish them?

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index 1d4d9f938689..cd2bd3daa7e1 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -8,7 +8,8 @@ three substreams within totally 10 channels.
>  
>  Required properties:
>  
> -  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible		: Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +			  "fsl,imx8qm-asrc0" or "fsl,imx8qm-asrc1".
>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.21.0
> 
