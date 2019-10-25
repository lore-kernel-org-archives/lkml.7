Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9824321D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG4lhRPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438040AbfJYIzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:55:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437229AbfJYIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:55:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so3783947wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0o1evno6haV1PZk5CsennP2f66XiGB9AxCdg0rnVFQ=;
        b=FG4lhRPIpLv1bI2+5PQqXPccLi1M2LaG9ZFLA3JTw9apptcOjsF4yUBGQ1p2o/MVPP
         aw/pTe89CmukvK92D40EQeECYpkHiTjrvVWy5M5Y4T323TNQ2ZIG97XnDQkuGBUITFG5
         6bm001yu7zKieO1XyPmOa0noaAhkf71cDWchXEbw0rWk/i70Zt27f76GLPuVifDxLPgm
         wRnSP+8ztowGnMPeWBSnDnrfcaoriRwcpl+9Kjv5OjIpiPbpUhEecKJu7U6BBZ8Qo66V
         sRZmFoL+5r33yQDEQnwb1vBOA0QphlCzcBeFWrxEC8nf/im/I8lsYMgmfo/jsROilf0Q
         W5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0o1evno6haV1PZk5CsennP2f66XiGB9AxCdg0rnVFQ=;
        b=GJQ483a1u4v5+QMA+O4Z+KNz+myKzq1wDvl5q1xd55psF/+b7X6qAoaYXioHA/Rzyb
         XSvJkBTS3seylC9ZvJk0QGpW9iCl6xNPxEHKQAWgC13JMlyPLKqSzAzKilUEIsRvJjQs
         2M2VHcCXU0/5n0Qwb5o8q/7ThW58syMHLTyypV2Q6LDgcRvX8rNQ0oNnLA5wA1sz1lu+
         W6mkfl4Yxsuo3YP0sCs1PQmWVLihs6g5CZ7xbruMkB39P+L92726uFIdISLhnOw4biN5
         TePtVS3mJj2Qh1hYHegkG8naSmt1ieGdmii32d6LeuygYisXEpfX2Z2Ir8Dw2i8UR1mS
         aCWA==
X-Gm-Message-State: APjAAAUGYU5dCNdP/qEIn1aU/p1Pe6GYk13lORW1MdeGJYEZKnkM+THb
        NTQcp/Ovu6xuTmxy+NNnkJB2zA==
X-Google-Smtp-Source: APXvYqwxebVwU3JPLWu+FN21Yw5b1DUrU9iBzksnwjCY+rWOd7gEbbU27OgkACABTCrk/ERH3DzeHA==
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr2497100wmu.69.1571993701786;
        Fri, 25 Oct 2019 01:55:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o18sm2031749wrm.11.2019.10.25.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:55:01 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:54:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 07/10] x86: olpc-xo1-sci: Remove invocation of MFD's
 .enable()/.disable() call-backs
Message-ID: <20191025085459.roxig2nyxfjlf6dz@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-8-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:29PM +0100, Lee Jones wrote:
> IO regions are now requested and released by this device's parent.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/x86/platform/olpc/olpc-xo1-sci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
> index 99a28ce2244c..933dd4fe3a97 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -15,7 +15,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_wakeup.h>
> -#include <linux/mfd/core.h>
>  #include <linux/power_supply.h>
>  #include <linux/suspend.h>
>  #include <linux/workqueue.h>
> @@ -537,10 +536,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
>  	if (!machine_is_olpc())
>  		return -ENODEV;
>  
> -	r = mfd_cell_enable(pdev);
> -	if (r)
> -		return r;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "can't fetch device resource info\n");
> @@ -605,7 +600,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
>  
>  static int xo1_sci_remove(struct platform_device *pdev)
>  {
> -	mfd_cell_disable(pdev);
>  	free_irq(sci_irq, pdev);
>  	cancel_work_sync(&sci_work);
>  	free_ec_sci();
> -- 
> 2.17.1
> 
