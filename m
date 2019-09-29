Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BABCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0844E2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfI2PpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 11:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2PpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 11:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA43A8980F0;
        Sun, 29 Sep 2019 15:45:12 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CE4C60606;
        Sun, 29 Sep 2019 15:45:02 +0000 (UTC)
Date:   Sun, 29 Sep 2019 17:45:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/4] perf inject jit: Fix JIT_CODE_MOVE filename
Message-ID: <20190929154501.GB602@krava>
References: <BN8PR21MB1362FF8F127B31DBF4121528F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1362FF8F127B31DBF4121528F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Sun, 29 Sep 2019 15:45:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 01:41:18AM +0000, Steve MacLean wrote:
> During perf inject --jit, JIT_CODE_MOVE records were injecting MMAP records
> with an incorrect filename. Specifically it was missing the ".so" suffix.
> 
> Further the JIT_CODE_LOAD record were silently truncating the
> jr->load.code_index field to 32 bits before generating the filename.
> 
> Make both records emit the same filename based on the full 64 bit
> code_index field.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/jitdump.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 1bdf4c6..e3ccb0c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -395,7 +395,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  	size_t size;
>  	u16 idr_size;
>  	const char *sym;
> -	uint32_t count;
> +	uint64_t count;
>  	int ret, csize, usize;
>  	pid_t pid, tid;
>  	struct {
> @@ -418,7 +418,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  		return -1;
>  
>  	filename = event->mmap2.filename;
> -	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%u.so",
> +	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
>  			jd->dir,
>  			pid,
>  			count);
> @@ -529,7 +529,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
>  		return -1;
>  
>  	filename = event->mmap2.filename;
> -	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%"PRIu64,
> +	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
>  	         jd->dir,
>  	         pid,
>  		 jr->move.code_index);
> -- 
> 2.7.4
