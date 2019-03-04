Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842982054F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfCDOsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfCDOsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52BC43001974;
        Mon,  4 Mar 2019 14:48:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id A06B55D6B3;
        Mon,  4 Mar 2019 14:48:48 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304144848.GK30476@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
 <20190225125615.GI19795@krava>
 <20190225133335.GM16922@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225133335.GM16922@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 04 Mar 2019 14:48:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 05:33:35AM -0800, Andi Kleen wrote:
> On Mon, Feb 25, 2019 at 01:56:15PM +0100, Jiri Olsa wrote:
> > On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:
> > 
> > SNIP
> > 
> > > +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> > > +{
> > > +	struct res_sample *r;
> > > +	int j;
> > > +
> > > +	if (!he->res_samples) {
> > > +		he->res_samples = calloc(sizeof(struct res_sample),
> > > +					symbol_conf.res_sample);
> > > +		if (!he->res_samples)
> > > +			return;
> > > +	}
> > > +	if (he->num_res < symbol_conf.res_sample) {
> > > +		j = he->num_res++;
> > > +	} else {
> > > +		j = random_max(++he->num_res + 1);
> > 
> > will he->num_res keep raising all the time?
> 
> Yes, but the display code limits it to symbol_conf.res_samples
> 
> That was intentional so that we can keep track of the total
> number of samples. Plan was to eventually display it somewhere
> so that the users know how many of the samples are covered
> (currently it is not though) 

if it's not use please change it, so it's not confusing
also there's hist_entry::stat.nr_events for that

jirka
