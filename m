Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FACC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E05721D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570186708;
	bh=Jo+AzM+Y/jwkc8TlToj6N90ZGgx26r92Ycaos97eW9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Wefa2LhXKr75grZm9gGhKArgYVBy6eXiG9pIAA2W7eWyXSEa3HfqDuuorklr17Sd
	 8rpGH3TY5qnPtr5D4HMzp/TJqQ9rhzLWltNK0+KRKRBuY4T+lLU8nbA49NTRopYFfK
	 vEK/DyjgdscqtVG9z4gV5T9OFRUI6ZPS+G8Wz8pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfJDK61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:58:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730678AbfJDK61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D8BCAB89;
        Fri,  4 Oct 2019 10:58:25 +0000 (UTC)
Date:   Fri, 4 Oct 2019 12:58:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20191004105824.GD9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-10-19 13:40:57, Anshuman Khandual wrote:
> Having unmovable pages on a given pageblock should be reported correctly
> when required with REPORT_FAILURE flag. But there can be a scenario where a
> reserved page in the page block will get reported as a generic "unmovable"
> reason code. Instead this should be changed to a more appropriate reason
> code like "Reserved page".

Others have already pointed out this is just redundant but I will have a
more generic comment on the changelog. There is essentially no
information why the current state is bad/unhelpful and why the chnage is
needed. All you claim is that something is a certain way and then assert
that it should be done differently. That is not how changelogs should
look like.
-- 
Michal Hocko
SUSE Labs
