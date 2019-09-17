Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E313121670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os/OjkFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfIQISO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:18:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44169 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbfIQISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:18:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1571888pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccksZ0DIr5YuOlmKQ56MKQuO6sfHn4/cYWLl1y6ZJss=;
        b=Os/OjkFdbkxbCMGYZNy/HnlfvRLdNhVDvO3OQ3Tjqp9ysoWyo0oM4s2SSDCAzouHsz
         gkjFk4cddTJ2rUMcXLsrmoS14Xcns241t9TBp2xl4Ltya+LciRWtEQ58XqrCB+viuEx7
         Xghm6/lG8f6ZFz2ZU4/8yigRh6Xo6AZmD5tcBL7R/PVjNIiv+hOwCPRttq4vURDrB2U9
         vVogGNoMgz30xlAJB7P7ThuBYG3OVdHfPB9AqNgQHkt62TSyfWxjkstqzWvMH0v+KetM
         TDXnzs7rLDW60zjQDKVvTA0qCV9uV+ENswqS425WgupE4mmBCfMyiGcnJRNzzZkvqwea
         1Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccksZ0DIr5YuOlmKQ56MKQuO6sfHn4/cYWLl1y6ZJss=;
        b=LS5YwVI7kVwTU6sNQKym6bYUDVsEQzSyF6G+Vw64wWaEDqsDB2U2tRwVM4w+s8xrmg
         Km+NJq2KwXSiySUKxN/egKPJS9y/ot29pJH0jngmrusIu6tJzLUdH3ATehraj+k3vSC7
         tU7kvCGISuxM0VzmDpjJGVU/M99YAe+zzQZrVbRfIdfWsPyo7hFg+MYBEd5Y3R/a1fiv
         xkMpytdYKIyf6TOKsaHcWjM33Nr9yxi294likz48pXDF1QmBTW7XEFSr89buCq8Pays6
         n16Y7Ojlwhy3dg0Nu7sJmdMn6cBlcOjYgCBdPILV3vnrvjciY2DgbEN83185w4RrtjqA
         +ZSw==
X-Gm-Message-State: APjAAAUQOpuGy8RcsxM7V4qWh+GpALc7+R7b/UGoeTEzup3y7oofAEe9
        INj0V2EMeP8KSIkpKxGPivXcQw==
X-Google-Smtp-Source: APXvYqwpy0WS+QkLpZKa7+H9dnq/Maul15NnA8yNy5WichOtA6IyRwXpsp5wW9igskBRzYgp3hRJ5g==
X-Received: by 2002:a62:1955:: with SMTP id 82mr2836635pfz.256.1568708292663;
        Tue, 17 Sep 2019 01:18:12 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id v44sm4392124pgn.17.2019.09.17.01.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 01:18:12 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:18:05 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: Initialize cpufreq-dt driver earlier
Message-ID: <20190917081805.kmhu6zcdo6akbqe3@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <23d3ed7edc8b859da8e7640f77cf3028ad5804f3.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d3ed7edc8b859da8e7640f77cf3028ad5804f3.1568240476.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-19, 04:02, Amit Kucheria wrote:
> This allows HW drivers that depend on cpufreq-dt to initialise earlier.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
