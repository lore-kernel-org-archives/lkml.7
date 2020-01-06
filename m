Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D72C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46AD207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:03:43 -0500
Received: from foss.arm.com ([217.140.110.172]:43360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:03:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ABCC328;
        Mon,  6 Jan 2020 04:03:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 515583F534;
        Mon,  6 Jan 2020 04:03:41 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:03:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: correctly handle failed perf_get_aux_event() (was: Re:
 [perf] perf_event_open() sometimes returning 0)
Message-ID: <20200106120338.GC9630@lakrids.cambridge.arm.com>
References: <alpine.DEB.2.21.2001021349390.11372@macbook-air>
 <alpine.DEB.2.21.2001021418590.11372@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001021418590.11372@macbook-air>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 02:22:47PM -0500, Vince Weaver wrote:
> On Thu, 2 Jan 2020, Vince Weaver wrote:
> 
> > so I was tracking down some odd behavior in the perf_fuzzer which turns 
> > out to be because perf_even_open() sometimes returns 0 (indicating a file 
> > descriptor of 0) even though as far as I can tell stdin is still open.

Yikes.

> error is triggered if aux_sample_size has non-zero value.
>
> seems to be this line in kernel/events/core.c:
> 
> 
>  if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
>                 goto err_locked;
> 
> 
> (note, err is never set)

Looks like that was introduced in commit:

  ab43762ef010967e ("perf: Allow normal events to output AUX data")
  
I guess we should return -EINVAL in this case.

Vince, does the below (untested) patch work for you?

Thanks,
Mark.

---->8----
From c79f31b42aaf85f3a924af9218794b3bc8b79892 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 6 Jan 2020 11:51:06 +0000
Subject: [PATCH] perf: correctly handle failed perf_get_aux_event()

Vince reports a worrying issue:

| so I was tracking down some odd behavior in the perf_fuzzer which turns
| out to be because perf_even_open() sometimes returns 0 (indicating a file
| descriptor of 0) even though as far as I can tell stdin is still open.

... and further the cause:

| error is triggered if aux_sample_size has non-zero value.
|
| seems to be this line in kernel/events/core.c:
|
| if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
|                goto err_locked;
|
| (note, err is never set)

This seems to be a thinko in commit:

  ab43762ef010967e ("perf: Allow normal events to output AUX data")

... and we should probably return -EINVAL here, as this should only
happen when the new event is mis-configured or does not have a
compatible aux_event group leader.

Fixes: ab43762ef010967e ("perf: Allow normal events to output AUX data")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde19b56..2173c23c25b4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11465,8 +11465,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
-	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
+	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
+		err = -EINVAL;
 		goto err_locked;
+	}
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
-- 
2.11.0

