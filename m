Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACACC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F208D21743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8vEJVaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfHGBlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:41:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfHGBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:41:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so38456584pls.8;
        Tue, 06 Aug 2019 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hwj3uGjc5P7Ed46PamHKrYgZN25uTv+4Y9CY8N3wDxE=;
        b=C8vEJVaL0ESKCzP7lefx1wgcIKNEPnvmGnxPgANSawJd2TYlYWBNmyzn02+3hhrIW4
         15kK0nHEK/7u1XpXTo8pF61gnaXoiwY6P/Gn50dCUnh6FHquoIT7a6gMNluhLYfMGCMJ
         zxlFl/1BJfY2zEZSoxUaOsr+aev7K7Aeur4d3UsvITBNuCufguDQRYOV+u27pp3JStTz
         hYtaywIaomr71CL0OgEpmgXNwWtz3L6NzXyeJoqhd+8dn80IsTy0gE6Yiv1xJz5GY7P7
         EdrSzazVpkm9tmgS/F8PUFKYloOaQnEXYUSLBj4ao3lLdd0OskVPHMmhS6oOFYE9oC2y
         E5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hwj3uGjc5P7Ed46PamHKrYgZN25uTv+4Y9CY8N3wDxE=;
        b=pdZ/1JrJAdXDpnph1ghO1A5hwpG+jwY7sF1zk+/uL3r7t6syMdnjZMjhbT20SI7CF9
         4czCXkvgK6LQHjtNuSZ1742IrG2dQBC/Epy4vhsCTvjxzAym6Rc3116bugMG5imP+u7f
         80EXbR2/jmBHnh5ZcxfhxJTdnAv8pDPX4E0+CkPVWTsEomYJaI9F20ZQg04EulnNAqOh
         VuXhlNAutGhhbVHwxe0Z0x+46no9Of33iFrq5nIdmk7YH/LVOpef1g/J8HAYiPIkSg19
         xipD/AEdygLaNOjekD2AVXtk/+1Qpxs2Y4SrKVbtrJ/zMJ/LCsGIrnhF/48GD01VDA9A
         0Z5g==
X-Gm-Message-State: APjAAAXUQjUfsThrnQsMmC2GxUcH1oHKjeKs4QxwMSmtA66GWu7DrcnB
        JC2nhKuPRN1wPtdbGUaE0D0=
X-Google-Smtp-Source: APXvYqyKWesJtrgg5eVS6TTcftVzlL7G23lqVSgTL3Z85jZoOflA0An/pnwl1gjI3N4imWHwAw2lFA==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr5869179plm.334.1565142071293;
        Tue, 06 Aug 2019 18:41:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v22sm87667096pgk.69.2019.08.06.18.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:41:11 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:42:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, timur@kernel.org,
        shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v3 5/5] ASoC: dt-bindings: Introduce compatible strings
 for 7ULP and 8MQ
Message-ID: <20190807014206.GG8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-6-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-6-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:12:14PM +0300, Daniel Baluta wrote:
> For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
> strings to differentiate this.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Looks good to me. As long as one of DT maintainers acks,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..e61c0dc1fc0b 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -8,7 +8,8 @@ codec/DSP interfaces.
>  Required properties:
>  
>    - compatible		: Compatible list, contains "fsl,vf610-sai",
> -			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> +			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
> +			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.17.1
> 
