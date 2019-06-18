Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A5AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="pO1ElnKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfFRKnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:43:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45758 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbfFRKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:43:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so20959092edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EiGfP218TyYVw3oIdFy9RKq7TADgpiAhaNHmeMUYr4k=;
        b=pO1ElnKQsOyzz/ort0DyFfwfmp1bAWRAuBwSI9NXrxnvwS1fp7AkRc9h7c4IDN9aSv
         88DrpiA05hwAwJUYfLiB2gIvc7eZ48VBG8eqmDmCi9NI8LeNM0eA0PEmEfa2hCjRvMTU
         +8xK55n6sUOfZlviscO6Q9v1tLSABAAWzWLUvodl9cqL8nMuWnSbcJzzcBy+2vNfWsvF
         YXEOTR/5a/pyt12CZKSrs7PEenI64xkaL2CAP7WA87dKvsKSVcQacxv0q34K/4SmiRKa
         x9vSyAUbFhG5UjNOhLSGaQ9/wN1zuXXKz5Nq/XRqGkL88RPFhx4ETYJQBKjUOhxIuKfv
         wIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EiGfP218TyYVw3oIdFy9RKq7TADgpiAhaNHmeMUYr4k=;
        b=DLUyo/XaxNQ472m0zDEyynN7oFKDWmi32u6DsNclMGJIjC/gibYL952ynK6GUwXS0O
         /J74TMNED2Suu6siP5ZZeJGqtie/5hva558a7XhSAT8zsc5dnLSskO2NU1WBjjUHbvqj
         Ac3UwSUM44K4Yr4jK+uDfDb6DAxKljR81Rb49o98OrFOy15XqXo8j5J9kYGX3EsxHha8
         +bwUIMiWPJNPf8O8YidKAHZT96yEYBIDBJcYANUavAsczcQuJhBThMZzanCV8K6V7+Wz
         n7LXxgT0G+P22Cr3wENZNi7RIvnyWs7avKiXHvN5Urm3wrCohqUqPDOw+PxpvYw0hcrY
         1HsA==
X-Gm-Message-State: APjAAAW+afH1qrIgiP/ujgCCBFjiCYyoTCd54lRsUC63FShJyl3hxE/M
        mRjdIP/Klg4/7twKnVh6nOr4Fw==
X-Google-Smtp-Source: APXvYqzfcVLq+uK/+F9zUZ+Q27F4RbbE1XwaPQ0EnXrPwVSblFMVNFmjlrqw15gn7Iss39OQ3In2lQ==
X-Received: by 2002:a17:906:451:: with SMTP id e17mr45052889eja.161.1560854601178;
        Tue, 18 Jun 2019 03:43:21 -0700 (PDT)
Received: from localhost ([94.1.151.203])
        by smtp.gmail.com with ESMTPSA id i6sm4670808eda.79.2019.06.18.03.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 03:43:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:43:19 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190618104319.GB4772@codeblueprint.co.uk>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun, at 05:22:21PM, Lendacky, Thomas wrote:
> On 6/10/19 4:26 PM, Matt Fleming wrote:
> > On Wed, 05 Jun, at 08:00:35PM, Peter Zijlstra wrote:
> >>
> >> And then we had two magic values :/
> >>
> >> Should we not 'fix' RECLAIM_DISTANCE for EPYC or something? Because
> >> surely, if we want to load-balance agressively over 30, then so too
> >> should we do node_reclaim() I'm thikning.
> > 
> > Yeah we can fix it just for EPYC, Mel suggested that approach originally.
> > 
> > Suravee, Tom, what's the best way to detect these EPYC machines that need to
> > override RECLAIM_DISTANCE?
> 
> You should be able to do it based on the family. There's an init_amd_zn()
> function in arch/x86/kernel/cpu/amd.c.  You can add something there or,
> since init_amd_zn() sets X86_FEATURE_ZEN, you could check for that if you
> prefer putting it in a different location.

This works for me under all my tests. Thoughts?

--->8---

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 80a405c2048a..4db4e9e7654b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/random.h>
+#include <linux/topology.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
@@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
+	node_reclaim_distance = 32;
+
 	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
 	if (!cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..74b484354ac9 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -59,6 +59,9 @@ int arch_update_cpu_topology(void);
  */
 #define RECLAIM_DISTANCE 30
 #endif
+
+extern int __read_mostly node_reclaim_distance;
+
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f53f89df837d..20f0f8f6792b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1284,6 +1284,7 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
+int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 #endif
 
 /*
@@ -1410,7 +1411,7 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
-		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
+		if (sched_domains_numa_distance[tl->numa_level] > node_reclaim_distance) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
 				       SD_WAKE_AFFINE);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a335f7c1fac4..67f5f09d70ed 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -710,7 +710,7 @@ static bool khugepaged_scan_abort(int nid)
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (!khugepaged_node_load[i])
 			continue;
-		if (node_distance(nid, i) > RECLAIM_DISTANCE)
+		if (node_distance(nid, i) > node_reclaim_distance)
 			return true;
 	}
 	return false;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..8ccaaf3a47f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3450,7 +3450,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
-				RECLAIM_DISTANCE;
+				node_reclaim_distance;
 }
 #else	/* CONFIG_NUMA */
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
