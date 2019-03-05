Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71907C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79C2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfCEM0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfCEM0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78596307E046;
        Tue,  5 Mar 2019 12:26:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id C5A4E1949C;
        Tue,  5 Mar 2019 12:26:50 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:26:49 +0100
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
Message-ID: <20190305122649.GL16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 05 Mar 2019 12:26:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:

SNIP

> +static int record__aio_enabled(struct record *rec);
> +
>  static void record__aio_mmap_read_sync(struct record *rec)
>  {
>  	int i;
>  	struct perf_evlist *evlist = rec->evlist;
>  	struct perf_mmap *maps = evlist->mmap;
>  
> -	if (!rec->opts.nr_cblocks)
> +	if (!record__aio_enabled(rec))
>  		return;
>  
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
> @@ -292,13 +294,17 @@ static int record__aio_parse(const struct option *opt,
>  
>  	if (unset) {
>  		opts->nr_cblocks = 0;
> -	} else {
> -		if (str)
> -			opts->nr_cblocks = strtol(str, NULL, 0);
> -		if (!opts->nr_cblocks)
> -			opts->nr_cblocks = nr_cblocks_default;
> +		return 0;
>  	}
>  
> +	if (str)
> +		opts->nr_cblocks = strtol(str, NULL, 0);
> +	if (!opts->nr_cblocks)
> +		opts->nr_cblocks = nr_cblocks_default;
> +
> +	if (opts->nr_cblocks > nr_cblocks_max)
> +		opts->nr_cblocks = nr_cblocks_max;
> +
>  	return 0;

does not seem to be related to the patch, if that's the case please separate

jirka
