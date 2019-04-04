Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADB3217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368059;
	bh=tcVl1G8z0d5PncOzfNypc82gV82guUmh6QsgFcaFWZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ii9OMvfjptMfpm4nCe0qku34f4Eq8wpRhUeyd0lrsBzKPrwr7fbBVeoMXGkirPpmQ
	 Hixbo6XDGTGo7QYnS7F2orpNhyk//p5L3uyabeuxqN/hKWZGjV2wY2aAl03pHIkXci
	 zYXJNg04euxsRJ0EL9TDNsgGvLCswTvMtc5ZTilk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfDDIyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbfDDIyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1152217D4;
        Thu,  4 Apr 2019 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368055;
        bh=tcVl1G8z0d5PncOzfNypc82gV82guUmh6QsgFcaFWZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR7ejfO88yyDdlajgABQpkXfZq62BT+yWrQB2a2GBd0DcMBRWCfH5vN41WPg86qXt
         3syJkY+64x3gHb9kzDHcV1C2kJZ6UmLEybLSV/Y+nLe8MP7EGcmRHjnp5LKp9Fmsrw
         bPOnyq9HYdkWVGOTsrssFVCLfOLavh+FA3HNDSHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/121] mm/page_ext.c: fix an imbalance with kmemleak
Date:   Thu,  4 Apr 2019 10:46:49 +0200
Message-Id: <20190404084546.524564358@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0c81585499601acd1d0e1cbf424cabfaee60628c ]

After offlining a memory block, kmemleak scan will trigger a crash, as
it encounters a page ext address that has already been freed during
memory offlining.  At the beginning in alloc_page_ext(), it calls
kmemleak_alloc(), but it does not call kmemleak_free() in
free_page_ext().

    BUG: unable to handle kernel paging request at ffff888453d00000
    PGD 128a01067 P4D 128a01067 PUD 128a04067 PMD 47e09e067 PTE 800ffffbac2ff060
    Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
    CPU: 1 PID: 1594 Comm: bash Not tainted 5.0.0-rc8+ #15
    Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20 10/25/2017
    RIP: 0010:scan_block+0xb5/0x290
    Code: 85 6e 01 00 00 48 b8 00 00 30 f5 81 88 ff ff 48 39 c3 0f 84 5b 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 85 87 01 00 00 <4c> 8b 3b e8 f3 0c fa ff 4c 39 3d 0c 6b 4c 01 0f 87 08 01 00 00 4c
    RSP: 0018:ffff8881ec57f8e0 EFLAGS: 00010082
    RAX: 0000000000000000 RBX: ffff888453d00000 RCX: ffffffffa61e5a54
    RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888453d00000
    RBP: ffff8881ec57f920 R08: fffffbfff4ed588d R09: fffffbfff4ed588c
    R10: fffffbfff4ed588c R11: ffffffffa76ac463 R12: dffffc0000000000
    R13: ffff888453d00ff9 R14: ffff8881f80cef48 R15: ffff8881f80cef48
    FS:  00007f6c0e3f8740(0000) GS:ffff8881f7680000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff888453d00000 CR3: 00000001c4244003 CR4: 00000000001606a0
    Call Trace:
     scan_gray_list+0x269/0x430
     kmemleak_scan+0x5a8/0x10f0
     kmemleak_write+0x541/0x6ca
     full_proxy_write+0xf8/0x190
     __vfs_write+0xeb/0x980
     vfs_write+0x15a/0x4f0
     ksys_write+0xd2/0x1b0
     __x64_sys_write+0x73/0xb0
     do_syscall_64+0xeb/0xaaa
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f6c0dad73b8
    Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 65 63 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
    RSP: 002b:00007ffd5b863cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
    RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6c0dad73b8
    RDX: 0000000000000005 RSI: 000055a9216e1710 RDI: 0000000000000001
    RBP: 000055a9216e1710 R08: 000000000000000a R09: 00007ffd5b863840
    R10: 000000000000000a R11: 0000000000000246 R12: 00007f6c0dda9780
    R13: 0000000000000005 R14: 00007f6c0dda4740 R15: 0000000000000005
    Modules linked in: nls_iso8859_1 nls_cp437 vfat fat kvm_intel kvm irqbypass efivars ip_tables x_tables xfs sd_mod ahci libahci igb i2c_algo_bit libata i2c_core dm_mirror dm_region_hash dm_log dm_mod efivarfs
    CR2: ffff888453d00000
    ---[ end trace ccf646c7456717c5 ]---
    Kernel panic - not syncing: Fatal exception
    Shutting down cpus with NMI
    Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range:
    0xffffffff80000000-0xffffffffbfffffff)
    ---[ end Kernel panic - not syncing: Fatal exception ]---

Link: http://lkml.kernel.org/r/20190227173147.75650-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2c44f5b78435..dece2bdf86fe 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -271,6 +271,7 @@ static void free_page_ext(void *addr)
 		table_size = get_entry_size() * PAGES_PER_SECTION;
 
 		BUG_ON(PageReserved(page));
+		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
 }
-- 
2.19.1



