Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0718C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4C20700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570196297;
	bh=604gsQxWdPw4qkopFM7tPeLqPTTlm62HSbXH+bbvhO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KtaNy8b66wewoDITgUZ4CLuH9fw3vUtfTABTLMdQhRQUGg4wg7o5C8rGhbSLLJtyF
	 aacR0FvxF4ePtI6zIL3/iqRgFeWuW2ZlnK4erO5Ysv7TldaVPDUY8PNIkcVYG9U8mY
	 BRhN1YWayQHtM7QbvGmXXD2kBnw6Xt4cLb8R0udE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfJDNiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:38304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388197AbfJDNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:38:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E84ACAEF6;
        Fri,  4 Oct 2019 13:38:14 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:38:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20191004133814.GM9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
 <20191004105824.GD9578@dhcp22.suse.cz>
 <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
 <1570193776.5576.270.camel@lca.pw>
 <20191004130713.GK9578@dhcp22.suse.cz>
 <1570195839.5576.273.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570195839.5576.273.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 09:30:39, Qian Cai wrote:
> On Fri, 2019-10-04 at 15:07 +0200, Michal Hocko wrote:
> > On Fri 04-10-19 08:56:16, Qian Cai wrote:
> > [...]
> > > It might be a good time to rethink if it is really a good idea to dump_page()
> > > at all inside has_unmovable_pages(). As it is right now, it is a a potential
> > > deadlock between console vs memory offline. More details are in this thread,
> > > 
> > > https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/
> > 
> > Huh. That would imply we cannot do any printk from that path, no?
> 
> Yes, or use something like printk_deferred()

This is just insane. The hotplug code is in no way special wrt printk.
It is never called from the printk code AFAIK and thus there is no real
reason why this particular code should be any special. Not to mention
it calls printk indirectly from a code that is shared with other code
paths.

> or it needs to rework of the current console locking which I have no
> clue yet.

Yes, if the lockdep is really referring to a real deadlock which I
haven't really explored.

-- 
Michal Hocko
SUSE Labs
