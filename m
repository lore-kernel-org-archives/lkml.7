Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E428C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FAA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565792918;
	bh=rTT+n4VWb72sM/fnRbqf1oXZ7qmfy4dtVTxKjHocCIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ba3W+vC5dJnG1ifdt/YLj0aghIdAd1pqL0GP5wM3EyrlJMN2SpHDZV+jCCg6OKGpW
	 99vrFijPsnOsDwSrgKRPB+rumQVuhHobfUBZnGUj6yBKu0SCYHe/hswWg2YKZlJD7E
	 jg3xuTZ5itgsiI1dCPYKXCLjrelFH7dm5fNI7CAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfHNO2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:28:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727524AbfHNO2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:28:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A8C1AEE9;
        Wed, 14 Aug 2019 14:28:35 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:28:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and
 nr_pages in online_pages_blocks()
Message-ID: <20190814142834.GD17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-3-david@redhat.com>
 <20190814140805.GA17933@dhcp22.suse.cz>
 <ddb10470-8d6e-c8bd-4877-197621219612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb10470-8d6e-c8bd-4877-197621219612@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 16:17:03, David Hildenbrand wrote:
> On 14.08.19 16:08, Michal Hocko wrote:
> > On Fri 09-08-19 14:56:59, David Hildenbrand wrote:
> >> Take care of nr_pages not being a power of two and start not being
> >> properly aligned. Essentially, what walk_system_ram_range() could provide
> >> to us. get_order() will round-up in case it's not a power of two.
> >>
> >> This should only apply to memory blocks that contain strange memory
> >> resources (especially with holes), not to ordinary DIMMs.
> > 
> > I would really like to see an example of such setup before making the
> > code hard to read. Because I am not really sure something like that
> > exists at all.
> 
> I don't have a real-live example at hand (founds this while exploring
> the code), however, the linked commit changed it without stating why it
> would be safe to do so.

Then just drop the change. It is making the code a real head scratcher,
and more so after the next patch. I am pretty sure that things would
easily and quickly blow up if we had ranges like that.
-- 
Michal Hocko
SUSE Labs
