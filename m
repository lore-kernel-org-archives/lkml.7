Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECCCA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB97218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 09:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfJTJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 05:32:40 -0400
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:54578 "EHLO
        outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfJTJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 05:32:40 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id CFAE698BA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 10:32:37 +0100 (IST)
Received: (qmail 31103 invoked from network); 20 Oct 2019 09:32:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Oct 2019 09:32:37 -0000
Date:   Sun, 20 Oct 2019 10:32:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191020093235.GL3321@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-3-mgorman@techsingularity.net>
 <20191018130127.GP5017@dhcp22.suse.cz>
 <20191018140959.GK3321@techsingularity.net>
 <20191018184024.2bb1a69997a9365c5d4ccf1c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191018184024.2bb1a69997a9365c5d4ccf1c@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:40:24PM -0700, Andrew Morton wrote:
> On Fri, 18 Oct 2019 15:09:59 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > > > Cc: stable@vger.kernel.org # v4.15+
> > > 
> > > Hmm, are you sure about 4.15? Doesn't this go all the way down to
> > > deferred initialization? I do not see any recent changes on when
> > > setup_per_cpu_pageset is called.
> > > 
> > 
> > No, I'm not 100% sure. It looks like this was always an issue from the
> > code but did not happen on at least one 4.12-based distribution kernel for
> > reasons that are non-obvious. Either way, the tag should have been "v4.1+"
> 
> I could mark
> 
> mm-pcp-share-common-code-between-memory-hotplug-and-percpu-sysctl-handler.patch
> mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
> 
> as Cc: <stable@vger.kernel.org>	[4.1+]
> 

That would be fine.

> But for backporting purposes it's a bit cumbersome that [2/3] is the
> important patch.  I think I'll switch the ordering so that
> mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
> is the first patch and the other two can be queued for 5.5-rc1, OK?
> 

It might be easier to simply collapse patch 1 and 2 together. They were
only split to make the review easier and to avoid two relatively big
changes in one patch.

> Also, is a Reported-by:Matt appropriate here?
> 

I don't object but I'm not actually sure who reported this first. I think
it was Thomas who talked to Boris about an EPYC performance issue, who
talked to Matt thinking it might be a scheduler issue who identified it
was my problem :P

-- 
Mel Gorman
SUSE Labs
