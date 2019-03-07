Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1743C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06EE20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGL76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:59:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCGL76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:59:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B98BD2D805;
        Thu,  7 Mar 2019 11:59:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F69E1001DD6;
        Thu,  7 Mar 2019 11:59:55 +0000 (UTC)
Date:   Thu, 7 Mar 2019 12:59:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
Message-ID: <20190307115955.GA29474@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122622.GJ16615@krava>
 <6c964c70-86d7-32ab-c497-5ea65a9fd034@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c964c70-86d7-32ab-c497-5ea65a9fd034@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 11:59:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:26:16AM +0300, Alexey Budankov wrote:
> 
> On 05.03.2019 15:26, Jiri Olsa wrote:
> > On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> +static size_t record__process_comp_header(void *record, size_t increment)
> >> +{
> >> +	struct compressed_event *event = record;
> >> +	size_t size = sizeof(struct compressed_event);
> >> +
> >> +	if (increment) {
> >> +		event->header.size += increment;
> >> +		return increment;
> >> +	} else {
> >> +		event->header.type = PERF_RECORD_COMPRESSED;
> >> +		event->header.size = size;
> >> +		return size;
> >> +	}
> > 
> > so zstd_compress_stream_to_records calls this in the loop:
> > 
> >           while (input.pos < input.size) {
> > 	  	...
> >                 size = process_header(record, 0);
> > 		...
> >                 size = process_header(record, size);
> > 	}
> > 
> > the header.size will get overwritten with every new iteration, no?
> 
> Every new record is headed by PERF_RECORD_COMPRESSED header an updated with 
> resulted compressed frame size after compression. 
> 
> process_header(, 0) puts header, then 
> compression puts compressed frame, then 
> process_header(, N) updates header.size value (+=).

and then process_header(, 0) is called again no?

jirka
