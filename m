Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1434C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BF1217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfGQHmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:42:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfGQHmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:42:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26CBCAF46;
        Wed, 17 Jul 2019 07:42:13 +0000 (UTC)
Date:   Wed, 17 Jul 2019 09:42:10 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com, pasha.tatashin@soleen.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
Message-ID: <20190717074210.GB22253@linux>
References: <20190715081549.32577-1-osalvador@suse.de>
 <20190715081549.32577-3-osalvador@suse.de>
 <87tvbne0rd.fsf@linux.ibm.com>
 <1563225851.3143.24.camel@suse.de>
 <87o91tcj9t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o91tcj9t.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:08:54AM +0530, Aneesh Kumar K.V wrote:
> Oscar Salvador <osalvador@suse.de> writes:
> 
> > On Mon, 2019-07-15 at 21:41 +0530, Aneesh Kumar K.V wrote:
> >> Oscar Salvador <osalvador@suse.de> writes:
> >> 
> >> > Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION
> >> > granularity.
> >> > The problem is that deactivation of the section occurs later on in
> >> > sparse_remove_section, so pfn_valid()->pfn_section_valid() will
> >> > always return
> >> > true before we deactivate the {sub}section.
> >> 
> >> Can you explain this more? The patch doesn't update section_mem_map
> >> update sequence. So what changed? What is the problem in finding
> >> pfn_valid() return true there?
> >
> > I realized that the changelog was quite modest, so a better explanation
> >  will follow.
> >
> > Let us analize what shrink_{zone,node}_span does.
> > We have to remember that shrink_zone_span gets called every time a
> > section is to be removed.
> >
> > There can be three possibilites:
> >
> > 1) section to be removed is the first one of the zone
> > 2) section to be removed is the last one of the zone
> > 3) section to be removed falls in the middle
> >  
> > For 1) and 2) cases, we will try to find the next section from
> > bottom/top, and in the third case we will check whether the section
> > contains only holes.
> >
> > Now, let us take the example where a ZONE contains only 1 section, and
> > we remove it.
> > The last loop of shrink_zone_span, will check for {start_pfn,end_pfn]
> > PAGES_PER_SECTION block the following:
> >
> > - section is valid
> > - pfn relates to the current zone/nid
> > - section is not the section to be removed
> >
> > Since we only got 1 section here, the check "start_pfn == pfn" will make us to continue the loop and then we are done.
> >
> > Now, what happens after the patch?
> >
> > We increment pfn on subsection basis, since "start_pfn == pfn", we jump
> > to the next sub-section (pfn+512), and call pfn_valid()-
> >>pfn_section_valid().
> > Since section has not been yet deactivded, pfn_section_valid() will
> > return true, and we will repeat this until the end of the loop.
> >
> > What should happen instead is:
> >
> > - we deactivate the {sub}-section before calling
> > shirnk_{zone,node}_span
> > - calls to pfn_valid() will now return false for the sections that have
> > been deactivated, and so we will get the pfn from the next activaded
> > sub-section, or nothing if the section is empty (section do not contain
> > active sub-sections).
> >
> > The example relates to the last loop in shrink_zone_span, but the same
> > applies to find_{smalles,biggest}_section.
> >
> > Please, note that we could probably do some hack like replacing:
> >
> > start_pfn == pfn 
> >
> > with
> >
> > pfn < end_pfn
> 
> Why do you consider this a hack? 
> 
>  /* If the section is current section, it continues the loop */
> 	if (start_pfn == pfn)
> 		continue;

I did not consider this a hack, but I really did not like to adapt that
to the sub-section case as it seemed more natural to 1) deactivate
sub-section and 2) look for the next one.
So we would not need these checks.

I might have bored at that time and I went for the most complex way to fix
it.

I will send v2 with the less intrusive check.

> 
> The comment explains that check is there to handle the exact scenario
> that you are fixing in this patch. With subsection patch that check is
> not sufficient. Shouldn't we just fix the check to handle that?
> 
> Not sure about your comment w.r.t find_{smalles,biggest}_section. We
> search with pfn range outside the subsection we are trying to remove.
> So this should not have an impact there?

Yeah, I overlooked the code.

-- 
Oscar Salvador
SUSE L3
