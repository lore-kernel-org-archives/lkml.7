Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB36C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC12087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567506164;
	bh=TqAMUer0veCdPZdpCz+MyHdiU6dn5CEA6RE5RIVVKtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NYlOv2nUYYmEcnBZp+V8YC9S4fdR1GEJXD6XsjmiJJgYINVQ7dsSKJ0DQhoIy3t/b
	 s1NOpKhUqlAxaLGLvwOz9eP6H3SPsKyc4I8V1JOg1oTzL6sGCcfDm3bju14l9iH+DS
	 bUGhXpXXzvVzwW6zDO5UJTJ5j20AEG0Sbp7EB5rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfICKWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:22:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfICKWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:22:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DE8FAD78;
        Tue,  3 Sep 2019 10:22:41 +0000 (UTC)
Date:   Tue, 3 Sep 2019 12:22:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Park Sangwoo <sangwoo2.park@lge.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, osalvador@suse.de, rppt@linux.vnet.ibm.com,
        alexander.h.duyck@linux.intel.com, glider@google.com,
        gregkh@linuxfoundation.org, guro@fb.com, jannh@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] mm: Add nr_free_highatomimic to fix incorrect
 watermatk routine
Message-ID: <20190903102238.GQ14028@dhcp22.suse.cz>
References: <20190903095959.GA4458@LGEARND18B2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903095959.GA4458@LGEARND18B2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 18:59:59, Park Sangwoo wrote:
> >On Mon 02-09-19 13:34:54, Sangwoo� wrote:
> >>>On Fri 30-08-19 18:25:53, Sangwoo wrote:
> >>>> The highatomic migrate block can be increased to 1% of Total memory.
> >>>> And, this is for only highorder ( > 0 order). So, this block size is
> >>>> excepted during check watermark if allocation type isn't alloc_harder.
> >>>>
> >>>> It has problem. The usage of highatomic is already calculated at
> >> NR_FREE_PAGES.
> >>>> So, if we except total block size of highatomic, it's twice minus size of
> >>allocated
> >>>> highatomic.
> >>>> It's cause allocation fail although free pages enough.
> >>>>
> >>>> We checked this by random test on my target(8GB RAM).
> >>>>
> >>>>  Binder:6218_2: page allocation failure: order:0, mode:0x14200ca
> >> (GFP_HIGHUSER_MOVABLE), nodemask=(null)
> >>>>  Binder:6218_2 cpuset=background mems_allowed=0
> >>>
> >>>How come this order-0 sleepable allocation fails? The upstream kernel
> >>>doesn't fail those allocations unless the process context is killed by
> >>>the oom killer.
> >> 
> >> Most calltacks are zsmalloc, as shown below.
> >
> >What makes those allocations special so that they fail unlike any other
> >normal order-0 requests? Also do you see the same problem with the
> >current upstream kernel? Is it possible this is an Android specific
> >issue?
> 
> There is the other case of fail order-0 fail.
> ----
> hvdcp_opti: page allocation failure: order:0, mode:0x1004000(GFP_NOWAIT|__GFP_COMP), nodemask=(null)

This is an atomic allocation and failing that one is not a problem
usually. High atomic reservations might prevent GFP_NOWAIT allocation
from suceeding but I do not see that as a problem. This is the primary
purpose of the reservation. 
[...]
> In my test, most case are using camera. So, memory usage is increased momentarily,
> it cause free page go to under low value of watermark.
> If free page is under low and 0-order fail is occured, its normal operation.
> But, although free page is higher than min, fail is occurred.
> After fix routin for checking highatomic size, it's not reproduced.

But you are stealing from the atomic reserves and thus defeating the
purpose of it.
-- 
Michal Hocko
SUSE Labs
