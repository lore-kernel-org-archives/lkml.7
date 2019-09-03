Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC66C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75912216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzzlGt3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfICDWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:22:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35110 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfICDWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:22:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so7430453pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 20:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C5xifJz6MrO6nz3FslQLOA1AK7POvdFVk/nrprJjlLs=;
        b=hzzlGt3VPY9MI79fgkmOFtXWQRrnPdYCLKbZqGO43YHSHmw7NE6GMjchqVOAsvCOPx
         JqNqakKR/gtui26JyGJguAnupphI6I5hrmYf+34IllOSFUAcoURMGsrqoqwN4ujNNae9
         1wDHeNLNGXL+wBw//6l7S1fGJIrniuVCrDNNN9/8cr4Kwr45aprAnFZhcduSmrUH6OVT
         rfCh5/+opQUOoGSSfaqWaH/lKuWQZvzBS3g+Xte0n+E60nkrfEo6+qqqPFr3kS/uMgEW
         cTwOs9RDVVCIBAt8lQkgkyYQPGBTIJ/8HwXpYvn+rsf1NBYMmKakFFTZDj6mAriG9a/o
         AZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5xifJz6MrO6nz3FslQLOA1AK7POvdFVk/nrprJjlLs=;
        b=NULDbB3sbc6m8Sy0hWIq5p6abGKMjZd20kGLOGbxNkEn0v62AVT0++nHp4dWyIEW04
         Hpsy9gOGhEzRK/rS2fdS+8mSNu3GVvCn7fYdXWaH+CBPbP+/ymPKLtVcwYaolxubey5o
         eEEAsFrZVZgTbNQK4VM1tkejAlylGvVsO9mOkMstTUjZFp6YmT/CT7PIsbOWPNVxGj7w
         LvVhEIpnRSv2HEeKHFSNBZGJ4qgGjlK3RQrruAPaw18BwrRPBeYBZ7N+Zlrt2lveT9YR
         ltmQRgnbH9Y19xB4gOv54kvqQPZLiLbdpUV/9fFoZRnVIILlv3foLAbgJ5CkFUDq90qj
         BD7g==
X-Gm-Message-State: APjAAAWuQBwawqLnPK3IFKKPz2FV/Qf/+yMpkiI9L2STuPB/LdXaTrOb
        eQ1y8SxO42nmzUVChPQxYlp3OA==
X-Google-Smtp-Source: APXvYqyxTsTf/DMN8g/gI1+80oPnZJl+iqDtLbGop7zzBOTpAboJep3KFSYOKyiRzAeTux4afDVEjA==
X-Received: by 2002:a63:6244:: with SMTP id w65mr14014871pgb.410.1567480938270;
        Mon, 02 Sep 2019 20:22:18 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j2sm292826pfe.130.2019.09.02.20.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 20:22:17 -0700 (PDT)
Date:   Mon, 2 Sep 2019 20:22:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, olof@lixom.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable the EFI Framebuffer
Message-ID: <20190903032215.GT6167@minitux>
References: <20190902130724.12030-1-lee.jones@linaro.org>
 <20190902130724.12030-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902130724.12030-2-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Sep 06:07 PDT 2019, Lee Jones wrote:

> Tested on the Lenovo Yoga C630 where this patch enables the
> framebuffer (screen/monitor).  Without it the device appears
> not to boot.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0fe943ac53b5..af7ca722b519 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -540,6 +540,7 @@ CONFIG_DRM_LIMA=m
>  CONFIG_DRM_PANFROST=m
>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
> +CONFIG_FB_EFI=y
>  CONFIG_BACKLIGHT_GENERIC=m
>  CONFIG_BACKLIGHT_PWM=m
>  CONFIG_BACKLIGHT_LP855X=m
> -- 
> 2.17.1
> 
