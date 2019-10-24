Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1A020684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XB1BmdDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437259AbfJXDLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:11:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46991 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406422AbfJXDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:11:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id e15so13302418pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fj9Ud66oz8U5Yh/1XlnusXjEqU0kK7uCGc0WJQSBIGo=;
        b=XB1BmdDhK1Adc+3GLTBFyds8asDdFqNihkzaQZ3S0CZh7SQbidKgRG564fjDr8uB1/
         3JEh+cQDXM0ji4XKwLsOp7+ziNhy3LQ/wWgOXMAmXxD3StUN5n0NxQNmU3tkcWjIUW/D
         sZk6o0jRBTDpoc8BZzGwbsUIukB/3rOcsvMDwux6XxvJ3rMUeHCY83yiwEXq4h6/qC1B
         8qEHs1L9y7RLG/oQjUS7c63yT7OCWEhiJ+bsNmJ/skoOyzAWQYZz7fhF/OayF5lvePu4
         1HwdDBxqjxjPfBWGQX4NmKf2w2MRqmB7jRSCWSXQfiULKRfFjdOXEMe5Qz/lIjIqKSnY
         mknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fj9Ud66oz8U5Yh/1XlnusXjEqU0kK7uCGc0WJQSBIGo=;
        b=dBP/+rR17uNoRrruKWrLy1X8FNbO8kUrHq6gUHZxPzEsuTyh0FueNHe9ERIPnLr54J
         3tCgvBZAcbOaihnYlTZKtFjPdqwr7F/UzBK4BsoejkPxnQwLc/trZ2/dy7KU8VKEciHR
         cyZCy5nVbvu3lTvYmmQ3HdDPg41PCnn9MCnqbkynTL+TDkTExE+9RIyXOIhT6TVT+XxM
         g4WLmWHfByARICNSuQPJ2xlqV1z1F55+/6AvcRvnxD9s1pQIySuawteEHpZ/kUjxOGz7
         TwN9C2PW3tG12Krwc0evmOKSCGpZFKNpLYaZEhoAF6OyweGOg3Qa/svsOXu8rgIPiLSe
         dpbA==
X-Gm-Message-State: APjAAAX4jAzwlN19knmSkNTrdW8Uk7PsvBTqG9aIxa6TrG04/z4SWSgK
        Dsmm6y9zGgIhgfUBWJUFWCU0cQ==
X-Google-Smtp-Source: APXvYqxmnp5RrvmPrhq+UllAh+A8a8Xg1WZP8AMCjdS1kF97/TLSGAp65Nm72oumNauPtPKePcXIZQ==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr4042999pjr.40.1571886681892;
        Wed, 23 Oct 2019 20:11:21 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id bx18sm600994pjb.26.2019.10.23.20.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:11:21 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:41:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: vexpress-spc: use macros instead of
 hardcoded values for cluster ids
Message-ID: <20191024031116.jwwwrc5hmy2knwmk@vireshk-i7>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023110811.15086-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 12:08, Sudeep Holla wrote:
> A15 and A7 cluster identifiers are fixed to 0 and 1 respectively. There are
> macros for the same and used in most of the places except this instance.
> 
> Lets use macros instead of hardcoded values for cluster ids even here.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied both. Thanks.

-- 
viresh
