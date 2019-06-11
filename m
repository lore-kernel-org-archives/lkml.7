Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB66A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbfFKI4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403860AbfFKI4J (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:56:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FA0730842AC;
        Tue, 11 Jun 2019 08:56:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93E795D72A;
        Tue, 11 Jun 2019 08:56:07 +0000 (UTC)
Date:   Tue, 11 Jun 2019 10:56:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190611085606.GA11510@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
 <20190605114417.GB5868@krava>
 <4bbc5085-c8b0-5e36-419c-6ee754186027@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bbc5085-c8b0-5e36-419c-6ee754186027@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 11 Jun 2019 08:56:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 07:41:47PM +0800, Jin, Yao wrote:
> 
> 
> On 6/5/2019 7:44 PM, Jiri Olsa wrote:
> > On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > > index 43623fa..d1641da 100644
> > > --- a/tools/perf/util/sort.h
> > > +++ b/tools/perf/util/sort.h
> > > @@ -79,6 +79,9 @@ struct hist_entry_diff {
> > >   		/* HISTC_WEIGHTED_DIFF */
> > >   		s64	wdiff;
> > > +
> > > +		/* PERF_HPP_DIFF__CYCLES */
> > > +		s64	cycles;
> > >   	};
> > >   };
> > > @@ -143,6 +146,9 @@ struct hist_entry {
> > >   	struct branch_info	*branch_info;
> > >   	long			time;
> > >   	struct hists		*hists;
> > > +	void			*block_hists;
> > > +	int			block_idx;
> > > +	int			block_num;
> > >   	struct mem_info		*mem_info;
> > >   	struct block_info	*block_info;
> > 
> > could you please not add the new block* stuff in here,
> > and instead use the "c2c model" and use yourr own struct
> > on top of hist_entry? we are trying to librarize this
> > stuff and keep only necessary things in here..
> > 
> > you're already using hist_entry_ops, so should be easy
> > 
> > something like:
> > 
> > 	struct block_hist_entry {
> > 		void			*block_hists;
> > 		int			block_idx;
> > 		int			block_num;
> > 		struct block_info	*block_info;
> > 
> > 		struct hist_entry	he;
> > 	};
> > 
> > 
> > 
> > jirka
> > 
> 
> Hi Jiri,
> 
> After more considerations, maybe I can't move these stuffs from hist_entry
> to block_hist_entry.

why?

> 
> Actually we use 2 kinds of hist_entry in this patch series. On kind of
> hist_entry is for symbol/function. The other kind of hist_entry is for basic
> block.

correct

so the way I see it the processing goes like this:


1) there's standard hist_entry processing ending up
   with evsel->hists->rb_root full of hist entries

2) then you process every hist_entry and create
   new 'struct hists' for each and fill it with
   symbol counts data



you could add 'struct hist_entry_ops' for the 1) processing
that adds the 'struct hists' object for each hist_entry

and add another 'struct hist_entry_ops' for 2) processing
to carry the block data for each hist_entry

jirka
