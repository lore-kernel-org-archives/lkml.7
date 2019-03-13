Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EC32087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCMOhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F961307D943;
        Wed, 13 Mar 2019 14:36:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB3F5610FF;
        Wed, 13 Mar 2019 14:36:57 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:36:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 02/12] perf record: implement
 -f,--mmap-flush=<threshold> option
Message-ID: <20190313143656.GB6676@krava>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <e582719a-ca01-22cd-bc73-6d693961bb18@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e582719a-ca01-22cd-bc73-6d693961bb18@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 13 Mar 2019 14:36:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:12:23AM +0300, Alexey Budankov wrote:

SNIP

>  	record__aio_mmap_read_sync(rec);
>  
>  	if (forks) {
> @@ -1815,6 +1863,7 @@ static struct record record = {
>  			.uses_mmap   = true,
>  			.default_per_cpu = true,
>  		},
> +		.mmap_flush          = MMAP_FLUSH_DEFAULT,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -1881,6 +1930,9 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
>  		     "number of mmap data pages and AUX area tracing mmap pages",
>  		     record__parse_mmap_pages),
> +	OPT_CALLBACK('f', "mmap-flush", &record.opts, "bytes",
> +		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
> +		     record__mmap_flush_parse),

let's not consume the 'f' for this option, just --map-flush

jirka
