Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE37C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ABA2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss/6IjFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfHHNUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:20:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46695 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:20:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so92018431qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wv04Yv2Yq5puUXXlC/N3MlD21vo7mH1+S8L0szqWvw=;
        b=Ss/6IjFhH/DLXdBvwvhX4asY7nXSQugE+H47cTGLDoF0lCn8uT7FEtyf8OZwjPI4gM
         PCaaxW48G9x/5Kv5PkrzgZedTc9b8q2eyppnNcI2rYdzLjcx/QXPEhtn0tadT3xrRhup
         lVetNJx0TIpxr0L5kqWJ21VWkV4nGPgjvfZR5ValUXatSuHuR6Tw35c1LgEm61LDpHqO
         5kvagcTBEbxIVpELGRxv5gDtXQiJ94FMQ+jxXQ/hncp/DKaUYeNSSCS29lapby+Cl4BK
         E2Fr+jEN8hze5A+6Kwa+oJGmJP4clT18BbqXR7GrO7sSLAGj4/F+DcHoQ606najodbpN
         xwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wv04Yv2Yq5puUXXlC/N3MlD21vo7mH1+S8L0szqWvw=;
        b=U1LKftEmCVxzBDllaaaVqG4R7o3UoBIUZ8wv7l4M7rBSUL7+dSsDLrtapmWVOS9DQf
         4uogNKFMhzgS4qmzOadWGFfcVXZvtef//PNdIQ1droOZT6CRaWZYgQyGHm5qDG5D/oJw
         S/A8JbNbD7tVHhoA8uhDv58NHRyFhcifNxAAtTt+gikbcp/46/ii2mx4RzhQp7YFuA0d
         NUeXtlrKU/npp6pD7h02cTAocHtPEl+K0DyQXKFuDKlqfBSO5+KBzFlyI0peTi3HqjZ9
         /sKjzkwaQ72t2MtR2sv+FTb4qAdNMrWQua4FUfjCK4jw6A46yKdr6rsL9iTeF0Gs8Prz
         EyuA==
X-Gm-Message-State: APjAAAXcxv35V3q6BMczIinQq55imDao1GGW+IOE+lNiTiieEzXCtmhf
        1LdOMXsIjDgwnSDHouUi0ek=
X-Google-Smtp-Source: APXvYqxdY3IP9ZcCFOO3zJ3tZyXNUTSUMzEsCVHm2+zbYqKbIdEYdS7oRj+zEeaeAhAYl9wYRjgqHQ==
X-Received: by 2002:a0c:dd86:: with SMTP id v6mr13248318qvk.176.1565270445531;
        Thu, 08 Aug 2019 06:20:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b126sm821393qkg.17.2019.08.08.06.20.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:20:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D82340340; Thu,  8 Aug 2019 10:20:39 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:20:39 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf db-export: Fix thread__exec_comm()
Message-ID: <20190808132039.GA19444@kernel.org>
References: <20190808064823.14846-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808064823.14846-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 08, 2019 at 09:48:23AM +0300, Adrian Hunter escreveu:
> Threads synthesized from /proc have comms with a start time of zero, and
> not marked as "exec". Currently, there can be 2 such comms. The first is
> created by processing a synthesized fork event and is set to the parent's
> comm string, and the second by processing a synthesized comm event set to
> the thread's current comm string.
> 
> In the absence of an "exec" comm, thread__exec_comm() picks the last
> (oldest) comm, which, in the case above, is the parent's comm string. For a
> main thread, that is very probably wrong. Use the second-to-last in that
> case.

Thanks, applied.

- Arnaldo
 
> This affects only db-export because it is the only user of
> thread__exec_comm().
> 
> Example:
> 
>  $ sudo perf record -a -o pt-a-sleep-1 -e intel_pt//u -- sleep 1
>  $ sudo chown ahunter pt-a-sleep-1
> 
>  Before:
> 
>  $ perf script -i pt-a-sleep-1 --itrace=bep -s tools/perf/scripts/python/export-to-sqlite.py pt-a-sleep-1.db branches calls
>  $ sqlite3 -header -column pt-a-sleep-1.db 'select * from comm_threads_view'
>  comm_id     command     thread_id   pid         tid
>  ----------  ----------  ----------  ----------  ----------
>  1           swapper     1           0           0
>  2           rcu_sched   2           10          10
>  3           kthreadd    3           78          78
>  5           sudo        4           15180       15180
>  5           sudo        5           15180       15182
>  7           kworker/4:  6           10335       10335
>  8           kthreadd    7           55          55
>  10          systemd     8           865         865
>  10          systemd     9           865         875
>  13          perf        10          15181       15181
>  15          sleep       10          15181       15181
>  16          kworker/3:  11          14179       14179
>  17          kthreadd    12          29376       29376
>  19          systemd     13          746         746
>  21          systemd     14          401         401
>  23          systemd     15          879         879
>  23          systemd     16          879         945
>  25          kthreadd    17          556         556
>  27          kworker/u1  18          14136       14136
>  28          kworker/u1  19          15021       15021
>  29          kthreadd    20          509         509
>  31          systemd     21          836         836
>  31          systemd     22          836         967
>  33          systemd     23          1148        1148
>  33          systemd     24          1148        1163
>  35          kworker/2:  25          17988       17988
>  36          kworker/0:  26          13478       13478
> 
>  After:
> 
>  $ perf script -i pt-a-sleep-1 --itrace=bep -s tools/perf/scripts/python/export-to-sqlite.py pt-a-sleep-1b.db branches calls
>  $ sqlite3 -header -column pt-a-sleep-1b.db 'select * from comm_threads_view'
>  comm_id     command     thread_id   pid         tid
>  ----------  ----------  ----------  ----------  ----------
>  1           swapper     1           0           0
>  2           rcu_sched   2           10          10
>  3           kswapd0     3           78          78
>  4           perf        4           15180       15180
>  4           perf        5           15180       15182
>  6           kworker/4:  6           10335       10335
>  7           kcompactd0  7           55          55
>  8           accounts-d  8           865         865
>  8           accounts-d  9           865         875
>  10          perf        10          15181       15181
>  12          sleep       10          15181       15181
>  13          kworker/3:  11          14179       14179
>  14          kworker/1:  12          29376       29376
>  15          haveged     13          746         746
>  16          systemd-jo  14          401         401
>  17          NetworkMan  15          879         879
>  17          NetworkMan  16          879         945
>  19          irq/131-iw  17          556         556
>  20          kworker/u1  18          14136       14136
>  21          kworker/u1  19          15021       15021
>  22          kworker/u1  20          509         509
>  23          thermald    21          836         836
>  23          thermald    22          836         967
>  25          unity-sett  23          1148        1148
>  25          unity-sett  24          1148        1163
>  27          kworker/2:  25          17988       17988
>  28          kworker/0:  26          13478       13478
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 65de51f93ebf ("perf tools: Identify which comms are from exec")
> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/thread.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 873ab505ca80..590793cc5142 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -214,14 +214,24 @@ struct comm *thread__comm(const struct thread *thread)
>  
>  struct comm *thread__exec_comm(const struct thread *thread)
>  {
> -	struct comm *comm, *last = NULL;
> +	struct comm *comm, *last = NULL, *second_last = NULL;
>  
>  	list_for_each_entry(comm, &thread->comm_list, list) {
>  		if (comm->exec)
>  			return comm;
> +		second_last = last;
>  		last = comm;
>  	}
>  
> +	/*
> +	 * 'last' with no start time might be the parent's comm of a synthesized
> +	 * thread (created by processing a synthesized fork event). For a main
> +	 * thread, that is very probably wrong. Prefer a later comm to avoid
> +	 * that case.
> +	 */
> +	if (second_last && !last->start && thread->pid_ == thread->tid)
> +		return second_last;
> +
>  	return last;
>  }
>  
> -- 
> 2.17.1

-- 

- Arnaldo
