Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEE2206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4B5RPLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfJNMQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:16:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:16:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so17004728wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rS8PHBYn9t8Naa/zL+9sCDYquW7iKNjTXXrUXJX7dy4=;
        b=C4B5RPLt7zfsBsAOI88o6vMRbqq2/ofHvgYHDeIxk6Iu3MEBYYbz4tMpf1whn50AEj
         Ga4xfPi2nmtHjYNHmDVUjWoNke+QLF45bGWMsEwt4n1GwTDgqPMXluJ4O2HRQd19zPDs
         3MIUl8/EDHvwx8BOUEce8sDcz1qPf2CERG6Azao8J4v3D2qT/7Ds6ENS2vFG1nW02RR3
         7lpSGy3gy3CDXR3YREZhN8BHxCBnVDUT6kbOCP3ALB6ynAV0Fr68j2cVkcAsaKNo4/aP
         MS/ZfsoqxpZCFy1btbwXIydmDvL3qhdmLHQDqw2+5V+4pEzZKqnf3ul+6RMQhfM3KGkm
         mL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rS8PHBYn9t8Naa/zL+9sCDYquW7iKNjTXXrUXJX7dy4=;
        b=iiwZCqc6wHBZAXKem0gOVPGPUlFklvQ82N2iE0bBPlPctOyNX+wxFQgsBL9K8HT4Q/
         Q0n7QwJLr3FsCyKNkmzFQlusHyMAaegxF90iRWgIUESJACiroT+JjE5CeIibn3uUdqUb
         0XOOPbuKElpAHpQXsDyZX9b1lDAuzj6KpmZrAWpw8mR2Rj6bH3Poqq7p5ZWqsdM4/y3i
         X3XPm0sNiGXRajY/pn7BD/JuEUaw4ObvGYPO+FtqBEMxfZ+MARMoz+VdXk7S0kU8wR+p
         86qxdPHiItI7/KviuAxYoaNwkxwm+sQoCWkME+mZUNn6YG3zPJeDIasHIStyxCVI2D57
         j0RA==
X-Gm-Message-State: APjAAAWXSQwGPPFeXTX0/W/6NZj/FaHSWJGMBEGHMFrIU8D+NyOa8fBk
        U1UV8z4Hicxvvj40tmq9YKGXrf3z8Ws=
X-Google-Smtp-Source: APXvYqzKxtXUbrbuBpRD6cmzuaSmLd/JPMv2UtJaAZzBZK/Q8iTBr7MgnMGLMJpVoX7ThVsQ0gYp0g==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr15438846wmj.94.1571055412241;
        Mon, 14 Oct 2019 05:16:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id s9sm19666036wme.36.2019.10.14.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:16:51 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:16:48 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@qperret.net, stable@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain
 destruction
Message-ID: <20191014121648.GA53234@google.com>
References: <20191014114710.22142-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014114710.22142-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Monday 14 Oct 2019 at 12:47:10 (+0100), Valentin Schneider wrote:
> While the static key is correctly initialized as being disabled, it will
> remain forever enabled once turned on. This means that if we start with an
> asymmetric system and hotplug out enough CPUs to end up with an SMP system,
> the static key will remain set - which is obviously wrong. We should detect
> this and turn off things like misfit migration and EAS wakeups.

FWIW we already clear the EAS static key properly (based on the sd
pointer, not the static key), so this is really only for the
capacity-aware stuff.

> Having that key enabled should also mandate
> 
>   per_cpu(sd_asym_cpucapacity, cpu) != NULL
> 
> for all CPUs, but this is obviously not true with the above.
> 
> On top of that, sched domain rebuilds first lead to attaching the NULL
> domain to the affected CPUs, which means there will be a window where the
> static key is set but the sd_asym_cpucapacity shortcut points to NULL even
> if asymmetry hasn't been hotplugged out.
> 
> Disable the static key when destroying domains, and let
> build_sched_domains() (re) enable it as needed.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5667a273bf6..c49ae57a0611 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2123,7 +2123,8 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>  {
>  	int i;
>  
> +	static_branch_disable_cpuslocked(&sched_asym_cpucapacity);
> +
>  	rcu_read_lock();
>  	for_each_cpu(i, cpu_map)
>  		cpu_attach_domain(NULL, &def_root_domain, i);

So what happens it you have mutiple root domains ? You might skip
build_sched_domains() for one of them and end up not setting the static
key when you should no ?

I suppose an alternative would be to play with static_branch_inc() /
static_branch_dec() from build_sched_domains() or something along those
lines.

Thanks,
Quentin
