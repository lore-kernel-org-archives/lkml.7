Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDCC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16503218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551345366;
	bh=SoyQ9NbCNu3qCLC3H+YdvJG0aFL8MI4pPTrw/9cL3Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hytQQzG+TiFT49LlgfttfyT8Uh8Wvx/ppVCPbcL0CTXrFDIiolWXXxAWr0Lv4tlT3
	 jzqQzGbkA0fMjNFE0uUvAJyvr3vB/BdzBFO6wMJejMe+p0Nar3WglNdfOXC24+RUCP
	 7eB8PDeIpHdjGW9EHr//eLNa8l7T9qLKv1NYz86c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfB1JQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:16:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731421AbfB1JQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:16:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6DA1ACC0;
        Thu, 28 Feb 2019 09:16:02 +0000 (UTC)
Date:   Thu, 28 Feb 2019 10:16:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228091602.GU10588@dhcp22.suse.cz>
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190227215109.cpiaheyqs2qdbl7p@d104.suse.de>
 <201cc8d8-953f-f198-bbfe-96470136db68@oracle.com>
 <bb71b68e-dc1b-a4d3-d842-b311535b92a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb71b68e-dc1b-a4d3-d842-b311535b92a8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-02-19 08:38:34, David Hildenbrand wrote:
> On 27.02.19 23:00, Mike Kravetz wrote:
> > On 2/27/19 1:51 PM, Oscar Salvador wrote:
> >> On Thu, Feb 21, 2019 at 10:42:12AM +0100, Oscar Salvador wrote:
> >>> [1] https://lore.kernel.org/patchwork/patch/998796/
> >>>
> >>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> >>
> >> Any further comments on this?
> >> I do have a "concern" I would like to sort out before dropping the RFC:
> >>
> >> It is the fact that unless we have spare gigantic pages in other notes, the
> >> offlining operation will loop forever (until the customer cancels the operation).
> >> While I do not really like that, I do think that memory offlining should be done
> >> with some sanity, and the administrator should know in advance if the system is going
> >> to be able to keep up with the memory pressure, aka: make sure we got what we need in
> >> order to make the offlining operation to succeed.
> >> That translates to be sure that we have spare gigantic pages and other nodes
> >> can take them.
> >>
> >> Given said that, another thing I thought about is that we could check if we have
> >> spare gigantic pages at has_unmovable_pages() time.
> >> Something like checking "h->free_huge_pages - h->resv_huge_pages > 0", and if it
> >> turns out that we do not have gigantic pages anywhere, just return as we have
> >> non-movable pages.
> > 
> > Of course, that check would be racy.  Even if there is an available gigantic
> > page at has_unmovable_pages() time there is no guarantee it will be there when
> > we want to allocate/use it.  But, you would at least catch 'most' cases of
> > looping forever.
> > 
> >> But I would rather not convulate has_unmovable_pages() with such checks and "trust"
> >> the administrator.
> 
> I think we have the exact same issue already with huge/ordinary pages if
> we are low on memory. We could loop forever.
> 
> In the long run, we should properly detect such issues and abort instead
> of looping forever I guess. But as we all know, error handling in the
> whole offlining part is still far away from being perfect ...

Migration allocation callbacks use __GFP_RETRY_MAYFAIL to not
be disruptive so they do not trigger the OOM killer and rely on somebody
else to pull the trigger instead. This means that if there is no other
activity on the system the hotplug migration would just loop for ever
or until interrupted by the userspace. THe later is important, user
might define a policy when to terminate and keep retrying is not
necessarily a wrong thing. One can simply do
timeout $TIMEOUT echo 0 > $PATH_TO_MEMBLOCK/online

and ENOMEM handling is not important. But I can see how people might
want to bail out early instead. So I do not have a strong opinion here.
We can try to consider ENOMEM from the migration as a hard failure and
bail out and see whether it works in practice.
-- 
Michal Hocko
SUSE Labs
