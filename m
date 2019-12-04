Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9567C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1CC20661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoaXn3dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLDJRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:17:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36312 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLDJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:17:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so2753818pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lMKKy9t0iWSR4/z3gVbW2YwCWQytCz8n363Y9SgDkLg=;
        b=AoaXn3dDFHX0ZWRCrotiHldBlB/HrbAlLuyfSzBLpifiSH9AVjZ1dj8Z7BaKH9srKf
         +nfYSDrlBV6KEf5TTRTVE940MSjDQV5a16P6WEbM93mSde6KBiZeA6nRAxw5Y25B/vnZ
         T5iVOgAJFmwHkTXfejyEXhk0jryeVIjlkrgZDB+IANQ7Ppjjw+WCfSoIoPyOmBk5/SC3
         m/4WwJOBPjBTvU3lKW7RnA9rmf7fJOKSPmSgGfctK+2LjzCuZV2ewflB92JKr429LENu
         2QaqPrTAuB5bm8jp/Y8wRk+pRvFHvaKUThzf3wRGmFAoCUvm0aIETHDh35mLioE6VHZK
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lMKKy9t0iWSR4/z3gVbW2YwCWQytCz8n363Y9SgDkLg=;
        b=WowwScHsLVUk+4zxPy6ZLdE/q5gMNwf6WnbJbeKZ3CaZEpD9iW1sFx8Hc9o6pi2gKL
         VAC9WtSpDZNQZpLN6wnkOav66MT+lECBZ1GkCF6t7/NKCMsEH99j57413BnQpPLD7ngM
         msMLaiH8Ywlnl/H5HI+hYF+EW6E4J1vFDBIcxSIRu5eVFTvyjTPrz8YwW/CiiM+bQGWb
         ZKbEE2DlxfT0LHon/Ckf/LiBLK2wKAtbcBT0PArpH+aGCy3UkWdB6XCyu7Ftwq5LP/UE
         p7iZ6ioumjbB+54X/znecrEEXEzmdI7CS9v9ygUcWDmVOLkNGQAt/cTeiBLbLomiP0Zv
         fwdw==
X-Gm-Message-State: APjAAAUnN8/Zmt7ADwreCcTXMn2qJlejT/0ip4i2THT3YYRsAf/G7aBk
        wDxZrxIQO27aaiXpnWiB8DTGoA==
X-Google-Smtp-Source: APXvYqyPYVArtaO2xDdvtLX/Iko7lEdMxiXPCNH/Ly1Vnt2lfYUTEc78zQ+nQkBgCTp9YuIdrXgr5g==
X-Received: by 2002:a17:902:8507:: with SMTP id bj7mr2349143plb.69.1575451025955;
        Wed, 04 Dec 2019 01:17:05 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id n26sm6717142pgd.46.2019.12.04.01.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 01:17:04 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:47:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20191204091703.d32to5omdm3eynon@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-19, 10:45, Mikko Perttunen wrote:
> Now, my original patchset (which this series is based on) did add
> nvidia,bpmp properties on the CPU DT nodes itself and query BPMP based on
> that. A change is still required for that since tegra_bpmp_get() currently
> takes a 'struct device *' which we don't have for a CPU DT node.

I may be missing the context, but the CPUs always have a struct device
* for them, which we get via a call to get_cpu_device(cpu), isn't ?

-- 
viresh
