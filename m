Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC356C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A3208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kx9ozOj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfFGTvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:51:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44640 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfFGTvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:51:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so1673344pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TVEMd3bZMyQ4yhDeztJRuk2J4p8KHFonqrl5D0eVVJM=;
        b=kx9ozOj9l8ViTxZ+S+v6BNTF3b8JJmWack9Y+41MjJrmzya6N6cjc44kWOFe4EWw0z
         xyOJvT3euw+oQ+2HGZVtHAKbfivt4twyEWb0jV2QJeBRxmuYhvy03PURjx06hj+c6li/
         zi0AVVWJ5RPrr7aueKO4i6DfodHwj3/9HxZwvUyP5sSvLjG5dLTG1WDV0msp4TMpbSoB
         /AsjeYMzfTFADZSMMSlqPgxuKrcyRZQeObboGFba0deMFwtAv+6HVKc7FAkzo5LR0jKT
         x9wOwne18xSxPqjhFpeyvEJ2Pt5iwvRAB3wUxcDTNqqaOFSOLbKaHEb64k4TO9VtWx0P
         L3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVEMd3bZMyQ4yhDeztJRuk2J4p8KHFonqrl5D0eVVJM=;
        b=fIUC1IJWE7km6qisLietkHaZOBehFGReNaJRnLxvM/ie7h7feCTJX6MjFtQBKGjqyG
         DKBnV+O2THjYLLcxwp7k+99YGfSAUe9MwdWmVZ4WPidn6Bmw89lIcsLivosa0e0eJlqc
         ZCx1euAChVjy/4gD3YbCN90HDqqI5MtEseHyXR0Nk0d6YKD4/Euz+aZm5tfHBZr1J8I3
         H5jkpsDeDl5Rczv/cDaKe7+8jn1zcyWArCa1Y02rpryV7sAPuqIK6JaXUb4JzDoSmgN6
         4U/1ddPGye+xpPUFwvyQIyZHzRjhbD4KElYWqIythyh3Ik/pU+PQU9YBBVAQobpqyAe8
         jNJA==
X-Gm-Message-State: APjAAAWW5Nl2x4Ew/K8YPsLa6HEQjpOpruOTjCcxYESdRm+00wpB4P7j
        1HAf1vT8ZJzo+EiQGQaQAJYx6g==
X-Google-Smtp-Source: APXvYqyW4EyjvINpT2OoNEqPgYxjlSm86KmXR2ap3vxcbxT+eDnPSbJRLJ+F1axxyMSBoVdW2eo/7Q==
X-Received: by 2002:a62:e710:: with SMTP id s16mr26263188pfh.183.1559937090852;
        Fri, 07 Jun 2019 12:51:30 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q3sm2662628pgv.21.2019.06.07.12.51.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 12:51:30 -0700 (PDT)
Date:   Fri, 7 Jun 2019 12:52:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Change QCOM repo location
Message-ID: <20190607195216.GY22737@tuxbook-pro>
References: <1559936691-15759-1-git-send-email-agross@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559936691-15759-1-git-send-email-agross@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jun 12:44 PDT 2019, Andy Gross wrote:

> This patch updates the Qualcomm SoC repo to a new location.
> 
> Signed-off-by: Andy Gross <agross@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5cfbea4..de1e935 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2079,7 +2079,7 @@ F:	drivers/tty/serial/msm_serial.c
>  F:	drivers/usb/dwc3/dwc3-qcom.c
>  F:	include/dt-bindings/*/qcom*
>  F:	include/linux/*/qcom*
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
>  
>  ARM/RADISYS ENP2611 MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
> -- 
> 2.7.4
> 
