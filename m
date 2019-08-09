Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F2C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF182166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkLm8gEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHIT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:58:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33312 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHIT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:58:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so46591069pfq.0;
        Fri, 09 Aug 2019 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojmnuX0x32lHJ/D+75vj1kRonZuJ/g9iqnUm+zVivbQ=;
        b=TkLm8gEEMKiW84W4cgO3zvgYqub5DNNpfruKswekAOlUl+cYRrXISnfEwCNCJjld37
         MpnXIJSZYfTAJ83cPWQb7HnOdnU9IgacryuATqNKcAJ0pudFeHiW67gBlWLyB3qJ5fqD
         7n4PuWj/J6WOaJr/Sk1w0wBVupILPbLKDgFfc43Tv1X2pOyPHF0IAEGU+uB/aOFAoLjX
         32YgPYRRjSNnvYRpMZNAvNttfOf82m/5Uk1BbxQoPxIe8Sb+M7PTPI/QVGYDG/wrUvxZ
         vakjJnYA5CnIZFc0fT7s/kcB/Q/781RityGhOB9smsOtTHLVbY5MdFAO4CqyBYZFYmKk
         4USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojmnuX0x32lHJ/D+75vj1kRonZuJ/g9iqnUm+zVivbQ=;
        b=rybZkHHavTXspEz4aOim5k/lEEtgpGtaDL7SVUCbiCUMrtWF9JaxLNYszKrEl4IkDR
         2pJgs9eVrNZU+7HqMdgpOBhwUXSObjQzZCyAUOA9c8HA1nfF78F8luI0QQcNiqJn6lc4
         tO//Ma0I+aGXcu5JERt/pi9K2u/C225nx4ThvQnMXljhkn0bjcnCprQVWR5AGfno7iqq
         T3r9fYJSlJwIN3CJrHFLsMrftK9DY1IMdBD/2GJzEaLLeCJlEOzwm92RO1pHWba9nCiv
         4JmWP3VMFOfNUUrR5eR75dDUH/lNEcLgdUGiTHgP93VebUGW/DTMVmVdcgj/UXKWgpv5
         rN6w==
X-Gm-Message-State: APjAAAVTZMAvhvBY2wM3xW/hzmOC95zowspo8l9oa4bfKL+NKBunT6nT
        6qN/yFfnnTJ2oTuTDTosxGU=
X-Google-Smtp-Source: APXvYqymbF/Bhg9bVlIjFmuXbUC94GuivHKAsuqe5AuDRK1+Hydo9/dP5KXtlzUlLvLE/7UKNhy1Bw==
X-Received: by 2002:aa7:9516:: with SMTP id b22mr23116258pfp.106.1565380738742;
        Fri, 09 Aug 2019 12:58:58 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id e13sm121094779pff.45.2019.08.09.12.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:58:58 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:58:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl_esai: Add compatible string for imx6ull
Message-ID: <20190809195845.GB8148@Asurada>
References: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 06:27:46PM +0800, Shengjiu Wang wrote:
> Add compatible string for imx6ull, from imx6ull platform,
> the issue of channel swap after xrun is fixed in hardware.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_esai.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 10d2210c91ef..4b4a8e831e9e 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -920,6 +920,7 @@ static int fsl_esai_remove(struct platform_device *pdev)
>  static const struct of_device_id fsl_esai_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-esai", },
>  	{ .compatible = "fsl,vf610-esai", },
> +	{ .compatible = "fsl,imx6ull-esai", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
> -- 
> 2.21.0
> 
