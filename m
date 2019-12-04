Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A91C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FEC206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZITHQSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfLDJvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:51:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44519 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLDJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:51:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so2771535pjh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=odZi1IR9XnidejlBLuktGXZN6VtsiVWqqzPx3lEfMLA=;
        b=EZITHQSpFxAZT7usbVviH2ml3EM4eJuEr7wGxBmMQMA542RB044GTT2Yfvi31fwPwj
         0szsqeoYyhxci7N4M1Q8L0voTsmAW210qZPrEg0GKU69+SF68UoL/sS8ok1AW0Cn2Zpy
         7bIjXY2Hv/Rpzi4bcL8w+rAupBSHi5cl5zGiAXFm6rjf5yQrjiYzyMD5RlkRWn7i4Fbd
         1syMeTlE/RV8VAozHm2/S4ZV9QQsZTbIyxXL/iVugxJe/yBaLLgMOuxXKFIeX5A4hW6S
         ibbg7jddnoyTowI1oGoAQG4iJt1w13W3TQsEC9aRwZB6bFOEkffLKZ/OzJqbjp94o+rG
         AQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=odZi1IR9XnidejlBLuktGXZN6VtsiVWqqzPx3lEfMLA=;
        b=gq6gG2jqcSl3ejph4M0AHg6MvzuEjNCTXxvZJOicLJacBfxVtcm4u/DjIA2fTTEgl3
         Cdmx2u7sbvTb9xoFarlyJAhYMeWPKzq0hS5gHjN2eJa4bANnZqSwBAD55z5wX9/CjivY
         1wIdScBIgR/vNidaR2a/5I79HJBx/RhSW3tS9e9msAoZqTFatndpaTqvrdMW5D1jh7e+
         Ksf2PPWZcUbmJB37pYJ2eVT+6Lsp7p5mn1C+dz8sax7d+nq3Ib1PaPiO0kuuMSPRsHCl
         lbunmES6mrp68gfcC+X0buszd0HskyQ7p91XebByZdXMzy7Ne8sg4FMchFLsBrKrZsdN
         VoXg==
X-Gm-Message-State: APjAAAWYdwYpcGTAeWHfBTHxznNWEYaANzaLO4HYOQ2FFy8Y9n3iz5B1
        LcLvLkHRE95X7J7wwC5okCiIiA==
X-Google-Smtp-Source: APXvYqyY9INZ1vv31aECkzfh918+GS1MGdepYxOYtRHcgrBPgrxoBps2q3Bn16LMv/xK/VTVlgWi5w==
X-Received: by 2002:a17:90a:19dd:: with SMTP id 29mr2442390pjj.32.1575453101867;
        Wed, 04 Dec 2019 01:51:41 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id u5sm6865104pfm.115.2019.12.04.01.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 01:51:40 -0800 (PST)
Date:   Wed, 4 Dec 2019 15:21:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com, devicetree@vger.kernel.org
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <20191204093339.GA2784830@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204093339.GA2784830@ulmo>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-19, 10:33, Thierry Reding wrote:
> Yeah, the code that registers this device is in drivers/base/cpu.c in
> register_cpu(). It even retrieves the device tree node for the CPU from
> device tree and stores it in cpu->dev.of_node, so we should be able to
> just pass &cpu->dev to tegra_bpmp_get() in order to retrieve a reference
> to the BPMP.
> 
> That said, I'm wondering if perhaps we could just add a compatible
> string to the /cpus node for cases like this where we don't have an
> actual device representing the CPU complex. There are a number of CPU
> frequency drivers that register dummy devices just so that they have
> something to bind a driver to.
> 
> If we allow the /cpus node to represent the CPU complex (if no other
> "device" does that yet), we can add a compatible string and have the
> cpufreq driver match on that.
> 
> Of course this would be slightly difficult to retrofit into existing
> drivers because they'd need to remain backwards compatible with existing
> device trees. But it would allow future drivers to do this a little more
> elegantly. For some SoCs this may not matter, but especially once you
> start depending on additional resources this would come in handy.
> 
> Adding Rob and the device tree mailing list for feedback on this idea.

Took some time to find this thread, but something around this was
suggested by Rafael earlier.

https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/

-- 
viresh
