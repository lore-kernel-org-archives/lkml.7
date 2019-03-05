Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279FA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCEMZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:25:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:25:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F249A30821E0;
        Tue,  5 Mar 2019 12:25:31 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44580171AC;
        Tue,  5 Mar 2019 12:25:30 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:25:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] perf report: implement record trace
 decompression
Message-ID: <20190305122529.GA16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <16550dfe-d4bf-2445-08df-faf0af0ab1e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16550dfe-d4bf-2445-08df-faf0af0ab1e1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 05 Mar 2019 12:25:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 07:06:23PM +0300, Alexey Budankov wrote:

SNIP

> +static int __perf_session__process_decomp_events(struct perf_session *session)
> +{
> +	s64 skip;
> +	u64 size, file_pos = 0;
> +	union perf_event *event;
> +	struct decomp *decomp = session->decomp_last;
> +
> +	if (!decomp)
> +		return 0;
> +
> +	while (decomp->head < decomp->size && !session_done()) {
> +		event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
> +		if (!event)
> +			break;
> +
> +		size = event->header.size;
> +		if (size < sizeof(struct perf_event_header) ||
> +		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
> +			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> +				decomp->file_pos + decomp->head, event->header.size, event->header.type);
> +			return -EINVAL;
> +		}
> +
> +		if (skip)
> +			size += skip;
> +
> +		decomp->head += size;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * On 64bit we can mmap the data file in one go. No need for tiny mmap
>   * slices. On 32bit we use 32MB.
> @@ -1933,6 +2051,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	head += size;
>  	file_pos += size;
>  
> +	err = __perf_session__process_decomp_events(session);
> +	if (err)
> +		goto out;

why don't we process decompressed events directly from the 
perf_session__process_compressed_event callback?

there would be no need for 'struct decomp' list logic

jirka
