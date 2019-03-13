Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726512171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCMJN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCMJNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C4A8309E975;
        Wed, 13 Mar 2019 09:13:25 +0000 (UTC)
Received: from krava (unknown [10.40.205.86])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D7205D9D3;
        Wed, 13 Mar 2019 09:13:23 +0000 (UTC)
Date:   Wed, 13 Mar 2019 10:13:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf, tools, report: Set up samples correctly in
 hierarchy mode
Message-ID: <20190313091322.GB30926@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-4-andi@firstfloor.org>
 <20190312111259.GA24700@krava>
 <20190312135230.bmjm4ynzrtwjf7cr@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312135230.bmjm4ynzrtwjf7cr@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 13 Mar 2019 09:13:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 06:52:30AM -0700, Andi Kleen wrote:
> On Tue, Mar 12, 2019 at 12:12:59PM +0100, Jiri Olsa wrote:
> > On Mon, Mar 11, 2019 at 08:52:24PM -0700, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > In hierarchy mode the res samples need to be cloned from the parent
> > > entry. Copy them in this case. This fixes res sample browsing
> > > with --hierarchy.
> > > 
> > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > > ---
> > >  tools/perf/util/hist.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 1f230285d78a..dcf24581dfbd 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
> > >  	}
> > >  
> > >  	if (symbol_conf.res_sample) {
> > > -		he->res_samples = calloc(sizeof(struct res_sample),
> > > -					symbol_conf.res_sample);
> > > +		if (he->res_samples) {
> > 
> > I dont think this leg will ever execute because we don't set
> > res_samples in template
> 
> I originally thought this too, but ...
> 
> The hierarchy mode calls it with a hist entry that is not
> a template.

right, forgot about this

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
