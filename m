Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F14C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C102B206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y78bswDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfG3IGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:06:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43256 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfG3IF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:05:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id r22so2037066pgk.10;
        Tue, 30 Jul 2019 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nK3/4x5NFOFF3oypb62NSdxsSYTDvzZWRrwefUu2HNE=;
        b=Y78bswDRD2RbS5DclyAkgDNCNYGF5tNENHw0Q0RvMmx6BgvibdVTxxPbv+Pa1+HCR6
         MbgDZA1yo2d/1YkGujCC2mulqo8MsG/dppVmsf2t3ZRaTA4li3AFbGRQAjwVFkE0kCzy
         LhjuvC4AT3BwiJLehh3d1bV1q9C1OZUngYZmYUSDbDQFNRxUWwrw+9T+tMdrg0Tbahv4
         2mpqH1IFpNa1B9agVc/ZnoCDSo28VebGBbk6hcNBk97amjnMObA0BZUliBqk8U4s0r7u
         lzqJlipEIk/brQbgMBxnGJ75UGgvzGJFbb/QpaAATc/lgcMO9R2D7Wf2PkZrskEjRuuC
         IXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nK3/4x5NFOFF3oypb62NSdxsSYTDvzZWRrwefUu2HNE=;
        b=aEDxC7ToSqV8LbGpoY46yUz3vbZbb67e9LXAfQzWK6asHWDw9c2VTFiGs795RrALzW
         5EFXEwV8qKYGOB16g1AXahJIq0egwV38HfQvYrNeAw1VTMeuN/zq0RPtWynlP+eGY3aG
         lVGPEpBfuhtc3tGMUOyaawzLgBpe2hfogTyQPOcyNk70my9R3tWN4WMmDmNskYTTXyuX
         Ag0qASRVo8BTMwnKVZARusTWGfw/QazXZEwMSeogwTcgDxEpu1NT096BzItyXOrngRqe
         NlO80vTeg7DEF8nlzF1CtxnAgEqo8jZVwpIKRXOCACbvfwVnfdDke58bXmeHr5ya55c+
         iKBA==
X-Gm-Message-State: APjAAAVNlCjox54m1MCVPo6LthGhpTqNAAfBV03G7maAU66IIT1CjJ1G
        LTs2x/WmznJFOTVgVVUvnmqeJT7H3dE=
X-Google-Smtp-Source: APXvYqwcWuXpzYPhzMAYQKDGxMxFYEY4mRBESlsr603Ceh+GLoj/fQuDNyNUfqD6447Ze+SKRIdySg==
X-Received: by 2002:a17:90a:3225:: with SMTP id k34mr114195494pjb.31.1564473959118;
        Tue, 30 Jul 2019 01:05:59 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id p7sm69133287pfp.131.2019.07.30.01.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:05:59 -0700 (PDT)
Date:   Tue, 30 Jul 2019 01:05:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 6/7] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Message-ID: <20190730080552.GC5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-7-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-7-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:24:28PM +0300, Daniel Baluta wrote:
> SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
> at the beginning of register address space.
> 
> On imx7ulp FIFOs can held up to 16 x 32 bit samples.
> On imx8mq FIFOs can held up to 128 x 32 bit samples.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 54e5e9abae01..0fb6750fefd5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1030,10 +1030,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>  	.reg_offset = 0,
>  };
>  
> +static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
> +	.use_imx_pcm = true,
> +	.fifo_depth = 16,
> +	.reg_offset = 8,
> +};
> +
> +static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
> +	.use_imx_pcm = true,
> +	.fifo_depth = 128,
> +	.reg_offset = 8,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
>  	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
>  	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> +	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
> +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
> -- 
> 2.17.1
> 
