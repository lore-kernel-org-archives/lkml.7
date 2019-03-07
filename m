Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3901E2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGWcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGWcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:32:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 209EA36807;
        Thu,  7 Mar 2019 22:32:51 +0000 (UTC)
Received: from krava (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1662310018F9;
        Thu,  7 Mar 2019 22:32:47 +0000 (UTC)
Date:   Thu, 7 Mar 2019 23:32:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCHv2 5/8] perf tools: Get precise_ip from the pmu config
Message-ID: <20190307223246.GA16788@krava>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
 <20190307153500.GC29474@krava>
 <20190307165123.GE7535@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165123.GE7535@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 22:32:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:51:23AM -0800, Andi Kleen wrote:
> On Thu, Mar 07, 2019 at 04:35:00PM +0100, Jiri Olsa wrote:
> > On Tue, Mar 05, 2019 at 08:40:17AM -0800, Andi Kleen wrote:
> > > On Tue, Mar 05, 2019 at 05:28:54PM +0100, Jiri Olsa wrote:
> > > > On Tue, Mar 05, 2019 at 08:13:19AM -0800, Andi Kleen wrote:
> > > > > On Tue, Mar 05, 2019 at 04:25:33PM +0100, Jiri Olsa wrote:
> > > > > > Getting precise_ip field from the perf_pmu::max_precise
> > > > > > config read from sysfs. If it's not available falling
> > > > > > back to current detection function.
> > > > > 
> > > > > max_precise depends on the event.  This won't work for all
> > > > > events. For example only instructions and cycles support
> > > > > ppp
> > > > 
> > > > I'm getting  precise_ip=3 on mem-* events as well, that's why I
> > > > was fixing this.. now it's not working for any event
> > > 
> > > I don't think it means anything for mem-*
> > > 
> > > There's some support for it on Goldmont plus for other events,
> > > but it doesn't support mem-*. On big core it's only
> > > for instructions and cycles, all implemented with the same
> > > event. All other PEBS events only have two levels
> > > switching between the two IPs.
> > 
> > ok, so how about this, it's the change I posted merged with the patch
> 
> Still seems like a hack. Even though I don't know of a case that
> would break now. But it would be better to have the precise probing
> in the open retry loop, instead of trying to reinvent it here.

right, I guess we could just set precise_ip hard to 3 for :P
and add fallback part for the precise_ip in perf_evsel__open

jirka
