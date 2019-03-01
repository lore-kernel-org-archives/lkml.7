Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5320848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8diKhbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfCATIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:08:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44944 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbfCATIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:08:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so11890326pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+6GPnEcEAUhLS3vR+WsAU+G3Ji2ikNeu0iNdflTt0U=;
        b=M8diKhbYhBiiqaK5tkrUv3E655iRMtRIIB5et1fIUFuGnxNUgMX9MwU1Ejd6wyjFJN
         dLoHEdYig/95Rnif8yIlxvqJwHwGkCnJe3GWNAB9gIlwP4p9o8W9A1l1HuL9J5M6maxD
         U+YqYVMSaAsHyPsg+0s7uhiU+7vRtaxMe+U8A9cLfJo2UX9qDYPRVOac1VfcgblTSO2H
         hBHslCyJQpK/2h8bhs5Jdz6di1iNq/KDgaWMa+r59VJRvRnXXxnI/TyvffV/pZAhoNDP
         ziODU6ACQw8ND0SYqtr2UJO3VFjmMJRz+Nykkv0r++gxZV4v88FpRBEkiTQx9S6VpMOF
         LY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+6GPnEcEAUhLS3vR+WsAU+G3Ji2ikNeu0iNdflTt0U=;
        b=ly2yBgOZJJZYhXLY4Q5r05FfuoxPBxxNhM5QHLqspbXrIXvHEFWOJwYTjMPl/1tZAK
         cwGAcuOtT1p1lnh6quiXKHna3+OjHbgq3jC6i3D1hxrJ8TwoBNZOyMB13z6biC/BdkSn
         C7tCuNtuAKb+AT4tlI+9M6e92FMuK4OTf6xfrrNUB4UdEfZaAftNt8LRI9dvu4NONsET
         thlmSM+CeVyWYQaO+fLlqHHwcaJt2fY6dudnVjguqLZSHxA4cqsBCqN0+bFzC+c2JEsZ
         HeVarQQHoOXhZY8BbgW3dm3QMLaapdlnwLZURsf+YYOYihsyDyGf/8t3w/DHvtHcBDU0
         jKTw==
X-Gm-Message-State: APjAAAXegwMDuUiV2ruI1mFPigx5gi8e8kjXYHFcL6RFSywJgsbVwezx
        zE07ryEwy0FD4D2iNwNad4Ia+yNZWIc=
X-Google-Smtp-Source: APXvYqxJ9JiJwheLjVBW2F+Sv9/yTfOgzdGLxiCiOUzDUyfooKU8W3S7Tl8hddK1/d7UTjcmMgRBjw==
X-Received: by 2002:a17:902:7798:: with SMTP id o24mr7068288pll.212.1551467283711;
        Fri, 01 Mar 2019 11:08:03 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k74sm51942940pfb.172.2019.03.01.11.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:08:02 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:08:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v4 2/5] base: soc: Export soc_device_register/unregister
 APIs
Message-ID: <20190301190842.GB27005@builder>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-3-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225065044.11023-3-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Feb 22:50 PST 2019, Vaishali Thakkar wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> Qcom Socinfo driver can be built as a module, so
> export these two APIs.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Changes since v3:
> 	- Add Greg's reviewed-by
> Changes since v2:
> 	- Reorder patches [patch 5->patch 2]
> Changes since v1:
> 	- None
> ---
>  drivers/base/soc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> index b0933b9fe67f..7c0c5ca5953d 100644
> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -164,6 +164,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>  out1:
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(soc_device_register);
>  
>  /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
>  void soc_device_unregister(struct soc_device *soc_dev)
> @@ -173,6 +174,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
>  	device_unregister(&soc_dev->dev);
>  	early_soc_dev_attr = NULL;
>  }
> +EXPORT_SYMBOL_GPL(soc_device_unregister);
>  
>  static int __init soc_bus_register(void)
>  {
> -- 
> 2.17.1
> 
