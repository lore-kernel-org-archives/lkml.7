Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245DC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEF9208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJ5z3L0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfE2KO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:14:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37973 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2KO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:14:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id 18so770485oij.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EAGedgacrWoeLyu0To12qxT1eO2alYayXGjZrLvwd+k=;
        b=AJ5z3L0kCSDsX8kXY7FSc2jTfD36U/yC4myrub3XWsesly5t1RLKUIYsFwmIk7zsYu
         G/ec1s4wKrkwSBj9pKJFzg44ijlFkepzOOVECZb78w2ln3vLeD60cOOUcrWjhvm/hcJj
         942E4WXbRgAxpZvAmBSkQhzszZ5bK+LHKWUDvfALZUh1KIitzPIV9pDwHwczthbpj6dX
         e6IMh8yRgg27ugsXJVH2tMCQrdblMWGwu8SuiAdRuTkI9USXONsl/TqcoWuCAoCtatnF
         ox3+f8AKTVMwzO+PznlyqLjWcdMeTDySGBYIriLWSXL+bIV/wMyDDeS0qlMUH7F541ct
         m+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EAGedgacrWoeLyu0To12qxT1eO2alYayXGjZrLvwd+k=;
        b=hut8IDzgUMIFFe5y3eOwS8d3hWaHxXKAeba+ZV6fNT0yLKtYzg074lZHG+vKCdQcl6
         2INmXjtIZQlPMdTBmTcfvhoH5WYjEdfQQSUb+fBoI+FwkzFM+lXQUapptaLaJDQd+hRV
         aUZFFd9xt7iqL0J5kodymaXOFxurx09rYBOEH9rmReXfMJXcHd0Cwo9WLH32xtn68qeJ
         3gvHbe1IXn1rsjFyEqipgfIlEqg8RK6bNJc1v7gCFlKEBDdnpW15a6r19suXX/DggB6p
         z6A2yTWdE2t4Mk9oz6wbwcF2kcDT4O5OI9IMQnsmzRyqFG13GM5oj77w+5krp9ZbWxK3
         KdAA==
X-Gm-Message-State: APjAAAUsU7LCaZIu1aaibGGGI0Nq+0c4lZTkr6nkgUSvYZ3qYn5W66yi
        rVE28b5fnRDurPI54mSkbA+OTw==
X-Google-Smtp-Source: APXvYqzycnDr7LSCH8lljP2nquWhzzkKaVjxa0t7sxxmmSebqcmDYlIZAEK+IFDcl6SuyoXkBJH5LA==
X-Received: by 2002:a54:4f98:: with SMTP id g24mr6026696oiy.99.1559124897777;
        Wed, 29 May 2019 03:14:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id w24sm5608786otk.74.2019.05.29.03.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 03:14:56 -0700 (PDT)
Date:   Wed, 29 May 2019 18:14:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH v2 00/11] dts: Update DT bindings for CoreSight
 replicator and funnel
Message-ID: <20190529101445.GC15808@leoy-ThinkPad-X240s>
References: <20190508021902.10358-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508021902.10358-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:18:51AM +0800, Leo Yan wrote:
> Since the DT bindings consolidatoins for CoreSight replicator and funnel
> is ready for kernel v5.2 merge window [1], this patch set is to update
> the related CoreSight DT bindings for platforms; IIUC, this patch set
> will be safe for merging into kernel v5.2 because the dependency
> patches in [1] will be landed into mainline kernel v5.2 cycle.

[...]

> Leo Yan (11):
>   ARM: dts: hip04: Update coresight DT bindings
>   ARM: dts: imx7s: Update coresight DT bindings
>   ARM: dts: qcom-apq8064: Update coresight DT bindings
>   ARM: dts: ste: Update coresight DT bindings
>   ARM: dts: vexpress-v2p-ca15_a7: Update coresight DT bindings
>   ARM: dts: qcom-msm8974: Update coresight DT bindings
>   arm64: dts: hi6220: Update coresight DT bindings
>   arm64: dts: juno: Update coresight DT bindings
>   arm64: dts: qcom-msm8916: Update coresight DT bindings
>   arm64: dts: sc9836: Update coresight DT bindings
>   arm64: dts: sc9860: Update coresight DT bindings

Gentle ping for maintainers.

Hi Andy, David,

Could you pick up patches 03, 06, 09/11 for QCOM DT bindings?

Hi Sudeep,

Could you pick up patches 05, 08/11 for Arm DT bindings?

Hi Chunyan, Orson, Baolin,

Could you pick up patches 10, 11/11 for Unisoc DT bindings?

Thanks a lot for Shawn and Linus have picked up 02, 04/11 separately.

Thanks,
Leo Yan
