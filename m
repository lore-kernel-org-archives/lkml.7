Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07387C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17F8204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfGXUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:31:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39641 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbfGXTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so34621204qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IlR64J5qqrd6EuvuKY5P82x6aYreNnzJ1G6l1ZuUNY=;
        b=RQ9AKTp9yYsMr+4HGb2kKGookE7FqoEJV8CQMNPfiQbIfmyYTiGPiPVqtqH6E5NIIr
         Lkr5sB/8LvDy7JbXA7bmk4B/RVYwNoqqr8+BSFtH7EXasr0M2yahUcKWqm0iAU8Di15F
         pp55n2qzOB0FxoYg8XJ9DXHwixOZDSs+0WJ2xmZkrvxt5hIyYUYswVY37LeLMJURd1DT
         y0qpYZsVItMgUijXQqjUfnngjIst9LH953BQlywHAZTfPP0cMtZQfabhm0q5np88tJLn
         +f0BX/DE1M0wYZYL4fRazf4otgOQPXpI61s7vAI4IA7x0IUX2Oy8pdHVW6aJxZjSRc2v
         KUyg==
X-Gm-Message-State: APjAAAV2antEg1ghsTHQ2K7BkLIv2uY0DHzPs5l3JWAgJiiTjrmFPG33
        esyNI0txsq8FoL7rzR8tSfCsgg==
X-Google-Smtp-Source: APXvYqx97nMdzW1EyclSEUzycK5uM7O9QoX/1frKAt0SC9iUExEORIMrePlvDOE1VhOIUnMcQHlxBA==
X-Received: by 2002:a37:a358:: with SMTP id m85mr32733397qke.190.1563996671660;
        Wed, 24 Jul 2019 12:31:11 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id e8sm20345589qkn.95.2019.07.24.12.31.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:31:10 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:31:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        kvm@vger.kernel.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, yang.zhang.wz@gmail.com,
        pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com,
        lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com
Subject: Re: [PATCH v2 0/5] mm / virtio: Provide support for page hinting
Message-ID: <20190724153003-mutt-send-email-mst@kernel.org>
References: <20190724165158.6685.87228.stgit@localhost.localdomain>
 <0c520470-4654-cdf2-cf4d-d7c351d25e8b@redhat.com>
 <f7578309-dd36-bda0-6a30-34a6df21faca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7578309-dd36-bda0-6a30-34a6df21faca@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 08:41:33PM +0200, David Hildenbrand wrote:
> On 24.07.19 20:40, Nitesh Narayan Lal wrote:
> > 
> > On 7/24/19 12:54 PM, Alexander Duyck wrote:
> >> This series provides an asynchronous means of hinting to a hypervisor
> >> that a guest page is no longer in use and can have the data associated
> >> with it dropped. To do this I have implemented functionality that allows
> >> for what I am referring to as page hinting
> >>
> >> The functionality for this is fairly simple. When enabled it will allocate
> >> statistics to track the number of hinted pages in a given free area. When
> >> the number of free pages exceeds this value plus a high water value,
> >> currently 32,
> > Shouldn't we configure this to a lower number such as 16?
> >>  it will begin performing page hinting which consists of
> >> pulling pages off of free list and placing them into a scatter list. The
> >> scatterlist is then given to the page hinting device and it will perform
> >> the required action to make the pages "hinted", in the case of
> >> virtio-balloon this results in the pages being madvised as MADV_DONTNEED
> >> and as such they are forced out of the guest. After this they are placed
> >> back on the free list, and an additional bit is added if they are not
> >> merged indicating that they are a hinted buddy page instead of a standard
> >> buddy page. The cycle then repeats with additional non-hinted pages being
> >> pulled until the free areas all consist of hinted pages.
> >>
> >> I am leaving a number of things hard-coded such as limiting the lowest
> >> order processed to PAGEBLOCK_ORDER,
> > Have you considered making this option configurable at the compile time?
> >>  and have left it up to the guest to
> >> determine what the limit is on how many pages it wants to allocate to
> >> process the hints.
> > It might make sense to set the number of pages to be hinted at a time from the
> > hypervisor.
> >>
> >> My primary testing has just been to verify the memory is being freed after
> >> allocation by running memhog 79g on a 80g guest and watching the total
> >> free memory via /proc/meminfo on the host. With this I have verified most
> >> of the memory is freed after each iteration. As far as performance I have
> >> been mainly focusing on the will-it-scale/page_fault1 test running with
> >> 16 vcpus. With that I have seen at most a 2% difference between the base
> >> kernel without these patches and the patches with virtio-balloon disabled.
> >> With the patches and virtio-balloon enabled with hinting the results
> >> largely depend on the host kernel. On a 3.10 RHEL kernel I saw up to a 2%
> >> drop in performance as I approached 16 threads,
> > I think this is acceptable.
> >>  however on the the lastest
> >> linux-next kernel I saw roughly a 4% to 5% improvement in performance for
> >> all tests with 8 or more threads. 
> > Do you mean that with your patches the will-it-scale/page_fault1 numbers were
> > better by 4-5% over an unmodified kernel?
> >> I believe the difference seen is due to
> >> the overhead for faulting pages back into the guest and zeroing of memory.
> > It may also make sense to test these patches with netperf to observe how much
> > performance drop it is introducing.
> >> Patch 4 is a bit on the large side at about 600 lines of change, however
> >> I really didn't see a good way to break it up since each piece feeds into
> >> the next. So I couldn't add the statistics by themselves as it didn't
> >> really make sense to add them without something that will either read or
> >> increment/decrement them, or add the Hinted state without something that
> >> would set/unset it. As such I just ended up adding the entire thing as
> >> one patch. It makes it a bit bigger but avoids the issues in the previous
> >> set where I was referencing things before they had been added.
> >>
> >> Changes from the RFC:
> >> https://lore.kernel.org/lkml/20190530215223.13974.22445.stgit@localhost.localdomain/
> >> Moved aeration requested flag out of aerator and into zone->flags.
> >> Moved bounary out of free_area and into local variables for aeration.
> >> Moved aeration cycle out of interrupt and into workqueue.
> >> Left nr_free as total pages instead of splitting it between raw and aerated.
> >> Combined size and physical address values in virtio ring into one 64b value.
> >>
> >> Changes from v1:
> >> https://lore.kernel.org/lkml/20190619222922.1231.27432.stgit@localhost.localdomain/
> >> Dropped "waste page treatment" in favor of "page hinting"
> > We may still have to try and find a better name for virtio-balloon side changes.
> > As "FREE_PAGE_HINT" and "PAGE_HINTING" are still confusing.
> 
> We should have named that free page reporting, but that train already
> has left.

I think VIRTIO_BALLOON_F_FREE_PAGE_HINT is different and arguably
actually does provide hints.

> -- 
> 
> Thanks,
> 
> David / dhildenb
