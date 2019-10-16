Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7749320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbfJPKPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPKPq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB8DD308624A;
        Wed, 16 Oct 2019 10:15:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB4C25C1D8;
        Wed, 16 Oct 2019 10:15:43 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:15:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191016101543.GC15580@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
 <20191015084102.GA10951@krava>
 <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 16 Oct 2019 10:15:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:53:18PM +0800, Jin, Yao wrote:

SNIP

> > > +static struct block_header_column{
> > > +	const char *name;
> > > +	int width;
> > > +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
> > > +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV] = {
> > > +		.name = "Sampled Cycles%",
> > > +		.width = 15,
> > > +	},
> > > +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
> > > +		.name = "Sampled Cycles",
> > > +		.width = 14,
> > > +	},
> > > +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
> > > +		.name = "Avg Cycles%",
> > > +		.width = 11,
> > > +	},
> > > +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
> > > +		.name = "Avg Cycles",
> > > +		.width = 10,
> > > +	},
> > > +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
> > > +		.name = "[Program Block Range]",
> > > +		.width = 70,
> > > +	},
> > > +	[PERF_HPP_REPORT__BLOCK_DSO] = {
> > > +		.name = "Shared Object",
> > > +		.width = 20,
> > > +	}
> > >   };
> > 
> > so we already have support for multiple columns,
> > why don't you add those as 'struct sort_entry' objects?
> > 
> 
> For 'struct sort_entry' objects, do you mean I should reuse the "sort_dso"
> which has been implemented yet in util/sort.c?
> 
> For other columns, it looks we can't reuse the existing sort_entry objects.

I did not mean reuse, just add new sort entries
to current sort framework

> 
> > SNIP
> > 
> > > +{
> > > +	struct block_hist *bh = &rep->block_hist;
> > > +
> > > +	get_block_hists(hists, bh, rep);
> > > +	symbol_conf.report_individual_block = true;
> > > +	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
> > > +		       stdout, true);
> > > +	hists__delete_entries(&bh->block_hists);
> > > +	return 0;
> > > +}
> > > +
> > >   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
> > >   					 struct report *rep,
> > >   					 const char *help)
> > > @@ -500,6 +900,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
> > >   			continue;
> > >   		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
> > > +
> > > +		if (rep->total_cycles) {
> > > +			hists__fprintf_all_blocks(hists, rep);
> > 
> > so this call kicks all the block info setup/count/print, right?
> > 
> 
> Yes, all in this call.
> 
> > I thingk it shouldn't be in the output code, but in the code before..
> > from what I see you could count block_info counts during the sample
> > processing, no?
> > 
> 
> In sample processing, we just get all symbols and account the cycles per
> symbol. We need to create/count the block_info at some points after the
> sample processing.

understand, but it needs to be outside display function

also, can't you gather the block_info data gradually
during the sample processing?

jirka

> 
> Maybe it's not very good to put block info setup/count/print in a call, but
> it's really not easy to process the block_info during the sample processing.
> 
> Thanks
> Jin Yao
> 
> > jirka
> > 
