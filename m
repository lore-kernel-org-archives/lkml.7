Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE7520828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCKR5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfCKR5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:57:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96AD1307CDEA;
        Mon, 11 Mar 2019 17:57:04 +0000 (UTC)
Received: from krava (ovpn-204-107.brq.redhat.com [10.40.204.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id E2AD35DD8D;
        Mon, 11 Mar 2019 17:57:01 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:57:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v7 perf,bpf 14/15] perf: introduce side band thread
Message-ID: <20190311175700.GD19721@krava>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-15-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307175810.249857-15-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 11 Mar 2019 17:57:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:58:09AM -0800, Song Liu wrote:

SNIP

> +static void *perf_evlist__poll_thread(void *arg)
> +{
> +	struct perf_evlist *evlist = arg;
> +	int i;
> +
> +	while (!(evlist->thread.done)) {
> +		perf_evlist__poll(evlist, 1000);
> +
> +		for (i = 0; i < evlist->nr_mmaps; i++) {
> +			struct perf_mmap *map = &evlist->mmap[i];
> +			union perf_event *event;
> +
> +			if (perf_mmap__read_init(map))
> +				continue;
> +			while ((event = perf_mmap__read_event(map)) != NULL) {
> +				struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
> +
> +				if (evsel && evsel->side_band.cb)
> +					evsel->side_band.cb(event, evsel->side_band.data);
> +				else
> +					pr_warning("cannot locate proper evsel for the side band event\n");
> +
> +				perf_mmap__consume(map);
> +			}
> +			perf_mmap__read_done(map);
> +		}

shouldn't you drain the map before leaving?

SNIP

> +out_delete_evlist:
> +	perf_evlist__delete(evlist);
> +	evlist = NULL;
> +	return -1;
> +}
> +
> +void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
> +{
> +	if (!evlist)
> +		return;
> +	evlist->thread.done = 1;
> +	pthread_join(evlist->thread.th, NULL);
> +	perf_evlist__exit(evlist);
> +	evlist = NULL;

I think the interface is ok, but please let this function
undo whatever perf_evlist__start_sb_thread did, so disable
and close events and cleanup maps

thanks,
jirka
