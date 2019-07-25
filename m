Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB73C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99E822C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5xiH5BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfGYKuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:50:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGYKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:50:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so50237230wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nQKT+T/j1mdeFVdWVU9qGzrt5bCMU/p8+mOprgJEXjo=;
        b=Q5xiH5BCEcUylSXkwJzTw8GU67wok8D2UApuNxGeftjwWvI9FpMlCMV02IoubS1AIV
         7WJjUIRjsWm1KjGYFuGbjniAVrUD2mSdICM5BQEimiXrhv5BGzEdGaa6uv4MZvsoO17F
         ZmZ14Oj29G7UTk3tLJVzvQ/aOjWkStfyajXITBDcC8HgqmCMDnDjQg1Vyb0eoBU6Kk48
         18lKwshNKxBYPIbkrSZeaCATY4OWsx/rHO7n33hRwEZIeRX6SUKnl0gmgMGmb4GwgpkN
         eSl3VGAmVTvxaFLq+0fWotEA0xT2JCRvvWL/TCS0muOCtsIRLuA70lUQk8mRCV5yzozt
         xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nQKT+T/j1mdeFVdWVU9qGzrt5bCMU/p8+mOprgJEXjo=;
        b=rF3nnaDWTqOufHEB3dtbriYcYUsBuDywMrRPJWXD0WfUzXnorrmiNOFRgFHUKg+2OZ
         DIGcfoMV3Vq3JylvWS+P7oRFsu9pPpAVks05JWzoQ2qVedjmc1HhwpEWPp3jpfr1STo0
         +cnCbvw83Pgn0bAhGP6KL4dPUFDvqGkD7F/bpEqYNG1lkzyhZ2TXoTwSXHir4ci9WQKs
         2ETDXBl7qCaTccYIa3EaLMm3fQaYRYEWBNpEEYvTfjU5LNRrH3B/9+349xlJPy08KFHA
         Hjar8KE3ukTV484qbd9MjiF07f8LqEc8tkTjTfZNKY+y4gYXUeYyw9K6JlITDueyodSZ
         bsfg==
X-Gm-Message-State: APjAAAXHZMLPCJZDIsy3I8Os1ZmcdkIZBozhR6Ljv8wlJWNQwdJTsoc4
        ojf2ZZ/W7fMUskhTWJM1mF4FpX/s5Yc=
X-Google-Smtp-Source: APXvYqwT5urqV3M8pPx1TSnTm+HWq+sEnCGeR1pyHNhxQ0nXjhwjD+PDwZmn+5zjuOb1aizsgzoIpA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr92247582wrq.333.1564051812935;
        Thu, 25 Jul 2019 03:50:12 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id b5sm41182841wru.69.2019.07.25.03.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 03:50:12 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:50:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Arnd Bergman <arnd@arnd.de>
Subject: Re: [PATCH v2 02/28] mfd: Remove unused helper
 syscon_regmap_lookup_by_pdevname
Message-ID: <20190725105005.GA6164@dell>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560534863-15115-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Suzuki K Poulose wrote:

> Nobody uses the exported helper syscon_regmap_lookup_by_pdevname,
> to lookup a device by name. Let us remove it.
> 
> Suggested-by: Arnd Bergman <arnd@arnd.de>
> Cc: Arnd Bergman <arnd@arnd.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Hi,
> 
> This patch again, could be separate from the series. However, it
> will conflict with the series during the merge. I have included it
> here before the actual series changes appear. Please do the necessary.
> ---
>  drivers/mfd/syscon.c       | 21 ---------------------
>  include/linux/mfd/syscon.h |  6 ------
>  2 files changed, 27 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
