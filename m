Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 05:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABB32073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 05:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6+eEjjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLDFkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 00:40:47 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42702 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 00:40:46 -0500
Received: by mail-pl1-f172.google.com with SMTP id x13so2667200plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 21:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nlaIN9YqTeVvOEvOaqRQ1YaBEeRTTUID5rlgxCfwdo=;
        b=N6+eEjjOXNURHW7+/eOmwTJmKlUtN5Qio3JCf2wYAxAHhpfA7j0ofmB0X/H9nUGjo5
         TjexCAQ6QRPCkhaW9R2l7OYDfhx+7HYGQJIJc4slotpuLNOGy601afmwwarinuAVupmy
         DI2SqMagEVpIV1q7JRUeYCDsdqPbuylq1dBKArtS6sSPCHPEvfFdvZX5cQ9ZnkwtdIEv
         13qX5PcwnTttpBuNmZ5S/fgjnH+8yDy/OHO+ewfkeBJXaJMsv0Tq8OWlMwVcg23S/yD0
         qB+Ac/XAdASZpLHOeQggAnRdt78Sz7FYLnS9ZBWrFTh0/XgB5iAO75B8rb5n0XNfgBDC
         rVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nlaIN9YqTeVvOEvOaqRQ1YaBEeRTTUID5rlgxCfwdo=;
        b=ib22Q7jK/TwWwH8AEmVQEsE98zEIKNNE74nCMfuzw2PvbkJAp395XF/cIl9zG4AyzP
         LfhQWRzsQ+c1ekvBHfBuR3q9UM6FlASKbDRD2UPbtFx/F8pDbI77evZ68xID1y/TlaQh
         EOUpYWad8ZG1vM/O3OB6J5/UxlhaC2QlywSAfkShUSvsQBV85R8HmKmylSrbSRa4h3P9
         wRzhvhPS67XBJmGMhMMN4ntXz5IOCBoKiMsEqqO9C50AeZkrDAmh1CmNrqnRAnnq7xl0
         Ol7syRwvCupu4wg6cTplh1M/m9AhQCrkMo1Ls2ZYspRZtD6A7Rtj7DqEqT77hjF3LKMA
         0J4w==
X-Gm-Message-State: APjAAAUdg5A76Ksm4StseLtM9Uq6D1oHip8g4KekXXcCx0tKgMqstn/E
        DlrjhzY3GIfciRKDiEsPH26BIQ==
X-Google-Smtp-Source: APXvYqxZVKhH0TJuFE6+Z7bfpOYjA3Ow1d6WgjnXTPJIsZJlzXz8bQ9KYyuieRvJBl6AiMxxv823Kg==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr1477376pjb.134.1575438045902;
        Tue, 03 Dec 2019 21:40:45 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id x11sm5811790pfn.53.2019.12.03.21.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 21:40:45 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:10:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On 03-12-19, 23:02, Sumit Gupta wrote:
> Add support for CPU frequency scaling on Tegra194. The frequency
> of each core can be adjusted by writing a clock divisor value to
> an MSR on the core. The range of valid divisors is queried from
> the BPMP.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/Kconfig.arm        |   6 +
>  drivers/cpufreq/Makefile           |   1 +
>  drivers/cpufreq/tegra194-cpufreq.c | 423 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+)
>  create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

Overall these are the things that you are doing here in the driver:

- open coded clk_{get|set}_rate(), why can't you implement a clock
  driver for the CPU and use the clk framework? You may not need the
  (hacky) work-queue usage then probably.

- populating cpufreq table, you can probably add OPPs instead using
  the same mechanism

- And then you can reuse the cpufreq-dt driver for your platform as
  well, as is the case for few other tegra platforms.

-- 
viresh
