Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1BFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C46E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="L6EyKcHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfJBVh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:37:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44748 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:37:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so216168qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFUfxxApQM/wOvv7cwP36LDDkmb0Ckr8pi1d84sDhxQ=;
        b=L6EyKcHiu04K/islvAwkUEMgORzQSKx5TpajWgelNjt/ueqnHPxO2yUNPSJHd7oXK3
         sfJwSi5zTinflkXUQWcNQPPyI9rVD7/fM0f9UQJCKVaynbLwbo0qoT6W6cRHti/occLH
         pkZRRbAQWW8vgwdDbT0MWEz9/5aul+kc4nxOAgc/ckJKu4D8LRlzZ0Ct0qPsAiDwo6GB
         OKsl39hQr5GoNdAHREF6Mgu7DNFT0q2BH/aL4y+tiuwH4Q8KYgETKC9+O/ZK33g0bU8l
         22b5WTvQnI0pPHkETYdzjoky16uEbAKAJ0W0L7Erd1fR1y+cK+o7F9peYa+3zeHfZ5va
         gjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFUfxxApQM/wOvv7cwP36LDDkmb0Ckr8pi1d84sDhxQ=;
        b=odQrl6GzpaBdnhNUYp/0HhZWUR7neEUjvWfWXI06NfEG8aQIFqFqLy6ty7pnrlKSPi
         yo6iXL0eXM9lTzE1ZIHIVjhDXmmUtybg6fXZ/m8L2+F7lHyzX+/AZJQ5Loct0MMMUHgG
         ZG59jloZyFPkDZJ5O4da5BMkilf3utwnBwu1M+R2GDTWaYGqKdlbmgC/5WBtGfluvhs8
         QuOWFLPlTsG/OHaY8n7zNWXYMm9uZ5A6sMBR4HZSGrKu5+W43oNP+VH/RUea3YVAr+tF
         yUHgXiCifCSc2gsfR4PlXVeHkKx5C1rm+Oe33zFqCsdZS1BQqhbw0SxwN1Uf7YxI0oVe
         PoDw==
X-Gm-Message-State: APjAAAWB9QOXhV+RZ5+pwq2PmONWQmQQWl14IyFgUimE6M2ynwdjWXOQ
        YlJcKmkpfOA+sBuiu2Cs0BWk35LuPS0=
X-Google-Smtp-Source: APXvYqwQJsoFFpm6x25BeaMqpbL8UY4PdxdZEVr4bEgnaXGS3uuDvF2zV8ZkMakf/dgAsRknl3i9jA==
X-Received: by 2002:a05:620a:5b5:: with SMTP id q21mr984182qkq.160.1570052245160;
        Wed, 02 Oct 2019 14:37:25 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v26sm404185qta.88.2019.10.02.14.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:37:24 -0700 (PDT)
Message-ID: <1570052242.5576.266.camel@lca.pw>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 02 Oct 2019 17:37:22 -0400
In-Reply-To: <20190924143615.19628-1-david@redhat.com>
References: <20190924143615.19628-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-24 at 16:36 +0200, David Hildenbrand wrote:
> Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
> rwsem") we do a cpus_read_lock() in mem_hotplug_begin(). This was
> introduced to fix a potential deadlock between get_online_mems() and
> get_online_cpus() - the memory and cpu hotplug lock. The root issue was
> that build_all_zonelists() -> stop_machine() required the cpu hotplug lock:
>     The reason is that memory hotplug takes the memory hotplug lock and
>     then calls stop_machine() which calls get_online_cpus().  That's the
>     reverse lock order to get_online_cpus(); get_online_mems(); in
>     mm/slub_common.c
> 
> So memory hotplug never really required any cpu lock itself, only
> stop_machine() and lru_add_drain_all() required it. Back then,
> stop_machine_cpuslocked() and lru_add_drain_all_cpuslocked() were used
> as the cpu hotplug lock was now obtained in the caller.
> 
> Since commit 11cd8638c37f ("mm, page_alloc: remove stop_machine from build
> all_zonelists"), the stop_machine_cpuslocked() call is gone.
> build_all_zonelists() does no longer require the cpu lock and does no
> longer make use of stop_machine().
> 
> Since commit 9852a7212324 ("mm: drop hotplug lock from
> lru_add_drain_all()"), lru_add_drain_all() "Doesn't need any cpu hotplug
> locking because we do rely on per-cpu kworkers being shut down before our
> page_alloc_cpu_dead callback is executed on the offlined cpu.". The
> lru_add_drain_all_cpuslocked() variant was removed.
> 
> So there is nothing left that requires the cpu hotplug lock. The memory
> hotplug lock and the device hotplug lock are sufficient.

Actually, powerpc does,

arch_add_memory()
  resize_hpt_for_hotplug()
    pseries_lpar_resize_hpt()
      stop_machine_cpuslocked()

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> RFC -> v1:
> - Reword and add more details why the cpu hotplug lock was needed here
>   in the first place, and why we no longer require it.
> 
> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c3e9aed6023f..5fa30f3010e1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -88,14 +88,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
>  
>  void mem_hotplug_begin(void)
>  {
> -	cpus_read_lock();
>  	percpu_down_write(&mem_hotplug_lock);
>  }
>  
>  void mem_hotplug_done(void)
>  {
>  	percpu_up_write(&mem_hotplug_lock);
> -	cpus_read_unlock();
>  }
>  
>  u64 max_mem_size = U64_MAX;
