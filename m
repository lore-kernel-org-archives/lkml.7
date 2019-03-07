Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F47C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FD620851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfCGPoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:44:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfCGPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:44:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84B83AA71;
        Thu,  7 Mar 2019 15:44:21 +0000 (UTC)
Received: from shadow.suse.cz (shadow.suse.cz [10.100.13.111])
        by dark.suse.cz (Postfix) with ESMTP id 480F312CC0A;
        Thu,  7 Mar 2019 16:44:21 +0100 (CET)
Received: by shadow.suse.cz (Postfix, from userid 10002)
        id 3E0F744700; Thu,  7 Mar 2019 16:44:21 +0100 (CET)
Date:   Thu, 7 Mar 2019 16:44:21 +0100
From:   Vojtech Pavlik <vojtech@suse.com>
To:     Coly Li <colyli@suse.de>
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
Message-ID: <20190307154421.GA8829@suse.cz>
References: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
 <24916a71-39ff-7324-ad12-9d79cc68d0da@suse.de>
 <3640cd7f-f32a-1509-dbef-6000b6e14e75@linux.alibaba.com>
 <c421d715-6d14-a6f0-907b-644318120c8e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c421d715-6d14-a6f0-907b-644318120c8e@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:36:18PM +0800, Coly Li wrote:
> On 2019/3/7 11:06 下午, Shile Zhang wrote:
> > 
> > On 2019/3/7 18:34, Coly Li wrote:
> >> On 2019/3/7 1:15 下午, shile.zhang@linux.alibaba.com wrote:
> >>> From: Shile Zhang <shile.zhang@linux.alibaba.com>
> >>>
> >>> Read /sys/fs/bcache/<uuid>/cacheN/priority_stats can take very long
> >>> time with huge cache after long run.
> >>>
> >>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> >> Hi Shile,
> >>
> >> Do you test your change ? It will be helpful with more performance data
> >> (what problem that you improved).
> > 
> > In case of 960GB SSD cache device, once read of the 'priority_stats'
> > costs about 600ms in our test environment.
> > 
> 
> After the fix, how much time it takes ?
> 
> 
> > The perf tool shown that near 50% CPU time consumed by 'sort()', this
> > means once sort will hold the CPU near 300ms.
> > 
> > In our case, the statistics collector reads the 'priority_stats'
> > periodically, it will trigger the schedule latency jitters of the
> > 
> > task which shared same CPU core.
> > 
> 
> Hmm, it seems you just make the sort slower, and nothing more changes.
> Am I right ?

Well, it has to make the sort slower, but it'll also avoid hogging the
CPU (on a non-preemptible kernel), avoiding a potential soft lockup
warning and allowing other tasks to run.

-- 
Vojtech Pavlik
VP SUSE Labs
