Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B2CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75582222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wltgfp1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633136AbfJRJwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:52:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633084AbfJRJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:52:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so3083329pgi.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtCCjDsxUW2f7hUMgiF/lhUDNP+eblATwyQXoaxQPFk=;
        b=Wltgfp1pRzOmQKZFcjNgOouPgbf2eUSJYhtjDuyyXGv7vJSSTSu0vasW7MlUVNQTD4
         DeUcGwnAuqncGmxTmK2pKrlyRmn2SaKZluwJgIsstd4tmo4Vk9DMmBentAt5U5YDtAd5
         8oL6KTKrp/xc3aYZktEd41bBr+uDOfEerZcF3muup6By6oAx6YybLI67W1ItqWsSww9N
         JapikXnjK6jl1K6iIoAOJzvXJd1g2oWH4ut503hPMwgdAQF5b0aBq+7ZJBshy/ve1bNu
         +/UBnOGIqMlUwL4p5rKeanvouZNG7xCoAjlhqPru9+xZG+VJ8deIr1WsqcJval7/LoQq
         jKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtCCjDsxUW2f7hUMgiF/lhUDNP+eblATwyQXoaxQPFk=;
        b=jvZGTXvossoGZ8jxjZT/CdK4TrXfdmxEiW0yyRfuz+Thi47yztjb5CoLCJI9CM19BC
         pg8lPm6kf/bM/WyXFhdXZvY4lceeTP979Lvu1NawxE73NIfp5zMuXYB5wYOiXBhzm+tR
         zoHhTAssmT38TdL2Ci6EC2VU4xfrVqpNQ8d9WY1EuVYQ7mqHuuCcXmCtmbTfAgy8TC+k
         t82LPuCj87/7C9bBx9rKubQx0wU/rpGrFpnBsIFzmwCWgTPp24RyES6JAItdFkjb+Evh
         pxtz0/nFwuOJ5psOKLDNk+39T5UgvSzlq6OVTE9a4JrMHnmLXgoD1jLPsIYJqckfpzjB
         +HEw==
X-Gm-Message-State: APjAAAXBWoocU4tuPGmBVWTDVpeSPz2kkotCOgLKvxy4HYmFvHVQdOZQ
        HSpS2nHqjX3Om3/tSfrlUz7yuEv+emA=
X-Google-Smtp-Source: APXvYqwrm9QohNHq0++rIl5Gykt4pMddHMa4LN9dNpYpqce8aMlV5KSJv4ChUb7fQ5cVJlnArIAL1A==
X-Received: by 2002:a17:90a:fd8d:: with SMTP id cx13mr9965664pjb.66.1571392334920;
        Fri, 18 Oct 2019 02:52:14 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id l184sm5575252pfl.76.2019.10.18.02.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:52:14 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:22:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/6] clk: qcom: Initialise clock drivers earlier
Message-ID: <20191018095212.7hpherdgzxhqzqjz@vireshk-i7>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <a59321a1016de3f08098739b6db5d5190ac1c85c.1571387352.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59321a1016de3f08098739b6db5d5190ac1c85c.1571387352.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 14:22, Amit Kucheria wrote:
> Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
> can have earlier access to cpufreq during booting.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c   | 2 +-
>  drivers/clk/qcom/gcc-qcs404.c | 2 +-
>  drivers/clk/qcom/gcc-sdm845.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
