Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C34C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF95E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552545224;
	bh=QkNstHU9k9hG+M4gHXh58xvFyWF6iVw6/PGPuyEdl4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tO/GXkpOMQmIT7xOdBPcgWJe0xEs2S2JyQG8+tLQ3SzTiPqYDXAEfOpg89+IaqMge
	 BAdPpr0+xcL4KOHCUOCUCMOveJQW06v0GMRRNsq/JVX8C2bQ+IViApDv64quwAdo5I
	 Nz2a0IvQtuU5BaYhzR8AteB0xYvl2Lxi1XClhQHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCNGdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:33:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfCNGdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:33:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E335BAD84;
        Thu, 14 Mar 2019 06:33:39 +0000 (UTC)
Date:   Thu, 14 Mar 2019 07:33:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix notification in offline error path
Message-ID: <20190314063338.GB7473@dhcp22.suse.cz>
References: <20190313210939.49628-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313210939.49628-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 17:09:39, Qian Cai wrote:
> When start_isolate_page_range() returned -EBUSY in __offline_pages(), it
> calls memory_notify(MEM_CANCEL_OFFLINE, &arg) with an uninitialized
> "arg". As the result, it triggers warnings below. Also, it is only
> necessary to notify MEM_CANCEL_OFFLINE after MEM_GOING_OFFLINE.
> 
> page:ffffea0001200000 count:1 mapcount:0 mapping:0000000000000000
> index:0x0
> flags: 0x3fffe000001000(reserved)
> raw: 003fffe000001000 ffffea0001200008 ffffea0001200008 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: unmovable page
> WARNING: CPU: 25 PID: 1665 at mm/kasan/common.c:665
> kasan_mem_notifier+0x34/0x23b
> CPU: 25 PID: 1665 Comm: bash Tainted: G        W         5.0.0+ #94
> Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20
> 10/25/2017
> RIP: 0010:kasan_mem_notifier+0x34/0x23b
> RSP: 0018:ffff8883ec737890 EFLAGS: 00010206
> RAX: 0000000000000246 RBX: ff10f0f4435f1000 RCX: f887a7a21af88000
> RDX: dffffc0000000000 RSI: 0000000000000020 RDI: ffff8881f221af88
> RBP: ffff8883ec737898 R08: ffff888000000000 R09: ffffffffb0bddcd0
> R10: ffffed103e857088 R11: ffff8881f42b8443 R12: dffffc0000000000
> R13: 00000000fffffff9 R14: dffffc0000000000 R15: 0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000560fbd31d730 CR3: 00000004049c6003 CR4: 00000000001606a0
> Call Trace:
>  notifier_call_chain+0xbf/0x130
>  __blocking_notifier_call_chain+0x76/0xc0
>  blocking_notifier_call_chain+0x16/0x20
>  memory_notify+0x1b/0x20
>  __offline_pages+0x3e2/0x1210
>  offline_pages+0x11/0x20
>  memory_block_action+0x144/0x300
>  memory_subsys_offline+0xe5/0x170
>  device_offline+0x13f/0x1e0
>  state_store+0xeb/0x110
>  dev_attr_store+0x3f/0x70
>  sysfs_kf_write+0x104/0x150
>  kernfs_fop_write+0x25c/0x410
>  __vfs_write+0x66/0x120
>  vfs_write+0x15a/0x4f0
>  ksys_write+0xd2/0x1b0
>  __x64_sys_write+0x73/0xb0
>  do_syscall_64+0xeb/0xb78
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f14f75cc3b8
> RSP: 002b:00007ffe84d01d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f14f75cc3b8
> RDX: 0000000000000008 RSI: 0000563f8e433d70 RDI: 0000000000000001
> RBP: 0000563f8e433d70 R08: 000000000000000a R09: 00007ffe84d018f0
> R10: 000000000000000a R11: 0000000000000246 R12: 00007f14f789e780
> R13: 0000000000000008 R14: 00007f14f7899740 R15: 0000000000000008
> 
> Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")

Cc: stable # 5.0

> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8ffe844766da..1559c1605072 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1703,12 +1703,12 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  failed_removal_isolated:
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> +	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal:
>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> -	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  	/* pushback to free area */
>  	mem_hotplug_done();
>  	return ret;
> -- 
> 2.17.2 (Apple Git-113)

-- 
Michal Hocko
SUSE Labs
