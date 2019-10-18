Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAFACA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C684D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJG8HcWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632787AbfJRI1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:27:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44039 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392728AbfJRI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:27:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so2942286pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fO5rhP6K+WvHSLdZS4qIOwy93CBX5JrPts4O8zPdzYA=;
        b=YJG8HcWnBa42iQUCBZi5ndFdutUmpewAtXsB0gND6NykpkWOPqPnM9k6YtUZUImg2J
         jU8FIXzxGeuG3+Tg7NHlzpj0hoTu3YiNnjmKy6RyJ6ApKMRxY6FsTkHTwCDSpGFBiUIE
         l3vJnbtewBJzAZjfZyihH8/EBZtVhikhf090q3MtNGgNSVE1nRwCyGvYgMyIr8ts/PfT
         n2FmH117syo5pL2uvGxQpBcZJZUiX3nRFBkUKkCDNpxBRYHvsStOuxEAb58S7cRNA6YH
         +GOzybZSGgKZLVya0j8z3SMAmr/vgsAOBdKtu/jmAjhgnUJ/NSb89VEvvcPSEXeFp82y
         MSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fO5rhP6K+WvHSLdZS4qIOwy93CBX5JrPts4O8zPdzYA=;
        b=EU9WhUX6nifoQ1liB5v0irVKedVlRI246mZzuOBE05TshGetMLvcohcnClk4/XXMt0
         aCyqhu4FBoLpSbLhPfoaK+NiLeLS7GLY1XcmWbwEBifAUuxdiWg7Zzcoy3QweLZ2XX6B
         FjGx5+IUwT4nu2w/pJPO+NuxQgmboye0vnTfBA6dOnhwd07UxRAXyxGmHrrFjvVIUQgA
         TnDA2eFsqKctDcmBcCvcpdJ60Xm3lT2y2DfyyuwxcEchAH5KUAc49Jl08GbtTbMcLyFY
         sy5/2bjKo1wV9cKEJnhF1S+sxPVZnO7LkZ7DCTNNzFK69QSMJwwyvU/H29tdwkb34hyZ
         MECw==
X-Gm-Message-State: APjAAAWex8GAM4sgZbfj8IIxuxAIkAYIXEi+Kovy+HnAvC2Okx60rjU9
        KpVVLx0qBmyKtV41U77wCBOJcw==
X-Google-Smtp-Source: APXvYqwn4Yr1AA9BWoOMP8e6FHAENoPiUbPydHx5Rm3qNWFhvl1J7+WureQPtv22CeRrq7TuEXsLxQ==
X-Received: by 2002:a65:6701:: with SMTP id u1mr8928898pgf.368.1571387268548;
        Fri, 18 Oct 2019 01:27:48 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id g7sm10492580pfm.176.2019.10.18.01.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:27:47 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:57:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7>
 <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > that the new min is less than the new max, because the QoS doesn't do
> > > that.]
> >
> > The ->verify() callback does that for us I believe.
> 
> It does in practice AFAICS, but in theory it may assume the right
> ordering between the min and the max and just test the boundaries, may
> it not?

I think cpufreq_verify_within_limits() gets called for sure from
within ->verify() for all platforms and this explicitly checks

        if (policy->min > policy->max)
                policy->min = policy->max;

-- 
viresh
