Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E616320679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572012114;
	bh=ZX/hOo1RzJeQ3ctvb+e/ot2mGTssbuGSxRkyobzgtk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gZCh/6Y5rOVhu/S4v9IKiQ6YSODmaYNlwLEJPPWkzqhgM+aW2WTmMl6HvxWdsJdMa
	 ejwaDFs5mq6C/6G86gBWLlkTLvRBusIqVY1GNsw5DwbVYPzlr4Lx/0xspmOgqtAFAZ
	 KXfasewehvh7tXojNoweVEEO8P+xZTauicMPRkcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505440AbfJYN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505383AbfJYN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A20DB8B0;
        Fri, 25 Oct 2019 13:57:50 +0000 (UTC)
Date:   Fri, 25 Oct 2019 15:57:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025135749.GK17610@dhcp22.suse.cz>
References: <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
 <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
 <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 15:45:37, Robert Stupp wrote:
> On Fri, 2019-10-25 at 15:27 +0200, Michal Hocko wrote:
> > On Fri 25-10-19 15:10:39, Robert Stupp wrote:
> > [...]
> > > cat /proc/$(pidof test)/smaps
> >
> > Nothing really unusual that would jump at me except for
> > > 7f8be90ed000-7f8be9265000 r-xp 00025000 103:02
> > > 44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
> > > Size:               1504 kB
> > > KernelPageSize:        4 kB
> > > MMUPageSize:           4 kB
> > > Rss:                 832 kB
> > > Pss:                   5 kB
> > > Shared_Clean:        832 kB
> > > Shared_Dirty:          0 kB
> > > Private_Clean:         0 kB
> > > Private_Dirty:         0 kB
> > > Referenced:          832 kB
> > > Anonymous:             0 kB
> > > LazyFree:              0 kB
> > > AnonHugePages:         0 kB
> > > ShmemPmdMapped:        0 kB
> > > Shared_Hugetlb:        0 kB
> > > Private_Hugetlb:       0 kB
> > > Swap:                  0 kB
> > > SwapPss:               0 kB
> > > Locked:                5 kB
> >
> > Huh, 5kB, is this really the case or some copy&paste error?
> > How can we end up with !pagesize multiple here?

Ohh, I haven't noticed pss and didn't realize that Locked is pss like as
well.

> >
> > > THPeligible:		0
> > > VmFlags: rd ex mr mw me lo sd
> 
> mlockall() seems to lock everything though, it just never returns.
> 
> Pretty sure that it's not a copy&paste error. Got a couple more runs
> that have an "odd size" - this time with 3kB...
> All "Locked" values seem to be okay - except that one. And it's always
> odd for the same one (the one with `Size: 1504 kB`).
> It's not always odd (3 kB or 5 kB) though - sometimes it says 4 kB.
> Seems it's a little breadcrumb?

Please try to watch for stack of the syscall and see if there is any
pattern.
-- 
Michal Hocko
SUSE Labs
