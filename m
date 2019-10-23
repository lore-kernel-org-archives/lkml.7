Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CACC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D3F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826473;
	bh=1pPpc5FTemHsQMH6mqz2Bz0LZ+qk3KBpFfGYrxTqgZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TuOmMC+FHFF8iQSPV3kW0a6lP5kJnIh8GeHtp2OURgTDTVS6ZAgGkFa0m90Ohcm0E
	 DQLh5ncMEa7sLCxDs0B8sbAF0dY/Ux1UMSIqXech6gcibymVcOJCV7nr+p1DnxOYMm
	 fVZq1nnhXlH6ZuTxK9NThwhlnN55VkYT4MndW9Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbfJWK1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:27:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34113 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbfJWK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:27:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so16323457wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WB7/i5uuRwyukis66Pg18JvXY3b0KiEPdqkT6P2Dv5I=;
        b=R7x6VqVuX7lVkmCO+K2fDj/vYXfgGxw/ejpqrsQfonR+8OMs7MVVN9Cdq2EpfLXNGU
         CmtSHbJOrdtfKjHA+LsqS5uh9v7KpfIkmPKxoBx1i5GkQ9ALmtop69IgQtIEPjV5gYhm
         /qD7fydWMTA3ZD2Y7HiW/wS9ka+zTm/IVor/16czzynERlOTjbdhStRfCrTnNO/kq/6y
         3Ffvga9fWCsuxGrnBao5AAAxs0x2M+PwwsL84UPTiTtd+mU8sLUmI7nbEpWUIqpSLhe7
         kPqNg6VHNIYAtqChxVoLux8YxID1CM25Sp+GMNSZr3df22ryRw1HOw1w2IxdosdlFirk
         ol2g==
X-Gm-Message-State: APjAAAX2+EFXoyYiAVlc/9gOHGZrqjfUy2Dcc72z4Gl1ZLxm4/pIoasu
        OAICdWCeDVzqhLZtoZ1CUwQ=
X-Google-Smtp-Source: APXvYqxhanNo7P+GGioOseTpZYeqbU9Rk+Vt1EErh5XE4tuQ07F4oXbDPsz/GAFPh2pt4bzO8TH5xA==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr7760523wrc.293.1571826469733;
        Wed, 23 Oct 2019 03:27:49 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-173-3.eurotel.cz. [37.188.173.3])
        by smtp.gmail.com with ESMTPSA id u21sm18234122wmu.27.2019.10.23.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:27:48 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Wed, 23 Oct 2019 12:27:35 +0200
Message-Id: <20191023102737.32274-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023095607.GE3016@techsingularity.net>
References: <20191023095607.GE3016@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 10:56:08, Mel Gorman wrote:
> On Wed, Oct 23, 2019 at 11:04:22AM +0200, Michal Hocko wrote:
> > So can we go with this to address the security aspect of this and have
> > something trivial to backport.
> > 
> 
> Yes.

Ok, patch 1 in reply to this email.

> > > > > There is a free_area structure associated with each page order. There
> > > > > is also a nr_free count within the free_area for all the different
> > > > > migration types combined. Tracking the number of free list entries
> > > > > for each migration type will probably add some overhead to the fast
> > > > > paths like moving pages from one migration type to another which may
> > > > > not be desirable.
> > > > 
> > > > Have you tried to measure that overhead?
> > > >  
> > > 
> > > I would prefer this option not be taken. It would increase the cost of
> > > watermark calculations which is a relatively fast path.
> > 
> > Is the change for the wmark check going to require more than
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c0b2e0306720..5d95313ba4a5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3448,9 +3448,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> >  		struct free_area *area = &z->free_area[o];
> >  		int mt;
> >  
> > -		if (!area->nr_free)
> > -			continue;
> > -
> >  		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
> >  			if (!free_area_empty(area, mt))
> >  				return true;
> > 
> > Is this really going to be visible in practice? Sure we are going to do
> > more checks but most orders tend to have at least some memory in a
> > reasonably balanced system and we can hardly expect an optimal
> > allocation path on those that are not.
> >  
> 
> You also have to iterate over them all later in the same function.  The the
> free counts are per migrate type then they would have to be iterated over
> every time.
> 
> Similarly, there would be multiple places where all the counters would
> have to be iterated -- find_suitable_fallback, show_free_areas,
> fast_isolate_freepages, fill_contig_page_info, zone_init_free_lists etc.
> 
> It'd be a small cost but given that it's aimed at fixing a problem with
> reading pagetypeinfo, is it really worth it? I don't think so.

Fair enough.

[...]
> > As pointed out in other email. The problem with this patch is that it
> > hasn't really removed the iteration over the whole free_list which is
> > the primary problem. So I think that we should either consider this a
> > non-issue and make it "admin knows this is potentially expensive" or do
> > something like Andrew was suggesting if we do not want to change the
> > nr_free accounting.
> > 
> 
> Again, the cost is when reading a proc file. From what Andrew said,
> the lock is necessary to safely walk the list but if anything. I would
> be ok with limiting the length of the walk but honestly, I would also
> be ok with simply deleting the proc file. The utility for debugging a
> problem with it is limited now (it was more important when fragmentation
> avoidance was first introduced) and there is little an admin can do with
> the information. I can't remember the last time I asked for the contents
> of the file when trying to debug a problem. There is a possibility that
> someone will complain but I'm not aware of any utility that reads the
> information and does something useful with it. In the unlikely event
> something breaks, the file can be re-added with a limited walk.

I went with a bound to the pages iteratred over in the free_list. See
patch 2.

-- 
Michal Hocko
SUSE Labs

