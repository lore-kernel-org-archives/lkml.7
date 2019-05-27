Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE040C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69D02146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE0LsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:48:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfE0LsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:48:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A90AAE27;
        Mon, 27 May 2019 11:48:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9825ADA85C; Mon, 27 May 2019 13:49:14 +0200 (CEST)
Date:   Mon, 27 May 2019 13:49:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [btrfs] 2996e1f8bc: aim7.jobs-per-min -13.2% regression
Message-ID: <20190527114914.GG15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <rong.a.chen@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190527091719.GS19312@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527091719.GS19312@shao2-debian>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:17:19PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -13.2% regression of aim7.jobs-per-min due to commit:

That's interesting and worth an investigation. This should not happen,
the code is almost the same, moved from one function to another and the
call is direct. I'd suspect some low-level causes like cache effects or
branching, the perf-stats.i.* show some differences.

Other stats say (slabinfo.*extent_buffer) that there was less work over
the period. The slab object counter says that the object reuse was
higher in the bad case.

And there are many stats that show two digit difference, I'm trying to
make some sense of that, eg. if memory placement on NUMA nodes can
affect the speed of checksumming (changed by the patch)

So I wonder how reliable the test is and if it really does the same
thing in both cases or if there's some subtle change in the patch that
we've missed.
