Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B64C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC328218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611200;
	bh=E1ZIMVNeoXwe262pymLdB9B4iFowt+1ZgtTXVXUvs3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qNPguGppST1jibm03jUYmQA7HJNikq7e63BIkBny6a1QZ4SE32KyS7hECZgmN2vcL
	 yOy7cAoJo3pa1cUWPi74Roxe5/fIKiDf6z9RlEGiGQWi5UXak3UdXOw90/8BE4c933
	 0ptajwEu2S35b4W0v0O57njVrIsvKYOuAC+WROgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404411AbfDRSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392014AbfDRSNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA6A206B6;
        Thu, 18 Apr 2019 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611189;
        bh=E1ZIMVNeoXwe262pymLdB9B4iFowt+1ZgtTXVXUvs3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1Dj4a0rAoM6AzNgBPPO6rHeaHrDMXZ9kg3v15S0k0/taXUloFgjJb/Y/b+xI1YI/
         M8CjtT3UzwJ1fzN/PdThs13eeUIQ+Bq+mtf3lYG1UXRgTG4zBgHsGy2bZsO0Ov/LV1
         hE0jaB8JUY8D1lZud5q10N0XZgeADA1RK/wle4d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paulo Alcantara (SUSE)" <paulo@paulo.ac>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 65/93] cifs: Fix slab-out-of-bounds when tracing SMB tcon
Date:   Thu, 18 Apr 2019 19:57:43 +0200
Message-Id: <20190418160443.923876658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 68ddb496800acdb46172b4981dc3753ea9b39c25 ]

This patch fixes the following KASAN report:

[  779.044746] BUG: KASAN: slab-out-of-bounds in string+0xab/0x180
[  779.044750] Read of size 1 at addr ffff88814f327968 by task trace-cmd/2812

[  779.044756] CPU: 1 PID: 2812 Comm: trace-cmd Not tainted 5.1.0-rc1+ #62
[  779.044760] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-0-ga698c89-prebuilt.qemu.org 04/01/2014
[  779.044761] Call Trace:
[  779.044769]  dump_stack+0x5b/0x90
[  779.044775]  ? string+0xab/0x180
[  779.044781]  print_address_description+0x6c/0x23c
[  779.044787]  ? string+0xab/0x180
[  779.044792]  ? string+0xab/0x180
[  779.044797]  kasan_report.cold.3+0x1a/0x32
[  779.044803]  ? string+0xab/0x180
[  779.044809]  string+0xab/0x180
[  779.044816]  ? widen_string+0x160/0x160
[  779.044822]  ? vsnprintf+0x5bf/0x7f0
[  779.044829]  vsnprintf+0x4e7/0x7f0
[  779.044836]  ? pointer+0x4a0/0x4a0
[  779.044841]  ? seq_buf_vprintf+0x79/0xc0
[  779.044848]  seq_buf_vprintf+0x62/0xc0
[  779.044855]  trace_seq_printf+0x113/0x210
[  779.044861]  ? trace_seq_puts+0x110/0x110
[  779.044867]  ? trace_raw_output_prep+0xd8/0x110
[  779.044876]  trace_raw_output_smb3_tcon_class+0x9f/0xc0
[  779.044882]  print_trace_line+0x377/0x890
[  779.044888]  ? tracing_buffers_read+0x300/0x300
[  779.044893]  ? ring_buffer_read+0x58/0x70
[  779.044899]  s_show+0x6e/0x140
[  779.044906]  seq_read+0x505/0x6a0
[  779.044913]  vfs_read+0xaf/0x1b0
[  779.044919]  ksys_read+0xa1/0x130
[  779.044925]  ? kernel_write+0xa0/0xa0
[  779.044931]  ? __do_page_fault+0x3d5/0x620
[  779.044938]  do_syscall_64+0x63/0x150
[  779.044944]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  779.044949] RIP: 0033:0x7f62c2c2db31
[ 779.044955] Code: fe ff ff 48 8d 3d 17 9e 09 00 48 83 ec 08 e8 96 02
02 00 66 0f 1f 44 00 00 8b 05 fa fc 2c 00 48 63 ff 85 c0 75 13 31 c0
0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48
89
[  779.044958] RSP: 002b:00007ffd6e116678 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  779.044964] RAX: ffffffffffffffda RBX: 0000560a38be9260 RCX: 00007f62c2c2db31
[  779.044966] RDX: 0000000000002000 RSI: 00007ffd6e116710 RDI: 0000000000000003
[  779.044966] RDX: 0000000000002000 RSI: 00007ffd6e116710 RDI: 0000000000000003
[  779.044969] RBP: 00007f62c2ef5420 R08: 0000000000000000 R09: 0000000000000003
[  779.044972] R10: ffffffffffffffa8 R11: 0000000000000246 R12: 00007ffd6e116710
[  779.044975] R13: 0000000000002000 R14: 0000000000000d68 R15: 0000000000002000

[  779.044981] Allocated by task 1257:
[  779.044987]  __kasan_kmalloc.constprop.5+0xc1/0xd0
[  779.044992]  kmem_cache_alloc+0xad/0x1a0
[  779.044997]  getname_flags+0x6c/0x2a0
[  779.045003]  user_path_at_empty+0x1d/0x40
[  779.045008]  do_faccessat+0x12a/0x330
[  779.045012]  do_syscall_64+0x63/0x150
[  779.045017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  779.045019] Freed by task 1257:
[  779.045023]  __kasan_slab_free+0x12e/0x180
[  779.045029]  kmem_cache_free+0x85/0x1b0
[  779.045034]  filename_lookup.part.70+0x176/0x250
[  779.045039]  do_faccessat+0x12a/0x330
[  779.045043]  do_syscall_64+0x63/0x150
[  779.045048]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  779.045052] The buggy address belongs to the object at ffff88814f326600
which belongs to the cache names_cache of size 4096
[  779.045057] The buggy address is located 872 bytes to the right of
4096-byte region [ffff88814f326600, ffff88814f327600)
[  779.045058] The buggy address belongs to the page:
[  779.045062] page:ffffea00053cc800 count:1 mapcount:0 mapping:ffff88815b191b40 index:0x0 compound_mapcount: 0
[  779.045067] flags: 0x200000000010200(slab|head)
[  779.045075] raw: 0200000000010200 dead000000000100 dead000000000200 ffff88815b191b40
[  779.045081] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
[  779.045083] page dumped because: kasan: bad access detected

[  779.045085] Memory state around the buggy address:
[  779.045089]  ffff88814f327800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  779.045093]  ffff88814f327880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  779.045097] >ffff88814f327900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  779.045099]                                                           ^
[  779.045103]  ffff88814f327980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  779.045107]  ffff88814f327a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  779.045109] ==================================================================
[  779.045110] Disabling lock debugging due to kernel taint

Correctly assign tree name str for smb3_tcon event.

Signed-off-by: Paulo Alcantara (SUSE) <paulo@paulo.ac>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
index 59be48206932..b49bc925fb4f 100644
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
@@ -378,19 +378,19 @@ DECLARE_EVENT_CLASS(smb3_tcon_class,
 		__field(unsigned int, xid)
 		__field(__u32, tid)
 		__field(__u64, sesid)
-		__field(const char *,  unc_name)
+		__string(name, unc_name)
 		__field(int, rc)
 	),
 	TP_fast_assign(
 		__entry->xid = xid;
 		__entry->tid = tid;
 		__entry->sesid = sesid;
-		__entry->unc_name = unc_name;
+		__assign_str(name, unc_name);
 		__entry->rc = rc;
 	),
 	TP_printk("xid=%u sid=0x%llx tid=0x%x unc_name=%s rc=%d",
 		__entry->xid, __entry->sesid, __entry->tid,
-		__entry->unc_name, __entry->rc)
+		__get_str(name), __entry->rc)
 )
 
 #define DEFINE_SMB3_TCON_EVENT(name)          \
-- 
2.19.1



