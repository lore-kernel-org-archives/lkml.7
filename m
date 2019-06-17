Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B17C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C038218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfFQGkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:40:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfFQGkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:40:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 103E643DB4676C2CDCFA;
        Mon, 17 Jun 2019 14:40:19 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 14:40:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <jeyu@kernel.org>,
        <peterz@infradead.org>
CC:     <yangyingliang@huawei.com>, <namit@vmware.com>,
        <cj.chengjian@huawei.com>
Subject: [PATCH] modules: fix BUG when load module with rodata=n
Date:   Mon, 17 Jun 2019 14:59:57 +0800
Message-ID: <1560754797-40683-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading a module with rodata=n, it causes an executing
NX-protected page BUG.

[   32.379191] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   32.382917] BUG: unable to handle page fault for address: ffffffffc0005000
[   32.385947] #PF: supervisor instruction fetch in kernel mode
[   32.387662] #PF: error_code(0x0011) - permissions violation
[   32.389352] PGD 240c067 P4D 240c067 PUD 240e067 PMD 421a52067 PTE 8000000421a53063
[   32.391396] Oops: 0011 [#1] SMP PTI
[   32.392478] CPU: 7 PID: 2697 Comm: insmod Tainted: G           O      5.2.0-rc5+ #202
[   32.394588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   32.398157] RIP: 0010:ko_test_init+0x0/0x1000 [ko_test]
[   32.399662] Code: Bad RIP value.
[   32.400621] RSP: 0018:ffffc900029f3ca8 EFLAGS: 00010246
[   32.402171] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   32.404332] RDX: 00000000000004c7 RSI: 0000000000000cc0 RDI: ffffffffc0005000
[   32.406347] RBP: ffffffffc0005000 R08: ffff88842fbebc40 R09: ffffffff810ede4a
[   32.408392] R10: ffffea00108e3480 R11: 0000000000000000 R12: ffff88842bee21a0
[   32.410472] R13: 0000000000000001 R14: 0000000000000001 R15: ffffc900029f3e78
[   32.412609] FS:  00007fb4f0c0a700(0000) GS:ffff88842fbc0000(0000) knlGS:0000000000000000
[   32.414722] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.416290] CR2: ffffffffc0004fd6 CR3: 0000000421a90004 CR4: 0000000000020ee0
[   32.418471] Call Trace:
[   32.419136]  do_one_initcall+0x41/0x1df
[   32.420199]  ? _cond_resched+0x10/0x40
[   32.421433]  ? kmem_cache_alloc_trace+0x36/0x160
[   32.422827]  do_init_module+0x56/0x1f7
[   32.423946]  load_module+0x1e67/0x2580
[   32.424947]  ? __alloc_pages_nodemask+0x150/0x2c0
[   32.426413]  ? map_vm_area+0x2d/0x40
[   32.427530]  ? __vmalloc_node_range+0x1ef/0x260
[   32.428850]  ? __do_sys_init_module+0x135/0x170
[   32.430060]  ? _cond_resched+0x10/0x40
[   32.431249]  __do_sys_init_module+0x135/0x170
[   32.432547]  do_syscall_64+0x43/0x120
[   32.433853]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Because if rodata=n, set_memory_x() cann't be called, fix this by
calling set_memory_x in complete_formation();

Fixes: f2c65fb3221a ("x86/modules: Avoid breaking W^X while loading modules")
Suggested-by: Jian Cheng <cj.chengjian@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/module.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 80c7c09584cf..1a5d879573c3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1949,12 +1949,10 @@ void module_enable_ro(const struct module *mod, bool after_init)
 	set_vm_flush_reset_perms(mod->core_layout.base);
 	set_vm_flush_reset_perms(mod->init_layout.base);
 	frob_text(&mod->core_layout, set_memory_ro);
-	frob_text(&mod->core_layout, set_memory_x);
 
 	frob_rodata(&mod->core_layout, set_memory_ro);
 
 	frob_text(&mod->init_layout, set_memory_ro);
-	frob_text(&mod->init_layout, set_memory_x);
 
 	frob_rodata(&mod->init_layout, set_memory_ro);
 
@@ -2018,6 +2016,12 @@ void set_all_modules_text_ro(void)
 static void module_enable_nx(const struct module *mod) { }
 #endif
 
+static void module_enable_x(const struct module *mod)
+{
+	frob_text(&mod->core_layout, set_memory_x);
+	frob_text(&mod->init_layout, set_memory_x);
+}
+
 #ifdef CONFIG_LIVEPATCH
 /*
  * Persist Elf information about a module. Copy the Elf header,
@@ -3616,6 +3620,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
+	module_enable_x(mod);
 
 	/* Mark state as coming so strong_try_module_get() ignores us,
 	 * but kallsyms etc. can see us. */
-- 
2.17.1

