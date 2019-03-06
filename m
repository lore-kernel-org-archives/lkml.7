Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD720C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870422075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZQ3pxa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfCFDRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:17:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44011 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfCFDRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:17:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so7146142pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 19:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3wd0DdmuExbS+qK+w1VioQQ6FV5ryqDB7pz7mPhOk/M=;
        b=eZQ3pxa/GML1d0Obx2Jg3rwCQO0jYYjU9GsmqG4mSuFizIA5TfWUOTnqtCcvmrzJOp
         ETaxD+EoRKpkzNQ7S5RfCKSY0rIM0czvV83umTRdb3DRMJ9fU7thYTS88csJI//eapHz
         cXobLEm7giPmLVQ3krjqw6dYnJsVxhHBnnJx2Clk5EGNNiv3RwdaC58AV6uo6jLy3DEF
         Ysd5l46eYe72Ijgo+xaq2/1u/grBg8OOs4bQspV8A+8M5Z7O60ES7wGdMlmJA9AnaNxR
         XDhQdx883qDroEP+vsPKntN7ah3mIFXRlPlWL7JyXSAQgdDvzmSaeDPgTQW3aDppsR+7
         zCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wd0DdmuExbS+qK+w1VioQQ6FV5ryqDB7pz7mPhOk/M=;
        b=FSCLieVtIBT3JSFdmp92G5LPR7E0rSJuxHdcvPhMxm84yxrP47571rKElsECroRpmN
         0PdKuY9rATp5bGwLkCcjBVMe6mG/Q4fpLH7t9BSG6IcYiWlDkTejSDy5h0OdQEFzWklL
         qWqxmGcZ5qk4x+5OJqxgRzpRy3XktPtFuh0V3U3FYUiAMmZZcpG6deqJNgLKoHYwwYOT
         HathuNGlvPvI5tvN2o6xqP9rEDY6bzWYNa92yinAQkszlb52dVQPpUKRdS+6C9yQnUJB
         iDiqmEsyRDL7bXN9OWH7NsrBc0u1PMfaKnJHZO1tk5Ujod5gbhWQGFJR8B83yvuUd+Gz
         7/cw==
X-Gm-Message-State: APjAAAWYEDuxU49cTWxhS8K9mG9zGRhkqhrrvgiyQIbgHdh1nfMCTdKH
        BGxGvlOU1C3n2CCdps5QTA1hYI2YEAw=
X-Google-Smtp-Source: APXvYqwbZ7Th6My3q44fTzeqBbXKoCmSqqX7+0muO789KHO7db/I0uHynNuMhq5ImG1OkTb4hUSj7w==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr4681067pls.15.1551842242705;
        Tue, 05 Mar 2019 19:17:22 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id y14sm418287pgs.47.2019.03.05.19.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 19:17:21 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:47:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Improve kerneldoc comments for
 cpufreq_cpu_get/put()
Message-ID: <20190306031719.clpdezdpblypwp5x@vireshk-i7>
References: <1633242.5muNhsBLsY@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633242.5muNhsBLsY@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-03-19, 11:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fix the formatting of the cpufreq_cpu_get() and cpufreq_cpu_put()
> kerneldoc comments and rework them to be somewhat easier to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -201,17 +201,15 @@ unsigned int cpufreq_generic_get(unsigne
>  EXPORT_SYMBOL_GPL(cpufreq_generic_get);
>  
>  /**
> - * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
> + * cpufreq_cpu_get - Return policy for a CPU and mark it as busy.
> + * @cpu: CPU to find the policy for.
>   *
> - * @cpu: cpu to find policy for.
> + * Call cpufreq_cpu_get_raw() to obtain a cpufreq policy for @cpu and increment
> + * the kobject reference counter of that policy.  Return a valid policy on
> + * success or NULL on failure.
>   *
> - * This returns policy for 'cpu', returns NULL if it doesn't exist.
> - * It also increments the kobject reference count to mark it busy and so would
> - * require a corresponding call to cpufreq_cpu_put() to decrement it back.
> - * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
> - * freed as that depends on the kobj count.
> - *
> - * Return: A valid policy on success, otherwise NULL on failure.
> + * The policy returned by this function has to be released with the help of
> + * cpufreq_cpu_put() to balance its kobject reference counter properly.
>   */
>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  {
> @@ -238,12 +236,8 @@ struct cpufreq_policy *cpufreq_cpu_get(u
>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
>  
>  /**
> - * cpufreq_cpu_put: Decrements the usage count of a policy
> - *
> - * @policy: policy earlier returned by cpufreq_cpu_get().
> - *
> - * This decrements the kobject reference count incremented earlier by calling
> - * cpufreq_cpu_get().

Shouldn't we always try to keep some description?

> + * cpufreq_cpu_put - Decrement kobject usage counter for cpufreq policy.
> + * @policy: cpufreq policy returned by cpufreq_cpu_get().
>   */
>  void cpufreq_cpu_put(struct cpufreq_policy *policy)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
