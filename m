Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3C22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfHUIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfHUIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 191A78AC6FF;
        Wed, 21 Aug 2019 08:30:32 +0000 (UTC)
Received: from [10.36.118.29] (unknown [10.36.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 464EF5D6B7;
        Wed, 21 Aug 2019 08:30:30 +0000 (UTC)
Subject: Re: [PATCH] vmw_balloon: Fix offline page marking with compaction
To:     Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>
References: <20190820160121.452-1-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <291b8bcd-df68-3f5e-2985-fcaa46c1ff38@redhat.com>
Date:   Wed, 21 Aug 2019 10:30:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820160121.452-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 21 Aug 2019 08:30:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.19 18:01, Nadav Amit wrote:
> The compaction code already marks pages as offline when it enqueues
> pages in the ballooned page list, and removes the mapping when the pages
> are removed from the list. VMware balloon also updates the flags,
> instead of letting the balloon-compaction logic handle it, which causes
> the assertion VM_BUG_ON_PAGE(!PageOffline(page)) to fire, when
> __ClearPageOffline is called the second time. This causes the following
> crash.
> 
> [  487.104520] kernel BUG at include/linux/page-flags.h:749!
> [  487.106364] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> [  487.107681] CPU: 7 PID: 1106 Comm: kworker/7:3 Not tainted 5.3.0-rc5balloon #227
> [  487.109196] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
> [  487.111452] Workqueue: events_freezable vmballoon_work [vmw_balloon]
> [  487.112779] RIP: 0010:vmballoon_release_page_list+0xaa/0x100 [vmw_balloon]
> [  487.114200] Code: fe 48 c1 e7 06 4c 01 c7 8b 47 30 41 89 c1 41 81 e1 00 01 00 f0 41 81 f9 00 00 00 f0 74 d3 48 c7 c6 08 a1 a1 c0 e8 06 0d e7 ea <0f> 0b 44 89 f6 4c 89 c7 e8 49 9c e9 ea 49 8d 75 08 49 8b 45 08 4d
> [  487.118033] RSP: 0018:ffffb82f012bbc98 EFLAGS: 00010246
> [  487.119135] RAX: 0000000000000037 RBX: 0000000000000001 RCX: 0000000000000006
> [  487.120601] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a85b6bd7620
> [  487.122071] RBP: ffffb82f012bbcc0 R08: 0000000000000001 R09: 0000000000000000
> [  487.123536] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb82f012bbd00
> [  487.125002] R13: ffffe97f4598d9c0 R14: 0000000000000000 R15: ffffb82f012bbd34
> [  487.126463] FS:  0000000000000000(0000) GS:ffff9a85b6bc0000(0000) knlGS:0000000000000000
> [  487.128110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  487.129316] CR2: 00007ffe6e413ea0 CR3: 0000000230b18001 CR4: 00000000003606e0
> [  487.130812] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  487.132283] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  487.133749] Call Trace:
> [  487.134333]  vmballoon_deflate+0x22c/0x390 [vmw_balloon]
> [  487.135468]  vmballoon_work+0x6e7/0x913 [vmw_balloon]
> [  487.136711]  ? process_one_work+0x21a/0x5e0
> [  487.138581]  process_one_work+0x298/0x5e0
> [  487.139926]  ? vmballoon_migratepage+0x310/0x310 [vmw_balloon]
> [  487.141610]  ? process_one_work+0x298/0x5e0
> [  487.143053]  worker_thread+0x41/0x400
> [  487.144389]  kthread+0x12b/0x150
> [  487.145582]  ? process_one_work+0x5e0/0x5e0
> [  487.146937]  ? kthread_create_on_node+0x60/0x60
> [  487.148637]  ret_from_fork+0x3a/0x50
> 
> Fix it by updating the PageOffline indication only when a 2MB page is
> enqueued and dequeued. The 4KB pages will be handled correctly by the
> balloon compaction logic.
> 
> Fixes: 83a8afa72e9c ("vmw_balloon: Compaction support")
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  drivers/misc/vmw_balloon.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 8840299420e0..5e6be1527571 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -691,7 +691,6 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>  		}
>  
>  		if (page) {
> -			vmballoon_mark_page_offline(page, ctl->page_size);
>  			/* Success. Add the page to the list and continue. */
>  			list_add(&page->lru, &ctl->pages);
>  			continue;
> @@ -930,7 +929,6 @@ static void vmballoon_release_page_list(struct list_head *page_list,
>  
>  	list_for_each_entry_safe(page, tmp, page_list, lru) {
>  		list_del(&page->lru);
> -		vmballoon_mark_page_online(page, page_size);
>  		__free_pages(page, vmballoon_page_order(page_size));
>  	}
>  
> @@ -1005,6 +1003,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  					enum vmballoon_page_size_type page_size)
>  {
>  	unsigned long flags;
> +	struct page *page;
>  
>  	if (page_size == VMW_BALLOON_4K_PAGE) {
>  		balloon_page_list_enqueue(&b->b_dev_info, pages);
> @@ -1014,6 +1013,11 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  		 * for the balloon compaction mechanism.
>  		 */
>  		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> +
> +		list_for_each_entry(page, pages, lru) {
> +			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
> +		}
> +
>  		list_splice_init(pages, &b->huge_pages);
>  		__count_vm_events(BALLOON_INFLATE, *n_pages *
>  				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
> @@ -1056,6 +1060,8 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  	/* 2MB pages */
>  	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
> +		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
> +
>  		list_move(&page->lru, pages);
>  		if (++i == n_req_pages)
>  			break;
> 

Or check in vmballoon_mark_page_online/vmballoon_mark_page_offline if
already properly marked, adding a comment. But what you have should also
work.

-- 

Thanks,

David / dhildenb
