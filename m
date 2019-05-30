Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4638C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DBB262B5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE3Wwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:52:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37693 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3Wwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:52:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so9151060qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 15:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t67ZC4MNc2SNAttzYwTDhyatXWg3h6kEvUy6EU0k9QU=;
        b=nzdvPg9oLVcGDMgHAJSgtonZWBv7efleZ8z+KHHmeRNxZ3vNlXj3Ww8xOLZfT1kHon
         P1WVwCRf+/78B3f5ZIaC/AxWdDxnO6na0rJVm7rL3m+yIUIziY+v947zvDBVt1LYtB1U
         a02fzKtkJ3dspglfbSG5e22Jod7psn+/W6qBiyt1tG+KlVVSty3jHzsNtCG1kd5eFgQu
         VuyPRsmw8aC09Fokhj020v2CRXwyMybSxi2A4v0QOCo67ZccZmfal8zs3RMJvKajBUlg
         zCkuQgaZwJhN0zBaJV4u8I7rntcgyhMkddjsVSloahkAlB+b5AxaD+SkgvQUct3uloFh
         fURA==
X-Gm-Message-State: APjAAAUu2T4UAwvCYmnX4jyuRjwdlPqKR13F2VRnZnhsSGBwE0m1W5ts
        l2IGw27QXLF7G7iPARc6sLfouQ==
X-Google-Smtp-Source: APXvYqwTE8uNShrRUaGGlmcc2h+GxOEcZ6AH8JazaRG/qhRpJu7znm1zUJrRhfEE9Idohkf2/B2tSw==
X-Received: by 2002:ad4:5146:: with SMTP id g6mr5719624qvq.136.1559256769266;
        Thu, 30 May 2019 15:52:49 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id j33sm2606122qtc.10.2019.05.30.15.52.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 15:52:48 -0700 (PDT)
Date:   Thu, 30 May 2019 18:52:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nitesh@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.zhang.wz@gmail.com, pagupta@redhat.com,
        riel@surriel.com, konrad.wilk@oracle.com, lcapitulino@redhat.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
Subject: Re: [RFC PATCH 00/11] mm / virtio: Provide support for paravirtual
 waste page treatment
Message-ID: <20190530185143-mutt-send-email-mst@kernel.org>
References: <20190530215223.13974.22445.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530215223.13974.22445.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:53:34PM -0700, Alexander Duyck wrote:
> This series provides an asynchronous means of hinting to a hypervisor
> that a guest page is no longer in use and can have the data associated
> with it dropped. To do this I have implemented functionality that allows
> for what I am referring to as "waste page treatment".
> 
> I have based many of the terms and functionality off of waste water
> treatment, the idea for the similarity occured to me after I had reached
> the point of referring to the hints as "bubbles", as the hints used the
> same approach as the balloon functionality but would disappear if they
> were touched, as a result I started to think of the virtio device as an
> aerator. The general idea with all of this is that the guest should be
> treating the unused pages so that when they end up heading "downstream"
> to either another guest, or back at the host they will not need to be
> written to swap.

A lovely analogy.

> So for a bit of background for the treatment process, it is based on a
> sequencing batch reactor (SBR)[1]. The treatment process itself has five
> stages. The first stage is the fill, with this we take the raw pages and
> add them to the reactor. The second stage is react, in this stage we hand
> the pages off to the Virtio Balloon driver to have hints attached to them
> and for those hints to be sent to the hypervisor. The third stage is
> settle, in this stage we are waiting for the hypervisor to process the
> pages, and we should receive an interrupt when it is completed. The fourth
> stage is to decant, or drain the reactor of pages. Finally we have the
> idle stage which we will go into if the reference count for the reactor
> gets down to 0 after a drain, or if a fill operation fails to obtain any
> pages and the reference count has hit 0. Otherwise we return to the first
> state and start the cycle over again.

will review the patchset closely shortly.

> This patch set is still far more intrusive then I would really like for
> what it has to do. Currently I am splitting the nr_free_pages into two
> values and having to add a pointer and an index to track where we area in
> the treatment process for a given free_area. I'm also not sure I have
> covered all possible corner cases where pages can get into the free_area
> or move from one migratetype to another.
> 
> Also I am still leaving a number of things hard-coded such as limiting the
> lowest order processed to PAGEBLOCK_ORDER, and have left it up to the
> guest to determine what size of reactor it wants to allocate to process
> the hints.
> 
> Another consideration I am still debating is if I really want to process
> the aerator_cycle() function in interrupt context or if I should have it
> running in a thread somewhere else.
> 
> [1]: https://en.wikipedia.org/wiki/Sequencing_batch_reactor
> 
> ---
> 
> Alexander Duyck (11):
>       mm: Move MAX_ORDER definition closer to pageblock_order
>       mm: Adjust shuffle code to allow for future coalescing
>       mm: Add support for Treated Buddy pages
>       mm: Split nr_free into nr_free_raw and nr_free_treated
>       mm: Propogate Treated bit when splitting
>       mm: Add membrane to free area to use as divider between treated and raw pages
>       mm: Add support for acquiring first free "raw" or "untreated" page in zone
>       mm: Add support for creating memory aeration
>       mm: Count isolated pages as "treated"
>       virtio-balloon: Add support for aerating memory via bubble hinting
>       mm: Add free page notification hook
> 
> 
>  arch/x86/include/asm/page.h         |   11 +
>  drivers/virtio/Kconfig              |    1 
>  drivers/virtio/virtio_balloon.c     |   89 ++++++++++
>  include/linux/gfp.h                 |   10 +
>  include/linux/memory_aeration.h     |   54 ++++++
>  include/linux/mmzone.h              |  100 +++++++++--
>  include/linux/page-flags.h          |   32 +++
>  include/linux/pageblock-flags.h     |    8 +
>  include/uapi/linux/virtio_balloon.h |    1 
>  mm/Kconfig                          |    5 +
>  mm/Makefile                         |    1 
>  mm/aeration.c                       |  324 +++++++++++++++++++++++++++++++++++
>  mm/compaction.c                     |    4 
>  mm/page_alloc.c                     |  220 ++++++++++++++++++++----
>  mm/shuffle.c                        |   24 ---
>  mm/shuffle.h                        |   35 ++++
>  mm/vmstat.c                         |    5 -
>  17 files changed, 838 insertions(+), 86 deletions(-)
>  create mode 100644 include/linux/memory_aeration.h
>  create mode 100644 mm/aeration.c
> 
> --
