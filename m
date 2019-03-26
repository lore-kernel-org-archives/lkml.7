Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC819C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E182075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfCZOSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCZOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:18:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A321185545;
        Tue, 26 Mar 2019 14:18:07 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EC4B1001E81;
        Tue, 26 Mar 2019 14:18:05 +0000 (UTC)
Date:   Tue, 26 Mar 2019 22:18:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190326141803.GX3659@MiWiFi-R3L-srv>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
 <20190326092936.GK28406@dhcp22.suse.cz>
 <20190326100817.GV3659@MiWiFi-R3L-srv>
 <20190326101710.GN28406@dhcp22.suse.cz>
 <20190326134522.GB21943@MiWiFi-R3L-srv>
 <20190326140348.GQ28406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326140348.GQ28406@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 26 Mar 2019 14:18:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 03:03pm, Michal Hocko wrote:
> On Tue 26-03-19 21:45:22, Baoquan He wrote:
> > On 03/26/19 at 11:17am, Michal Hocko wrote:
> > > On Tue 26-03-19 18:08:17, Baoquan He wrote:
> > > > On 03/26/19 at 10:29am, Michal Hocko wrote:
> > > > > On Tue 26-03-19 17:02:25, Baoquan He wrote:
> > > > > > Reorder the allocation of usemap and memmap since usemap allocation
> > > > > > is much simpler and easier. Otherwise hard work is done to make
> > > > > > memmap ready, then have to rollback just because of usemap allocation
> > > > > > failure.
> > > > > 
> > > > > Is this really worth it? I can see that !VMEMMAP is doing memmap size
> > > > > allocation which would be 2MB aka costly allocation but we do not do
> > > > > __GFP_RETRY_MAYFAIL so the allocator backs off early.
> > > > 
> > > > In !VMEMMAP case, it truly does simple allocation directly. surely
> > > > usemap which size is 32 is smaller. So it doesn't matter that much who's
> > > > ahead or who's behind. However, this benefit a little in VMEMMAP case.
> > > 
> > > How does it help there? The failure should be even much less probable
> > > there because we simply fall back to a small 4kB pages and those
> > > essentially never fail.
> > 
> > OK, I am fine to drop it. Or only put the section existence checking
> > earlier to avoid unnecessary usemap/memmap allocation?
> 
> DO you have any data on how often that happens? Should basically never
> happening, right?

Oh, you think about it in this aspect. Yes, it rarely happens.
Always allocating firstly can increase efficiency. Then I will just drop
it.
