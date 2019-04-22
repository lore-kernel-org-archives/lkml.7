Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA43C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DC220656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNJKS9E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfDVIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:25:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35703 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:25:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so5535766pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eZttZoRI1Bxp3d2eFi6YCbyM9frd1o83Z+JFliK9Qn4=;
        b=ZNJKS9E6anH/5+LTRL6OfBJ2YDWg7Ou+a01a25KHYsD2q4ZR8UbHbM455GveAaQjRI
         K/RQs8gMvs0ALdQroV1Qr8iTpETkCDS+cvqGBiFHCG8Jsj+81a9ry4AXZ/9R4uKWa0RJ
         FrgBi8deISNNBv9a3VjunvYT6iRL+EsiV0Co+iHT7HH8uqdZKVrBBptzAGsGll/A60MR
         4/VF1GeCKt4KXnxqmYx26a2+OtRFi2gzLUReFs4K7swJr9WI+samPmt4ZKb5tZ/Jvlck
         JzBLkD7WhKisbkPijvw7Wiu4uHkTfBQRhoMfMXHkDuYYt9TWvC5TU04MOxjFMUr0g+yu
         NMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZttZoRI1Bxp3d2eFi6YCbyM9frd1o83Z+JFliK9Qn4=;
        b=Yq+2nbci2HK2TQIk65Akdj4pE3Wsje3Er1niYGieSGzaz2yXYu3eHeULt3jjsCVZ9h
         3HJez6qTWD+0cXfO4gd3Ov/QQLZYLCEQSps7L8DRnV9wSou+rZ3rl7pOYYLRDMaBePGy
         S2wHT/NUUKihGj6HsI25ujwMfW8FZBz/FZGds/R7cgVAdZ9xkCBb5vVvvdvbeq2jJqZf
         gOghNybELwRDt+L8BmbzfZWeGC7s1/837U9x/Hdnqx4O9TfXaPBU91tz+P3ZKg0rMuDy
         bCwF0gii0/y1nbDnkpAfc3dUTQhM9QHhM69U4IBCWU+TfevQ2Fx1O8XI2CZfUA/v8ArQ
         CHiw==
X-Gm-Message-State: APjAAAVfDGSf8PfZT6DpM/yEahaA9FYG4r6OXAtQ+epNTLTtFiFAakzA
        v3Q2Lrur+2tu2w4qawoLMiIdGQ==
X-Google-Smtp-Source: APXvYqwf4zC62yigSvmTz08LKnjZX4flCnUI/q6vxc838AyjcsYU6kRBCdBZztWlTlHsmIh/iZZpGg==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr19402490pfc.123.1555921521699;
        Mon, 22 Apr 2019 01:25:21 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id k3sm10670212pfb.175.2019.04.22.01.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:25:20 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:55:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190422082518.jenl4x7rkmv3j67x@vireshk-i7>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
 <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
 <20190418080429.pn4r6lnftlfsf4c4@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418080429.pn4r6lnftlfsf4c4@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-19, 09:04, Quentin Perret wrote:
> On Thursday 18 Apr 2019 at 09:23:23 (+0530), Viresh Kumar wrote:
> > On 17-04-19, 10:43, Quentin Perret wrote:
> > >  static struct thermal_cooling_device *
> > >  __cpufreq_cooling_register(struct device_node *np,
> > > -			struct cpufreq_policy *policy, u32 capacitance)
> > > +			struct cpufreq_policy *policy,
> > > +			struct em_perf_domain *em)
> > >  {
> > 
> > > +	if (em_is_sane(cpufreq_cdev, em)) {
> > > +		cpufreq_cdev->em = em;
> > >  		cooling_ops = &cpufreq_power_cooling_ops;
> > > -	} else {
> > > +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
> > >  		cooling_ops = &cpufreq_cooling_ops;
> > > +	} else {
> > > +		WARN(1, "cpu_cooling: no valid frequency table found\n");
> > 
> > Well the frequency table is valid, isn't it ?
> 
> True ...
> 
> > Maybe something like: "cpu_cooling doesn't support unsorted frequency tables" ?
> 
> Right, otherwise I guess that could be confused with the check on
> cpu_table_count_valid_entries() above. And while I'm thinking about it
> perhaps WARN is a bit too much here ? We can handle the error safely so
> pr_err() should be enough ?

Hmm, I would keep the WARN as it is hard to miss it compared to a
simple pr_err.

-- 
viresh
