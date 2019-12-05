Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EDC2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951FA206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjq9QecI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfLECv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:51:29 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46441 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfLECv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:51:29 -0500
Received: by mail-pg1-f174.google.com with SMTP id z124so833174pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 18:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YXOwxN1kP+K4jqhxg2yhpfqPO6sP7d2qL2AC9K9utQ4=;
        b=qjq9QecI/wOJmuVH8+2KuOKZd77fkfhSNfn75KhTqEhICZ1dJqZObyHA6YA6REPVQI
         qUmsq/SmFCy9XPAFYfIXDM60S+OakybcZPUjZwNhLBKA/7paGXMi9QCzMMNKwIcy84KA
         qrUzznkALn//5SzE7Y0GRlKUOBJLtRKsJ+exXKT4ZeCTjv8MzL3d1bJ0gFGpG2AVAWW8
         VSnlqKn3T7sw0ROo3Ch5kfswp5/6Wg/11JgpwIPSKHj2Cle8tT7pYIc3jUCsQQNHRp50
         wcr4hxUQOifunSOuS23mTqe6Ex44OF3flMKDSiwqg0UF5UA0JxQVvbhHThGa8VT2rXIp
         whyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YXOwxN1kP+K4jqhxg2yhpfqPO6sP7d2qL2AC9K9utQ4=;
        b=hT+y8bfk/2leJkCuGs7bD7k/HAyZ1ldJSrBEGyUHymiOl08dFnHK4AAFJiWF+wH7bM
         eNWA5KsUIxYVMHKAw4UrJHJLvTfObFEvJkQvGB2VzrSmQ2fuzZocr1cZNmRM6XSzhJKz
         uPherFoG+sKg0xT+CGH3akTdCQhWfwhYtO5FlocsmDM/Tc4lZ9viCIZ/TvalBVUTaSRT
         MPY9u+9N0h+myVxEjovZk2BLhJ6LRNCnY1XB8J6a2PPlypMjrCK2S58Riu3ASjAH38An
         Mx+qw7Czf0zwGnIwSOByXcTzia/Jy045NOExLkYl4mVANdV6HB5pt3Q4E6pc67lUtskV
         R+hg==
X-Gm-Message-State: APjAAAUfB8hihF0BiUBKHHWZhozuSy/zMXMbpOVN5NdR55AXzUjfls/E
        KfvtGP9fZPY79qB2HNxhYr3tOQ==
X-Google-Smtp-Source: APXvYqyiIzUgOpbu5JKLdnKDPxQgFqCYX1OfETQq1MaukN74rbD9OAIBcUgXHGPceCG2ufABoZTxow==
X-Received: by 2002:a63:fc5d:: with SMTP id r29mr7055870pgk.282.1575514288156;
        Wed, 04 Dec 2019 18:51:28 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id o31sm6605986pgb.56.2019.12.04.18.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 18:51:27 -0800 (PST)
Date:   Thu, 5 Dec 2019 08:21:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     sumitg <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20191205025125.imxnao2qwyons5zl@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
 <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
 <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-19, 16:57, Dmitry Osipenko wrote:
> 04.12.2019 14:27, Viresh Kumar пишет:
> > On 04-12-19, 16:25, sumitg wrote:
> >> In T194, CCPLEX doesn't have access to set clocks and the
> >>
> >> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
> >>
> >> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
> >>
> >> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
> >>
> >> used to read the counters and calculate "actual" cpu freq at CCPLEX.
> >>
> >> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
> >>
> >> given by node "scaling_cur_freq".
> > 
> > Right, but why can't this be hidden in the CPU's clk driver instead,
> > so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?
> 
> What about to make use of dev_pm_opp_register_set_opp_helper()?

It has a different purpose where we have to play with different
regulators. And that won't help with clk_get_rate() anyway.

-- 
viresh
