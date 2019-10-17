Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF6DCA9EC8
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5BB21D80
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTBpYroK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438343AbfJQW4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:56:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43141 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389846AbfJQW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:56:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so1846702plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7fAk6Ny4DJQ5l4MTTiOy6lM7oc/Wj2NcDwRmnBk5mc=;
        b=HTBpYroKSBaPUtGEak9yuDbAiftxZm4Y06bRyoXf4yy479H26dVNgqyfTelLzVrwkd
         mWP51goHVTam5bBvJMd9DxEAHtJZe819kIY7kSEldm/gVL1u3Rk1NU7uNBzGplKZ4QmN
         MRj1JjAOK73X2IOpNx6TK85mAIQ/Z8zxrHX8YKw3La+MRIFEpTWGHADtgZHHJCE25RLK
         qOUONxOwcCHXWIDNEFn53oYoLw5KgDkQz6qGXo9zyYLyN6ulGlF5QX8S+G/rnIRlkqGB
         PHHIpR7nQkzrzU90dlfJ3AEUyOK429glHW9o0u7txbuuEpTfV0ZFrLzI53ilUfKa/bXS
         5lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7fAk6Ny4DJQ5l4MTTiOy6lM7oc/Wj2NcDwRmnBk5mc=;
        b=VHQEmOfSkrMbdbSDB2aRlcW+8B/3dASMUHu11wq2IUyJSZbvkIVRLIIVHZvwrNN4KV
         fLmHrFmP4s0CKgyQQwX6cQIPSLswvCe0s98dMz6RrdMegymcDYglEzAY8kkvbuQXhSyn
         0Q/R5BDfNbeA9j+H5+sQooJs5Mq+Rh9s/AztouaRZTXMFcR+kBF8gVaFR8oRlBLUbOQ/
         F/M8Q8zK5PDsCfvMasl6USylBCGWFGarw+o3ckwdsHPvu+S1xdWLLWSInSw9gg4OMwdQ
         zWiXBH6sqQ2LJ2BsFYgnIbpaBiWyk/+GIWix0cISa4LWq1w9z6IHlaEaVQVpYVzy33hP
         CDaQ==
X-Gm-Message-State: APjAAAU7YeRe43rvbkmg6QRAzRccpHS5fhZC+in393Ro9kqK4qLS2uMt
        6e8JeHVZu6HEe04A4Bg7moNPsmOg4og=
X-Google-Smtp-Source: APXvYqyrOw1FIEd/vQvX0yHxqzUjxYrKB+jDFUhQZAJ+1gX2nk4jHPUlXGyn/miCjzxIwudaEuS0EQ==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr2057661plb.184.1571352961749;
        Thu, 17 Oct 2019 15:56:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d20sm4325548pfq.88.2019.10.17.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 15:56:00 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:55:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable SN65DSI86 display bridge
Message-ID: <20191017225558.GA4500@tuxbook-pro>
References: <20190926230209.47592-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926230209.47592-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Sep 16:02 PDT 2019, Jeffrey Hugo wrote:

> This enables display on the Lenovo Yoga C630 by connecting the DSI output
> from the SoC to the eDP input of the panel.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Applied, thanks

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0134a84481f8..f318836bb9b8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -541,6 +541,7 @@ CONFIG_DRM_MSM=m
>  CONFIG_DRM_TEGRA=m
>  CONFIG_DRM_PANEL_SIMPLE=m
>  CONFIG_DRM_SII902X=m
> +CONFIG_DRM_TI_SN65DSI86=m
>  CONFIG_DRM_I2C_ADV7511=m
>  CONFIG_DRM_VC4=m
>  CONFIG_DRM_ETNAVIV=m
> -- 
> 2.17.1
> 
