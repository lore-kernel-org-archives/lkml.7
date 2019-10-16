Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEF21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571226583;
	bh=HO29WnQIUrFLiXDGOAo6Pd0NjxJeaVFMjec8aEHbZTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AVFtRKWIoCy7ODhTmiRG4MC/L+IcnZ3htvIco3gjzldY5pxdIkyHV5pwfZMrYYE5w
	 O3RFentIobd5nt+AJPuOmOvs7bdxWW6feLKXQjzTvH/neLjz8AuopDq5cJqkUcocHk
	 yuVhALTsbEn2l5rPf+gAsH/x+DC1jcXrGB+7se6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfJPLtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbfJPLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:49:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 737E8B435;
        Wed, 16 Oct 2019 11:49:35 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:49:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
Message-ID: <20191016114934.GZ317@dhcp22.suse.cz>
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
 <20191016085123.GO317@dhcp22.suse.cz>
 <679b5c66-8f1b-ec4d-64dd-13fbc440917d@redhat.com>
 <20191016110831.GV317@dhcp22.suse.cz>
 <eb2406d5-1327-1365-be0e-ee319ab92088@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2406d5-1327-1365-be0e-ee319ab92088@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 13:10:41, David Hildenbrand wrote:
> On 16.10.19 13:08, Michal Hocko wrote:
> > On Wed 16-10-19 10:56:16, David Hildenbrand wrote:
[...]
> > > Gigantic pages have to be aligned AFAIK.
> > 
> > Aligned to what? I do not see any guarantee like that in the existing
> > code.
> > 
> 
> pfn = ALIGN(zone->zone_start_pfn, nr_pages);

I am obviously blind! Sorry about the confusion.

-- 
Michal Hocko
SUSE Labs
