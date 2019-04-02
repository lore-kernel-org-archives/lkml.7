Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D639C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BF620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8+6WX2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDBERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:17:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39825 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDBERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:17:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so5856750pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a0qx78kuY10hcO8pUn7vYHqtV8RW724JNmIEI9ZX1hU=;
        b=Y8+6WX2AligyBZo06Q8F0bb4H53rfA5iOzhTWMWdmC8owZjfWdVxkmZ4bkC9RvIiMO
         o9C5Ei6KJZfyTJZHxYtE/jh7NVsDofIYSMnnQUxxVZM0eN99gxEJabqL/3SBpDyF62Gn
         kxYeD9/B9Mg06rIJgoY9cr3rgMQ3QHH4rfa/a1swRzsNfzykZBGsbVk9IMmMj/2/GEzC
         YyKTKDfSrBtZptRhRnsXtCyVq3P3RXiZnTxeVnbZcdsp+CSxbCEShk9Te8VCv7N1Dx71
         Bz6PDrfPUOep18KGshZHLrZlDhiSdcu8Lvt+9FPfRGzE0gzgwviyGrrajXd/3WB3SCfz
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a0qx78kuY10hcO8pUn7vYHqtV8RW724JNmIEI9ZX1hU=;
        b=IKSVg+pIZFQYBMe08ejDgH3YywpVyj7L257PA8dzBmLCEKk/+mXFMasSGtfCtoOGsY
         EO/ZYWx5CnWs+BSm+l51K/Ys9UVTVnBUVMUzcug86qHMO9brMEWA8qiwPV0E/B2RxhlM
         fOhkaf9YkveLDitY/RQCwtF0Ne3BoAZjqChIoiV656YySyK0T9zbJ2jXIDfAqedhqIBU
         V9nUA09MtKxD1tdFTX9nXSejzeT/Kj7NHUCEz+syLOFlqbhQIw89nV8iW01jaPbq+scI
         jGzpLf87fND+/83QXyoi01YhOAgWMywNHePMomYTox3qCjCjV6JATzOvKejUIwFobt63
         4m3w==
X-Gm-Message-State: APjAAAWLkmVK6sD0MZAAampX/A6axshwuvfaSdXh/qI/ZqQxXjmbFShc
        l4IuSCmR6n1/U5Ej3EDqY8QbRw==
X-Google-Smtp-Source: APXvYqy5ArUUyVOOVGot4MrWVBsLMRJo7Ry1qos4p/9Gsr2iwyYx7bEwmEMaNvp7QeoLJh8s/73sVw==
X-Received: by 2002:a63:c302:: with SMTP id c2mr37480589pgd.235.1554178657060;
        Mon, 01 Apr 2019 21:17:37 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id d3sm16985523pfn.113.2019.04.01.21.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:17:36 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:17:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Message-ID: <20190402041728.GP4187@dell>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551780434-4580-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Mar 2019, Claudiu.Beznea@microchip.com wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add new compatible string for the HLCD controller on SAM9X60 SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
