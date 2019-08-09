Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33BC32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50732208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565387167;
	bh=krs14MxqF/pN/1zEXk5uy9zIQQ+Idv7oecPmObOlHuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CT2Xijxxsl4VXdc8rgNKlzYvb9VtB0vDJzY8bB5TgsSzGrUuT2T8QC6RfKomnlLNR
	 xBHjs9VQqa/slR6AH54QR9Hya9pYiwxyXPTFmAp/Anh/yyprbZscbqZZAXrUJOXQQH
	 bbhQz0zNwArqKaFd10X3OJ33VkiiAa3VAjvaFFQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfHIVqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfHIVqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:46:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B823208C4;
        Fri,  9 Aug 2019 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565387163;
        bh=krs14MxqF/pN/1zEXk5uy9zIQQ+Idv7oecPmObOlHuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qVHDCIU/kq/eMF+7450sA0Gi4W8R6Pt/6iQN+5P1onujMQsj2D+51QxXu1tMalHhz
         CzSqV6LdCzbPLLgUOALzHnHzZ1E2TwbSx/8Zybo6Hg3MiCu1xEJUTwarfxo0DzpjZM
         UNWKCraKny/ooTAo/Y+z9FA44E3OT/1oVt8C3kts=
Date:   Fri, 9 Aug 2019 14:46:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and
 nr_pages in online_pages_blocks()
Message-Id: <20190809144602.eddc3827a373f17ddda7d069@linux-foundation.org>
In-Reply-To: <20190809125701.3316-3-david@redhat.com>
References: <20190809125701.3316-1-david@redhat.com>
        <20190809125701.3316-3-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Aug 2019 14:56:59 +0200 David Hildenbrand <david@redhat.com> wrote:

> Take care of nr_pages not being a power of two and start not being
> properly aligned. Essentially, what walk_system_ram_range() could provide
> to us. get_order() will round-up in case it's not a power of two.
> 
> This should only apply to memory blocks that contain strange memory
> resources (especially with holes), not to ordinary DIMMs.

I'm assuming this doesn't fix any known runtime problem and that a
-stable backport isn't needed.

> Fixes: a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher order")

To that end, I replaced this with my new "Fixes-no-stable" in order to
discourage -stable maintainers from overriding our decision.

> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
