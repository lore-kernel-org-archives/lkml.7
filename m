Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F866C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E19206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575357381;
	bh=lHWxS9F5hSS5jVBbp1I/i9edw2Kjpzv5ypLC7gz0rPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SwD9G2MmmGmuaCBXDJ6gDgGZSi0aMt6X7NFXq/unnLuRi2sI/lIWAIPYez0bVNUvx
	 /rl22fBjIxTFEllLKRGEC8mTWI32up17K/a/AJzhnNqSUOwjVdxz4psZBnTzixhQEs
	 jcdxMC+xBmM9PjuxT6f6gcZ0zXvLfYLsDCFv6p4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfLCHQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:16:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53410 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfLCHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:16:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so1809652wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 23:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nm5A1amt4gZBv6FaNIeY6UwlHa3/CPSKkGpJ+nmg4WQ=;
        b=vVcCo/FnN44L6dGlzg2plLMKtRWguBBQrM0LwKjHE7LW5lthXoidG7NRCsvrtNmYlN
         VKgI3RS8dNBbyxtG2kwNnH8IiGRPGcJwvYCRhovyT57UCT7AOr+Vz79QHB5YVS3yFzLa
         D6flrQcWainoiJJ32DRFIsbwZaLFgmJhbbXC5ZLgamF4ICJI2krCg6oVOEYDMb4RFPoa
         szXzzqi7XjFDpS+fufQNgmrv2FI6auiWGcHGFIO6GqZrGWkag0JV89vCGJ+Mvu7fp8OS
         SLgxkuw///IjvZgGh4nmHTuLA7bZJK15Gj77NEM7WgiJu39fX6j1afMbKcWmCe202I+V
         PvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nm5A1amt4gZBv6FaNIeY6UwlHa3/CPSKkGpJ+nmg4WQ=;
        b=NR7c7yq/lE+0Zc1uM13HSG03UcLOwX0t30XAp3W95kaLi/l3YdranK09CR8m+lAAcC
         XklLevm+lUIFa6u20ntAbYGN+O0Ze8ALrOm1vfmtJNUHqRvdm24ottk3HaKxc4cKBoXM
         Nv5yQi7Hh6h7NakhCDL60tD+XH5VxIyUi/yVrkPiiyuJA24Xvrt+Ls3cNdrx+1hnuXGR
         /8kcuajRqfuGB/XW7zE8RTK48terQA5O4Ds49pQb3g3e/ahlhbfuWK3r2aL7fvdaLj2b
         qe9m1SfJDBEyTntz2Eh5tY7GC2sp+UDFJY2a0aKlH4lPiikGg6KuNGzklivu62bepK4a
         gPdw==
X-Gm-Message-State: APjAAAWG8pgGGrxFR/0Xwku9Z2NfvO+XaDmhftaCFnrR6vYDLM2BLBFR
        QmBOrW/vh4CPliCG1JdPhso=
X-Google-Smtp-Source: APXvYqwOGNkR9MZbSoKGnc21fmMPfKDE0QLYW3yC/6u1+KlD5Aa4w0Pde4PpkjaXJRGuHaro/6ffBQ==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr9235273wma.121.1575357377685;
        Mon, 02 Dec 2019 23:16:17 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u1sm1925589wmc.3.2019.12.02.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:16:17 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:16:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] sched/numa: expose per-task
 pages-migration-failure
Message-ID: <20191203071615.GD115767@gmail.com>
References: <7038afda-dd08-f01f-5da0-afadf76f5533@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7038afda-dd08-f01f-5da0-afadf76f5533@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* 王贇 <yun.wang@linux.alibaba.com> wrote:

> NUMA balancing will try to migrate pages between nodes, which
> could caused by memory policy or numa group aggregation, while
> the page migration could failed too for eg when the target node
> run out of memory.
> 
> Since this is critical to the performance, admin should know
> how serious the problem is, and take actions before it causing
> too much performance damage, thus this patch expose the counter
> as 'migfailed' in '/proc/PID/sched'.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Acked-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/sched/debug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index f7e4579e746c..73c4809c8f37 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -848,6 +848,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>  	P(total_numa_faults);
>  	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
>  			task_node(p), task_numa_group_id(p));
> +	SEQ_printf(m, "migfailed=%lu\n", p->numa_faults_locality[2]);

Any reason not to expose the other 2 fields of this array as well, which 
show remote/local migrations?

Thanks,

	Ingo
