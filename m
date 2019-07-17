Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EF7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB76E217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOmbQpeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfGQKcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:32:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38044 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfGQKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:32:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so10634085pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jp8lk+XdDHx/WRkU1D5GuTsiUq4pyzz7UbpMROhU2ZE=;
        b=MOmbQpeDaySamzTzRxIvnvpX4HkW3+1U/OzVaoTxLpP6WjNEghuOIG54DmhnLBEVUB
         Gv4MX0Yp1QzSU0H9tyF2pWpMZIzF0KJbCAupNNzEMzr68ZS9+WhIuQQmv28CL5DrsNmt
         C8ovN8ETD/P4jJcMkoMZEko1obD20GCi4h3BDU1Is/6IxqvWKZQfFGSVfOuuALec8LbJ
         fhX59w96WZTzCy79irx+IZYzVGnLMenGkRcY+72ECSzzAdmRqMlislssJbw3NlvMk2DX
         W0fKLSMLIekMkjKUi20BXVICF1dGLsuyPKeRyqsJjUdbtccs+DyB0eZFfr30N96xdA3J
         wDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jp8lk+XdDHx/WRkU1D5GuTsiUq4pyzz7UbpMROhU2ZE=;
        b=LnhEH215R5XJwjxathMlyWEAPKn8ZnRNo4I5t0tgINrSEgvFXVXsksOcSsU6l+oZlQ
         2e+m1V76s7wFZsU8BrrzUPWBIapT4Uqu/7La05jHVSpefUmw0vDPT9eHHeAFwmwBgPGg
         I7r5rs0tdbljkfmR+6UloXFNw3FyErYXD/ZVP8uoeyuQ1rbispS77maGGNVabDnb26Br
         Upej3FrYamyj/CnPDPmA4xG3CwNXrvWqENsLFIlT0mVLUJqTroQz6VFOKFys277GR5Eg
         THaGH+KcMk9r85+54CwHnjqrMy6Ba4G/h44gDqJIPB6LLhrkVKXq++yhm/NWOqGcmf8U
         QYAQ==
X-Gm-Message-State: APjAAAVIfBEhdm70HFU76tYwjQTwbEFhVlJnMizUpYubVPLN1W582ft6
        dMpxLOpTMe9ex8WA7tFx2lKXOw==
X-Google-Smtp-Source: APXvYqwzL9mzp2aY/MeHimwmrGDIE6cQH+Ek0FFpxQTvAEuh2tG8JwxKx/eWT+sFX3kvqFizrjbQXg==
X-Received: by 2002:a63:f357:: with SMTP id t23mr7820293pgj.421.1563359543184;
        Wed, 17 Jul 2019 03:32:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id h1sm30377545pfo.152.2019.07.17.03.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:32:21 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:02:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190717103220.f7cys267hq23fbsb@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-19, 18:10, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in the OPP framework and in DT. Since there can
> be more than one interconnect path used by a device, we also need a way to
> assign a bandwidth OPP table to an interconnect path.
> 
> This patch series:
> - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> - Adds interconnect-opp-table property to interconnect DT bindings
> - Adds OPP helper functions for bandwidth OPP tables
> - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000>;
> 		opp-avg-KBps = <1000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000>;
> 		opp-avg-KBps = <2000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000>;
> 		opp-avg-KBps = <9000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525>;
> 		opp-avg-KBps = <452>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051>;
> 		opp-avg-KBps = <915>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500>;
> 		opp-avg-KBps = <3000>;
> 	};
> };

Who is going to use the above tables and how ? These are the maximum
BW available over these paths, right ?

> gpu_opp_table: gpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 	};
> 	opp-400000000 {
> 		opp-hz = /bits/ 64 <400000000>;
> 	};
> };

Shouldn't this link back to the above tables via required-opp, etc ?
How will we know how much BW is required by the GPU device for all the
paths ?

> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEM_CACHE>,
> 			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
> 	interconnect-names = "gpu-cache", "gpu-mem";
> 	interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
> };

-- 
viresh
