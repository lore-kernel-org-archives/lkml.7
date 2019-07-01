Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FCC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF5420659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561972840;
	bh=zzoyBMVq6fGZIND8NYFZmL6/hTHNSybu/Z5psT7nHeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xjfe1JPrKg0mxaQvJvL8Jmu9TSmNBBu3As+7HmOrHzqBESxLLgdAZ3eREwLmkOlIF
	 sc0XNFMPmIYR/h4cF9PIaDl3L+bOmJFjuKwPKHpEUSxpqE9wZKdtbrQ9lBRMznJxqk
	 aAaJW0lJBgkiHno91UHooOxwFpoYAXn4a1Uh2278=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfGAJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfGAJUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98C0EB02C;
        Mon,  1 Jul 2019 09:20:37 +0000 (UTC)
Date:   Mon, 1 Jul 2019 11:20:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com,
        rpenyaev@suse.de, guro@fb.com, aryabinin@virtuozzo.com,
        rppt@linux.ibm.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite
 vmap_area
Message-ID: <20190701092037.GL6376@dhcp22.suse.cz>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-06-19 15:56:45, Pengfei Li wrote:
> Hi,
> 
> This series of patches is to reduce the size of struct vmap_area.
> 
> Since the members of struct vmap_area are not being used at the same time,
> it is possible to reduce its size by placing several members that are not
> used at the same time in a union.
> 
> The first 4 patches did some preparatory work for this and improved
> readability.
> 
> The fifth patch is the main patch, it did the work of rewriting vmap_area.
> 
> More details can be obtained from the commit message.

None of the commit messages talk about the motivation. Why do we want to
add quite some code to achieve this? How much do we save? This all
should be a part of the cover letter.

> Thanks,
> 
> Pengfei
> 
> Pengfei Li (5):
>   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
>   mm/vmalloc.c: Introduce a wrapper function of
>     insert_vmap_area_augment()
>   mm/vmalloc.c: Rename function __find_vmap_area() for readability
>   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
>   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> 
>  include/linux/vmalloc.h |  28 +++++---
>  mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-------------
>  2 files changed, 117 insertions(+), 55 deletions(-)
> 
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
