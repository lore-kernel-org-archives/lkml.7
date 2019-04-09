Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B702C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2171720880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfDIKmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfDIKmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:42:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BCA26698A;
        Tue,  9 Apr 2019 10:42:09 +0000 (UTC)
Received: from krava (unknown [10.40.205.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC58A69185;
        Tue,  9 Apr 2019 10:42:06 +0000 (UTC)
Date:   Tue, 9 Apr 2019 12:42:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
Message-ID: <20190409104205.GB29688@krava>
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401142000.17679-1-tmricht@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 09 Apr 2019 10:42:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 04:20:00PM +0200, Thomas Richter wrote:

SNIP

> perf_session__process_event() returns to its caller, where -ENOMEM is
> changed to -EINVAL and processing stops:
> 
>  if ((skip = perf_session__process_event(session, event, head)) < 0) {
>       pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> 	     head, event->header.size, event->header.type);
>       err = -EINVAL;
>       goto out_err;
>  }
> 
> This occured in the FINISHED_ROUND event when it has to process some
> 10000 entries and ran out of memory.
> 
> I understand that my perf.data file might just be too big, but I would
> like to see some error message indicating OOM error instead of
> processing failure of a unrelated event.

you can limit the size of the report queue via ~/.perfconfig file:

[report]
queue-size=1M

above should use only 1M for the queue management data the data
for sample still get allocated thought.. but it could help

> 
> However this patch just does what the pr_debug() statement indicates,
> the event is skipped and processing continues.
> But at least the root cause is indicated and also shows up in the
> GUI.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/builtin-report.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 4054eb1f98ac..7a27b815f7a8 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
>  		al.map->dso->hit = 1;
>  
>  	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pr_debug("problem adding hist entry, skipping event\n");
> +		if (ret == -ENOMEM) {
> +			pr_err("Running out of memory\n");
> +			ret = 0;
> +		}
> +	}


I think we can propagate the error completely (like below),
and even warn about ENOMEM specificaly

but I think we should bail out in case of ENOMEM, because
the data are incomplete and misleading

jirka


---
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..eea247a26ad8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
-		err = -EINVAL;
+		err = skip;
 		goto out;
 	}
 
