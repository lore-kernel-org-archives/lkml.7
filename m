Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4D82077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/mN+nbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfLLNmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:42:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfLLNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rJa/W2tgIFhiXVFPcpKb0nFBD1So+fskYEhVFV4Lyeo=; b=t/mN+nbvqhhz38AdviLVnyhVu
        xYiIN4f7rZpxm7bwweRNQ3uLeYJnaGEeRx4J6OTDXgeK1c0+4c0sVs0YaJshLnr3yWmUxTFkznYnw
        gRFZJklq/Ovmwdti2gnzOV68LlHiZcQkqZt7e7ADORypdWBpYWE7qf7jZFlsFEaMNZEcdi1LSrQwy
        92s5XFsERA2Ou7NAWJaBOcfncGSEXl8TPTOD7jD5l8rUMEZvBNDiQ6Y0Mm9VYH3xTt4gunl8X0QiA
        3+S2AAFWiruPcmZXkGa60oybDy4udKiD7zThaA2hmk9LaUvTVQFDkosAPd84yakQDcwyYE+9jkl7F
        AhpV3yYaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifOjg-0001Xc-Rj; Thu, 12 Dec 2019 13:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E687C300F29;
        Thu, 12 Dec 2019 14:41:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46A2729E10BD6; Thu, 12 Dec 2019 14:42:31 +0100 (CET)
Date:   Thu, 12 Dec 2019 14:42:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Message-ID: <20191212134231.GW2844@hirez.programming.kicks-ass.net>
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
> +/* Remove dup_master for the event */
> +static void perf_event_remove_dup(struct perf_event *event,
> +				  struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp, *new_master;
> +	int count;
> +
> +	/* no sharing */
> +	if (!event->dup_master)
> +		return;
> +
> +	WARN_ON_ONCE(event->state != PERF_EVENT_STATE_INACTIVE &&
> +		     event->state != PERF_EVENT_STATE_OFF);
> +
> +	/* this event is not the master */
> +	if (event->dup_master != event) {
> +		event->dup_master = NULL;
> +		return;
> +	}
> +
> +	/* this event is the master */
> +	perf_event_exit_dup_master(event);
> +
> +	count = 0;
> +	new_master = NULL;
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
> +		if (tmp->dup_master == event) {
> +			count++;
> +			if (!new_master)
> +				new_master = tmp;
> +		}
> +	}
> +
> +	if (!count)
> +		return;
> +
> +	if (count == 1) {
> +		/* no more sharing */
> +		new_master->dup_master = NULL;
> +		return;
> +	}
> +
> +	perf_event_init_dup_master(new_master);
> +
> +	/* switch to new_master */
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry)
> +		if (tmp->dup_master == event)
> +			tmp->dup_master = new_master;
> +}

I'm thinking you can do that in a single iteration:

	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
		if (tmp->dup_master != event)
			continue;

		if (!new_master)
			new_master = tmp;

		tmp->dup_master = new_master;
		count++;
	}

	if (count == 1)
		new_master->dup_master = NULL;
	else
		perf_event_init_dup_master(new_master);

Hmm?
