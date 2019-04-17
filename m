Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F1E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555507895;
	bh=myoczHuYfHHXEBLagJSHqVXd38Vp4lsfExcyMTcSyrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I7pIRxQwF8bEOHh+U0bocrpHns7c0LZpeu6FvsLWXdc3ELEb6iehP9ueoRBR0QfeS
	 7fkQ39ks5vSGoNrV7QDtupZhMdpMDea/fmmClnOKO8aXYkT4A3+0e8FiX3mg0sGJam
	 XEvQ8vEzVlitEj/EmIetOrbEky73MATtF/5ELH9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfDQNbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:31:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729939AbfDQNbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:31:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E052EB136;
        Wed, 17 Apr 2019 13:31:31 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:31:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: Release memory resource after
 arch_remove_memory()
Message-ID: <20190417133131.GK5878@dhcp22.suse.cz>
References: <20190409100148.24703-1-david@redhat.com>
 <20190409100148.24703-2-david@redhat.com>
 <20190417131258.GI5878@dhcp22.suse.cz>
 <ae4cc790-8d9b-39ad-d29c-d8bd290da165@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4cc790-8d9b-39ad-d29c-d8bd290da165@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 15:24:47, David Hildenbrand wrote:
> On 17.04.19 15:12, Michal Hocko wrote:
> > On Tue 09-04-19 12:01:45, David Hildenbrand wrote:
> >> __add_pages() doesn't add the memory resource, so __remove_pages()
> >> shouldn't remove it. Let's factor it out. Especially as it is a special
> >> case for memory used as system memory, added via add_memory() and
> >> friends.
> >>
> >> We now remove the resource after removing the sections instead of doing
> >> it the other way around. I don't think this change is problematic.
> >>
> >> add_memory()
> >> 	register memory resource
> >> 	arch_add_memory()
> >>
> >> remove_memory
> >> 	arch_remove_memory()
> >> 	release memory resource
> >>
> >> While at it, explain why we ignore errors and that it only happeny if
> >> we remove memory in a different granularity as we added it.
> > 
> > OK, I agree that the symmetry is good in general and it certainly makes
> > sense here as well. But does it make sense to pick up this particular
> > part without larger considerations of add vs. remove apis? I have a
> > strong feeling this wouldn't be the only thing to care about. In other
> > words does this help future changes or it is more likely to cause more
> > code conflicts with other features being developed right now?
> 
> I am planning to
> 
> 1. factor out memory block device handling, so features like sub-section
> add/remove are easier to add internally. Move it to the user that wants
> it. Clean up all the mess we have right now due to supporting memory
> block devices that span several sections.
> 
> 2. Make sure that any arch_add_pages() and friends clean up properly if
> they fail instead of indicating failure but leaving some partially added
> memory lying around.
> 
> 3. Clean up node handling regarding to memory hotplug/unplug. Especially
> don't allow to offline/remove memory spanning several nodes etc.

Yes, this all sounds sane to me.

> IOW, in order to properly clean up memory block device handling and
> prepare for more changes people are interested in (e.g. sub-section add
> of device memory), this is the right thing to do. The other parts are
> bigger changes.

This would be really valuable to have in the cover. Beause there is so
much to clean up in this mess but making random small cleanups without a
larger plan tends to step on others toes more than being useful.
-- 
Michal Hocko
SUSE Labs
