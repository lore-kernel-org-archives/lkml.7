Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27444C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE642176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576704769;
	bh=bld35zTZcRXiD+j1dhIsJWuS7BmU8XOEkgifMLzAO38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K1zHJhlzHyb8yKOTARSFcYrx/VFe2NMRJU5hy+QAAGUv7yw/t8aWEM/1WshT0APAa
	 KNvNw3MroSQ1C4YrL+PylVih6pUw2dHezZL3m86PTaNa8w4YN1CqUUHRPXdSm7UyCz
	 pL9L/P/vBWNm/H/eUy138cWtYz6BgmxgfpJkUko4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLRVcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:32:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34410 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:32:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so1991141oig.1;
        Wed, 18 Dec 2019 13:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExRyZF/HT35yVWV944MHnvHyOox+9HKzQszoyRT+kgo=;
        b=A3qDz8WjfPOxcRhh4aTDV0wfsLxCmyVw3sz92sK5g4vyhoPnlMGAiVkGC6wpz0QZ0f
         Ieh1Qrv4Q4sCL7QzkMnD2SnzZjc6qJIUMlxWHBKONyStEhrdlS66csD9pkWftR39odqy
         V4I8lhUrvdkJ+vSOa/11ZOsIPp+/AmUGPd7SFZz0OXd0PNqnOWA7RZOF5E69kJIigz57
         gFZKAF0teQHAyEyh3A/P2nL+nGK+Llw4O1BVOXx03huqOcaVsORpEXeLIh9o3bJVxECQ
         b4R0p1DY8nPO4taskDcl3ScNUhQYAQh7jJE8x5ZRXQyicr5WL+bB6ys1W5+uB/gyhnLj
         xPhg==
X-Gm-Message-State: APjAAAXbwLwEJIkN4fMVfoRUmWAVa+wjw7pn2/qDDD8RdfiQBu+GlHan
        etCuDHg+VSOy3qM63org4w==
X-Google-Smtp-Source: APXvYqwM8S9+AzrNrHA74otnIP6JBmDMXRocmfVFFFcvwlrOBmtc64wp73828FrIwJ04oiTPlEJDMQ==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr1533371oif.100.1576704766553;
        Wed, 18 Dec 2019 13:32:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a74sm1255077oii.37.2019.12.18.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:32:46 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:32:45 -0600
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
Subject: Re: [PATCH v4 19/19] ASoC: nau8825: change Tegra clk_out_2 provider
 from tegra_car to pmc
Message-ID: <20191218213245.GA23867@bogus>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-20-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576613046-17159-20-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 12:04:06 -0800, Sowjanya Komatineni wrote:
> Tegra clk_out_1, clk_out_2, and clk_out_3 are part of PMC block and
> these clocks are moved from clock drvier to pmc driver with pmc as
> a provider for these clocks.
> 
> Update bindings document to use pmc as clock provider for clk_out_2 and
> change id to pmc clock id.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/sound/nau8825.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
