Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A0C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABC520678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmYA7sgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfIQIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:17:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36812 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfIQIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:17:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so1183121plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9/DW6g+3IE/yyFuOvSrn5fLFzPH6bb0i0Y6gcBVBAds=;
        b=AmYA7sgGtBXo3HXA6Oaq46Vw7COra6dAPpgXuBsbFtWfIN/wBCE0KcfO2elqptvqGq
         EgVwqvqC7sMlDb0dedinqFLdc/KZ0NWafoxjaRBJdqzRhWp897F4MG2Zyjr8Y2CO3xbv
         cX6+/dUqeCOJhWiU9z7NqWaC+Mz6fDwmh4ITIvyYroIXne3fNbcZ+DbH7qiQk7xWe7RH
         726VldWLzisQK/8LvqwxYEHaJ/ktJ2u9ecM1ulYFJOm1O5oZ04zk8uvMtYofw4Ze9D0x
         YPppmgtzmBG+C+PHLZw6PhpwtebtFoKLwL0mq34MriooGlWjINfOVGyLzEXvi4u6sJ9x
         Lzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/DW6g+3IE/yyFuOvSrn5fLFzPH6bb0i0Y6gcBVBAds=;
        b=Hwq0QNmltu30M5MrOISSmUy6oo1uS67WG7jjPjXQmy9IApvUumnB+EwmoggaaM2CCC
         OP1oFq7HpBc3rGXAcPAvMN4UGTNie1XjyD1K67F4bvUCRpSC3IBYs+TZp0WJmjMbdX7A
         kjSF0nhFnI5DGdHdtNJCtfTZs3AijvPRHI+4L76B7EVZd4zSzgijJjWtRpWjwz/M01bB
         P0/93mnx0Pi0iUuASgxKL9vDUjaXe8ok8d0ewbmqsfv/d7GRUzz8uUdqO/lK0Xn6zWld
         HqktPB2KbCnFEi5Rd3CSNpTNwwa5FxsQAwspGlbPjPeFg/lRtoG/78u7+jenHxt3e5l9
         IBog==
X-Gm-Message-State: APjAAAXDP8Ei9SRYEqn51A0Z3kmTPFR/4zUV5bq2vkS3+yxA5IZfMaIe
        UCyH3urT4I1JAEVCZTvhuq+Wrw==
X-Google-Smtp-Source: APXvYqyRI8nkDySYpiYXHcJJkhuEXz+qWr4f+DIU2GB/BH5ywA3QvtlckSgoTkdi8kbdT3OxMBeikw==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9mr2309457pli.206.1568708276547;
        Tue, 17 Sep 2019 01:17:56 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id m9sm1570681pjf.11.2019.09.17.01.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 01:17:55 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:17:54 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] cpufreq: Initialise the governors in core_initcall
Message-ID: <20190917081754.pjmgolgdtz2jcp76@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <6ac50a647b8b9ee4af70a33fab10bb5df4a6b5ff.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac50a647b8b9ee4af70a33fab10bb5df4a6b5ff.1568240476.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-19, 04:02, Amit Kucheria wrote:
> Initialise the cpufreq governors earlier to allow for earlier
> performance control during the boot process.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
>  drivers/cpufreq/cpufreq_performance.c  | 2 +-
>  drivers/cpufreq/cpufreq_powersave.c    | 2 +-
>  drivers/cpufreq/cpufreq_userspace.c    | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
