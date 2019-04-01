Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71472C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7FD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142016;
	bh=YvUgUt5pc8y92KmBXjD614wVqyqxin7tMyalzY4GodA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKbMenixH6K9hPoM2GCTVgVLFm64pYWHe3S7JltXw4BO7uQQbamDQ4YhVBmMGV4CG
	 njhOC94tD6oNIdOH664RDNZz0zBKm+wdxSZhxCtFGGKYskUq5mDhzL0wzJrK3UQDlZ
	 ScWFKTU6PET5LfIWrlcj2V6Sc9Nqhv2DUrL+w408=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfDASGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfDARMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580FC21924;
        Mon,  1 Apr 2019 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138727;
        bh=YvUgUt5pc8y92KmBXjD614wVqyqxin7tMyalzY4GodA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBIHVWnyeOyViy1ozcQqrNRg5lkiJIs2wAnJ4jw4Ejln7WIMzeUt218ssYeX/vzgN
         3j8DIQREEfSR8EwwE99AjH0Tlxrm0FwuAsfGBi2dYzONswHc2kGRbB2lmAyIbPTI2d
         LxQLbmXI+T6PQyz1BZvzmpUoD3VLRADFmfo+4nRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 130/146] mm/memory_hotplug.c: fix notification in offline error path
Date:   Mon,  1 Apr 2019 19:02:22 +0200
Message-Id: <20190401170059.227328158@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qian Cai <cai@lca.pw>

commit c4efe484b5f0d768e23c9731082fec827723e738 upstream.

When start_isolate_page_range() returned -EBUSY in __offline_pages(), it
calls memory_notify(MEM_CANCEL_OFFLINE, &arg) with an uninitialized
"arg".  As the result, it triggers warnings below.  Also, it is only
necessary to notify MEM_CANCEL_OFFLINE after MEM_GOING_OFFLINE.

  page:ffffea0001200000 count:1 mapcount:0 mapping:0000000000000000
  index:0x0
  flags: 0x3fffe000001000(reserved)
  raw: 003fffe000001000 ffffea0001200008 ffffea0001200008 0000000000000000
  raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
  page dumped because: unmovable page
  WARNING: CPU: 25 PID: 1665 at mm/kasan/common.c:665
  kasan_mem_notifier+0x34/0x23b
  CPU: 25 PID: 1665 Comm: bash Tainted: G        W         5.0.0+ #94
  Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20
  10/25/2017
  RIP: 0010:kasan_mem_notifier+0x34/0x23b
  RSP: 0018:ffff8883ec737890 EFLAGS: 00010206
  RAX: 0000000000000246 RBX: ff10f0f4435f1000 RCX: f887a7a21af88000
  RDX: dffffc0000000000 RSI: 0000000000000020 RDI: ffff8881f221af88
  RBP: ffff8883ec737898 R08: ffff888000000000 R09: ffffffffb0bddcd0
  R10: ffffed103e857088 R11: ffff8881f42b8443 R12: dffffc0000000000
  R13: 00000000fffffff9 R14: dffffc0000000000 R15: 0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000560fbd31d730 CR3: 00000004049c6003 CR4: 00000000001606a0
  Call Trace:
   notifier_call_chain+0xbf/0x130
   __blocking_notifier_call_chain+0x76/0xc0
   blocking_notifier_call_chain+0x16/0x20
   memory_notify+0x1b/0x20
   __offline_pages+0x3e2/0x1210
   offline_pages+0x11/0x20
   memory_block_action+0x144/0x300
   memory_subsys_offline+0xe5/0x170
   device_offline+0x13f/0x1e0
   state_store+0xeb/0x110
   dev_attr_store+0x3f/0x70
   sysfs_kf_write+0x104/0x150
   kernfs_fop_write+0x25c/0x410
   __vfs_write+0x66/0x120
   vfs_write+0x15a/0x4f0
   ksys_write+0xd2/0x1b0
   __x64_sys_write+0x73/0xb0
   do_syscall_64+0xeb/0xb78
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f14f75cc3b8
  RSP: 002b:00007ffe84d01d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f14f75cc3b8
  RDX: 0000000000000008 RSI: 0000563f8e433d70 RDI: 0000000000000001
  RBP: 0000563f8e433d70 R08: 000000000000000a R09: 00007ffe84d018f0
  R10: 000000000000000a R11: 0000000000000246 R12: 00007f14f789e780
  R13: 0000000000000008 R14: 00007f14f7899740 R15: 0000000000000008

Link: http://lkml.kernel.org/r/20190320204255.53571-1-cai@lca.pw
Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>	[5.0.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory_hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1684,12 +1684,12 @@ static int __ref __offline_pages(unsigne
 
 failed_removal_isolated:
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal:
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
 		 reason);
-	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 	/* pushback to free area */
 	mem_hotplug_done();
 	return ret;


