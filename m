Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D55CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED020684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571785878;
	bh=JjSlb4m7LKOUcgdQA7mlpDxGQQjQIrdM30z6C96PXCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AIYYqXDmNEYt8rZBEInyrKI+hPdrPkcCST3ieeViQd6aMYPRTTYdrCk8Ul/F23twd
	 JvfaTGqxj0doNrwJF9svlspI/JmwsraDv9rSD3cSKVIViSWxSnMHX/6ftMGrKoTJhW
	 EeYAgkngTxokz1rsiyoWbiPdR0vKFJ2ajHf5Tccs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbfJVXKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfJVXKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:10:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F92F20700;
        Tue, 22 Oct 2019 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571785846;
        bh=JjSlb4m7LKOUcgdQA7mlpDxGQQjQIrdM30z6C96PXCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXLHmUcqD7kZJKs+FUFkcCnpAokDjFTxsKxDN2yqwPK6aEvcjnpbzXBvtIcTdpQSY
         /GIT5cuPzev1z46Gl8Xp4xZhBFmW9ssQdBJfozx68VB4fDJIjPwh7onC4lKKZGH8L/
         JmIFohHToZpgDWHGA3VRn6cyJk86Bw0k2HDgxSIM=
Date:   Tue, 22 Oct 2019 16:10:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+667740df862911577d63@syzkaller.appspotmail.com>
Cc:     hughd@google.com, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: linux-next test error: WARNING in collapse_file
Message-Id: <20191022161045.3ba1aa9b537455de6c5e4513@linux-foundation.org>
In-Reply-To: <0000000000000b75de0595878a3e@google.com>
References: <0000000000000b75de0595878a3e@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 15:44:12 -0700 syzbot <syzbot+667740df862911577d63@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a722f75b Add linux-next specific files for 20191022
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=126aea5b600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32434321999f01e9
> dashboard link: https://syzkaller.appspot.com/bug?extid=667740df862911577d63
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+667740df862911577d63@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1080 at mm/khugepaged.c:1643  
> collapse_file+0x1f9d/0x4170 mm/khugepaged.c:1643
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 1080 Comm: khugepaged Not tainted 5.4.0-rc4-next-20191022 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2e3/0x75c kernel/panic.c:221
>   __warn.cold+0x2f/0x35 kernel/panic.c:582
>   report_bug+0x289/0x300 lib/bug.c:195
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   fixup_bug arch/x86/kernel/traps.c:169 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:collapse_file+0x1f9d/0x4170 mm/khugepaged.c:1643
> Code: a1 c0 ff 31 c9 ba 01 00 00 00 4c 89 fe 48 8b bd c0 fe ff ff e8 e4 e9  
> ec ff e9 b4 fd ff ff 4c 8b bd 88 fe ff ff e8 93 a1 c0 ff <0f> 0b 4c 8b a3  
> 50 ff ff ff c7 85 80 fe ff ff 00 00 00 00 e9 05 f6
> RSP: 0018:ffff8880a818fad0 EFLAGS: 00010293
> RAX: ffff8880a7dd8440 RBX: ffff8880a818fc88 RCX: ffffffff81b2b688
> RDX: 0000000000000000 RSI: ffffffff81b2b9ad RDI: 0000000000000001
> RBP: ffff8880a818fcb0 R08: ffff8880a7dd8440 R09: fffff940004942b9
> R10: fffff940004942b8 R11: ffffea00024a15c7 R12: 0000000000000001
> R13: ffffea0002383a08 R14: 0000000000000000 R15: ffffea0002338000
>   khugepaged_scan_file mm/khugepaged.c:1881 [inline]
>   khugepaged_scan_mm_slot mm/khugepaged.c:1979 [inline]
>   khugepaged_do_scan mm/khugepaged.c:2063 [inline]
>   khugepaged+0x2da9/0x4360 mm/khugepaged.c:2108
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Thanks.  This should be fixed in v4:


From: Song Liu <songliubraving@fb.com>
Subject: mmthp-recheck-each-page-before-collapsing-file-thp-v4

Trigger filemap_flush() for PageDirty() case.  This covers one-off
situation, where the file hasn't been flushed since first write.

Link: http://lkml.kernel.org/r/20191022191006.411277-1-songliubraving@fb.com
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Song Liu <songliubraving@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/khugepaged.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/mm/khugepaged.c~mmthp-recheck-each-page-before-collapsing-file-thp-v4
+++ a/mm/khugepaged.c
@@ -1636,11 +1636,20 @@ static void collapse_file(struct mm_stru
 			goto out_unlock;
 		}
 
-		/*
-		 * khugepaged should not try to collapse dirty pages for
-		 * file THP. Show warning if this somehow happens.
-		 */
-		if (WARN_ON_ONCE(!is_shmem && PageDirty(page))) {
+		if (!is_shmem && PageDirty(page)) {
+			/*
+			 * khugepaged only works on read-only fd, so this
+			 * page is dirty because it hasn't been flushed
+			 * since first write. There won't be new dirty
+			 * pages.
+			 *
+			 * Trigger async flush here and hope the writeback
+			 * is done when khugepaged revisits this page.
+			 *
+			 * This is a one-off situation. We are not forcing
+			 * writeback in loop.
+			 */
+			filemap_flush(mapping);
 			result = SCAN_FAIL;
 			goto out_unlock;
 		}
_

