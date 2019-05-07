Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C364C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14226206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251499;
	bh=vNqgHxRiOFUN0GlBXAgpl4H94Q5kJ0fJ/eOihX2RWQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1/zQJIu3ejvQvhp97cXUVW0Z85VKlMg2fvbzFsZHHzapEAsdsiaHKcFhRW27FHfNn
	 TlfyZxyegoO7kvwSvReWQSACZNCyY4qaODEb5eFsNh2AZ0CR+aro9AWgM/v+mke7SV
	 X7c1+Ot6r5T3sAbzp4kRIQD7QGa4TT7BvcMvjMXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEGRvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:51:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbfEGRvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:51:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26A7EAEF5;
        Tue,  7 May 2019 17:51:35 +0000 (UTC)
Date:   Tue, 7 May 2019 19:51:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
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
Message-ID: <20190507175133.GV31017@dhcp22.suse.cz>
References: <20190507053826.31622-1-sashal@kernel.org>
 <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
 <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
 <20190507170208.GF1747@sasha-vm>
 <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
 <20190507171806.GG1747@sasha-vm>
 <20190507173224.GS31017@dhcp22.suse.cz>
 <20190507173655.GA1403@bombadil.infradead.org>
 <CAHk-=wjFkwKpRGP-MJA6mM6ZOu0aiqtvmqxKR78HHXVd_SwpUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFkwKpRGP-MJA6mM6ZOu0aiqtvmqxKR78HHXVd_SwpUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-05-19 10:43:31, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Can we do something with qemu?  Is it flexible enough to hotplug memory
> > at the right boundaries?
> 
> It's not just the actual hotplugged memory, it's things like how the
> e820 tables were laid out for the _regular_ non-hotplug stuff too,
> iirc to get the cases where something didn't work out.
> 
> I'm sure it *could* be emulated, and I'm sure some hotplug (and page
> poison errors etc) testing in qemu would be lovely and presumably some
> people do it, but all the cases so far have been about odd small
> special cases that people didn't think of and didn't hit. I'm not sure
> the qemu testing would think of them either..

Yes, this is exactly my point. It would be great to have those odd small
special cases that we have met already available though. For a
regression testing for them at least.
-- 
Michal Hocko
SUSE Labs
