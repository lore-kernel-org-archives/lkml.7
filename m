Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE27C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5E20665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MTltNbiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfHPQYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:24:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:24:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so3390084pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+FnGUjvDduLwmUWcToVoaAXXHIij4xR404WzOvDXCGc=;
        b=MTltNbiV9blPzssoSIvlKEyj8GXjlJa+fTvON9N33advNQcU11h1WD1WT/KRbmrvP3
         vRLBlOKxwF0MBicin2hGRhH5vXXLB2sGtQm4sRn/bAyavToGE2ymMR767zs4j1UNdwy+
         FyUzJVfIN8v/tO5tRuqG1dY5ILDNrbcyYKzxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FnGUjvDduLwmUWcToVoaAXXHIij4xR404WzOvDXCGc=;
        b=nBqrjOrFGbqa8dYO0bZ0beGfIRtftHrWSioQ+Kmjdh+JU8RTGSVlBMhkyObGP/Xx0c
         A0vtoGDd1QpkDFUA3xCuotZguJpl1VVbK+sgZ5gDJKmMuupg47N86SQj6ZmdohJmK8EB
         JPfihoZwZIUedl2MN0b+SBZ5Cwp0P1yIsO0CYJSUJ2bpCPngeAaByy7OH0KaJwWpFBXz
         7w4It87c2ItobFe/RVnlbpprzW9D0EtL1Malh7blzfPqayUeXF4S+FJMYqHvFWP38AiN
         yVaszlGQKNkAXJDil5P31WWzP0ciqsrVhGYTGo+VB4+h1oP++tWFwCN4gZp9oULJkI/h
         uMFw==
X-Gm-Message-State: APjAAAXPc7wPB/7A2q15ePID56iLW5dp8116/9N4nDTZJHxPTuXmqyp/
        U3Sm6wcF1yUp2pXoe8OTuO7H9YiJpT8=
X-Google-Smtp-Source: APXvYqzJmE/VBzfM7dTcmo0WjYgJ+PK/5UhEbZvqR0WC+cO/22WibiU0WDBTKE49AWeUGONok8bFbg==
X-Received: by 2002:a62:cdc3:: with SMTP id o186mr11699752pfg.168.1565972662164;
        Fri, 16 Aug 2019 09:24:22 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id k3sm1538327pjo.3.2019.08.16.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 09:24:21 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:24:04 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190816162404.GB10481@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-3-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> I really cannot explain this patch, but without it, the "else if" block
> just doesn't execute thus causing the tick's dep mask to not be set and
> causes the tick to be turned off.
> 
> I tried various _ONCE() macros but the only thing that works is this
> patch.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 856d3c9f1955..ac6bcf7614d7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	long incby = 2;
> +	int dnn = rdp->dynticks_nmi_nesting;

I believe the accidental sign extension / conversion from long to int was
giving me an illusion since things started working well. Changing the 'int
dnn' to 'long dnn' gives similar behavior as without this patch! At least I
know now. Please feel free to ignore this particular RFC patch while I debug
this more (over the weekend or early next week). The first 2 patches are
good, just ignore this one.

thanks,

 - Joel


>  
>  	/* Complain about underflow. */
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> @@ -826,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  
>  		incby = 1;
>  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> -		   !rdp->dynticks_nmi_nesting &&
> +		   !dnn &&
>  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
>  		rdp->rcu_forced_tick = true;
>  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
