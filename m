Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28EC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57DD2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sc0E/8iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfFRJ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:26:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40502 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfFRJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:26:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so2710458pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACmcdqOP2gSGSso0d/MiQ00IgAVGq25vQtNqguYCF5w=;
        b=sc0E/8iB4qaqHn9Zp1WR0OtM9S8b0KYzP6oOnRw5yROW6enOifvofAeCtv31AqOYo/
         a8y5opv8HfdW6eTBEHVj7aAJilzMPTo9rmEpF8/79ZrG7Tz2xvc18qbElUHHCqtdm++F
         cgWe47VNKw5H6+E+VSZV3v4mL57BeVLM4cSW1rbq3QY48kquBQpPf519wgWpEDuFkeI9
         5wKIrFfJbP5sEaQHHdDzIqqTxj4DFbsBHbg91ivq5Y8LquUvB4OHHLku8qEeQXj74meE
         PCPfSLjxdUCAjl0Rk7VQUyPz7sORJR8qPHvNW/rQ7KMTGcpfH5kNpXt8S7IeJz4qC5jr
         wmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACmcdqOP2gSGSso0d/MiQ00IgAVGq25vQtNqguYCF5w=;
        b=qf2SALsz9943gKO8JmU4PqKpWf9Nd3ryCtsln/KmcqTD0q4x9dLuD7usZzNFpZFpJf
         OuMBVkoSJjENZIXN7sfoz3gBvFyIUi3HrdZ+4y9JyaUAy0/4BGNHtbBblWdsJ4K/mQOs
         guQGdhPm+Ad3baSn0dBclF2zDkyr9xdLQEsowGljp3QPZtKPC4Jsg2x7dY4KV/TMO9UB
         7dJ2eWED6G54ZvqvBZG308hsbMCd95MaOaCPf85blek985NRrnyZ8pigv4Qsram3Op3L
         W1TLyphpIqH4nk4YkUXq8sGthHH/4XsiYLvvA+sadPrhc4hDMh61ClCCjcpV0RS5tm/Q
         fviw==
X-Gm-Message-State: APjAAAW/vKlSQOMWcAMr5wt68Gp3D+7O1MCq2PtwSRGFgXXpWVrn4kaI
        Dztu2lZx8SN5X+nrsR1gZ9JcVQ==
X-Google-Smtp-Source: APXvYqw7S7g+LxxyGBTPUPd97vZx4Wcl8CWA1Ovr31OCsPH4/P6Iao8SMp+SLw9BjAv0mLfR5zA/5A==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr1732002pgf.38.1560849964851;
        Tue, 18 Jun 2019 02:26:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id ci15sm4292839pjb.12.2019.06.18.02.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 02:26:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:56:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, quentin.perret@arm.com
Subject: Re: [PATCH] sched/topology: remove unused sd param from
 arch_scale_cpu_capacity()
Message-ID: <20190618092601.2aws7kujvk2pulwt@vireshk-i7>
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-19, 17:00, Vincent Guittot wrote:
> struct sched_domain *sd parameter is not used anymore in
> arch_scale_cpu_capacity() so we can remove it.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/kernel/topology.c       |  2 +-
>  drivers/base/arch_topology.c     |  6 +++---
>  include/linux/arch_topology.h    |  2 +-
>  include/linux/energy_model.h     |  2 +-
>  include/linux/sched/topology.h   | 14 +++-----------
>  kernel/power/energy_model.c      |  2 +-
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/deadline.c          |  2 +-
>  kernel/sched/fair.c              |  6 +++---
>  kernel/sched/pelt.c              |  2 +-
>  kernel/sched/pelt.h              |  2 +-
>  kernel/sched/sched.h             |  2 +-
>  kernel/sched/topology.c          |  8 ++++----
>  13 files changed, 22 insertions(+), 30 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
