Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB064C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6351205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251020;
	bh=MgDFGrkZDLpSs/KQVk/e0UuY3f2cZXg4Ok1w+xY767Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FKBPnbUtivK23R0yNj4X6r3AsWYw1AesP6yGa80gWJNULLb/dGUzSaObJnEQhudEu
	 PcXIgv51FGYzhOHRAlekyLTS3ibsf9ixddta6wF4GGyWhrIjuD+GmB/aO/ebLJK0jQ
	 vJS5+dxBeu4kLS7RR6LhgZPqzmNU9fYrD4dQBBv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEGRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:43:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfEGRni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CE04AF7C;
        Tue,  7 May 2019 17:43:37 +0000 (UTC)
Date:   Tue, 7 May 2019 19:43:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH AUTOSEL 4.14 62/95] mm, memory_hotplug: initialize struct
 pages for the full memory section
Message-ID: <20190507174336.GU31017@dhcp22.suse.cz>
References: <20190507053826.31622-1-sashal@kernel.org>
 <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
 <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
 <20190507170208.GF1747@sasha-vm>
 <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
 <20190507171806.GG1747@sasha-vm>
 <20190507173224.GS31017@dhcp22.suse.cz>
 <20190507173655.GA1403@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507173655.GA1403@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-05-19 10:36:55, Matthew Wilcox wrote:
> On Tue, May 07, 2019 at 07:32:24PM +0200, Michal Hocko wrote:
> > On Tue 07-05-19 13:18:06, Sasha Levin wrote:
> > > Michal, is there a testcase I can plug into kselftests to make sure we
> > > got this right (and don't regress)? We care a lot about memory hotplug
> > > working right.
> > 
> > As said in other email. The memory hotplug tends to work usually. It
> > takes unexpected memory layouts which trigger corner cases. This makes
> > testing really hard.
> 
> Can we do something with qemu?  Is it flexible enough to hotplug memory
> at the right boundaries?

No idea. But I have tried to describe those layouts in the changelog so
if somebody can come up with a way to reproduce them under kvm/qemu I
would really appreciate that.

-- 
Michal Hocko
SUSE Labs
