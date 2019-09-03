Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D82C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E2217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6PG039p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfICDVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:21:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40994 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfICDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:21:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so3244277pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YCNZUFFCq8Dg+vMJfD+J8C6FHbcggQzGWyRcaMVlho=;
        b=U6PG039pK9bsS1zvciaOqcNObGI7jJccmjXdUEK3bXW97rnyaYZIU4jE2Le2Bll2gU
         f6wEHFLch/afAO+ke4X2XUzvqFw+uEOXR4rg7nyqUeEYPph1iH9KOzGyvAOZp73VJJGF
         MFpW0y9CcZd0DAfU1m/Z3+unbIbVBjZynhqhLq/uKJQzvGq6gSpfn3cpQMaHu3f7DQ5x
         Ks6TnsBJyijVpdkAwPOTCH4PP1v2cZmxWLgth2QRegHt8FSWZv2pqmwOMeHnmpQCdKsj
         hP5ZbfprjgFmy5Fo7zs2SVOXGvmNnkHMCKcbbjw/qT10aprc2Df1p5UqKMUurV6bGmu4
         TZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YCNZUFFCq8Dg+vMJfD+J8C6FHbcggQzGWyRcaMVlho=;
        b=Wk1wtW7MFYCLzPPKQoudfUnusHVdqrBJYVVjUacQ4jDb1GsKX6YXaNWkyr4zDBzzRG
         8+ARhKTxuJTjF5u8/jNPlcvCOInEqAllHD11AJFDgk8hh33kuhoUA2onr05tZyc0w19S
         yKI3rNF471u939W856puly0J8AYvLg+4W71fSPL4pegyNZpOSMFZPPeF0nUPBl5T91eh
         Mu5pZvEEtP5fchaIY+u8QI3jDHbo4fuyclunvGZD1zDj4uM+UxsA/8rvrrFIDlfEOSGr
         C3lWBxHd//l3CAxNadPVBhFehHmkQmui/LbTcMeuZMso7zBAe+DNSi9+94PZ5VDhsmhx
         /23w==
X-Gm-Message-State: APjAAAUx1A4lxQAFatS2SwSbcEActcV2yLymfmP1kaDObi38qQyMSXXI
        ln0n6/n5snKlhPvEqKnFw/tlbQtzn68=
X-Google-Smtp-Source: APXvYqwRrr7EZTieX+RMyO61+sJm9FbeCeWoneGeKcok9cTk8OK8st2NyVow7YmYF3F8MXfmQAKbkw==
X-Received: by 2002:a63:3148:: with SMTP id x69mr26074750pgx.300.1567480907715;
        Mon, 02 Sep 2019 20:21:47 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm23361696pfb.122.2019.09.02.20.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 20:21:47 -0700 (PDT)
Date:   Mon, 2 Sep 2019 20:21:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, olof@lixom.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable Qualcomm GENI based I2C
 controller
Message-ID: <20190903032144.GS6167@minitux>
References: <20190902130724.12030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902130724.12030-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Sep 06:07 PDT 2019, Lee Jones wrote:

> Tested on the Lenovo Yoga C630 where this patch enables the
> keyboard, touchpad and touchscreen.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index facf19cc275d..0fe943ac53b5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -366,6 +366,7 @@ CONFIG_I2C_IMX_LPI2C=y
>  CONFIG_I2C_MESON=y
>  CONFIG_I2C_MV64XXX=y
>  CONFIG_I2C_PXA=y
> +CONFIG_I2C_QCOM_GENI=m
>  CONFIG_I2C_QUP=y
>  CONFIG_I2C_RK3X=y
>  CONFIG_I2C_SH_MOBILE=y
> -- 
> 2.17.1
> 
