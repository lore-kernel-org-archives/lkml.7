Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA94EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E7F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCMOhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2001 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:37:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE87D2DDA6;
        Wed, 13 Mar 2019 14:37:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4377F5D75C;
        Wed, 13 Mar 2019 14:37:15 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:37:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 08/12] perf record: implement compression for AIO
 trace streaming
Message-ID: <20190313143714.GE6676@krava>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 13 Mar 2019 14:37:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:30:13AM +0300, Alexey Budankov wrote:
> 
> Compression is implemented using the functions from zstd.c. As the memory
> to operate on the compression uses mmap->aio.data[] buffers. If Zstd
> streaming compression API fails for some reason the data to be compressed
> are just copied into the memory buffers using plain memcpy().
> 
> Compressed trace frame consists of an array of PERF_RECORD_COMPRESSED
> records. Each element of the array is not longer that PERF_SAMPLE_MAX_SIZE
> and consists of perf_event_header followed by the compressed chunk
> that is decompressed on the loading stage.
> 
> perf_mmap__aio_push() is replaced by perf_mmap__push() which is now used
> in the both serial and AIO streaming cases. perf_mmap__push() is extended 
> with positive return values to signify absence of data ready for processing.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 110 ++++++++++++++++++++++++++++--------
>  tools/perf/util/mmap.c      |  76 +------------------------
>  tools/perf/util/mmap.h      |  12 ----
>  3 files changed, 87 insertions(+), 111 deletions(-)

nice stats for adding new feature ;-)

jirka
