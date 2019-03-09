Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B8220645
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCIRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCIRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:21:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B54C23003093;
        Sat,  9 Mar 2019 17:21:17 +0000 (UTC)
Received: from krava (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0D405D6A6;
        Sat,  9 Mar 2019 17:21:14 +0000 (UTC)
Date:   Sat, 9 Mar 2019 18:21:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 07/11] perf session: Add
 __perf_session__process_dir_events function
Message-ID: <20190309172113.GA6378@krava>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-8-jolsa@kernel.org>
 <20190308183805.GG10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308183805.GG10690@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 09 Mar 2019 17:21:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:38:05PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > +	/* Read data from the header file.. */
> > +	ret = reader__process_events(&rd, session, &prog);
> > +	if (ret)
> > +		goto out_err;
> > +
> > +	/* ... and continue with data files. */
> > +	for (i = 0; i < data->dir.nr ; i++) {
> > +		struct perf_data_file *file = &data->dir.files[i];
> > +
> > +		if (file->size == 0)
> > +			continue;
> > +
> > +		rd = (struct reader) {
> > +			.fd		= file->fd,
> > +			.data_size	= file->size,
> > +			.data_offset	= 0,
> > +			.process	= process_index,
> > +		};
> > +
> > +		ret = reader__process_events(&rd, session, &prog);
> > +		if (ret)
> > +			goto out_err;
> 
> Don't we have to have some handling of PERF_RECORD_FINISHED_ROUND here?
> I.e. what happens if we fill th ordered events with just the contents
> of, say, the first CPU and then have those events flushed and processed
> before we start even looking at the events in the other CPUs?

PERF_RECORD_FINISHED_ROUND is disabled for directory data,
because each file contains sorted cpu data, so we only
merge them together

> 
> I think some detailed explanation of what happens here is in need, no?

right, I'll put the comment for the function

jirka
