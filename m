Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62075C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 10:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB092166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 10:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbfHCKsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 06:48:36 -0400
Received: from foss.arm.com ([217.140.110.172]:60062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbfHCKsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 06:48:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD29F344;
        Sat,  3 Aug 2019 03:48:34 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39443F71F;
        Sat,  3 Aug 2019 03:48:33 -0700 (PDT)
Date:   Sat, 3 Aug 2019 11:48:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190803104830.GB58477@iMac.local>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730130215.919b31c19df935cc5f1483e6@linux-foundation.org>
 <20190731154450.GB17773@arrakis.emea.arm.com>
 <20190801064153.GD11627@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801064153.GD11627@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:41:53AM +0200, Michal Hocko wrote:
> On Wed 31-07-19 16:44:50, Catalin Marinas wrote:
> > On Tue, Jul 30, 2019 at 01:02:15PM -0700, Andrew Morton wrote:
> > > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > Add mempool allocations for struct kmemleak_object and
> > > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > > under memory pressure. Additionally, mask out all the gfp flags passed
> > > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > > 
> > > > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > > > different minimum pool size (defaulting to NR_CPUS * 4).
> > > 
> > > btw, the checkpatch warnings are valid:
> > > 
> > > WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
> > > #70: FILE: mm/kmemleak.c:197:
> > > +static int min_object_pool = NR_CPUS * 4;
> > > 
> > > WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
> > > #71: FILE: mm/kmemleak.c:198:
> > > +static int min_scan_area_pool = NR_CPUS * 1;
> > > 
> > > There can be situations where NR_CPUS is much larger than
> > > num_possible_cpus().  Can we initialize these tunables within
> > > kmemleak_init()?
> > 
> > We could and, at least on arm64, cpu_possible_mask is already
> > initialised at that point. However, that's a totally made up number. I
> > think we would better go for a Kconfig option (defaulting to, say, 1024)
> > similar to the CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE and we grow it if
> > people report better values in the future.
> 
> If you really want/need to make this configurable then the command line
> parameter makes more sense - think of distribution kernel users for
> example.

I doubt you'd have pre-built distribution kernels with kmemleak enabled.

> But I am still not sure why this is really needed. The initial
> size is a "made up" number of course. There is no good estimation to
> make (without a crystal ball). The value might be increased based on
> real life usage.

We had a similar situation with the early log buffer (before slab is
initialised), initially 400 which was good enough for my needs (embedded
systems) but others had entirely different requirements. A configurable
(cmdline, Kconfig) option would make it easier for people to change,
especially if coupled with a meaningful suggestion in dmesg.

Another option is to use the early log as an emergency pool after
initialisation instead of freeing it (it's currently __initdata) and
drop the mempool idea. I may give this a go, at least we only have a
single Kconfig option.

-- 
Catalin
