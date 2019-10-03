Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A260AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0882133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfJCIlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfJCIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:41:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EEAD28;
        Thu,  3 Oct 2019 01:41:38 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C4C3F739;
        Thu,  3 Oct 2019 01:41:37 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:41:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 1/3] mm: kmemleak: Make the tool tolerant to struct
 scan_area allocation failures
Message-ID: <20191003084135.GA21629@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-2-catalin.marinas@arm.com>
 <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:13:07PM +1000, Alexey Kardashevskiy wrote:
> On 13/08/2019 02:06, Catalin Marinas wrote:
> > Object scan areas are an optimisation aimed to decrease the false
> > positives and slightly improve the scanning time of large objects known
> > to only have a few specific pointers. If a struct scan_area fails to
> > allocate, kmemleak can still function normally by scanning the full
> > object.
> > 
> > Introduce an OBJECT_FULL_SCAN flag and mark objects as such when
> > scan_area allocation fails.
> 
> I came across this one while bisecting sudden drop in throughput of a
> 100Gbit Mellanox CX4 ethernet card in a PPC POWER9 system, the speed
> dropped from 100Gbit to about 40Gbit. Bisect pointed at dba82d943177,
> this are the relevant config options:
> 
> [fstn1-p1 kernel]$ grep KMEMLEAK ~/pbuild/kernel-le-4g/.config
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y

The throughput drop is probably caused caused by kmemleak slowing down
all memory allocations (including skb). So that's expected. You may get
similar drop with other debug options like lock proving, kasan.

> Setting CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400 or even 4000 (this is
> what KMEMLEAK_EARLY_LOG_SIZE is now in the master) produces soft
> lockups on the recent upstream (sha1 a3c0e7b1fe1f):
> 
> [c000001fde64fb60] [c000000000c24ed4] _raw_write_unlock_irqrestore+0x54/0x70
> [c000001fde64fb90] [c0000000004117e4] find_and_remove_object+0xa4/0xd0
> [c000001fde64fbe0] [c000000000411c74] delete_object_full+0x24/0x50
> [c000001fde64fc00] [c000000000411d28] __kmemleak_do_cleanup+0x88/0xd0
> [c000001fde64fc40] [c00000000012a1a4] process_one_work+0x374/0x6a0
> [c000001fde64fd20] [c00000000012a548] worker_thread+0x78/0x5a0
> [c000001fde64fdb0] [c000000000135508] kthread+0x198/0x1a0
> [c000001fde64fe20] [c00000000000b980] ret_from_kernel_thread+0x5c/0x7c

That's the kmemleak disabling path. I don't have the full log but I
suspect by setting a small pool size, kmemleak failed to allocate memory
and went into disabling itself. The clean-up above tries to remove the
allocated metadata. It seems that it takes significant time on your
platform. Not sure how to avoid the soft lock-up but I wouldn't bother
too much about it, it's only triggered by a previous error condition
disabling kmemleak.

> KMEMLEAK_EARLY_LOG_SIZE=8000 works but slow.
> 
> Interestingly KMEMLEAK_EARLY_LOG_SIZE=400 on dba82d943177 still worked
> and I saw my 100Gbit. Disabling KMEMLEAK also fixes the speed
> (apparently).

A small memory pool for kmemleak just disables it shortly after boot, so
it's no longer in the way and you get your throughput back.

> Is that something expected? Thanks,

Yes for the throughput. Not sure about the soft lock-up. Do you have the
full log around the lock-up?

-- 
Catalin
