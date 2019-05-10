Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B13C20896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="K6VPCzQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEJPMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:12:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44904 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:12:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so2554316qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3vTpPdYQ5vB7aevtIN60GjRAPGc+R9hv+e9/nZAALjQ=;
        b=K6VPCzQI/rBj+Eb6z2HfWaRq3HMpBQMSJ2KLFIFvk9/9NUBOkSONit9B/HNmlZyeCT
         SwDUUzUp3Piw7Baoq/baWcXhn9Dj5ltl7r26Uqh4xtPi0rV84wgygn0TXm2MJRfDXSzB
         e4jMFJZOoZAtZArQVm2uVHDQtVn+R1oSwtA5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vTpPdYQ5vB7aevtIN60GjRAPGc+R9hv+e9/nZAALjQ=;
        b=Z97MsxB7r5r3cuCHqU1LTZlVaB5wYXXGOB2NcPc4RnF/aRix0jvZmrlSdpv5mWMsMT
         8OQp/wFdy9A15DgfkN9NEHjcqJfzUfj6P1mJydlRbaMNYZ7FFylVGtOgrQPPVVc/6Vn8
         Tsn7jx5tLLt6JXwUPuPeb6PbhXKyL8MUl/oQVkuU2mGTVtz9VXsYfmoVdGSvzp/PBYgs
         rTF4NV4mP+SVL1VcAXLcl+xz8fSpnw12u6KSGiL4JDx9BDXv+7LWdraX/mNeuR01CrzF
         SpBVSKrPVjlJTzPCyzSiU+udbtGURFlH8/E8hvB4WwEiz7ct39UcLyOciIYse8JAccD3
         NhDQ==
X-Gm-Message-State: APjAAAU54ED4XadYXUC0/VxhY5H1qJe/NKruKdF6nHOXUDGsdoMSzApN
        T74mWcihtsxjlDyQqDvQ/A+uag==
X-Google-Smtp-Source: APXvYqyyK8yrNf9+l6Z9htdz7McGOQE80G+llNHB7Ogmh+fWCvcioERMwHmWm33Oq4Qd+du5x1u5zQ==
X-Received: by 2002:aed:258a:: with SMTP id x10mr10100599qtc.380.1557501152047;
        Fri, 10 May 2019 08:12:32 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id u21sm3618175qtk.61.2019.05.10.08.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:12:31 -0700 (PDT)
Date:   Fri, 10 May 2019 11:12:25 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 12/17] sched: A quick and dirty cgroup tagging
 interface
Message-ID: <20190510151225.GA13930@sinkpad>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Apr-2019 04:18:17 PM, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Marks all tasks in a cgroup as matching for core-scheduling.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  4 +++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5066a1493acf..e5bdc1c4d8d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6658,6 +6658,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
>  	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
>  			  struct task_group, css);
>  	tg = autogroup_task_group(tsk, tg);
> +
> +#ifdef CONFIG_SCHED_CORE
> +	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
> +		tsk->core_cookie = 0UL;
> +
> +	if (tg->tagged /* && !tsk->core_cookie ? */)
> +		tsk->core_cookie = (unsigned long)tg;
> +#endif
> +
>  	tsk->sched_task_group = tg;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> @@ -7117,6 +7126,43 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
> +#ifdef CONFIG_SCHED_CORE
> +static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
> +{
> +	struct task_group *tg = css_tg(css);
> +
> +	return !!tg->tagged;
> +}
> +
> +static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
> +{
> +	struct task_group *tg = css_tg(css);
> +	struct css_task_iter it;
> +	struct task_struct *p;
> +
> +	if (val > 1)
> +		return -ERANGE;
> +
> +	if (tg->tagged == !!val)
> +		return 0;
> +
> +	tg->tagged = !!val;
> +
> +	if (!!val)
> +		sched_core_get();
> +
> +	css_task_iter_start(css, 0, &it);
> +	while ((p = css_task_iter_next(&it)))
> +		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
> +	css_task_iter_end(&it);
> +
> +	if (!val)
> +		sched_core_put();
> +
> +	return 0;
> +}
> +#endif
> +
>  static struct cftype cpu_legacy_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> @@ -7152,6 +7198,14 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_u64 = cpu_rt_period_read_uint,
>  		.write_u64 = cpu_rt_period_write_uint,
>  	},
> +#endif
> +#ifdef CONFIG_SCHED_CORE
> +	{
> +		.name = "tag",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_tag_read_u64,
> +		.write_u64 = cpu_core_tag_write_u64,
> +	},
>  #endif
>  	{ }	/* Terminate */
>  };
> @@ -7319,6 +7373,14 @@ static struct cftype cpu_files[] = {
>  		.seq_show = cpu_max_show,
>  		.write = cpu_max_write,
>  	},
> +#endif
> +#ifdef CONFIG_SCHED_CORE
> +	{
> +		.name = "tag",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_tag_read_u64,
> +		.write_u64 = cpu_core_tag_write_u64,
> +	},
>  #endif
>  	{ }	/* terminate */
>  };
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 42dd620797d7..16fb236eab7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -363,6 +363,10 @@ struct cfs_bandwidth {
>  struct task_group {
>  	struct cgroup_subsys_state css;
>  
> +#ifdef CONFIG_SCHED_CORE
> +	int			tagged;
> +#endif
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	/* schedulable entities of this group on each CPU */
>  	struct sched_entity	**se;
> -- 
> 2.17.1

Even though this may not be the definitive interface, a quick fix to
remove the tag if it was set and the cgroup is getting removed.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6dc072c..be981e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7190,6 +7190,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
        return 0;
 }

+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+       struct task_group *tg = css_tg(css);
+
+       if (tg->tagged) {
+               sched_core_put();
+               tg->tagged = 0;
+       }
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
        struct task_group *tg = css_tg(css);
@@ -7832,6 +7844,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
        .css_alloc      = cpu_cgroup_css_alloc,
        .css_online     = cpu_cgroup_css_online,
+       .css_offline    = cpu_cgroup_css_offline,
        .css_released   = cpu_cgroup_css_released,
        .css_free       = cpu_cgroup_css_free,
        .css_extra_stat_show = cpu_extra_stat_show,

