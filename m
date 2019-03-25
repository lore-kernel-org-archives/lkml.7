Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E63FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCF921473
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U23th7m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfCYN1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:46 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:42127 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfCYN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:44 -0400
Received: by mail-vs1-f49.google.com with SMTP id f15so5339028vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxPqGCa8pnc4EKu5Oo82+7cOln1w7hY7wTrCkcyvNp4=;
        b=U23th7m74bviA3RqDmGbozqbiAVgfJntKtjGf3D/YPm1GCNOUpBxTXKQ+hV9dUBSvX
         qXrk5olz++cPOoZnl3szDckYVurTowj1vak4FvvdDbqG1VvgViwvHqKP2nDn0u1vOqVM
         6rOffPBL08zzn05L4VQGm8bnkTJDJaAE2IMtYtwwznr69YP7TahYDX84EFrZpqaL0CIJ
         12d9+bqfeBVGndTRptYoEc0G1Det0WFuyESrvztzeW7Zr+WX9vBRJSjYvlskJC3U2BVB
         htPvz7OqlKRb5byQhAbphVfuUeiGlqNf9nXLUCViDMHtOvmBNOQJ/LGTEYb/9yVRmFQ3
         dqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxPqGCa8pnc4EKu5Oo82+7cOln1w7hY7wTrCkcyvNp4=;
        b=ngE3kGrAlF7hcEUcm75ZUOHvULqza4JQnRB9MXO+pXma9CljzL0MwpcqRDmgQ6bUd/
         /3dHd8EcxAKU0UzIF3IKuzcQj2cMvw/z4fnxHkVH5PG4vKDsvY4k3Xj05wAeZu4Xwju9
         IpsSgud6ii07/lrFN4uChv5SlSM1brAVJbmSmQXeKczfnCmw9u4DEx60enw6lTi06gwC
         +Fsq0mUNm4rjSFNDIVX37gy9DfqgS/+LS+Tv3v8WgKkLIaFk8fYWOy36MFzQv2YpHnK1
         +1DfRSbsnFgTDdqQlCcLXG83QTdtHzPhPuThOC1AZ6RROFApPEufWN5SxPphaeQ3p9UU
         CLwQ==
X-Gm-Message-State: APjAAAXR8XScR0wJBu86MvorjWiHoot7jp4ILI4m01RhIvl+VsXdnjq3
        lKpMHs3xHqZD6sIAY+DivwBH3RrgJevDoT2AXkfncw==
X-Google-Smtp-Source: APXvYqwRWQvg9XlTvMB6tdKDm8DAgcZ7HaMMybf2BolTcaHHy/ZOkwua6rlR9fdorUVafSp9UOv2jx2qoc3tFdax6WY=
X-Received: by 2002:a67:ee04:: with SMTP id f4mr5818616vsp.34.1553520463686;
 Mon, 25 Mar 2019 06:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190322141138.19244-1-yuehaibing@huawei.com>
In-Reply-To: <20190322141138.19244-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:27:07 +0100
Message-ID: <CAPDyKFpdQkOzXnBKjGhCZSgtBSSePkzeMUYwABkW61eCNzRu5w@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-omap: Make sdhci_omap_reset static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 15:15, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/mmc/host/sdhci-omap.c:788:6: warning:
>  symbol 'sdhci_omap_reset' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed47..649c03f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -785,7 +785,7 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_omap_start_clock(omap_host);
>  }
>
> -void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> --
> 2.7.0
>
>
