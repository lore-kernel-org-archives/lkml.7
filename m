Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02637233FE
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHTXWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:22:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46244 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHTXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:22:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so91972pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4v+ShOaPHaAWiuaNUOtHBRCqtga9ZulC8uE46GGNuXg=;
        b=IzVxJzJ9FXQ9JgQofhrBEJKTXcyMzijlM5huVofN6yMl8KALgLdHG/eDBKpWxPB3ae
         IBgOmy8UB4AschE+typL78IPWSEb363RA8JCv+4n2tSTC4Hvvoc94x1XEuJYLbV9wm9C
         lRRqJeddYEoMpfEQ1mWnK4RCladAhCKZC2ukbvPPMwBWLgmomJiDzyqMxzYmjnX0ECjQ
         9QnzFd22Un0UlXalXNJnV3EmpPzLnHOMSCErVr5PlQEIOsJTtL+MjPBe2/jkld5s7fYJ
         9fdErA4fMEZGqrX73lXUBKMBcc8YfkGgjvMsgRSqW9gbUX1uquV5T+xnmGqNomPAmcm4
         patw==
X-Gm-Message-State: APjAAAWDvza2mtACXjKXjp1v0O4/a2fBY3EIEY1qPBtMgjbchhZ8LWzB
        SE1gGbU1VXh8TMExo5tyXRTY/CKSvR8=
X-Google-Smtp-Source: APXvYqxfJMHRdvOL8ArbBkvh5e8568nZR7jefCh1KkT4bkWbF48xSVHXsMtw1BqwnAy0sOM7GKS3IQ==
X-Received: by 2002:a62:8343:: with SMTP id h64mr31380056pfe.170.1566343332256;
        Tue, 20 Aug 2019 16:22:12 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id k64sm27850253pgk.74.2019.08.20.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:22:11 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] vmw_balloon: Fix offline page marking with compaction
Date:   Tue, 20 Aug 2019 09:01:21 -0700
Message-Id: <20190820160121.452-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compaction code already marks pages as offline when it enqueues
pages in the ballooned page list, and removes the mapping when the pages
are removed from the list. VMware balloon also updates the flags,
instead of letting the balloon-compaction logic handle it, which causes
the assertion VM_BUG_ON_PAGE(!PageOffline(page)) to fire, when
__ClearPageOffline is called the second time. This causes the following
crash.

[  487.104520] kernel BUG at include/linux/page-flags.h:749!
[  487.106364] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[  487.107681] CPU: 7 PID: 1106 Comm: kworker/7:3 Not tainted 5.3.0-rc5balloon #227
[  487.109196] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
[  487.111452] Workqueue: events_freezable vmballoon_work [vmw_balloon]
[  487.112779] RIP: 0010:vmballoon_release_page_list+0xaa/0x100 [vmw_balloon]
[  487.114200] Code: fe 48 c1 e7 06 4c 01 c7 8b 47 30 41 89 c1 41 81 e1 00 01 00 f0 41 81 f9 00 00 00 f0 74 d3 48 c7 c6 08 a1 a1 c0 e8 06 0d e7 ea <0f> 0b 44 89 f6 4c 89 c7 e8 49 9c e9 ea 49 8d 75 08 49 8b 45 08 4d
[  487.118033] RSP: 0018:ffffb82f012bbc98 EFLAGS: 00010246
[  487.119135] RAX: 0000000000000037 RBX: 0000000000000001 RCX: 0000000000000006
[  487.120601] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a85b6bd7620
[  487.122071] RBP: ffffb82f012bbcc0 R08: 0000000000000001 R09: 0000000000000000
[  487.123536] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb82f012bbd00
[  487.125002] R13: ffffe97f4598d9c0 R14: 0000000000000000 R15: ffffb82f012bbd34
[  487.126463] FS:  0000000000000000(0000) GS:ffff9a85b6bc0000(0000) knlGS:0000000000000000
[  487.128110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  487.129316] CR2: 00007ffe6e413ea0 CR3: 0000000230b18001 CR4: 00000000003606e0
[  487.130812] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  487.132283] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  487.133749] Call Trace:
[  487.134333]  vmballoon_deflate+0x22c/0x390 [vmw_balloon]
[  487.135468]  vmballoon_work+0x6e7/0x913 [vmw_balloon]
[  487.136711]  ? process_one_work+0x21a/0x5e0
[  487.138581]  process_one_work+0x298/0x5e0
[  487.139926]  ? vmballoon_migratepage+0x310/0x310 [vmw_balloon]
[  487.141610]  ? process_one_work+0x298/0x5e0
[  487.143053]  worker_thread+0x41/0x400
[  487.144389]  kthread+0x12b/0x150
[  487.145582]  ? process_one_work+0x5e0/0x5e0
[  487.146937]  ? kthread_create_on_node+0x60/0x60
[  487.148637]  ret_from_fork+0x3a/0x50

Fix it by updating the PageOffline indication only when a 2MB page is
enqueued and dequeued. The 4KB pages will be handled correctly by the
balloon compaction logic.

Fixes: 83a8afa72e9c ("vmw_balloon: Compaction support")
Cc: David Hildenbrand <david@redhat.com>
Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 8840299420e0..5e6be1527571 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -691,7 +691,6 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 		}
 
 		if (page) {
-			vmballoon_mark_page_offline(page, ctl->page_size);
 			/* Success. Add the page to the list and continue. */
 			list_add(&page->lru, &ctl->pages);
 			continue;
@@ -930,7 +929,6 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 
 	list_for_each_entry_safe(page, tmp, page_list, lru) {
 		list_del(&page->lru);
-		vmballoon_mark_page_online(page, page_size);
 		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
@@ -1005,6 +1003,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 					enum vmballoon_page_size_type page_size)
 {
 	unsigned long flags;
+	struct page *page;
 
 	if (page_size == VMW_BALLOON_4K_PAGE) {
 		balloon_page_list_enqueue(&b->b_dev_info, pages);
@@ -1014,6 +1013,11 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 		 * for the balloon compaction mechanism.
 		 */
 		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
+
+		list_for_each_entry(page, pages, lru) {
+			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
+		}
+
 		list_splice_init(pages, &b->huge_pages);
 		__count_vm_events(BALLOON_INFLATE, *n_pages *
 				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
@@ -1056,6 +1060,8 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	/* 2MB pages */
 	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
 	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
+		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
+
 		list_move(&page->lru, pages);
 		if (++i == n_req_pages)
 			break;
-- 
2.19.1

