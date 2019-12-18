Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1506C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9334A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576704733;
	bh=j1uJQ0XtX8XcnUkQ5p1k2qhsN+czD8DXwLPwYHwRv0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jq/jnddMsFlJ2abBf5HcQCOX+nW8yJgk6jdKNxy4zCR4nx6BKY5z7iL/Lo+SqiDUX
	 Fu0vMwUWgjpZwgGLx0XUvSUis4xAD68bU+moO1kr1rd2GuwUoYMXNtilTHjbkmL4bl
	 5q1yT2Uo41yektyZZVXXLn8jedCbo4EE8j1cHkQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLRVcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:32:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34371 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfLRVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:32:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so4249865otf.1;
        Wed, 18 Dec 2019 13:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6cR5cjWXquCfRvE+W/pPG29nvQyejfq0BlN6fGgdbw=;
        b=jr5GvkzNPczebNW/nwJGdU+gdblg455Cz4chtB+YXOpapRdJsLV3xFEEg++8z9PhaI
         BufOipJ5+0Tsp1u8dqFm2/dQyoJxXBd+c1Y0uMtV5IjMLOA7pusShNY6eb80P+iM1719
         nogwATsPsVKUy3hY+IOBiO4+rWeTU4J4kAANjVJK8h1Sn8B5OdxAPjqbagVqkcIe1nLt
         vs4rzvLehD/U/t7djhJ3j9hvGLVuiE5UnWdtFDA4St+Ci6SufbNH3yFO3qF6lWhDgazh
         97X2sGR7lUUF09jFcuHxtUn+1nqoJmlN03xyeB/KgXyRW1qsmgov1AuZb5I9rOcLfFy/
         azFw==
X-Gm-Message-State: APjAAAXOAeMfrv0Ic1aMsYF1l+fgkh9NWF5nUggmui8V8Fg6n+f6Y4TB
        1u+AdCdm+BX0kVOCO1pZvA==
X-Google-Smtp-Source: APXvYqziswJF3btCEwJOSoHjnpI0T4gtWdT1setdMlPdpGVDpGEr7eLPr9bhTavr8JiYrl6CNXL1jA==
X-Received: by 2002:a05:6830:1407:: with SMTP id v7mr5015553otp.58.1576704731228;
        Wed, 18 Dec 2019 13:32:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm1153616otj.6.2019.12.18.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:32:10 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:32:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
Message-ID: <20191218213209.GA22981@bogus>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-11-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576613046-17159-11-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 12:03:57 -0800, Sowjanya Komatineni wrote:
> clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra PMC block and
> these clocks are moved to Tegra PMC driver with pmc as clock provider
> and uses clock ids from dt-bindings/soc/tegra-pmc.h
> 
> So, this patch removes ids for these clocks from Tegra clock dt-bindings.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
>  include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
>  include/dt-bindings/clock/tegra20-car.h         |  2 +-
>  include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
>  include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
