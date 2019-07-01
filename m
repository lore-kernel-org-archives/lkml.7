Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA0C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8622089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="SD517PuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGAUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:20:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40084 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so12118486qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKLYJBfF6Xs5Sh+AvFb0x5KesF+JTuG7hjQLTrg/0HY=;
        b=SD517PuLqxobQLE0ZbMWG5IoIobVDCZ2h3h+XUg1HIpw5WU2V5W9QopgycQKmlozw7
         00GsN4R9+YTUhLnx+uJzfyearxwrrTquPPXatszUiQt5AsvGdahgofKneA/GUJtpx04X
         1HATzCC9LrdrBzB+IZwGxB7tE50oq+3knc2FIAZvofNQjpoyZhWplSNiOINZopacfyIj
         AV2ExY61XLGo5K1K0ywn3DOSuxt0Ny60AIGT8fdSEX7eYv+i8/egIwLkuHjvLIdxBm8O
         Po6VMQhrJV38ZcA6G62g5uktJgZ1aspOD+541i74l9E28UWo3fJrQxkjosBhbUG7jqEY
         D9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKLYJBfF6Xs5Sh+AvFb0x5KesF+JTuG7hjQLTrg/0HY=;
        b=Zq8N4QQTejJUZgzxP+e0wniKBcKBnPwY3qumQvB1keNNtNzLPDn/wqZ4whNKsy3Wlv
         70I2UarqoTurZ9nOJ0VG460ScVjH+44dAFSGJVW7sKyfS+6ncJpaMLOToGA6uVqf+Mp4
         YSTnWEoZJLpQO+D4p8WKFzeczKHcVnTFgYpB0B0Y5Up+jLpecCt8QRyrES0xxLrkCVFo
         K0G0a4hUHz6Ui+eMUcvAIgOdDcWmmAnM0M+fwdxAM6K9pfVUhVNTj0Uo9MXEzas8xZU3
         aHEpqMO0ekDMB8RhhS0t5iqaZwNq/0N1oFWvXyJtRfeUp+voXtzbAH+9N/s3tEjmTAUZ
         ejfg==
X-Gm-Message-State: APjAAAUk3tqCBkUvYozrHSf6UXyNE6016CIXaiyUS+Ne0+pS+/BfJ14O
        e4or3keKz2k7WSkzQhN0F583FQ==
X-Google-Smtp-Source: APXvYqyiUg+cWSA8RB2PRW7ThMM2AUualzG5O3o8LYlafx6pWP1Hx6ZNzgtVWVjV904McazzVzTfsw==
X-Received: by 2002:a37:c408:: with SMTP id d8mr22103639qki.18.1562012433559;
        Mon, 01 Jul 2019 13:20:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id o54sm6242083qtb.63.2019.07.01.13.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 13:20:32 -0700 (PDT)
Date:   Mon, 1 Jul 2019 16:20:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 09/10] sched,fair: add helper functions for flattened
 runqueue
Message-ID: <20190701202030.6sm7mdztyt6t5mui@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-10-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204913.10287-10-riel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:12PM -0400, Rik van Riel wrote:
> Add helper functions to make the flattened runqueue patch a little smaller.
> 
> The task_se_h_weight function is similar to task_se_h_load, but scales the
> task weight by the group weight, without taking the task's duty cycle into
> account.
> 
> The task_se_in_cgroup helper is functionally identical to parent_entity,
> but directly calling a function with that name obscures what the other
> code is trying to use it for, and would make the code harder to understand.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a751e7a9b228..6fea8849cc12 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -243,6 +243,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
>  
>  const struct sched_class fair_sched_class;
>  static unsigned long task_se_h_load(struct sched_entity *se);
> +static unsigned long task_se_h_weight(struct sched_entity *se);
>  
>  /**************************************************************
>   * CFS operations on generic schedulable entities:
> @@ -411,6 +412,12 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
>  	return se->parent;
>  }
>  
> +/* Is this (task) sched_entity in a non-root cgroup? */
> +static inline bool task_se_in_cgroup(struct sched_entity *se)
> +{
> +	return parent_entity(se);
> +}
> +
>  static void
>  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  {
> @@ -7819,6 +7826,20 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>  	}
>  }
>  
> +static unsigned long task_se_h_weight(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq;
> +
> +	if (!task_se_in_cgroup(se))
> +		return se->load.weight;
> +
> +	cfs_rq = group_cfs_rq_of_parent(se);
> +	update_cfs_rq_h_load(cfs_rq);
> +
> +	/* Reduce the load.weight by the h_load of the group the task is in. */
> +	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;

This should be

scale_load_down(cfs_rq->h_load * se->load.weight);

Thanks,

Josef
