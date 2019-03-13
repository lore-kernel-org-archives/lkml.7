Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F388A2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552464070;
	bh=2TDmEoCcgHMKSbjT/SIgwVVG4CmX4DKwmv6SgL5W9vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KJkuvJ0/wmOuMuhonJz1qlI90JJJgtIax7AMOpAc58KVChAjRZDEe1hddHvOoFLT6
	 h3E3sSI9pEudA7T9n0gWZ0mfgRaSwhjDgcKUKO1eehiNHiypjUECYVQ91BfUk9Noln
	 nr9CNbwd4kFEBA5HFxptl0pVNoH5PyP6SbNZdxVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfCMIBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:01:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfCMIBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:01:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE063AE84;
        Wed, 13 Mar 2019 08:01:05 +0000 (UTC)
Date:   Wed, 13 Mar 2019 09:01:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix offline undo_isolate_page_range()
Message-ID: <20190313080105.GG5721@dhcp22.suse.cz>
References: <20190313014216.36782-1-cai@lca.pw>
 <20190313075212.wc3pbwixx3ppwxua@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313075212.wc3pbwixx3ppwxua@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 08:52:16, Oscar Salvador wrote:
> On Tue, Mar 12, 2019 at 09:42:16PM -0400, Qian Cai wrote:
> > +
> > +	/*
> > +	 * Onlining will reset pagetype flags and makes migrate type
> > +	 * MOVABLE, so just need to decrease the number of isolated
> > +	 * pageblocks zone counter here.
> > +	 */
> > +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
> > +		int i;
> > +
> > +		for (i = 0; i < pageblock_nr_pages; i++)
> > +			if (pfn_valid_within(pfn + i)) {
> > +				zone->nr_isolate_pageblock--;
> > +				break;
> > +			}
> > +	}
> > +
> 
> I do not really like this.
> 
> I first thought about saving the value before entering start_isolate_page_range,
> but that could race with alloc_contig_range for instance.

Yup. We need to take the zone lock.

> So, why not make start_isolate_page_range to return the actual number of isolated
> pageblocks?

That makes more sense indeed.

-- 
Michal Hocko
SUSE Labs
