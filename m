Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F413C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FA4214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440796AbfIXLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395105AbfIXLLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E43EF7FDCA;
        Tue, 24 Sep 2019 11:11:54 +0000 (UTC)
Received: from localhost (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D92860603;
        Tue, 24 Sep 2019 11:11:53 +0000 (UTC)
Date:   Tue, 24 Sep 2019 19:11:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] memcg: Only record foreign writebacks with dirty pages
 when memcg is not disabled
Message-ID: <20190924111138.GA31919@MiWiFi-R3L-srv>
References: <20190923083030.6442-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923083030.6442-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 24 Sep 2019 11:11:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel, memcg usually is disabled with 'cgroup_disable=memory'
for saving memory. Now kdump kernel will always panic when dump vmcore
to local disk:

BUG: kernel NULL pointer dereference, address: 0000000000000ab8
PGD 5fcab067 P4D 5fcab067 PUD 5ff73067 PMD 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 598 Comm: makedumpfile Not tainted 5.3.0+ #26
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
RIP: 0010:mem_cgroup_track_foreign_dirty_slowpath+0x38/0x140
Code: 55 48 8b 2d 6a bd 12 01 53 4c 8b 67 38 0f 1f 44 00 00 49 8b 06 48 89 e9 31 db be ff ff ff ff 48 8b 38 49 8d 84 24 d0 0a 00 00 <48> 39 78 e8
74 5a 48 8b 50 f8 48 39 ca 79 0e 44 8b 00 41 83 f8 01
RSP: 0018:ffffbc9300817bd0 EFLAGS: 00010046
RAX: 0000000000000ad0 RBX: 0000000000000000 RCX: 00000000fffba227
RDX: fffffffffffffff8 RSI: 00000000ffffffff RDI: 0000000000000004
RBP: 00000000fffba227 R08: 0000000000030340 R09: ffffbc9300817d10
R10: 0000000000000000 R11: 0000000000001000 R12: 0000000000000000
R13: ffff999c1fa2bcf0 R14: ffff999c1f7bcc78 R15: ffffe51fc177a8c0
FS:  00007f84f14c2b80(0000) GS:ffff999c22200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000ab8 CR3: 000000005f564000 CR4: 00000000003406b0
Call Trace:
 __set_page_dirty+0x52/0xc0
 iomap_set_page_dirty+0x50/0x90
 iomap_write_end+0x6e/0x270
 iomap_write_actor+0xce/0x170
 ? iomap_write_end+0x270/0x270
 iomap_apply+0xba/0x11e
 ? iomap_write_end+0x270/0x270
 iomap_file_buffered_write+0x62/0x90
 ? iomap_write_end+0x270/0x270
 xfs_file_buffered_aio_write+0xca/0x320 [xfs]
 new_sync_write+0x12d/0x1d0
 vfs_write+0xa5/0x1a0
 ksys_write+0x59/0xd0
 do_syscall_64+0x59/0x1e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f84f1093ab5

And this will corrupt the 1st kernel too with 'cgroup_disable=memory'.

From the trace and with debugging, it is pointing to commit 97b27821b485
("writeback, memcg: Implement foreign dirty flushing") which introduced
this regression. Disabling memcg causes the null pointer dereference at
uninitialized data in function mem_cgroup_track_foreign_dirty_slowpath().

Fix it by returning directly if memcg is disabled, but not trying to
record the foreign writebacks with dirty pages.

Fixed: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Move the checking code into mem_cgroup_track_foreign_dirty_slowpath()
  because usually memcg is enabled by default, and the original condition
  checking in mem_cgroup_track_foreign_dirty() is more unlikely being
  true to make it return.

 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f3c15bb07cce..84e3fdb1ccb4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4317,6 +4317,9 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 
 	trace_track_foreign_dirty(page, wb);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
-- 
2.17.2

