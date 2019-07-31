Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A5FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3301E206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfGaJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:54:01 -0400
Received: from foss.arm.com ([217.140.110.172]:43700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:54:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D67D0337;
        Wed, 31 Jul 2019 02:53:59 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50EE3F71F;
        Wed, 31 Jul 2019 02:53:58 -0700 (PDT)
Date:   Wed, 31 Jul 2019 10:53:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731095355.GC63307@arrakis.emea.arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
 <1564518157.11067.34.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564518157.11067.34.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:22:37PM -0400, Qian Cai wrote:
> On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com>
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2011,6 +2011,12 @@
> > >  			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
> > >  			the default is off.
> > >  
> > > +	kmemleak.mempool=
> > > +			[KNL] Boot-time tuning of the minimum kmemleak
> > > +			metadata pool size.
> > > +			Format: <int>
> > > +			Default: NR_CPUS * 4
> > > +
> 
> Catalin, BTW, it is right now unable to handle a large size. I tried to reserve
> 64M (kmemleak.mempool=67108864),
> 
> [    0.039254][    T0] WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:4707 __alloc_pages_nodemask+0x3b8/0x1780
[...]
> [    0.039646][    T0] NIP [c000000000395038] __alloc_pages_nodemask+0x3b8/0x1780
> [    0.039693][    T0] LR [c0000000003d9320] kmalloc_large_node+0x100/0x1a0
> [    0.039727][    T0] Call Trace:
> [    0.039795][    T0] [c00000000170fc80] [c0000000003e5080] __kmalloc_node+0x520/0x890
> [    0.039816][    T0] [c00000000170fd20] [c0000000002e9544] mempool_init_node+0xb4/0x1e0
> [    0.039836][    T0] [c00000000170fd80] [c0000000002e975c] mempool_create_node+0xcc/0x150
> [    0.039857][    T0] [c00000000170fdf0] [c000000000b2a730] kmemleak_init+0x16c/0x54c
> [    0.039878][    T0] [c00000000170fef0] [c000000000ae460c] start_kernel+0x69c/0x7cc
> [    0.039908][    T0] [c00000000170ff90] [c00000000000a7d4] start_here_common+0x1c/0x434
[...]
> [    0.040100][    T0] kmemleak: Kernel memory leak detector disabled

It looks like the mempool cannot be created. 64M objects means a
kmalloc(512MB) for the pool array in mempool_init_node(), so that hits
the MAX_ORDER warning in __alloc_pages_nodemask().

Maybe the mempool tunable won't help much for your case if you need so
many objects. It's still worth having a mempool for kmemleak but we
could look into changing the refill logic while keeping the original
size constant (say 1024 objects).

> [   16.192449][    T1] BUG: Unable to handle kernel data access at 0xffffffffffffb2aa

This doesn't seem kmemleak related from the trace.

-- 
Catalin
