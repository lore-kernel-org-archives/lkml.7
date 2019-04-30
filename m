Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CFDC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055C120652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfD3JSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:18:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:4844 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfD3JSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:18:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 02:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="146944618"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2019 02:18:46 -0700
Date:   Tue, 30 Apr 2019 17:22:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] latencytop lock usage improvement
Message-ID: <20190430092248.b7ztl733nhu7acjd@shbuild888>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
 <20190430080910.GI2623@hirez.programming.kicks-ass.net>
 <20190430083505.n5mozwybbnwydo3z@shbuild888>
 <20190430091033.GN2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430091033.GN2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Apr 30, 2019 at 11:10:33AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 04:35:05PM +0800, Feng Tang wrote:
> > Hi Peter,
> > 
> > On Tue, Apr 30, 2019 at 10:09:10AM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 29, 2019 at 04:03:28PM +0800, Feng Tang wrote:
> > > > Hi All,
> > > > 
> > > > latencytop is a very nice tool for tracing system latency hotspots, and
> > > > we heavily use it in our LKP test suites.
> > > 
> > > What data does latency-top give that perf cannot give you? Ideally we'd
> > > remove latencytop entirely.
> > 
> > Thanks for the review. In 0day/LKP test service, we have many tools for
> > monitoring and analyzing the test results, perf is the most important
> > one, which has the most parts in our auto-generated comparing results.   
> > For example to identify spinlock contentions and system hotspots.
> > 
> > latencytop is another tool we used to find why systems go idle, like why
> > workload chose to sleep or waiting for something. 
> 
> You're not answering the question; why can't you use perf for that? ISTR
> we explicitly added support for things like that.

I was not very familiar with perf before. And after my last reply,
I googled a little, and found "perf sched latency" has the simliar
function, except I can't directly get the call chain, any suggestion
for this? thanks!

- Feng

