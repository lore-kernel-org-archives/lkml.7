Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93538C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662DA2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567404600;
	bh=A7Zmfk+4gzP+U9J4aAkExL3X+eu5y33xAx9wJWo7fsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XzfydMPwFqNQRpAptGtqMP6bv6WfjJ4g5X1tszujSkNcMPnk2xiLrbgwtLrFsrYEZ
	 b3MlBF/F7RpXR1nNgvcdnMac62uT/OT+1qQt+tRnAgT0GQpPFr3+PuG2b273CUMJdi
	 oCNpcJ5/Gy+E6QLjQUX9rqk3YzpP+0ptHrEOYfnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfIBGJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 02:09:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfIBGJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 02:09:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDD63B04F;
        Mon,  2 Sep 2019 06:09:57 +0000 (UTC)
Date:   Mon, 2 Sep 2019 08:09:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?67CV7IOB7Jqw?= <sangwoo2.park@lge.com>
Cc:     hannes@cmpxchg.org, arunks@codeaurora.org, guro@fb.com,
        richard.weiyang@gmail.com, glider@google.com, jannh@google.com,
        dan.j.williams@intel.com, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, rppt@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, janne.huttunen@nokia.com,
        pasha.tatashin@soleen.com, vbabka@suse.cz, osalvador@suse.de,
        mgorman@techsingularity.net, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] mm: Add nr_free_highatomimic to fix incorrect
 watermatk routine
Message-ID: <20190902060955.GB14028@dhcp22.suse.cz>
References: <1567157153-22024-1-git-send-email-sangwoo2.park@lge.com>
 <20190830110907.GC28313@dhcp22.suse.cz>
 <OF7501D4D5.8C005EEB-ON49258469.00192B40-49258469.00192B40@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF7501D4D5.8C005EEB-ON49258469.00192B40-49258469.00192B40@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-09-19 13:34:54, 박상우 wrote:
> >On Fri 30-08-19 18:25:53, Sangwoo wrote:
> >> The highatomic migrate block can be increased to 1% of Total memory.
> >> And, this is for only highorder ( > 0 order). So, this block size is
> >> excepted during check watermark if allocation type isn't alloc_harder.
> >>
> >> It has problem. The usage of highatomic is already calculated at
> NR_FREE_PAGES.
> >> So, if we except total block size of highatomic, it's twice minus size of
> allocated
> >> highatomic.
> >> It's cause allocation fail although free pages enough.
> >>
> >> We checked this by random test on my target(8GB RAM).
> >>
> >>  Binder:6218_2: page allocation failure: order:0, mode:0x14200ca
> (GFP_HIGHUSER_MOVABLE), nodemask=(null)
> >>  Binder:6218_2 cpuset=background mems_allowed=0
> >
> >How come this order-0 sleepable allocation fails? The upstream kernel
> >doesn't fail those allocations unless the process context is killed by
> >the oom killer.
> 
> Most calltacks are zsmalloc, as shown below.

What makes those allocations special so that they fail unlike any other
normal order-0 requests? Also do you see the same problem with the
current upstream kernel? Is it possible this is an Android specific
issue?

>  Call trace:
>   dump_backtrace+0x0/0x1f0
>   show_stack+0x18/0x20
>   dump_stack+0xc4/0x100
>   warn_alloc+0x100/0x198
>   __alloc_pages_nodemask+0x116c/0x1188
>   do_swap_page+0x10c/0x6f0
>   handle_pte_fault+0x12c/0xfe0
>   handle_mm_fault+0x1d0/0x328
>   do_page_fault+0x2a0/0x3e0
>   do_translation_fault+0x44/0xa8
>   do_mem_abort+0x4c/0xd0
>   el1_da+0x24/0x84
>   __arch_copy_to_user+0x5c/0x220
>   binder_ioctl+0x20c/0x740
>   compat_SyS_ioctl+0x128/0x248
>   __sys_trace_return+0x0/0x4
-- 
Michal Hocko
SUSE Labs
