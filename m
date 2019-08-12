Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE47320842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwnqJLC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfHLJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:40:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50468 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfHLJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so11523108wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=59c3QHXShQnZeBOeVXyfZYyWKS3iXSLrYGkx5kM2ofQ=;
        b=PwnqJLC1Guhk76m10HECrO9KNcWCjyUdJrIQOYPHNxV28xqc55Wbv/PBfqWoh7kFvV
         bj+STLIRGB29npgk34GVpRMb6wWy5ufuZiGRfl3CpE3vTuD1p3kBmHMAGQL/36WvOEcB
         5oufOskSKbLRlVLusJnfnY1jTGW3yoiwb+UbFAOr/RgBlrl7V28Fi2oPYa0luHHvmvSS
         Na9hSZAoz7NZaF/NLOxYMoSduLrw+EQeJ+iGKijB2bJjab79RJsCMvwcpSDNvgT7+pqQ
         gy7IkXPm8cB0Po0H/XoBZM/5lTZu5QLFOA53yKhMs0SMGnhyd1t6C3wTyTumuXpPTr59
         AcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=59c3QHXShQnZeBOeVXyfZYyWKS3iXSLrYGkx5kM2ofQ=;
        b=lf35KVvBXnRTN3JS54lok/SfI2Z2cCupZOsr0etxzdmvkDIuzFjivzpLQVT1v+xeGx
         Pd3H5vTblqqxHW/ZBBoonvb6dW8nwjT8D6dinZT+q1p5nm/IJAeFUeUQAB3dcddh4egn
         g9iMVdBOevsrqL7CBEVIMPH4emo4Wir+PTQJ3wvC0BJaRFfDlFs+RRNzoHUqhilQ5x8k
         9fvEbvBhRlz5tLrGNC1vDRD0503L/oB1+XguwnziryZAI5ol8fX4BAO4xgBOo0RmbFB8
         f5/fjYmqu3DMYmSuV6irztLZFtAEhPv36nLlLGP1tp41v0D8/kxMYvP4z60r6dJzFk1X
         yl5w==
X-Gm-Message-State: APjAAAU4Xf92VwKzyk/3n53dHmNO8804Ys3B33m4lBCjk492xEQqO0Z0
        oCKuLNsoolidj4D0WYPSEnOp0A==
X-Google-Smtp-Source: APXvYqyKPNnnSt0LN3y13OrGNxqAfH0vDwGRaY5OjZILvIYA18kRJmmzSXZBB0dpTThOcM7G6iSlYw==
X-Received: by 2002:a1c:1b97:: with SMTP id b145mr25393126wmb.158.1565602772035;
        Mon, 12 Aug 2019 02:39:32 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id o17sm12910169wrx.60.2019.08.12.02.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 02:39:30 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:39:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 27/57] mfd: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190812093928.GB26727@dell>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-28-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730181557.90391-28-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Stephen Boyd wrote:

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/mfd/ab8500-debugfs.c       |  8 ++------
>  drivers/mfd/db8500-prcmu.c         |  4 +---
>  drivers/mfd/fsl-imx25-tsadc.c      |  4 +---
>  drivers/mfd/intel_soc_pmic_bxtwc.c |  4 +---
>  drivers/mfd/jz4740-adc.c           | 11 +++--------
>  drivers/mfd/qcom_rpm.c             | 12 +++---------
>  drivers/mfd/sm501.c                |  4 +---
>  7 files changed, 12 insertions(+), 35 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
