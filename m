Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28117C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9DF2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpV9QmHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEJKlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:41:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34669 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEJKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:41:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so3035670pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jl5drP4AlLOoi8Q04Np1I7m7iKZgKEx7fc6pTOC7Ug4=;
        b=XpV9QmHuiAQeQWwBZ7TnoQkZll8Q/0XCJa882vUgg703AsL/Mikydw8XVt28VUbIdh
         vnb1bUbGhaEjnDv7SlOL/0KxRtQwMhl9y11YH0Prpozpcp1zf31/BF79v3hwHS99v6ON
         RsSTB6Nx0TcpMtKs2lHJmhAEzclu2fbeOq5d3RAJqIIz5uSmHT0vxIg75tgDi12v7yod
         eYSP/bpayO2hgRmpCPJ3wKwqAVKRQspCbkgzKwMy7gaiPro6n04XYcQAs5n9erwaWL1p
         IsgE+rV1iuDfn/jX3OySQyIAmCv97lxGIEvBMJ3GGEE8GJQg7WoaGbQzfD6ItTLeiz5Q
         /+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jl5drP4AlLOoi8Q04Np1I7m7iKZgKEx7fc6pTOC7Ug4=;
        b=eb7nSaFsiHLND5uq/MQvNJ6yyasS+eyNuIaPyv8OWtQi4uih83xRGV2ZX0hSUfnCFj
         jBEy23MV/kB+KS0EdzwnAXcv5HzcJL6+EgryL1pCjjKiWjtwEBOzEmlKfCy/5seakT1Z
         QBRvTdWaQWH1dmu35ihnnBiK3H0uczbJpNYIWE6y1zdx51PMXfsHrzwp0T2KZjX4E/2j
         OMg3O/e8ow26m3CQyNzdIVdNwfvy4wgoQIO14tpzQrDUfXO92EOKRPiahn/msQ/qaQV7
         Ow0n/LqIM2gplYN8I9xfnCUG/u/jXbvarl1Oc+mRJ3ptRkoBsimoMrDAUt/uzy9H6yKS
         sz1A==
X-Gm-Message-State: APjAAAXUP2FRJHI3GKiVEyHCpExRXWYsqrhXKFth7vTRDKKJsFEapEFx
        8ylLJFn5GSojUVNwV2BIZeJmQg==
X-Google-Smtp-Source: APXvYqzYYnPxqxmztajriV5CS8ZaQq9j5fqccboqPPlOfZ1nYejF9Rg5rYIJ7y+KSmzuhF2jrQYzWg==
X-Received: by 2002:a62:414a:: with SMTP id o71mr13100142pfa.240.1557484879939;
        Fri, 10 May 2019 03:41:19 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id d15sm6560432pfr.179.2019.05.10.03.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:41:19 -0700 (PDT)
Date:   Fri, 10 May 2019 16:11:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Explain the kobject_put() in
 cpufreq_policy_alloc()
Message-ID: <20190510104117.3heutt6azy6hc4nq@vireshk-i7>
References: <2270903.5qkiGuZaYc@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2270903.5qkiGuZaYc@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-19, 12:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It may not be particularly clear why the kobject_put() after
> failing kobject_init_and_add() in cpufreq_policy_alloc() is not
> redundant, so add a comment to explain that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1133,6 +1133,11 @@ static struct cpufreq_policy *cpufreq_po
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
>  		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +		/*
> +		 * The entire policy object will be freed below, but the extra
> +		 * memory allocated for the kobject name needs to be freed by
> +		 * releasing the kobject.
> +		 */
>  		kobject_put(&policy->kobj);
>  		goto err_free_real_cpus;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
