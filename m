Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD980C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5920823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553609032;
	bh=jgFBdyNhB56pXkn3kHqGwV4wD7A3nF+zJJ2CiXn1+Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rpkoDV8uRBo2QZ1XFBo3t5TR6ChdAykYPwpmF9Lac/sFzi6OWZ+dNNWkSea7RWpXm
	 FI8POqH5a6PmTUwu7ur4yv+HLrzhAyzrXpyFrg0fcxq/0q3riHEq1Q8D4yl7Pj2aW8
	 HP9a7k7Z+LZFLaaIETGTSeITTyoIHqIZWOh4TNJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfCZODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:03:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfCZODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61482AF74;
        Tue, 26 Mar 2019 14:03:49 +0000 (UTC)
Date:   Tue, 26 Mar 2019 15:03:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190326140348.GQ28406@dhcp22.suse.cz>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
 <20190326092936.GK28406@dhcp22.suse.cz>
 <20190326100817.GV3659@MiWiFi-R3L-srv>
 <20190326101710.GN28406@dhcp22.suse.cz>
 <20190326134522.GB21943@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326134522.GB21943@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 21:45:22, Baoquan He wrote:
> On 03/26/19 at 11:17am, Michal Hocko wrote:
> > On Tue 26-03-19 18:08:17, Baoquan He wrote:
> > > On 03/26/19 at 10:29am, Michal Hocko wrote:
> > > > On Tue 26-03-19 17:02:25, Baoquan He wrote:
> > > > > Reorder the allocation of usemap and memmap since usemap allocation
> > > > > is much simpler and easier. Otherwise hard work is done to make
> > > > > memmap ready, then have to rollback just because of usemap allocation
> > > > > failure.
> > > > 
> > > > Is this really worth it? I can see that !VMEMMAP is doing memmap size
> > > > allocation which would be 2MB aka costly allocation but we do not do
> > > > __GFP_RETRY_MAYFAIL so the allocator backs off early.
> > > 
> > > In !VMEMMAP case, it truly does simple allocation directly. surely
> > > usemap which size is 32 is smaller. So it doesn't matter that much who's
> > > ahead or who's behind. However, this benefit a little in VMEMMAP case.
> > 
> > How does it help there? The failure should be even much less probable
> > there because we simply fall back to a small 4kB pages and those
> > essentially never fail.
> 
> OK, I am fine to drop it. Or only put the section existence checking
> earlier to avoid unnecessary usemap/memmap allocation?

DO you have any data on how often that happens? Should basically never
happening, right?
-- 
Michal Hocko
SUSE Labs
