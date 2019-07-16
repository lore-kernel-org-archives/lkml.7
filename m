Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E45C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0072145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xf2P5LIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfGPKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:34:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38847 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbfGPKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:34:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so399650pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QxxqH1klgQB/FyA39Y7OEvDvoonTizxWFfioa8D1t40=;
        b=xf2P5LIO9hWNbapEX+fdvUfYtiVCakX+hLWMydt2yN3Vw7xSuw4LTrhAOlE9eHGkXV
         ZXri5YpyaLoSXmY3UhvAza2hQiH7V5aDWUQJKmWcA3fL9aIk8wGtUJWMjmj1He+Qg6ge
         Zs5cM3BcdYG/rKHm6etKXh3v7rMY5IVnEKdAmdggYSVhm7n52YYFfuzU/PLKuyvfq/GN
         LVL0VYRUrdcsrZYUUn/E58oa3rUTCBl/BofHy4fSy/2EEXbk74k0yPXKUHP281Ya0kzR
         +7SDzP1LeZzrJ/b4YlJfzNH02EC6UxB27fLNrLdUoLkwksGoT8hJSJByjJ9vuDxqP19B
         YeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QxxqH1klgQB/FyA39Y7OEvDvoonTizxWFfioa8D1t40=;
        b=qzJTk6gbBR5qEhhL64+MWsDpiVOxds0wSLASX6G0eDYb89btcbU4SsvOtTZo9pAjtV
         K+uLfYipWv/hmbTweHALpIXPzjAfjqNZz+UvKT+hSJLsD63Gmo1x1+N6A9Q22w1uqKsj
         epNr8+59HPiF1910XHd6Lj3xCCcqTLEfIuPiKyTEfjdtmC9fvhlDrROh3CsaKqTtzMIn
         uvEkJzgiLByT/M4bzsQI4r6zLe5stbHs/blYAzVp4sZehfumD9C7p7Z+S/yEX8EkMtMA
         qQFEzZeC2jje0E0ROCvuOF8ZyqeGFgUmPURqGF+q8yI+UmidTBR2kq+mVptIbpyS8uQj
         LWUQ==
X-Gm-Message-State: APjAAAWsJNuoevzv0I/+iDgT5kCe7hlmVHIKnDsH/hT4a2b3B7VakG1I
        NaRoRbUtqc41cai6p+tKyZ/qEg==
X-Google-Smtp-Source: APXvYqw3Z2+vS2tUbGWfRTc7j//TaXFA8aoy7O2ZbYIm/MymR8ofJtuyFD8Y0klG0kA/ujSeBRNV/w==
X-Received: by 2002:a63:5045:: with SMTP id q5mr24596211pgl.380.1563273279071;
        Tue, 16 Jul 2019 03:34:39 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id d14sm27437543pfo.154.2019.07.16.03.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 03:34:38 -0700 (PDT)
Date:   Tue, 16 Jul 2019 16:04:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add CPR and populate OPP
 table
Message-ID: <20190716103436.az5rdk6f3yoa3apz@vireshk-i7>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-12-niklas.cassel@linaro.org>
 <20190710090303.tb5ue3wq6r7ofyev@vireshk-i7>
 <20190715132405.GA5040@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715132405.GA5040@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-19, 15:24, Niklas Cassel wrote:
> This was actually my initial thought when talking to you 6+ months ago.
> However, the problem was that, from the CPR drivers' perspective, it
> only sees the CPR OPP table.
> 
> 
> So this is the order things are called,
> from qcom-cpufreq-nvmem.c perspective:
> 
> 1) dev_pm_opp_set_supported_hw()
> 
> 2) dev_pm_opp_attach_genpd() ->
> which results in
> int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> 		      struct device *dev)
> being called.
> This callback is inside the CPR driver, and here we have the
> CPU's (genpd virtual) struct device, and this is where we would like to
> know the opp-hz.
> The problem here is that:
> [    3.114979] cpr_pd_attach_dev: dev_pm_opp_get_opp_count for dev: genpd:0:cpu0: -19
> [    3.119610] cpr_pd_attach_dev: dev_pm_opp_get_opp_count for dev: cpu0: 0
> [    3.126489] cpr_pd_attach_dev: dev_pm_opp_get_opp_count for dev: cpr@b018000: 3
> 
> While we have the CPR OPP table in the attach callback, we don't
> have the CPU OPP table, neither in the CPU struct device or the genpd virtual
> struct device.

If you can find CPU's physical number from the virtual device, then
you can do get_cpu_device(X) and then life will be easy ?

> Since we have called dev_pm_opp_attach_genpd(.., .., &virt_devs) which
> attaches an OPP table to the CPU, I would have expected one of them to
> be >= 0.
> Especially since dev_name(virt_devs[0]) == genpd:0:cpu0
> 
> I guess it should still be possible to parse the required-opps manually here,
> by iterating the OF nodes, however, we won't be able to use the CPU's struct
> opp_table (which is the nice representation of the OF nodes).
> 
> Any suggestions?

-- 
viresh
