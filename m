Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22EF206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEvfs86e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfLEEgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:36:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32820 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLEEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:36:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so1858141wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=keNUPJzqbpb1zvh7gwgj7wSZGJ1RcEtCjXcl9nIyRWA=;
        b=hEvfs86e9uivc96esO1PqMIaSDQRwe6rRSEh3UTbWwRpAfK2D9o0OHW9jyWdUe+ImC
         KM5sjitV4VYUSsac91vLm0LvC2QACkEbjm+0bQ9Usog5c782YsT0qny4ZFJy4VNaaSPj
         EoxT4aPxXr+CxnhTvj6mg+0gI6BMQ0BvXkUSCTtK4JWxrfURYclITMO5RB0/bJH0GV9K
         ICalID4puBDrItEojRVXbjuKsTJ/YPJt6Xlql9wzZ9RXhh3pubq8cEt3s5sYE1KzUS8x
         QwAVJIhhZQaZkudwl6IhRSSzAGZ1MN263zCP8gq5tnsmIZCHCa1Ve0QoErHbRHURc2er
         kWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=keNUPJzqbpb1zvh7gwgj7wSZGJ1RcEtCjXcl9nIyRWA=;
        b=T9VRrcIcRpL7JYkrYc4Nb6I6uPBQSSCcBOE6GxBG/XJxn83AaWDNW5Nc2euOaz7wIA
         JmrJuvaA/12MF0lU43i+o2spTElPEhLt1Z4ZKg2alHyvuJsE4XVHz4eHPue5Mq3YWnJS
         XaoZq0t/Y7Vh29t1VH2g4Y4B+DktOcbiLelC1lWmiCDhZP3sv5tuIcu8AsTQPBMesYcg
         +1KBphSusA9++0WiLMGPO96G4IP276Yij3cvckz9Cd5dUR2Qyi2eqMlTa5YLH7mPNIHJ
         ABjcqgR1vSJ1MSDSXmz9F83rw2CBDbFXGB/ukDW4KFolPeEHg3NxGoIX9J8691xq218k
         FfMQ==
X-Gm-Message-State: APjAAAVjZfL2zeMZkDisytrI77pIzVMO+LzvpqgJ21Y/y+BPw1oIrG1n
        QiiBYZfWIrHWioKHBdFDY/syaQ==
X-Google-Smtp-Source: APXvYqyAeuNq7VceTAS9eq+u2nkne8kbzO+3NySJpdhCTng6yAxjdC53noAT+TaQdRaTXEWhj0rzog==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr7357191wrr.252.1575520573537;
        Wed, 04 Dec 2019 20:36:13 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id j12sm11408925wrw.54.2019.12.04.20.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 20:36:12 -0800 (PST)
Date:   Thu, 5 Dec 2019 04:36:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
Message-ID: <20191205043609.GA231782@google.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
 <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
 <9436e207-8a65-f01b-c348-32a8a00f03d4@infradead.org>
 <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thursday 05 Dec 2019 at 12:27:47 (+0800), Zhang Rui wrote:
> I overlooked the original report probably because I was not CCed.
> 
> This is introduced by commit a4e893e802e6("thermal: cpu_cooling:
> Migrate to using the EM framework") which adds the dependency of
> ENERGY_MODEL for THERMAL_GOV_POWER_ALLOCATOR.
> 
> To fix this, it's better to make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> depends on THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Please confirm the problem is fixed by below patch.
> 
> thanks,
> rui
> 
> From c9429f6e28ea2219686a4294d39f015ba373774b Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 5 Dec 2019 12:17:07 +0800
> Subject: [PATCH] thermal: fix a Kconfig warning
> 
> Currently, THERMAL_GOV_POWER_ALLOCATOR is selected by
> THERMAL_DEFAULT_GOV_POWER_ALLOCATOR even if it has some unmet
> dependencies.
> 
> This causes the Kconfig warning
>    WARNING: unmet direct dependencies detected for
>       THERMAL_GOV_POWER_ALLOCATOR
>       Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>       Selected by [y]:
>       - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> 
> Fix the problem by making THERMAL_DEFAULT_GOV_POWER_ALLOCATOR depends on
> THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Fixes: a4e893e802e6("thermal: cpu_cooling: Migrate to using the EM framework")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 59b79fc48266..79b27865c6f4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -108,7 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  
>  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>  	bool "power_allocator"
> -	select THERMAL_GOV_POWER_ALLOCATOR
> +	depends on THERMAL_GOV_POWER_ALLOCATOR
>  	help
>  	  Select this if you want to control temperature based on
>  	  system and device power allocation. This governor can only
> -- 
> 2.17.1

FWIW, a similar fix has been suggested a couple weeks back:

  https://lore.kernel.org/lkml/20191113105313.41616-1-yuehaibing@huawei.com/

Thanks,
Quentin
