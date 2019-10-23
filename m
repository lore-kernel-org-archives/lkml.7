Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E40CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7657021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="QmuG8/iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfJWRTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:19:08 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53264 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfJWRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:19:08 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id B8BB486932; Wed, 23 Oct 2019 19:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1571851144;
        bh=opp/GfOXhFo6b96viRcisk/YU8FVOGPwNP//I6JaG8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmuG8/iXoEtSbueaY+lGIlauFNsqmmr4toPxCJXDd9r3LStZAYGdChmQErpiZQ+y2
         sp6QcKgnCFHFuhbdvfntEVpIiD7iI+kYunN6JJyBkCU/UM4IU0kuLH7D+oTs2CB/Bo
         Rv56q/GiQk2PdQaLJDdWHz4jjEmn80Z2UCnECho8=
Date:   Wed, 23 Oct 2019 10:19:04 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023171904.ft735ormkro6tahp@two.firstfloor.org>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
 <20191023095911.GJ22919@krava>
 <20191023130235.GF4660@tassilo.jf.intel.com>
 <20191023143049.GS22919@krava>
 <20191023145206.GH4660@tassilo.jf.intel.com>
 <6ac1024c-bc73-87cd-31d2-819abee60137@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac1024c-bc73-87cd-31d2-819abee60137@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 07:16:13PM +0300, Alexey Budankov wrote:
> 
> On 23.10.2019 17:52, Andi Kleen wrote:
> > On Wed, Oct 23, 2019 at 04:30:49PM +0200, Jiri Olsa wrote:
> >> On Wed, Oct 23, 2019 at 06:02:35AM -0700, Andi Kleen wrote:
> >>> On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
> >>>> On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
> >>>>
> >>>> SNIP
> >>>>
> >>>>> +}
> >>>>> diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> >>>>> new file mode 100644
> >>>>> index 000000000000..e56148607e33
> >>>>> --- /dev/null
> >>>>> +++ b/tools/perf/util/affinity.h
> >>>>> @@ -0,0 +1,15 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +#ifndef AFFINITY_H
> >>>>> +#define AFFINITY_H 1
> >>>>> +
> >>>>> +struct affinity {
> >>>>> +	unsigned char *orig_cpus;
> >>>>> +	unsigned char *sched_cpus;
> >>>>
> >>>> why not use cpu_set_t directly?
> >>>
> >>> Because it's too small in glibc (only 1024 CPUs) and perf already 
> >>> supports more.
> >>
> >> nice, we're using it all over the place.. how about using bitmap_alloc?
> > 
> > Okay.
> > 
> > The other places is mainly perf record from Alexey's recent affinity changes.
> > These probably need to be fixed.
> > 
> > +Alexey
> 
> Despite the issue indeed looks generic for stat and record modes,
> have you already observed record startup overhead somewhere in your setups?
> I would, first, prefer to reproduce the overhead, to have stable use case 
> for evaluation and then, possibly, improvement.

What I meant the cpu_set usages you added in 

commit 9d2ed64587c045304efe8872b0258c30803d370c
Author: Alexey Budankov <alexey.budankov@linux.intel.com>
Date:   Tue Jan 22 20:47:43 2019 +0300

    perf record: Allocate affinity masks

need to be fixed to allocate dynamically, or at least use MAX_NR_CPUs to
support systems with >1024CPUs. That's an independent functionality
problem.

I haven't seen any large enough perf record usage to run
into the IPI problems for record.

-Andi
