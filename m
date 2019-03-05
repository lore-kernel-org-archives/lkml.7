Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52A20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCEQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:40:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:3749 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfCEQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:40:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 08:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="162434491"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 05 Mar 2019 08:40:17 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8B168301BC4; Tue,  5 Mar 2019 08:40:17 -0800 (PST)
Date:   Tue, 5 Mar 2019 08:40:17 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
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
Subject: Re: [PATCH 5/8] perf tools: Get precise_ip from the pmu config
Message-ID: <20190305164017.GD17272@tassilo.jf.intel.com>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305162854.GB4533@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:28:54PM +0100, Jiri Olsa wrote:
> On Tue, Mar 05, 2019 at 08:13:19AM -0800, Andi Kleen wrote:
> > On Tue, Mar 05, 2019 at 04:25:33PM +0100, Jiri Olsa wrote:
> > > Getting precise_ip field from the perf_pmu::max_precise
> > > config read from sysfs. If it's not available falling
> > > back to current detection function.
> > 
> > max_precise depends on the event.  This won't work for all
> > events. For example only instructions and cycles support
> > ppp
> 
> I'm getting  precise_ip=3 on mem-* events as well, that's why I
> was fixing this.. now it's not working for any event

I don't think it means anything for mem-*

There's some support for it on Goldmont plus for other events,
but it doesn't support mem-*. On big core it's only
for instructions and cycles, all implemented with the same
event. All other PEBS events only have two levels
switching between the two IPs.

-Andi
