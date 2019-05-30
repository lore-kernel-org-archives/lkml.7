Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD41C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190EE259B4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfE3NcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:32:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:47737 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfE3NcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:32:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:32:00 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2019 06:31:58 -0700
Date:   Thu, 30 May 2019 21:32:15 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [btrfs] 2996e1f8bc: aim7.jobs-per-min -13.2% regression
Message-ID: <20190530133215.GC22325@shao2-debian>
References: <20190527091719.GS19312@shao2-debian>
 <20190527114914.GG15290@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190527114914.GG15290@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:49:14PM +0200, David Sterba wrote:
> On Mon, May 27, 2019 at 05:17:19PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -13.2% regression of aim7.jobs-per-min due to commit:
> 
> That's interesting and worth an investigation. This should not happen,
> the code is almost the same, moved from one function to another and the
> call is direct. I'd suspect some low-level causes like cache effects or
> branching, the perf-stats.i.* show some differences.
> 
> Other stats say (slabinfo.*extent_buffer) that there was less work over
> the period. The slab object counter says that the object reuse was
> higher in the bad case.
> 
> And there are many stats that show two digit difference, I'm trying to
> make some sense of that, eg. if memory placement on NUMA nodes can
> affect the speed of checksumming (changed by the patch)
> 
> So I wonder how reliable the test is and if it really does the same
> thing in both cases or if there's some subtle change in the patch that
> we've missed.

Hi,

The test is unstable, we can't reproduce the issue. It's probably a false
positive, sorry for the inconvenience.

Best Regards,
Rong Chen
