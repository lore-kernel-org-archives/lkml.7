Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B057AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB242087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569228648;
	bh=UBz32YEEXAuoIE5neJ+6vFd292uCxpaDmhU+hDre2ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pi0J2ZTdj228HPbTqfCywbRChcnl6Ug9Js9AoxwauGVmepkABzCo3/l1WgW1eAX+Z
	 v1ChGt2m9wjHxcDa+JJ3fpAHgynsuxnKkEFBQKkMBV7pmw6z3em+DrL/C3CkhBDHt0
	 6mItdKv4wNTS+D/EkDtB17yrM24sqypaykiTro2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfIWIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731680AbfIWIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 886DDAAB2;
        Mon, 23 Sep 2019 08:50:45 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:50:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Lucian Adrian Grijincu <lucian@fb.com>, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190923085045.GC6016@dhcp22.suse.cz>
References: <20190913211119.416168-1-lucian@fb.com>
 <20190916152619.vbi3chozlrzdiuqy@box>
 <20190917101519.GD1872@dhcp22.suse.cz>
 <20190917113550.v6nool7oizht66fx@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917113550.v6nool7oizht66fx@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 14:35:50, Kirill A. Shutemov wrote:
> On Tue, Sep 17, 2019 at 12:15:19PM +0200, Michal Hocko wrote:
> > On Mon 16-09-19 18:26:19, Kirill A. Shutemov wrote:
> > > On Fri, Sep 13, 2019 at 02:11:19PM -0700, Lucian Adrian Grijincu wrote:
> > > > As pages are faulted in MLOCK_ONFAULT correctly updates
> > > > /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.
> > > 
> > > I don't think there's something wrong with this behaviour. It is okay to
> > > keep the page an evictable LRU list (and not account it to NR_MLOCKED).
> > 
> > evictable list is an implementation detail. Having an overview about an
> 
> s/evictable/unevictable/
> 
> > amount of mlocked pages can be important. Lazy accounting makes this
> > more fuzzy and harder for admins to monitor.
> > 
> > Sure it is not a bug to panic about but it certainly makes life of poor
> > admins harder.
> 
> Good luck with making mlock accounting exact :P

I didn't say exact. All I am saying is that the more imprecise it will
be the harder it is for admin to make any sense of the value.

> For start, try to handle sanely trylock_page() failure under ptl while
> dealing with FOLL_MLOCK.

There are likely cases when accounting is problematic/impossible. But
those should be a minority.
 
> > If there is a pathological THP behavior possible then we should look
> > into that as well.
> 
> There's nothing pathological about THP behaviour. See "MLOCKING
> Transparent Huge Pages" section in Documentation/vm/unevictable-lru.rst.

Thanks this documentation helps. I was worried there is something more
going on.
-- 
Michal Hocko
SUSE Labs
