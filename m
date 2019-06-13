Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77740C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3B2206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfFMPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:47:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:32858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfFMJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:33:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3ECB3AF22;
        Thu, 13 Jun 2019 09:33:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Jun 2019 11:33:02 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Check absolute error return from
 vmap_[p4d|pud|pmd|pte]_range()
In-Reply-To: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
References: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-13 10:12, Anshuman Khandual wrote:
> vmap_pte_range() returns an -EBUSY when it encounters a non-empty PTE. 
> But
> currently vmap_pmd_range() unifies both -EBUSY and -ENOMEM return code 
> as
> -ENOMEM and send it up the call chain which is wrong. Interestingly 
> enough
> vmap_page_range_noflush() tests for the absolute error return value 
> from
> vmap_p4d_range() but it does not help because -EBUSY has been merged 
> with
> -ENOMEM. So all it can return is -ENOMEM. Fix this by testing for 
> absolute
> error return from vmap_pmd_range() all the way up to vmap_p4d_range().

I could not find any real external caller of vmap API who really cares
about the errno, and frankly why they should?  This is allocation path,
allocation failed - game over.  When you step on -EBUSY case something
has gone completely wrong in your kernel, you get a big warning in
your dmesg and it is already does not matter what errno you get.

--
Roman

