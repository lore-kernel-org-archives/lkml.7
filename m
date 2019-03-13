Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89E32147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCMOhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0D794AD5;
        Wed, 13 Mar 2019 14:37:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3518F610FF;
        Wed, 13 Mar 2019 14:37:10 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:37:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 06/12] perf util: introduce Zstd based streaming
 compression API
Message-ID: <20190313143709.GD6676@krava>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <f9062f55-c37f-bf50-8566-a587bce30131@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9062f55-c37f-bf50-8566-a587bce30131@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 13 Mar 2019 14:37:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:23:42AM +0300, Alexey Budankov wrote:
> 
> Implemented functions are based on Zstd streaming compression API.
> The functions are used in runtime to compress data that come from
> mmaped kernel buffer. zstd_init(), zstd_fini() are used for 
> initialization and finalization to allocate and deallocate internal
> zstd objects. zstd_compress_stream_to_records() is used to convert 
> parts of mmaped kernel buffer into an array of PERF_RECORD_COMPRESSED 
> records.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/Build      |  2 +
>  tools/perf/util/compress.h | 18 ++++++++
>  tools/perf/util/zstd.c     | 95 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 tools/perf/util/zstd.c
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8dd3102301ea..920ee8bebd83 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -145,6 +145,8 @@ perf-y += scripting-engines/
>  
>  perf-$(CONFIG_ZLIB) += zlib.o
>  perf-$(CONFIG_LZMA) += lzma.o
> +perf-y += zstd.o

we have CONFIG_ZSTD, so we can do:

perf-$(CONFIG_ZSTD) += zstd.o

and skip that #ifdef HAVE_ZSTD_SUPPORT in zstd.c
and put stub inlines into compress.h

thanks,
jirka
