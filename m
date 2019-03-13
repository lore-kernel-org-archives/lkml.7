Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE05C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386CF206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552508386;
	bh=xF6bggXljhZSA7+n1F86pjdGyVnpQCj3CBQVLrNEFnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zp3q8Yxct74xbEgfEkFOZhX+3pSiSRvpZTQCqSwe+vYV9s7aKb30IhJAJ/CBI+nzv
	 YAflKzSS/ZXDXL+ywz+S2Yorfz1ozhj7dHp0+Cw0hTHWVKOIyx/DT+wd4Ofl/x7mUl
	 zR93FfRgzU//Bt1+cnGCrNQ+7t02BZoz9uDc+OQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfCMUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:19:44 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36108 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfCMUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:19:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id 189so2573283ywi.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAX8dogAgzi5qFobW6OjpOevgIDAZa/XIjee6QmCjo4=;
        b=t+zDGDAQVUMOTRUXx523LgUDX/+1zABA2Mh2nZwt2PiMt4yQFGG7iJaH4CkMBCkFyM
         eUB8fJKcBHxaeP1q0+hknLunHMkobBKBJeVpjUBvEqZRepQH57Typ3cqt15sshEuAYuy
         dZaOw1hZgFoXHCTuOG97BK6hoS2xAdAXS0COk/kCryvDJ6QAZ+W9MBtjj8AmwQsi16cw
         t/hxgOwYv7Cn7p7sxKuHXswnImapI3MvY2Lf7u98hAQ322pxMoHbDlwWo4KJIOZIuaFs
         2bGXpX9Xu7P3solqsSNdXB+shmkGOe5sTKkgMcP2i4nO3qNSZathPdsAL63pFZZJul+9
         lp8A==
X-Gm-Message-State: APjAAAVDsk4Nu/pVDFmPmb1/vQwEaABkEkBoWDJUZTXuWU0oY/AhyL+v
        XKCf961+CijD5K0+z637wcc=
X-Google-Smtp-Source: APXvYqx8y07VDD2YKkX/5xu1EgKjZeOAENZ/0ff9kTaY+GeumyehkYVULruUk3IrH3/yVPwwp1bigA==
X-Received: by 2002:a25:2bc3:: with SMTP id r186mr20242387ybr.292.1552508382572;
        Wed, 13 Mar 2019 13:19:42 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:d743])
        by smtp.gmail.com with ESMTPSA id w127sm4379231ywf.97.2019.03.13.13.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:19:41 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:19:39 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] introduce percpu block scan_hint
Message-ID: <20190313201939.GA60770@dennisz-mbp.dhcp.thefacebook.com>
References: <20190228021839.55779-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:18:27PM -0500, Dennis Zhou wrote:
> Hi everyone,
> 
> It was reported a while [1] that an increase in allocation alignment
> requirement [2] caused the percpu memory allocator to do significantly
> more work.
> 
> After spending quite a bit of time diving into it, it seems the crux was
> the following:
>   1) chunk management by free_bytes caused allocations to scan over
>      chunks that could not fit due to fragmentation
>   2) per block fragmentation required scanning from an early first_free
>      bit causing allocations to repeat work
> 
> This series introduces a scan_hint for pcpu_block_md and merges the
> paths used to manage the hints. The scan_hint represents the largest
> known free area prior to the contig_hint. There are some caveats to
> this. First, it may not necessarily be the largest area as we do partial
> updates based on freeing of regions and failed scanning in
> pcpu_alloc_area(). Second, if contig_hint == scan_hint, then
> scan_hint_start > contig_hint_start is possible. This is necessary
> for scan_hint discovery when refreshing the hint of a block.
> 
> A necessary change is to enforce a block to be the size of a page. This
> let's the management of nr_empty_pop_pages to be done by breaking and
> making full contig_hints in the hint update paths. Prior, this was done
> by piggy backing off of refreshing the chunk contig_hint as it performed
> a full scan and counting empty full pages.
> 
> The following are the results found using the workload provided in [3].
> 
>         branch        | time
>        ------------------------
>         5.0-rc7       | 69s
>         [2] reverted  | 44s
>         scan_hint     | 39s
> 
> The times above represent the approximate average across multiple runs.
> I tested based on a basic 1M 16-byte allocation pattern with no
> alignment requirement and times did not differ between 5.0-rc7 and
> scan_hint.
> 
> [1] https://lore.kernel.org/netdev/CANn89iKb_vW+LA-91RV=zuAqbNycPFUYW54w_S=KZ3HdcWPw6Q@mail.gmail.com/
> [2] https://lore.kernel.org/netdev/20181116154329.247947-1-edumazet@google.com/
> [3] https://lore.kernel.org/netdev/vbfzhrj9smb.fsf@mellanox.com/
> 
> This patchset contains the following 12 patches:
>   0001-percpu-update-free-path-with-correct-new-free-region.patch
>   0002-percpu-do-not-search-past-bitmap-when-allocating-an-.patch
>   0003-percpu-introduce-helper-to-determine-if-two-regions-.patch
>   0004-percpu-manage-chunks-based-on-contig_bits-instead-of.patch
>   0005-percpu-relegate-chunks-unusable-when-failing-small-a.patch
>   0006-percpu-set-PCPU_BITMAP_BLOCK_SIZE-to-PAGE_SIZE.patch
>   0007-percpu-add-block-level-scan_hint.patch
>   0008-percpu-remember-largest-area-skipped-during-allocati.patch
>   0009-percpu-use-block-scan_hint-to-only-scan-forward.patch
>   0010-percpu-make-pcpu_block_md-generic.patch
>   0011-percpu-convert-chunk-hints-to-be-based-on-pcpu_block.patch
>   0012-percpu-use-chunk-scan_hint-to-skip-some-scanning.patch
> 
> 0001 fixes an issue where the chunk contig_hint was being updated
> improperly with the new region's starting offset and possibly differing
> contig_hint. 0002 fixes possibly scanning pass the end of the bitmap.
> 0003 introduces a helper to do region overlap comparison. 0004 switches
> to chunk management by contig_hint rather than free_bytes. 0005 moves
> chunks that fail to allocate to the empty block list to prevent excess
> scanning with of chunks with small contig_hints and poor alignment.
> 0006 introduces the constraint PCPU_BITMAP_BLOCK_SIZE == PAGE_SIZE and
> modifies nr_empty_pop_pages management to be a part of the hint updates.
> 0007-0009 introduces percpu block scan_hint. 0010 makes pcpu_block_md
> generic so chunk hints can be managed as a pcpu_block_md responsible
> for more bits. 0011-0012 add chunk scan_hints.
> 
> This patchset is on top of percpu#master a3b22b9f11d9.
> 
> diffstats below:
> 
> Dennis Zhou (12):
>   percpu: update free path with correct new free region
>   percpu: do not search past bitmap when allocating an area
>   percpu: introduce helper to determine if two regions overlap
>   percpu: manage chunks based on contig_bits instead of free_bytes
>   percpu: relegate chunks unusable when failing small allocations
>   percpu: set PCPU_BITMAP_BLOCK_SIZE to PAGE_SIZE
>   percpu: add block level scan_hint
>   percpu: remember largest area skipped during allocation
>   percpu: use block scan_hint to only scan forward
>   percpu: make pcpu_block_md generic
>   percpu: convert chunk hints to be based on pcpu_block_md
>   percpu: use chunk scan_hint to skip some scanning
> 
>  include/linux/percpu.h |  12 +-
>  mm/percpu-internal.h   |  15 +-
>  mm/percpu-km.c         |   2 +-
>  mm/percpu-stats.c      |   5 +-
>  mm/percpu.c            | 547 +++++++++++++++++++++++++++++------------
>  5 files changed, 404 insertions(+), 177 deletions(-)
> 
> Thanks,
> Dennis

Applied to percpu/for-5.2.

Thanks,
Dennis
