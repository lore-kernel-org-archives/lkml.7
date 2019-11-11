Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71CBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C021655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKKOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:39:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:62624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfKKOjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:39:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 06:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="213776866"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2019 06:39:00 -0800
Received: from [10.252.3.28] (unknown [10.252.3.28])
        by linux.intel.com (Postfix) with ESMTP id BAFF35803A5;
        Mon, 11 Nov 2019 06:38:56 -0800 (PST)
Subject: Re: [RFC] perf session: Fix compression processing
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191103222441.GE8251@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d57725e6-e62f-b37e-6cb4-28bf521faaea@linux.intel.com>
Date:   Mon, 11 Nov 2019 17:38:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191103222441.GE8251@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.11.2019 1:24, Jiri Olsa wrote:
> hi,
<SNIP>
> ---
> The compressed data processing occasionally fails with:
>   $ perf report --stdio -vv
>   decomp (B): 44519 to 163000
>   decomp (B): 48119 to 174800
>   decomp (B): 65527 to 131072
>   fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
>   Error:
>   failed to process sample
>   ...
> 
> It's caused by recent fuzzer fix that does not take into account
> that compressed data do not need to by fully present in the buffer,
> so it's ok to just return NULL and not to fail.
> 
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/session.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f07b8ecb91bc..3589ed14a629 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1959,7 +1959,7 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  
>  static union perf_event *
>  fetch_mmaped_event(struct perf_session *session,
> -		   u64 head, size_t mmap_size, char *buf)
> +		   u64 head, size_t mmap_size, char *buf, bool decomp)

bools in interface make code less transparent.

>  {
>  	union perf_event *event;
>  
> @@ -1979,6 +1979,8 @@ fetch_mmaped_event(struct perf_session *session,
>  		/* We're not fetching the event so swap back again */
>  		if (session->header.needs_swap)
>  			perf_event_header__bswap(&event->header);
> +		if (decomp)
> +			return NULL;
>  		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
>  			 __func__, head, event->header.size, mmap_size);
>  		return ERR_PTR(-EINVAL);
> @@ -1997,7 +1999,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  		return 0;
>  
>  	while (decomp->head < decomp->size && !session_done()) {
> -		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
> +		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data, true);

It looks like this call can be skipped, at all, in this case.

>  
>  		if (IS_ERR(event))
>  			return PTR_ERR(event);
> @@ -2100,7 +2102,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	}
>  
>  more:
> -	event = fetch_mmaped_event(session, head, mmap_size, buf);
> +	event = fetch_mmaped_event(session, head, mmap_size, buf, false);
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
> 

~Alexey
