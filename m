Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB842C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9B207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbfIWPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfIWPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:37:55 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F99C641C2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:37:55 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id k67so18175292qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E4QK3gDwO4DVf24v4ZLxlDMDZWgHlHSA6oyD8Fga644=;
        b=BhaLCcY0R7MDryatSPt1mFcLzJXLvkDHTpyETqFmUP0d/xANacZ0XQiA5ZL4pWTPue
         XbXq+qQeuHeQBtayBrdMQdLtVsmJf5uqrjq+svxSXQfzkCXWSQ628BQK1Mr97aAu3x4b
         JxVz2UczZfK6FkmtL0ryuXAIrRGvJclc+GrJiRRyfRl1vtr4+qPN6GGwoW5ERC+1M8xl
         dy3z3U95bMCQgwBvZmFnbSm9w0Hl2kn6/UdUBArbnWjTJX0UlsMwxAa9gvK6GJoU5yDO
         P56g8oF4SaptnYr8BG55TrIZalk43dNbdKaBM9Vv6Z2PIkdxAjqPCtzFZpzqQiFREqf0
         KDtw==
X-Gm-Message-State: APjAAAX7XOT7GqINv3FYxQPpczw7GfOVluFmt7Jso5p/2nDwZsVQbE08
        yLmxVzVGWRrrv6Itcb6Hnda3Pffd3HIjnv+0OsvKDsNAco6ECobPhLJyFOrMyiOGxbbz0rmWQXJ
        uaV+GIirdJBJEzKOebJjYlETZ
X-Received: by 2002:a37:57c6:: with SMTP id l189mr452339qkb.246.1569253074526;
        Mon, 23 Sep 2019 08:37:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMQYK4n8L9Q6BZh5x7gAOg7nRwOrwBwHigRwbuP/jdi+b4Ycl1HHmEcZoDvnm4Qa21KTqtNw==
X-Received: by 2002:a37:57c6:: with SMTP id l189mr452317qkb.246.1569253074360;
        Mon, 23 Sep 2019 08:37:54 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id l7sm5265164qke.67.2019.09.23.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:37:53 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:37:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-arm-kernel@lists.infradead.org,
        Oscar Salvador <osalvador@suse.de>,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v10 3/6] mm: Introduce Reported pages
Message-ID: <20190923113722-mutt-send-email-mst@kernel.org>
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190918175249.23474.51171.stgit@localhost.localdomain>
 <20190923041330-mutt-send-email-mst@kernel.org>
 <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com>
 <20190923105746-mutt-send-email-mst@kernel.org>
 <CAKgT0Ufp0bdz3YkbAoKWd5DALFjAkHaSUn_UywW1+3hk4tjPSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ufp0bdz3YkbAoKWd5DALFjAkHaSUn_UywW1+3hk4tjPSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:28:00AM -0700, Alexander Duyck wrote:
> On Mon, Sep 23, 2019 at 8:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 23, 2019 at 07:50:15AM -0700, Alexander Duyck wrote:
> > > > > +static inline void
> > > > > +page_reporting_reset_boundary(struct zone *zone, unsigned int order, int mt)
> > > > > +{
> > > > > +     int index;
> > > > > +
> > > > > +     if (order < PAGE_REPORTING_MIN_ORDER)
> > > > > +             return;
> > > > > +     if (!test_bit(ZONE_PAGE_REPORTING_ACTIVE, &zone->flags))
> > > > > +             return;
> > > > > +
> > > > > +     index = get_reporting_index(order, mt);
> > > > > +     reported_boundary[index] = &zone->free_area[order].free_list[mt];
> > > > > +}
> > > >
> > > > So this seems to be costly.
> > > > I'm guessing it's the access to flags:
> > > >
> > > >
> > > >         /* zone flags, see below */
> > > >         unsigned long           flags;
> > > >
> > > >         /* Primarily protects free_area */
> > > >         spinlock_t              lock;
> > > >
> > > >
> > > >
> > > > which is in the same cache line as the lock.
> > >
> > > I'm not sure what you mean by this being costly?
> >
> > I've just been wondering why does will it scale report a 1.5% regression
> > with this patch.
> 
> Are you talking about data you have collected from a test you have
> run, or the data I have run?

About the kernel test robot auto report that was sent recently.

> In the case of the data I have run I notice almost no difference as
> long as the pages are not actually being madvised. Once I turn on the
> madvise then I start seeing the regression, but almost all of that is
> due to page zeroing/faulting. There isn't expected to be a gain from
> this patchset until you start having guests dealing with memory
> overcommit on the host. Then at that point the patch set should start
> showing gains when the madvise bits are enabled in QEMU.
> 
> Also the test I have been running is a modified version of the
> page_fault1 test to specifically target transparent huge pages in
> order to make this test that much more difficult, the standard
> page_fault1 test wasn't showing much of anything since the overhead
> for breaking a 2M page into 512 4K pages and zeroing those
> individually in the guest  was essentially drowning out the effect of
> the patches themselves.
> 
> - Alex
