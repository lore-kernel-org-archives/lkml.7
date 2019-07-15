Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A954C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE7206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbfGOVYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:24:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730076AbfGOVYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:24:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BAF6AE16;
        Mon, 15 Jul 2019 21:24:13 +0000 (UTC)
Message-ID: <1563225851.3143.24.camel@suse.de>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
From:   Oscar Salvador <osalvador@suse.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Jul 2019 23:24:11 +0200
In-Reply-To: <87tvbne0rd.fsf@linux.ibm.com>
References: <20190715081549.32577-1-osalvador@suse.de>
         <20190715081549.32577-3-osalvador@suse.de> <87tvbne0rd.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 21:41 +0530, Aneesh Kumar K.V wrote:
> Oscar Salvador <osalvador@suse.de> writes:
> 
> > Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION
> > granularity.
> > The problem is that deactivation of the section occurs later on in
> > sparse_remove_section, so pfn_valid()->pfn_section_valid() will
> > always return
> > true before we deactivate the {sub}section.
> 
> Can you explain this more? The patch doesn't update section_mem_map
> update sequence. So what changed? What is the problem in finding
> pfn_valid() return true there?

I realized that the changelog was quite modest, so a better explanation
 will follow.

Let us analize what shrink_{zone,node}_span does.
We have to remember that shrink_zone_span gets called every time a
section is to be removed.

There can be three possibilites:

1) section to be removed is the first one of the zone
2) section to be removed is the last one of the zone
3) section to be removed falls in the middle
 
For 1) and 2) cases, we will try to find the next section from
bottom/top, and in the third case we will check whether the section
contains only holes.

Now, let us take the example where a ZONE contains only 1 section, and
we remove it.
The last loop of shrink_zone_span, will check for {start_pfn,end_pfn]
PAGES_PER_SECTION block the following:

- section is valid
- pfn relates to the current zone/nid
- section is not the section to be removed

Since we only got 1 section here, the check "start_pfn == pfn" will make us to continue the loop and then we are done.

Now, what happens after the patch?

We increment pfn on subsection basis, since "start_pfn == pfn", we jump
to the next sub-section (pfn+512), and call pfn_valid()-
>pfn_section_valid().
Since section has not been yet deactivded, pfn_section_valid() will
return true, and we will repeat this until the end of the loop.

What should happen instead is:

- we deactivate the {sub}-section before calling
shirnk_{zone,node}_span
- calls to pfn_valid() will now return false for the sections that have
been deactivated, and so we will get the pfn from the next activaded
sub-section, or nothing if the section is empty (section do not contain
active sub-sections).

The example relates to the last loop in shrink_zone_span, but the same
applies to find_{smalles,biggest}_section.

Please, note that we could probably do some hack like replacing:

start_pfn == pfn 

with

pfn < end_pfn

But the way to fix this is to 1) deactivate {sub}-section and 2) let
shrink_{node,zone}_span find the next active {sub-section}.

I hope this makes it more clear.


-- 
Oscar Salvador
SUSE L3
