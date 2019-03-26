Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5755620857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553595434;
	bh=tpyOwrolBJY4nPL6vIRppBHnolucs6Y2R/jwk2Mi9rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLap7prLY6P9WAVUHyzcBNNiTPX2DrhTRejyGYFshDawIvFiHi4asb59PJbmJSBK1
	 lGYgXz5QZexVj3AEyUju8nx6gGpNvue7swOARy6ZcH9TzM8n6y7FJ/F4hDwy6Myqnl
	 E9cVaprV2BE0iXe07KKpz9jw3gzFnVjeCi/p6Og4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfCZKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:50962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbfCZKRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FC8DAEDB;
        Tue, 26 Mar 2019 10:17:11 +0000 (UTC)
Date:   Tue, 26 Mar 2019 11:17:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190326101710.GN28406@dhcp22.suse.cz>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
 <20190326092936.GK28406@dhcp22.suse.cz>
 <20190326100817.GV3659@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326100817.GV3659@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 18:08:17, Baoquan He wrote:
> On 03/26/19 at 10:29am, Michal Hocko wrote:
> > On Tue 26-03-19 17:02:25, Baoquan He wrote:
> > > Reorder the allocation of usemap and memmap since usemap allocation
> > > is much simpler and easier. Otherwise hard work is done to make
> > > memmap ready, then have to rollback just because of usemap allocation
> > > failure.
> > 
> > Is this really worth it? I can see that !VMEMMAP is doing memmap size
> > allocation which would be 2MB aka costly allocation but we do not do
> > __GFP_RETRY_MAYFAIL so the allocator backs off early.
> 
> In !VMEMMAP case, it truly does simple allocation directly. surely
> usemap which size is 32 is smaller. So it doesn't matter that much who's
> ahead or who's behind. However, this benefit a little in VMEMMAP case.

How does it help there? The failure should be even much less probable
there because we simply fall back to a small 4kB pages and those
essentially never fail.

> And this make code a little cleaner, e.g the error handling at the end
> is taken away.
> 
> > 
> > > And also check if section is present earlier. Then don't bother to
> > > allocate usemap and memmap if yes.
> > 
> > Moving the check up makes some sense.
> > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > 
> > The patch is not incorrect but I am wondering whether it is really worth
> > it for the current code base. Is it fixing anything real or it is a mere
> > code shuffling to please an eye?
> 
> It's not a fixing, just a tiny code refactorying inside
> sparse_add_one_section(), seems it doesn't worsen thing if I got the
> !VMEMMAP case correctly, not quite sure. I am fine to drop it if it's
> not worth. I could miss something in different cases.

Well, I usually prefer to not do micro-optimizations in a code that
really begs for a much larger surgery. There are other people working on
the code and patches like these might get into the way and cuase
conflicts without a very good justification.
-- 
Michal Hocko
SUSE Labs
