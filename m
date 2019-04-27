Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF44C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA58D2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9FA2uFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfD0EHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:07:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfD0EHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:07:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so2517986pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sHjhSeHLZOISDTWLd5HgzhgEu5HKQPPyt82AaIYHEI=;
        b=I9FA2uFkm/p3DJImFhodZlql3qikYCK+AVc3mEzTwZKDBZw98Qr5AxT4d+3c98XL0t
         rElznvxBS5Ut7X0LSQjvPmPPBlRUP9fwPhpGeSwW4LSIwqDF9LIzAMM8A/O5Y590X7g4
         zDVIuQ+INt/J1StjR2of5pGiGjjfgKh9YuHiaCz5xxSiAZkb/Y5/165eedmq2HvWxHZ1
         LtcSajbLhjrFdQXuGA6N22Pjd7tI6cijBYotveVn2HhcFFKxFLFo2RooOcN4YszAKKiY
         KGHUBdcWp/3XiJRK8szmD7QFhOrawcQnWslZh5lJhnbjH9+Efoqx3FD0l0M/oiEhknBZ
         4Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sHjhSeHLZOISDTWLd5HgzhgEu5HKQPPyt82AaIYHEI=;
        b=SG1XtqBzEN8YU4uRVsnKf9f/G/xUYLabawyTwiuDD29uX3F8VAls/qte9ZXP8xXx5M
         jmTaIW/HqmQxDOWnW5zg08j5IehLVZUhi8hH3dW88Y3FGwZd4dAseRSysrlb7C8g1V9b
         RFFNi39LfQW4PHgNIEpjpz9AbguxoMey3baJEJaH2e7WL/P8aitvhtKGG4v8fUaNvRZk
         Gi0WAE8Lwbxa/2S4zsBzEPpO6AvoIFTdihfSvi+I3MkpizJPR33TycePXdYj469rV49i
         etAAvBxzPHqXTPyYC5IUL3M4PbxGe+ehGoFs+BAGWmUmJBBhPxG2e4hGKV3sj3Y4Fgkp
         X1Iw==
X-Gm-Message-State: APjAAAVOhpJLLsH5faaDH9E+2vNaw+6kHXchQxeVkZmpx3DSXqrC062H
        LMGdKWdTzSXIhhsg8BLy+H7anA==
X-Google-Smtp-Source: APXvYqxzWZiZxsqpqDMpICtkf+a6IiHzMjDlzq51uM7acysoesNv5y5j76madqtL7IOK5e4Qiaq7gw==
X-Received: by 2002:a62:b612:: with SMTP id j18mr51657875pff.124.1556338070896;
        Fri, 26 Apr 2019 21:07:50 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm43510021pfc.47.2019.04.26.21.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 21:07:49 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:07:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, joe@perches.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: fix typo in file name
Message-ID: <20190427040747.GB3137@builder>
References: <cover.1553848972.git.amit.kucheria@linaro.org>
 <c89ce5c4e66de489bb089dd60cd8a26949501a59.1553848972.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c89ce5c4e66de489bb089dd60cd8a26949501a59.1553848972.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Mar 01:47 PDT 2019, Amit Kucheria wrote:

> Commit e31f941cf977 ("MAINTAINERS: update list of qcom drivers") had a
> typo in the filename, replace the underscore with dash.
> 
> Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Picked up

Thanks,
Bjorn

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..d2c5852a3c8d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2007,7 +2007,7 @@ F:	drivers/i2c/busses/i2c-qup.c
>  F:	drivers/i2c/busses/i2c-qcom-geni.c
>  F:	drivers/mfd/ssbi.c
>  F:	drivers/mmc/host/mmci_qcom*
> -F:	drivers/mmc/host/sdhci_msm.c
> +F:	drivers/mmc/host/sdhci-msm.c
>  F:	drivers/pci/controller/dwc/pcie-qcom.c
>  F:	drivers/phy/qualcomm/
>  F:	drivers/power/*/msm*
> -- 
> 2.17.1
> 
