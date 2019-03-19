Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5568C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75667206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfCSQDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:03:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:65286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfCSQDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:03:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 09:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="330022091"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 09:03:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 44B2C301BB6; Tue, 19 Mar 2019 09:03:37 -0700 (PDT)
Date:   Tue, 19 Mar 2019 09:03:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190319160337.GW24002@tassilo.jf.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-4-kan.liang@linux.intel.com>
 <20190319144748.GH5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319144748.GH5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:47:48PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 02:41:25PM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Adaptive PEBS is a new way to report PEBS sampling information. Instead
> > of a fixed size record for all PEBS events it allows to configure the
> > PEBS record to only include the information needed. Events can then opt
> > in to use such an extended record, or stay with a basic record which
> > only contains the IP.
> > 
> > The major new feature is to support LBRs in PEBS record.
> > This allows (much faster) large PEBS, while still supporting callstacks
> > through callstack LBR. 
> 
> Does it also allow normal LBR usage? Or does it have to be callstacks?

It allows normal LBR too. But I would expect callstack to be the most
common one.  As long as you set a period you can get multi-record
PEBS with -g, which has a lot lower lower overhead than using
PMIs.

Eventually I hope we can even make multi-record PEBS
work in frequency mode by averaging the frequency over multiple
records.


> >  	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> > +	hwc->config &= ~ICL_EVENTSEL_ADAPTIVE;
> 
> Just curious; the way I read the SDM, we could leave this set, is that
> correct?

It needs to be cleared to get the basic record (which should be
a common case)

-Andi
