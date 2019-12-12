Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ACC2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3mtmXS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfLLNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:49:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfLLNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r9Ziduu2E/lHprflWnWjfIynK8+5aLFth0xvY5j7dKA=; b=J3mtmXS3fna1ZQeTt6NdUVwCQ
        19bX/7lt8H+daXHuMfh1ujuX7UVjYjQDthpOFyAIlqkIs417kHXcLaUyI9n/FQeYYY8hI+3gpV2UH
        DVQ/bB9AFVx6E6ivFLf23mkQUM960g0usLUADdNA+NJYnnygutMSVyt9XGf/GOyy0KuVebFLAnGu7
        Tn2lwV7mGnr/yfFjyG+G0qmIv3ZflFt0JtZqWCmRp4zVW6EzR0V9VEF5l5/I0OvS0eO7cw9QtPwsg
        doPSjG6kkgy93PooKN4mbmoh5cCsWp8+6qZhQiHIAzGPfSmaCovkV+Aw/4eOEFFuBTAj/IO37BqXp
        YLku+A3FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifOqn-0001D9-Kk; Thu, 12 Dec 2019 13:49:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 848863058B4;
        Thu, 12 Dec 2019 14:48:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDE9C29E10BD9; Thu, 12 Dec 2019 14:49:51 +0100 (CET)
Date:   Thu, 12 Dec 2019 14:49:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Message-ID: <20191212134951.GX2844@hirez.programming.kicks-ass.net>
References: <20191207002447.2976319-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002447.2976319-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:

> @@ -750,6 +752,16 @@ struct perf_event {
>  	void *security;
>  #endif
>  	struct list_head		sb_list;
> +
> +	/* for PMU sharing */
> +	struct perf_event		*dup_master;
> +	/* check event_sync_dup_count() for the use of dup_base_* */
> +	u64				dup_base_count;
> +	u64				dup_base_child_count;
> +	/* when this event is master,  read from master*count */
> +	local64_t			master_count;
> +	atomic64_t			master_child_count;
> +	int				dup_active_count;
>  #endif /* CONFIG_PERF_EVENTS */
>  };

> +/* PMU sharing aware version of event->pmu->add() */
> +static int event_pmu_add(struct perf_event *event,
> +			 struct perf_event_context *ctx)
> +{
> +	struct perf_event *master;
> +	int ret;
> +
> +	/* no sharing, just do event->pmu->add() */
> +	if (!event->dup_master)
> +		return event->pmu->add(event, PERF_EF_START);

Possibly we should look at the location of perf_event::dup_master to be
in a hot cacheline. Because I'm thinking you just added a guaranteed
miss here.

> +
> +	master = event->dup_master;
> +
> +	if (!master->dup_active_count) {
> +		ret = event->pmu->add(master, PERF_EF_START);
> +		if (ret)
> +			return ret;
> +
> +		if (master != event)
> +			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
> +	}
> +
> +	master->dup_active_count++;
> +	master->pmu->read(master);
> +	event->dup_base_count = local64_read(&master->count);
> +	event->dup_base_child_count = atomic64_read(&master->child_count);
> +	return 0;
> +}

> +/* PMU sharing aware version of event->pmu->del() */
> +static void event_pmu_del(struct perf_event *event,
> +			  struct perf_event_context *ctx)
> +{
> +	struct perf_event *master;
> +
> +	if (event->dup_master == NULL) {
> +		event->pmu->del(event, 0);
> +		return;
> +	}

How about you write it exactly like the add version:

	if (!event->dup_master)
		return event->pmu->del(event, 0);

?

> +
> +	master = event->dup_master;
> +	event_sync_dup_count(event, master);
> +	if (--master->dup_active_count == 0) {
> +		event->pmu->del(master, 0);
> +		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
> +	} else if (master == event) {
> +		perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
> +	}
> +}
> +
> +/* PMU sharing aware version of event->pmu->read() */
> +static void event_pmu_read(struct perf_event *event)
> +{
> +	if (event->dup_master == NULL) {
> +		event->pmu->read(event);
> +		return;
> +	}

And here too.

> +	event_sync_dup_count(event, event->dup_master);
> +}
