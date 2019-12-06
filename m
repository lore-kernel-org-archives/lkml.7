Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FAAC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969592467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575620235;
	bh=xNF4HFBCn6fvCdXmRfl4tqe31ZppPMp5cm+2u3VUVBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K38HRfDzLXQ+8cQol/ONDGoeGvlBsFaCV3UHYkJaAAAJASrvvK+RaTkOaoaFCfnLn
	 d9Pa1a3PxZ4wXK10X50lHRXnK8JMHOXQTcyAC1RTnDkguUjf4vbm2/vfK6ny+K3EUh
	 BupWUJAvuXUDZKd/bJKOCMQbWeZZ9Uo6+0rV51oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLFIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:17:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42548 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfLFIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:17:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so6713068wrf.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 00:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ba4Nt9WY6yvIikHrTS1xoSBFk9RdJgbhCF3yF6te8s=;
        b=cXX7XJq7GYMzUsdBShHgNw+YPvf53FNIEPxeEvePXmoIPXyvrwPyIl57wHSFeGyYBs
         nJfSEGwQo6fjILIJ0E0WU2x7FFZiiqZ4DtSPdGYAXkIk5bdmHtJdXdV13161c7OySLdX
         Xgx9Heej/6aJRIFkitK235s4lBmozNf+Xwkdkns1G9XXWufez7h1v2Wj0PfVcDXPzMWM
         LLsQNZQvO853gDG/qgYwc5WopFxc6H4ClQ+EgflhMbz4zvbEkdMZVi4FkHwemaYAsjAg
         Iz2uZoPBqBF4nLd0tO89yFOwy+DTieIIIv3m1CwL6DYMrtDeEodvTwyDT46LB5+0wsxs
         vdDg==
X-Gm-Message-State: APjAAAXSC0CCGTbU7/2Ln785BsKbSTruKkDDCBu7dUeg5t0gBpjkwkMz
        OxRCAmQn/rkk8IUJe01gP2c=
X-Google-Smtp-Source: APXvYqz7pdRuocMu/w2UUxNUvWadUbptDhdAP1Ezq/w2Mu1TsFypaAE46oXMVBQg8qHcIzOmid5Tng==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr2462382wrr.82.1575620231692;
        Fri, 06 Dec 2019 00:17:11 -0800 (PST)
Received: from localhost (ip-37-188-170-11.eurotel.cz. [37.188.170.11])
        by smtp.gmail.com with ESMTPSA id v4sm3881781wml.2.2019.12.06.00.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 00:17:10 -0800 (PST)
Date:   Fri, 6 Dec 2019 09:17:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
Message-ID: <20191206081710.GK28317@dhcp22.suse.cz>
References: <20191205223721.40034-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205223721.40034-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-12-19 14:37:21, Shakeel Butt wrote:
> The cred_jar kmem_cache is already memcg accounted in the current
> kernel but cred->security is not. Account cred->security to kmemcg.
> 
> Recently we saw high root slab usage on our production and on further
> inspection, we found a buggy application leaking processes. Though that
> buggy application was contained within its memcg but we observe much
> more system memory overhead, couple of GiBs, during that period. This
> overhead can adversely impact the isolation on the system. One of source
> of high overhead, we found was cred->secuity objects.
 
I am not familiar with this area much. What is the timelife of these
objects? Do they go away with a task allocating them?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> ---
>  kernel/cred.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index c0a4c12d38b2..9ed51b70ed80 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -223,7 +223,7 @@ struct cred *cred_alloc_blank(void)
>  	new->magic = CRED_MAGIC;
>  #endif
>  
> -	if (security_cred_alloc_blank(new, GFP_KERNEL) < 0)
> +	if (security_cred_alloc_blank(new, GFP_KERNEL_ACCOUNT) < 0)
>  		goto error;
>  
>  	return new;
> @@ -282,7 +282,7 @@ struct cred *prepare_creds(void)
>  	new->security = NULL;
>  #endif
>  
> -	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> +	if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
>  		goto error;
>  	validate_creds(new);
>  	return new;
> @@ -715,7 +715,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
>  #ifdef CONFIG_SECURITY
>  	new->security = NULL;
>  #endif
> -	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> +	if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
>  		goto error;
>  
>  	put_cred(old);
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 

-- 
Michal Hocko
SUSE Labs
