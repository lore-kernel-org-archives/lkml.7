Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3EBC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1425A24680
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576712608;
	bh=JsY8wnlgjOmOswBCu6ssvSC/Jbc8DFtUGCRq/k+FGvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pG8zvnsjz6ZOlW2W1vI85dLdwrOnzya676y+0yeVuxBjvIqb3NECXMv09WwCcENqY
	 c3kubsWfVsv5eXnEiLZB+PBZZkFHhcGhxwV2m682IjyI2dxcyM3BdzBxTCgSw+IiWX
	 uM/Hw/LqeCtPvNB+6Vs4z/vHrbZzWSv+dQh4uqQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRXn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:43:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40794 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRXn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:43:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so1700782oib.7;
        Wed, 18 Dec 2019 15:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msjfoAGOe1xlJPE1TZ3Bmw7KcL7yxIkeg+V5WRco54U=;
        b=fGiFjuWswxGFDQ7VEF5t5A9uXobESIby0bmDSp/LSeLKGzv7ala6fe6sqX1l6C7Nz4
         Lq91Iv2Wylt6uxcvWeHbcCK0QzdDnhLNtINJQ4hdL9bGRXBvVNIUmGyLRZDc0Ux7Bvhv
         EmT0kros8K4mcCR1bduXSw7hBF+JaAntbrygVFRWAyoGX70p0nZ6PNEgATwcDu+X/jA/
         DNTtbdpGI1xnw7JRAS7OUNFKPxX0UBDmHrS44SNpV8JNPEsp3BfCwEfs6betGz/TLz/W
         QBtzhEdETEq/hSfT4eWssLwjbDaE3YG+lxHPnnjptORjdPNDmbTmZNJGYvemL/4BNci0
         Jgug==
X-Gm-Message-State: APjAAAUvs2BJztz2Bxg4cENipeAwL+mXnLZZKMcWI8rTj/O33TXANKsZ
        qmnR/XLQm6KpWWclNQWACw==
X-Google-Smtp-Source: APXvYqyuAOpnUBmA0v6QZRoARMBZbF7L6n+QbJWT4C9peJtbIAP5gasaJY57lTkyGrnVRbEgUNeoDA==
X-Received: by 2002:aca:bb08:: with SMTP id l8mr1594201oif.47.1576712605848;
        Wed, 18 Dec 2019 15:43:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm1396738otl.20.2019.12.18.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:43:24 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:43:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: gcc-msm8996: Fix parent for CLKREF clocks
Message-ID: <20191218234323.GA18109@bogus>
References: <20191207203603.2314424-1-bjorn.andersson@linaro.org>
 <20191207203603.2314424-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207203603.2314424-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Dec 2019 12:36:02 -0800, Bjorn Andersson wrote:
> The CLKREF clocks are all fed by the clock signal on the CXO2 pad on the
> SoC. Update the definition of these clocks to allow this to be wired up
> to the appropriate clock source.
> 
> Retain "xo" as the global named parent to make the change a nop in the
> event that DT doesn't carry the necessary clocks definition.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.yaml   |  6 ++--
>  drivers/clk/qcom/gcc-msm8996.c                | 35 +++++++++++++++----
>  2 files changed, 32 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
