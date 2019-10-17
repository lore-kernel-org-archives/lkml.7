Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5288FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2892053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRNCLJb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407442AbfJQCnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:43:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42024 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbfJQCnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:43:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so363131pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrqLYMo728235YBWz2v13YUKhg9+UyvipsJm/DfRcsU=;
        b=KRNCLJb5VccX6YbkyBGLsjizRwutMxkJvqbOSEwLHZcbFZ/MC2xT6oQyeYv9kHx3a5
         SIw6ymVVh5WR2KDSpUwWsyC5U8+mQrvW2yhX8VHGz68x02gbVIdivs78/pT3nFJJ4ees
         1B8sTSmuEiURIOkLYN2RoHc+SwBmmQ5YPp8SvKDOZFnU8uwpZS+jcZNo070uJGmdmt72
         upnkJ8pzw+v2BhUmhG5VTQSvai4pBSo/0xge8yX/S3RyJo5LQCPGud+wCekEwUJwHyqg
         BSuw8pL2Sur5K2nD7WPERt/A8p6zLMDeAAPSm4reMyN41Y8IHjPxnStvRSVhFvS+84g0
         aSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrqLYMo728235YBWz2v13YUKhg9+UyvipsJm/DfRcsU=;
        b=kvleuemgBxzkH5OC33jitsEebjg/zVxnVvQLbxsnsabag/3Gs9duRdKY6PH+4w8+UQ
         hR5nLVt65LpNPlOCYs+pCxtBeLL6vOWXcZpdxoUCDz3+UWnhEcGNf8NeBavW4ltQmOnq
         PcXkxGHkqqMmrpOK5197h9BX04wkpeSOIWIghfF4Je72/MAFFnQAzoVIhIJe63zRhrsP
         1EVgTutB/p4LN7RJyp7Gb8zt58jQ1OPqMNm7TdTObK4IdLGYpFF2h8o5sZTTh0I5m+g+
         qzEm7p4k6LUBw+26grmj4GJfSiRrnR+GQ2ErnrWFh7qIWWjTEMWN3nLHOfEI0ExGs+3c
         qmUw==
X-Gm-Message-State: APjAAAV6ZRdxAiFqur9M3lfrIS8S3ajvylxOnbW0/jgBfaUO4Qirw+Lr
        TirCyIuRSJNxe35QosGT+Kp3nw==
X-Google-Smtp-Source: APXvYqzBSm5KQJhD1bgMwV0FdJUZEJEIfD+nzymxlKuEgr074kmwn3aWvd/ylkFk2SznWsMkZyei7w==
X-Received: by 2002:a17:902:a5c9:: with SMTP id t9mr1380197plq.99.1571280200592;
        Wed, 16 Oct 2019 19:43:20 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id d20sm473357pfq.88.2019.10.16.19.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:43:19 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:13:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>, nico@fluxnic.net
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017024318.axs37rs4zy2wb5xh@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Nico in case he has any issues with this series.

On 16-10-19, 12:03, Sudeep Holla wrote:
> Hi,
> 
> Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
> there's no point in keeping it separate anymore. I wanted to post these
> patches for ages but kept postponing for no reason.
> 
> Regards,
> Sudeep
> 
> Sudeep Holla (3):
>   cpufreq: scpi: remove stale/outdated comment about the driver
>   cpufreq: merge arm_big_little and vexpress-spc
>   cpufreq: simplify and remove lots of debug messages
> 
>  MAINTAINERS                            |   5 +-
>  drivers/cpufreq/Kconfig.arm            |  12 +-
>  drivers/cpufreq/Makefile               |   2 -
>  drivers/cpufreq/arm_big_little.c       | 658 -------------------------
>  drivers/cpufreq/arm_big_little.h       |  43 --
>  drivers/cpufreq/scpi-cpufreq.c         |   2 -
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 559 ++++++++++++++++++++-
>  7 files changed, 539 insertions(+), 742 deletions(-)
>  delete mode 100644 drivers/cpufreq/arm_big_little.c
>  delete mode 100644 drivers/cpufreq/arm_big_little.h
> 
> --
> 2.17.1

-- 
viresh
