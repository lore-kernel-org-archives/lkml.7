Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795022146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moiJhGTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfCTNF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:05:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:05:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so19999003wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/7aZ2qEgUMS4VwIoiwp9ThhiabkO+yBZ85+zXiYDfoE=;
        b=moiJhGTbMn6iphRnXEa8YwF3RcwYDewv+vemObV2SSx/Wpgf9ZAA+9xrDqtm/tNY45
         A05aDJyU0LngNAUuIqPwqk4jKftOXi7m7+E4Xbrpi2Ty73oix8sr0RG0rRZ2n/YqAzUW
         7RzzXeJCfVGMtql6K6nXjiSSQ35iGJJiiNIAKVRyK6V40ked0JWsWm5O+aHXr/yAD4rx
         7pb8hXjI2wyHY0ZDR5XciKUSxWt/jmDV8d16hr/4gE0I120tGpEqZvQ/stqlFJGlc0K3
         +PT4NoAe5cBOCAIy3wYFcOVY0hcPA8GQKggLJuHOgSuq/FflFyZL2VBHo7xo75np3HSg
         upuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/7aZ2qEgUMS4VwIoiwp9ThhiabkO+yBZ85+zXiYDfoE=;
        b=BRQwGDn7+mNO1Nc4ku2o7qL72az8PcYGDDz0FnhV065qcNP03Oi+5l4znSIV0GP2iG
         1sruNt1+W4y4bgs4ufxLVP4USGytsT8XqxishLCWsJNoYaoE2Xj6TbsN/wRRGaUxjRai
         FMCl02oBVG0ATwgTiBauAndjTfJ5yroYpnjupp4S4NO6UhSxVqbwKwZL50yowpc1FvZR
         D2355J0mEazSvjPvJh98zW17V0Bk3KIB8jIBqxHnfLUdb4Ka7kUEYK6ILF+GIw7xOZ8b
         hbY1CQKNb+JYGFcMlc4nhTZHvWdGGoiDubhB6LknpwR9tnhPHFLr7R/ry+n9r9w1XFwc
         jz0w==
X-Gm-Message-State: APjAAAV2x1v6lMwi6cNk13QteYC+XopPHCViHOIjPfG60PMZSPjz8JaN
        F0txtaUp7L6Dh+2FPNeUsFGRog==
X-Google-Smtp-Source: APXvYqyYkijsXl6jDZ6l/pka/VdJ/jXuHhXMhrM3IoMtdmr7/0Pu3WGbigqKPUH2r/dCKuN5ZEKVRw==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr1431470wmb.84.1553087124938;
        Wed, 20 Mar 2019 06:05:24 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id l8sm1989105wrv.45.2019.03.20.06.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:05:24 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:05:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, arnd@arndb.de, mark.rutland@arm.com,
        gabriel.fernandez@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Message-ID: <20190320130522.GO4731@dell>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Fabrice Gasnier wrote:

> STM32 system configuration controller registers needs to be clocked.
> Document clock support on stm32-syscon.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - move clocks to specific bindings using syscon as per Rob's comment
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
