Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A8CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B492086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392268AbfJWOwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:52:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:61706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390614AbfJWOwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:52:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="197443614"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2019 07:52:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 78A1F3009CA; Wed, 23 Oct 2019 07:52:06 -0700 (PDT)
Date:   Wed, 23 Oct 2019 07:52:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        alexey.budankov@linux.intel.com
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023145206.GH4660@tassilo.jf.intel.com>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
 <20191023095911.GJ22919@krava>
 <20191023130235.GF4660@tassilo.jf.intel.com>
 <20191023143049.GS22919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023143049.GS22919@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:30:49PM +0200, Jiri Olsa wrote:
> On Wed, Oct 23, 2019 at 06:02:35AM -0700, Andi Kleen wrote:
> > On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
> > > On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
> > > 
> > > SNIP
> > > 
> > > > +}
> > > > diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> > > > new file mode 100644
> > > > index 000000000000..e56148607e33
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/affinity.h
> > > > @@ -0,0 +1,15 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#ifndef AFFINITY_H
> > > > +#define AFFINITY_H 1
> > > > +
> > > > +struct affinity {
> > > > +	unsigned char *orig_cpus;
> > > > +	unsigned char *sched_cpus;
> > > 
> > > why not use cpu_set_t directly?
> > 
> > Because it's too small in glibc (only 1024 CPUs) and perf already 
> > supports more.
> 
> nice, we're using it all over the place.. how about using bitmap_alloc?

Okay.

The other places is mainly perf record from Alexey's recent affinity changes.
These probably need to be fixed.

+Alexey

And some stuff in bench/*. That's more nice to have.

-Andi
