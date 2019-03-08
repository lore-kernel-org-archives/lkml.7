Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7A02087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCHPI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:08:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:47205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfCHPI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:08:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 07:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120809744"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 07:08:27 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6FE093015F7; Fri,  8 Mar 2019 07:08:27 -0800 (PST)
Date:   Fri, 8 Mar 2019 07:08:27 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Message-ID: <20190308150827.GH7535@tassilo.jf.intel.com>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-4-andi@firstfloor.org>
 <6d837d6b-da67-9878-dcc5-a2b0f2dc6826@intel.com>
 <20190307110231.GB8979@krava>
 <20190308133901.GB26260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308133901.GB26260@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:39:01AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 07, 2019 at 12:02:31PM +0100, Jiri Olsa escreveu:
> > On Wed, Mar 06, 2019 at 04:23:40PM +0200, Adrian Hunter wrote:
> > > On 5/03/19 4:47 PM, Andi Kleen wrote:
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > The --cpu option only filtered samples. Filter other perf events,
> > > > such as COMM, FORK, SWITCH by the CPU too.
> > > 
> > > Because tasks can migrate from cpu to cpu, we probably need to process most
> > > of the events anyway, even if they are not printed.
> > 
> > agreed, I wonder we could just make the perf_event__fprintf conditional
> 
> Humm, probably just do the filtering on PERF_RECORD_SAMPLE is enough?
> I.e. having the other PERF_RECORD_{COMM,MMAP,} etc is required in face
> of migration.

The goal was to only show the output for the correct CPU in the perf
sample context browser. Otherwise the output on larger systems
is very confusing because most of it is for irrelevant CPUs.

-andi
