Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B40C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCKMdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfCKMdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA11E308FBA0;
        Mon, 11 Mar 2019 12:33:48 +0000 (UTC)
Received: from krava (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA43519731;
        Mon, 11 Mar 2019 12:33:46 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:33:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
Message-ID: <20190311123345.GD26829@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <cc16317a-87f0-7abe-69a6-31394d32dda7@linux.intel.com>
 <20190305122604.GG16615@krava>
 <bcee0574-80cc-79df-b36d-e6495c786d9f@linux.intel.com>
 <92831c18-865b-50bf-1f03-b38b63099703@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92831c18-865b-50bf-1f03-b38b63099703@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 11 Mar 2019 12:33:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:19:03AM +0300, Alexey Budankov wrote:
> On 07.03.2019 11:29, Alexey Budankov wrote:
> > 
> > On 05.03.2019 15:26, Jiri Olsa wrote:
> >> On Fri, Mar 01, 2019 at 06:43:28PM +0300, Alexey Budankov wrote:
> >>>
> >>> Define bytes_transferred and bytes_compressed metrics to calculate
> >>> comp_ratio=transferred/compressed in the end of the data collection.
> >>>
> >>> bytes_transferred accumulates the amount of bytes that was extracted from
> >>> the mmaped kernel buffers for compression. bytes_compressed accumulates
> >>> the amount of bytes that was received after applying compression to
> >>> move to a storage.
> >>>
> >>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>> ---
> >>>  tools/perf/builtin-record.c | 8 ++++++++
> >>>  tools/perf/util/env.h       | 1 +
> >>>  tools/perf/util/session.h   | 2 ++
> >>>  3 files changed, 11 insertions(+)
> >>>
> >>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >>> index 9b02a68e8c23..ab121bc27c6d 100644
> >>> --- a/tools/perf/builtin-record.c
> >>> +++ b/tools/perf/builtin-record.c
> >>> @@ -1449,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >>>  	record__mmap_read_all(rec, true);
> >>>  	record__aio_mmap_read_sync(rec);
> >>>  
> >>> +	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
> >>> +		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
> >>> +
> >>> +		session->header.env.comp_ratio = ratio + 0.5;
> >>
> >> what's the + 0.5 for?
> > 
> > Arithmetic rounding before type cast.
> > 
> >>
> >>> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
> >>> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
> >>> +	}
> >>> +
> >>
> >> could this be below together with the current:
> >>
> >> 	fprintf(stderr, "[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
> > 
> > Please provide an example of what you exactly mean.
> 
> It could look like this:
> 
> [ perf record: Woken up 101 times to write data ]
> [ perf record: Captured and wrote 5.173 MB perf.data (714077 samples), compressed 27.241 MB to 5.160 MB, ratio is 5.279 ]

yes, maybe we don't need to repeat the original size twice:

[ perf record: Captured and wrote 5.173 MB perf.data (714077 samples), compressed (original 27.241 MB, ratio 5.279) ]

jirka
