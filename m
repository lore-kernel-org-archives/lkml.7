Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2293FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919A32168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfJPMx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfJPMx2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBE87A3CD82;
        Wed, 16 Oct 2019 12:53:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id C975E1001B08;
        Wed, 16 Oct 2019 12:53:25 +0000 (UTC)
Date:   Wed, 16 Oct 2019 14:53:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191016125325.GA10222@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
 <20191015084102.GA10951@krava>
 <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
 <20191016101543.GC15580@krava>
 <456b8e97-dc50-449c-9999-0bddef0e9c4c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456b8e97-dc50-449c-9999-0bddef0e9c4c@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 12:53:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:51:07PM +0800, Jin, Yao wrote:
> 
> 
> On 10/16/2019 6:15 PM, Jiri Olsa wrote:
> > On Tue, Oct 15, 2019 at 10:53:18PM +0800, Jin, Yao wrote:
> > 
> > SNIP
> > 
> > > > > +static struct block_header_column{
> > > > > +	const char *name;
> > > > > +	int width;
> > > > > +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
> > > > > +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV] = {
> > > > > +		.name = "Sampled Cycles%",
> > > > > +		.width = 15,
> > > > > +	},
> > > > > +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
> > > > > +		.name = "Sampled Cycles",
> > > > > +		.width = 14,
> > > > > +	},
> > > > > +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
> > > > > +		.name = "Avg Cycles%",
> > > > > +		.width = 11,
> > > > > +	},
> > > > > +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
> > > > > +		.name = "Avg Cycles",
> > > > > +		.width = 10,
> > > > > +	},
> > > > > +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
> > > > > +		.name = "[Program Block Range]",
> > > > > +		.width = 70,
> > > > > +	},
> > > > > +	[PERF_HPP_REPORT__BLOCK_DSO] = {
> > > > > +		.name = "Shared Object",
> > > > > +		.width = 20,
> > > > > +	}
> > > > >    };
> > > > 
> > > > so we already have support for multiple columns,
> > > > why don't you add those as 'struct sort_entry' objects?
> > > > 
> > > 
> > > For 'struct sort_entry' objects, do you mean I should reuse the "sort_dso"
> > > which has been implemented yet in util/sort.c?
> > > 
> > > For other columns, it looks we can't reuse the existing sort_entry objects.
> > 
> > I did not mean reuse, just add new sort entries
> > to current sort framework
> > 
> 
> Does it seem like what the c2c does?

well c2c has its own data output with multiline column titles,
hence it has its own separate dimension stuff, but your code
output is within the standard perf report right? single column
output.. why couldn't you use just sort_entry ?

jirka
