Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874AACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6645221872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405547AbfJWNCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:02:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:61271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403983AbfJWNCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:02:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="223176393"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 06:02:35 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 35B2830034D; Wed, 23 Oct 2019 06:02:35 -0700 (PDT)
Date:   Wed, 23 Oct 2019 06:02:35 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023130235.GF4660@tassilo.jf.intel.com>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
 <20191023095911.GJ22919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023095911.GJ22919@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
> On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
> 
> SNIP
> 
> > +}
> > diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> > new file mode 100644
> > index 000000000000..e56148607e33
> > --- /dev/null
> > +++ b/tools/perf/util/affinity.h
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#ifndef AFFINITY_H
> > +#define AFFINITY_H 1
> > +
> > +struct affinity {
> > +	unsigned char *orig_cpus;
> > +	unsigned char *sched_cpus;
> 
> why not use cpu_set_t directly?

Because it's too small in glibc (only 1024 CPUs) and perf already 
supports more.

-andi
