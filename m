Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCEM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfCEM06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3555081DF1;
        Tue,  5 Mar 2019 12:26:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 81F8D60BEE;
        Tue,  5 Mar 2019 12:26:56 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:26:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/10] perf inject: enable COMPRESSED records
 decompression
Message-ID: <20190305122655.GM16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <fa393ac2-f9ae-288b-ff0b-9218b8270775@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa393ac2-f9ae-288b-ff0b-9218b8270775@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 05 Mar 2019 12:26:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 07:07:49PM +0300, Alexey Budankov wrote:
> 
> Initialized decompression API so COMPRESSED record would be
> decompressed into the resulting output data file.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-inject.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 24086b7f1b14..8e0e06d3edfc 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -837,6 +837,9 @@ int cmd_inject(int argc, const char **argv)
>  	if (inject.session == NULL)
>  		return -1;
>  
> +	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
> +		pr_warning("Decompression initialization failed.\n");

hum, I wonder we should put this inside perf_session__new/perf_session__delete

jirka

> +
>  	if (inject.build_ids) {
>  		/*
>  		 * to make sure the mmap records are ordered correctly
> @@ -867,6 +870,7 @@ int cmd_inject(int argc, const char **argv)
>  	ret = __cmd_inject(&inject);
>  
>  out_delete:
> +	zstd_fini(&(inject.session->zstd_data));
>  	perf_session__delete(inject.session);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
