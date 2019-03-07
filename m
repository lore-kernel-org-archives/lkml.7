Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB01C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10F82081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCGOFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCGOFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:05:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B9615D61A;
        Thu,  7 Mar 2019 14:05:37 +0000 (UTC)
Received: from krava (unknown [10.40.206.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id F09375C545;
        Thu,  7 Mar 2019 14:05:34 +0000 (UTC)
Date:   Thu, 7 Mar 2019 15:05:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v6 perf,bpf 14/15] perf: introduce side band thread
Message-ID: <20190307140534.GA7233@krava>
References: <20190306071359.2359896-1-songliubraving@fb.com>
 <20190306071359.2359896-15-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306071359.2359896-15-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 07 Mar 2019 14:05:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:13:58PM -0800, Song Liu wrote:

SNIP

> +void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
> +{
> +	if (!evlist)
> +		return;
> +	evlist->thread.done = 1;
> +	pthread_join(evlist->thread.th, NULL);
> +	perf_evlist__exit(evlist);
> +	evlist = NULL;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 868294491194..ed8cab1b7438 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -51,6 +51,11 @@ struct perf_evlist {
>  	struct perf_env	*env;
>  	u64		first_sample_time;
>  	u64		last_sample_time;
> +	struct {
> +		pthread_t		th;
> +		struct perf_evsel	*evsel;

what's the evsel pointer for?

> +		volatile int		done;
> +	} thread;
>  };

SNIP
