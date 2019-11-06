Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259BC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF532173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573053819;
	bh=X+YH5JAUqnyLSy4pbm3uTxZ5dvpE9FRN6x8yiM26nbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkz8n/5nU9OGfGjpYQrYlJZWw8Nccx/r93Elp9B+SUnQ9t1FIq+4d3Gwx34qKqXd1
	 kIhH3pXVpdmhQ0oqCvO7xg0pjjuAzgqFqcQ3v43Onux+IQ6EUDGY2nSmqF1aVg8g/r
	 ESPZtToNsYW3iIbavWLRCQirXEG7ICR8eIVPZCsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfKFPXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:23:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:49254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfKFPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:23:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6EB9B57E;
        Wed,  6 Nov 2019 15:23:35 +0000 (UTC)
Date:   Wed, 6 Nov 2019 16:23:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: move definitions of
 {set,clear}_zone_contiguous
Message-ID: <20191106152335.GC8138@dhcp22.suse.cz>
References: <20191106123911.7435-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106123911.7435-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 12:39:11, Ben Dooks (Codethink) wrote:
> The {set,clear}_zone_contiguous are built whatever the
> configuraiton so move the definitions outside the current
> ifdef to avoid the following compiler warnings:
> 
> mm/page_alloc.c:1550:6: warning: no previous prototype for âset_zone_contiguousâ [-Wmissing-prototypes]
> mm/page_alloc.c:1571:6: warning: no previous prototype for âclear_zone_contiguousâ [-Wmissing-prototypes]
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/memory_hotplug.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f46ea71b4ffd..6a6456040802 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -229,9 +229,6 @@ void put_online_mems(void);
>  void mem_hotplug_begin(void);
>  void mem_hotplug_done(void);
>  
> -extern void set_zone_contiguous(struct zone *zone);
> -extern void clear_zone_contiguous(struct zone *zone);
> -
>  #else /* ! CONFIG_MEMORY_HOTPLUG */
>  #define pfn_to_online_page(pfn)			\
>  ({						\
> @@ -339,6 +336,9 @@ static inline int remove_memory(int nid, u64 start, u64 size)
>  static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> +extern void set_zone_contiguous(struct zone *zone);
> +extern void clear_zone_contiguous(struct zone *zone);
> +
>  extern void __ref free_area_init_core_hotplug(int nid);
>  extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
> -- 
> 2.24.0.rc1

-- 
Michal Hocko
SUSE Labs
