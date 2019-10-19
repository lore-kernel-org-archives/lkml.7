Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F4721897
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571449239;
	bh=g2s7DIla01Hjq/ujtCCOV9iLU60FNUozPmziSr01GAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sm2G6xuw+iURVpFZJnj/srIpshwqwPu9GjRb+umzKr4bKzCQEC6E5Ql+0vtSD294C
	 StQzIsrFjobygGhSEljmIKIj96As/tofwsWwxVrtZh+INen4hkpoFra6x7LQKbDH+b
	 77cvy1KBTp3ns5qOvAk7bl7q1tT5o6Tjz2HZfBug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfJSBk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 21:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfJSBk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 21:40:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE1C21897;
        Sat, 19 Oct 2019 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571449224;
        bh=g2s7DIla01Hjq/ujtCCOV9iLU60FNUozPmziSr01GAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXRNUGRTCrrH1kM4V1G0z4mK+A4NqvpQnalanUdSuAz05Ko+0QKs/a1q1fIgVLaoL
         QPncMLbw2xT32S4J2L7OsewKlJfObhx9Dw6HO3X7DmBe526Jr9i0Cek0wcFGqGOIve
         JpiBTl0RB9y8VWLn8yFlgnhmXD5xJfvtaj0g+Fvw=
Date:   Fri, 18 Oct 2019 18:40:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-Id: <20191018184024.2bb1a69997a9365c5d4ccf1c@linux-foundation.org>
In-Reply-To: <20191018140959.GK3321@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
        <20191018105606.3249-3-mgorman@techsingularity.net>
        <20191018130127.GP5017@dhcp22.suse.cz>
        <20191018140959.GK3321@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 15:09:59 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> > > Cc: stable@vger.kernel.org # v4.15+
> > 
> > Hmm, are you sure about 4.15? Doesn't this go all the way down to
> > deferred initialization? I do not see any recent changes on when
> > setup_per_cpu_pageset is called.
> > 
> 
> No, I'm not 100% sure. It looks like this was always an issue from the
> code but did not happen on at least one 4.12-based distribution kernel for
> reasons that are non-obvious. Either way, the tag should have been "v4.1+"

I could mark

mm-pcp-share-common-code-between-memory-hotplug-and-percpu-sysctl-handler.patch
mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch

as Cc: <stable@vger.kernel.org>	[4.1+]

But for backporting purposes it's a bit cumbersome that [2/3] is the
important patch.  I think I'll switch the ordering so that
mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
is the first patch and the other two can be queued for 5.5-rc1, OK?

Also, is a Reported-by:Matt appropriate here?


From: Mel Gorman <mgorman@techsingularity.net>
Subject: mm, meminit: recalculate pcpu batch and high limits after init completes

Deferred memory initialisation updates zone->managed_pages during the
initialisation phase but before that finishes, the per-cpu page allocator
(pcpu) calculates the number of pages allocated/freed in batches as well
as the maximum number of pages allowed on a per-cpu list.  As
zone->managed_pages is not up to date yet, the pcpu initialisation
calculates inappropriately low batch and high values.

This increases zone lock contention quite severely in some cases with the
degree of severity depending on how many CPUs share a local zone and the
size of the zone.  A private report indicated that kernel build times were
excessive with extremely high system CPU usage.  A perf profile indicated
that a large chunk of time was lost on zone->lock contention.

This patch recalculates the pcpu batch and high values after deferred
initialisation completes on each node.  It was tested on a 2-socket AMD
EPYC 2 machine using a kernel compilation workload -- allmodconfig and all
available CPUs.

mmtests configuration: config-workload-kernbench-max Configuration was
modified to build on a fresh XFS partition.

kernbench
                                5.4.0-rc3              5.4.0-rc3
                                  vanilla         resetpcpu-v1r1
Amean     user-256    13249.50 (   0.00%)    15928.40 * -20.22%*
Amean     syst-256    14760.30 (   0.00%)     4551.77 *  69.16%*
Amean     elsp-256      162.42 (   0.00%)      118.46 *  27.06%*
Stddev    user-256       42.97 (   0.00%)       50.83 ( -18.30%)
Stddev    syst-256      336.87 (   0.00%)       33.70 (  90.00%)
Stddev    elsp-256        2.46 (   0.00%)        0.81 (  67.01%)

                   5.4.0-rc3   5.4.0-rc3
                     vanillaresetpcpu-v1r1
Duration User       39766.24    47802.92
Duration System     44298.10    13671.93
Duration Elapsed      519.11      387.65

The patch reduces system CPU usage by 69.16% and total build time by
27.06%.  The variance of system CPU usage is also much reduced.

Link: http://lkml.kernel.org/r/20191018105606.3249-3-mgorman@techsingularity.net
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Matt Fleming <matt@codeblueprint.co.uk>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <stable@vger.kernel.org>	[4.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c~mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes
+++ a/mm/page_alloc.c
@@ -1818,6 +1818,14 @@ static int __init deferred_init_memmap(v
 	 */
 	while (spfn < epfn)
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+
+	/*
+	 * The number of managed pages has changed due to the initialisation
+	 * so the pcpu batch and high limits needs to be updated or the limits
+	 * will be artificially small.
+	 */
+	zone_pcp_update(zone);
+
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
@@ -8514,7 +8522,6 @@ void free_contig_range(unsigned long pfn
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
  * page high values need to be recalulated.
@@ -8528,7 +8535,6 @@ void __meminit zone_pcp_update(struct zo
 				per_cpu_ptr(zone->pageset, cpu));
 	mutex_unlock(&pcp_batch_high_lock);
 }
-#endif
 
 void zone_pcp_reset(struct zone *zone)
 {
_

