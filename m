Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37A0C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B643214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Jr/O/vzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504625AbfIXLmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:42:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35840 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfIXLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:42:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so1533257edn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuhYmVDSsjLYiHNawgxRRfNixwEpzZBn/t6o9EOfLfU=;
        b=Jr/O/vzDAbi/aruyVAZ8RD/ZvodHFwWuQZwgq4LWosJC4mwjMQAhx//CTh24Z7oHqC
         UWJ9artITjzqTBXCVXlcq/LUeEUmkI3ZSVf/b/buoiGNWM/Rd2HLvYgwFz0hfJnkRjZn
         Ra8tS3YXi8byzDr223DEniG9NKmyMQmIJqQ4/9FojqlqhH5LOK05ydVd2c0gzjEsA2GN
         Ya1Yg8AAxDQ9ubKreNfL/03wyah7d6Bqv0Q7Qb8/3s3q5xzE1fxxPYp1CITaN9ZCFOCz
         S12Otd08+su1CuAGxVnvm2AYcJnz6nB499PJKxcmXJBZtR/3dYFJwSWU2ncpMgHZ71AK
         A2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuhYmVDSsjLYiHNawgxRRfNixwEpzZBn/t6o9EOfLfU=;
        b=SLT0kvuYhCKeImCq3RthysWw2VK5dQnO24YsqFQTyrRQOus6NBX9SZs1q05WwgoHEJ
         D30EH/HC8DF37hUdwMDkYZdabtw/CZHxGmIhwiGkiLBF71ShCLdF54JnteT6/o36UzW3
         5BHmAXyhRHdpsPPIsFHhkxPp6nQqgXgYyjiUIgxNrFdEf4oeVKst1xpXcCHBQUVqbLov
         msRVyo7Z5P7ftZT74XdmLv8jHpIab093eHd0pJ91qLxnScmmfH+v8zANtL+L1U8+bDk6
         n8zNx8L025h26Xz7QCm3r8JDsKqPlod/08cyS/V1o6NTKDejY7hdfjOM1A/pN8/WGQyZ
         VtFQ==
X-Gm-Message-State: APjAAAXcSE/kJ+U+i939qg2MiU2Gf8hpbO92Ey/qherPNaLbbqdh2xmU
        K80wUwm1jpxBu19QF8WrSiCq/Q==
X-Google-Smtp-Source: APXvYqyzY0ZNkQ2FDVRvqB1DFjXSOXcwdxkXSCxlPqkOW/2hELi0Wzo379Jt+pqCkN5s3qypSn9LPA==
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr2001596ejj.135.1569325362199;
        Tue, 24 Sep 2019 04:42:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t9sm180814eji.26.2019.09.24.04.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:42:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D05491022A6; Tue, 24 Sep 2019 14:42:42 +0300 (+03)
Date:   Tue, 24 Sep 2019 14:42:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 4/4] mm, page_owner, debug_pagealloc: save and dump
 freeing stack trace
Message-ID: <20190924114242.q6rtv5h6xswxigim@box>
References: <20190820131828.22684-1-vbabka@suse.cz>
 <20190820131828.22684-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131828.22684-5-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:18:28PM +0200, Vlastimil Babka wrote:
> The debug_pagealloc functionality is useful to catch buggy page allocator users
> that cause e.g. use after free or double free. When page inconsistency is
> detected, debugging is often simpler by knowing the call stack of process that
> last allocated and freed the page. When page_owner is also enabled, we record
> the allocation stack trace, but not freeing.
> 
> This patch therefore adds recording of freeing process stack trace to page
> owner info, if both page_owner and debug_pagealloc are configured and enabled.
> With only page_owner enabled, this info is not useful for the memory leak
> debugging use case. dump_page() is adjusted to print the info. An example
> result of calling __free_pages() twice may look like this (note the page last free
> stack trace):
> 
> BUG: Bad page state in process bash  pfn:13d8f8
> page:ffffc31984f63e00 refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x1affff800000000()
> raw: 01affff800000000 dead000000000100 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
> page dumped because: nonzero _refcount
> page_owner tracks the page as freed
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL)
>  prep_new_page+0x143/0x150
>  get_page_from_freelist+0x289/0x380
>  __alloc_pages_nodemask+0x13c/0x2d0
>  khugepaged+0x6e/0xc10
>  kthread+0xf9/0x130
>  ret_from_fork+0x3a/0x50
> page last free stack trace:
>  free_pcp_prepare+0x134/0x1e0
>  free_unref_page+0x18/0x90
>  khugepaged+0x7b/0xc10
>  kthread+0xf9/0x130
>  ret_from_fork+0x3a/0x50
> Modules linked in:
> CPU: 3 PID: 271 Comm: bash Not tainted 5.3.0-rc4-2.g07a1a73-default+ #57
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x85/0xc0
>  bad_page.cold+0xba/0xbf
>  rmqueue_pcplist.isra.0+0x6c5/0x6d0
>  rmqueue+0x2d/0x810
>  get_page_from_freelist+0x191/0x380
>  __alloc_pages_nodemask+0x13c/0x2d0
>  __get_free_pages+0xd/0x30
>  __pud_alloc+0x2c/0x110
>  copy_page_range+0x4f9/0x630
>  dup_mmap+0x362/0x480
>  dup_mm+0x68/0x110
>  copy_process+0x19e1/0x1b40
>  _do_fork+0x73/0x310
>  __x64_sys_clone+0x75/0x80
>  do_syscall_64+0x6e/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f10af854a10
> ...
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +
>  mm/Kconfig.debug                              |  4 +-
>  mm/page_owner.c                               | 53 ++++++++++++++-----
>  3 files changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 47d981a86e2f..e813a17d622e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -809,6 +809,8 @@
>  			enables the feature at boot time. By default, it is
>  			disabled and the system will work mostly the same as a
>  			kernel built without CONFIG_DEBUG_PAGEALLOC.
> +			Note: to get most of debug_pagealloc error reports, it's
> +			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
>  	debugpat	[X86] Enable PAT debugging
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 82b6a20898bd..327b3ebf23bf 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -21,7 +21,9 @@ config DEBUG_PAGEALLOC
>  	  Also, the state of page tracking structures is checked more often as
>  	  pages are being allocated and freed, as unexpected state changes
>  	  often happen for same reasons as memory corruption (e.g. double free,
> -	  use-after-free).
> +	  use-after-free). The error reports for these checks can be augmented
> +	  with stack traces of last allocation and freeing of the page, when
> +	  PAGE_OWNER is also selected and enabled on boot.
>  
>  	  For architectures which don't enable ARCH_SUPPORTS_DEBUG_PAGEALLOC,
>  	  fill the pages with poison patterns after free_pages() and verify
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 4a48e018dbdf..dee931184788 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -24,6 +24,9 @@ struct page_owner {
>  	short last_migrate_reason;
>  	gfp_t gfp_mask;
>  	depot_stack_handle_t handle;
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	depot_stack_handle_t free_handle;
> +#endif

I think it's possible to add space for the second stack handle at runtime:
adjust page_owner_ops->size inside the ->need(). The second stack might be
useful beyond CONFIG_DEBUG_PAGEALLOC. We probably should not tie these
features.

-- 
 Kirill A. Shutemov
