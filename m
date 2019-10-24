Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1782173B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437289AbfJXDdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:33:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:31425 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392870AbfJXDdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:33:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 20:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,223,1569308400"; 
   d="scan'208";a="188457716"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2019 20:33:13 -0700
Date:   Thu, 24 Oct 2019 11:33:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191024033313.GA42124@shbuild999.sh.intel.com>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
 <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
 <1571842093.5937.84.camel@lca.pw>
 <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:01:04PM +0800, Waiman Long wrote:
> On 10/23/19 10:48 AM, Qian Cai wrote:
> >>> this still isn't a bulletproof fix.  Maybe just terminate the list
> >>> walk if freecount reaches 1024.  Would anyone really care?
> >>>
> >>> Sigh.  I wonder if anyone really uses this thing for anything
> >>> important.  Can we just remove it all?
> >>>
> >> Removing it will be a breakage of kernel API.
> > Who cares about breaking this part of the API that essentially nobody will use
> > this file?
> >
> There are certainly tools that use /proc/pagetypeinfo and this is how
> the problem is found. I am not against removing it, but we have to be
> careful and deprecate it in way that minimize user impact.

We have been using the /proc/pagetypeinfo for debugging, mainly for
client platforms like phones/tablets. We met problems like very slow
system response or OOM things, and many of them could be related with
memory pressure or fragmentation issues, where monitoring /proc/pagetypeinfo
will be very useful for debugging.

So I think Michal's idea to change it to 0400 is a good idea.

Thanks,
Feng

 
> Cheers,
> Longman
> 
> 
