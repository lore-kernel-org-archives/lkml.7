Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37613C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCGTDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCGTDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B8AF81DFC;
        Thu,  7 Mar 2019 19:03:35 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-41.phx2.redhat.com [10.3.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9503A29684;
        Thu,  7 Mar 2019 19:03:34 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 718464BF3; Thu,  7 Mar 2019 16:03:30 -0300 (BRT)
Date:   Thu, 7 Mar 2019 16:03:30 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com, acme@kernel.org
Subject: Re: [PATCH] perf/core: restore mmap record type correctly
Message-ID: <20190307190330.GA2443@redhat.com>
References: <20190307185233.225521-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307185233.225521-1-eranian@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Mar 2019 19:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 07, 2019 at 10:52:33AM -0800, Stephane Eranian escreveu:
> On mmap(), perf_events generates a RECORD_MMAP record and then checks
> which events are interested in this record. There are currently 2 versions
> of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger. The event
> configuration controls which version the user level tool accepts. If the
> event->attr.mmap2=1 field then MMAP2 record is returned. The
> perf_event_mmap_output() takes care of this. It checks attr->mmap2 and corrects
> the record fields before putting it in the sampling buffer of the event.
> At the end the function restores the modified MMAP record fields.
> 
> The problem is that the function restores the size but not the
> type. Thus, if a subsequent event only accepts MMAP type, then it would
> instead receive an MMAP2 record with a size of MMAP record.
> 
> This patch fixes the problem by restoring the record type on exit.

Right, simple enough, bug fixed, Peter, I'm taking this one, ok?

- Arnaldo
 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  kernel/events/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5f59d848171e..f170cd12beed 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7188,6 +7188,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	struct perf_output_handle handle;
>  	struct perf_sample_data sample;
>  	int size = mmap_event->event_id.header.size;
> +	u32 type = mmap_event->event_id.header.type;
>  	int ret;
>  
>  	if (!perf_event_mmap_match(event, data))
> @@ -7231,6 +7232,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	perf_output_end(&handle);
>  out:
>  	mmap_event->event_id.header.size = size;
> +	mmap_event->event_id.header.type = type;
>  }
>  
>  static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
> -- 
> 2.21.0.360.g471c308f928-goog
