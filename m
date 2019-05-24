Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0674BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23102081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbfEXOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:35:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391470AbfEXOff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:35:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E62A93A6EDFF9F60A4F2;
        Fri, 24 May 2019 22:35:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 22:35:26 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] jffs2: fix null-ptr-deref during jffs2_unregister_compressor()
Date:   Fri, 24 May 2019 22:43:57 +0800
Message-ID: <20190524144357.43560-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that jffs2_register_compressor() could not be called
(eg, alloc_workspace() return fails) in jffs2_compressors_init(), so
unconditionally delete list if unregister compressors will trigger
this issue when rmmod jffs2.

  BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x45/0xd0 lib/list_debug.c:51
  Read of size 8 at addr 0000000000000000 by task syz-executor.0/8049

  CPU: 1 PID: 8049 Comm: syz-executor.0 Tainted: G         C 5.1.0+ #28
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0xa9/0x10e lib/dump_stack.c:113
   __kasan_report+0x171/0x18d mm/kasan/report.c:321
   kasan_report+0xe/0x20 mm/kasan/common.c:614
   __list_del_entry_valid+0x45/0xd0 lib/list_debug.c:51
   jffs2_unregister_compressor+0x41/0xf0 [jffs2]
   jffs2_lzo_exit+0x11/0x20 [jffs2]
   jffs2_compressors_exit+0xa/0x30 [jffs2]
   exit_jffs2_fs+0x1b/0xf4b [jffs2]
   __do_sys_delete_module kernel/module.c:1027 [inline]
   __se_sys_delete_module kernel/module.c:970 [inline]
   __x64_sys_delete_module+0x244/0x330 kernel/module.c:970
   do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Add 'bool initialized' into struct jffs2_compressor, return error
if initialized is not set in jffs2_unregister_compressor().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/jffs2/compr.c | 7 +++++++
 fs/jffs2/compr.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 4849a4c9a0e2..efbc166f8dca 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -302,6 +302,8 @@ int jffs2_register_compressor(struct jffs2_compressor *comp)
 {
 	struct jffs2_compressor *this;
 
+	comp->initialized = false;
+
 	if (!comp->name) {
 		pr_warn("NULL compressor name at registering JFFS2 compressor. Failed.\n");
 		return -1;
@@ -331,6 +333,8 @@ int jffs2_register_compressor(struct jffs2_compressor *comp)
 
 	spin_unlock(&jffs2_compressor_list_lock);
 
+	comp->initialized = true
+
 	return 0;
 }
 
@@ -338,6 +342,9 @@ int jffs2_unregister_compressor(struct jffs2_compressor *comp)
 {
 	D2(struct jffs2_compressor *this);
 
+	if (!comp->initialized)
+		return -1;
+
 	jffs2_dbg(1, "Unregistering JFFS2 compressor \"%s\"\n", comp->name);
 
 	spin_lock(&jffs2_compressor_list_lock);
diff --git a/fs/jffs2/compr.h b/fs/jffs2/compr.h
index 5e91d578f4ed..c90b86fbddfe 100644
--- a/fs/jffs2/compr.h
+++ b/fs/jffs2/compr.h
@@ -56,6 +56,7 @@ struct jffs2_compressor {
 			  uint32_t cdatalen, uint32_t datalen);
 	int usecount;
 	int disabled;		/* if set the compressor won't compress */
+	int initialized;
 	unsigned char *compr_buf;	/* used by size compr. mode */
 	uint32_t compr_buf_size;	/* used by size compr. mode */
 	uint32_t stat_compr_orig_size;
-- 
2.20.1

