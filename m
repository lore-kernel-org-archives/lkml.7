Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A26EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CC22068D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573787201;
	bh=uCBVztTu6lSlxUIFPiCLJQhpmUGyMfqYd3PM9NUf/qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F8lyl5NRmEx8aFCc98TYagU+FAZpCf+bkM+s5uPROJjFDwmoH08JuDUqZEExUi9if
	 KMUs7kTgp+HvIPLgLEZ0Yg0wQWvZ0e0PXjN7S8cGSNUIZpJGS1y/gGYynYsxMypU0I
	 41rhfMEVkEowPQ2Rr5j4sU8i1tZLuRbn1OFUU9jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKODGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfKODGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:06:39 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1251206D6;
        Fri, 15 Nov 2019 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573787198;
        bh=uCBVztTu6lSlxUIFPiCLJQhpmUGyMfqYd3PM9NUf/qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSilm70zUgETF3oaIt2tUiDi7Hk8zoad408iroxPG4K7TZKXfgdhHeob7HyIYJckC
         w2PHFuzg2NliBr1qvREyYf9a7PNXenKptlSbBuoWErlKsg7XLu3laOxSHT4tOEt8kK
         YpG2oGhH87fLEQgmVQxJpiZz9dvPriUxajhkE7y8=
Date:   Fri, 15 Nov 2019 11:06:35 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] mm: remove the memory isolate notifier
Message-ID: <20191115030635.GA777671@kroah.com>
References: <20191114131911.11783-1-david@redhat.com>
 <20191114131911.11783-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114131911.11783-2-david@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 02:19:10PM +0100, David Hildenbrand wrote:
> Luckily, we have no users left, so we can get rid of it. Cleanup
> set_migratetype_isolate() a little bit.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c  | 19 -------------------
>  include/linux/memory.h | 27 ---------------------------
>  mm/page_isolation.c    | 38 ++++----------------------------------
>  3 files changed, 4 insertions(+), 80 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
