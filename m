Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B223C4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D5D218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 03:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfIRDJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 23:09:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728206AbfIRDJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 23:09:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5335DCD535D0C4A99B76;
        Wed, 18 Sep 2019 11:09:44 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.177) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 18 Sep 2019 11:09:36 +0800
From:   chenzefeng <chenzefeng2@huawei.com>
To:     <linux@armlinux.org.uk>, <matthias.schiffer@ew.tq-group.com>,
        <tglx@linutronix.de>, <info@metux.net>,
        <gregkh@linuxfoundation.org>
CC:     <chenzefeng2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <liucheng32@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH] arm:unwind: fix incorrect backtrace with unwind_table
Date:   Wed, 18 Sep 2019 11:09:34 +0800
Message-ID: <1568776174-84980-1-git-send-email-chenzefeng2@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm, if the CONFIG_ARM_UNWIND is open, when insmod a module,
the init section add to the unwind_table, the code path as follow:
	load_module
	--->post_relocation
	------->module_finalize
	----------->maps[ARM_SEC_INIT].txt_sec = s
	----------->unwind_table_add

Later if load_module success, the init section's memory will be
vfree, the code path as follow:
	load_module
	--->do_init_module
	------->freeinit->module_init = mod->init_layout.base
	------->schedule_work(&init_free_wq)
	----------->do_free_init
	--------------->vfree(freeinit->module_init)

But after the init section's had been vfree, but it's unwind_table
is not removed.

The issue as follow:
When insmod module A, the system alloc the "Addr1" for it's init
text section, and add it to the unwind_table list, after insmod
success, the "Addr1" would be vfreed.
Unfortunately, later insmod module B, the system alloc the "Addr1"
for it's text section, and add it to the unwind_table list, too.
And we dumpstack in module B, we may get a incorrect backtrace.

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/arm/kernel/module.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f..438ed67 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -410,7 +410,20 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	int i;
 
 	for (i = 0; i < ARM_SEC_MAX; i++)
-		if (mod->arch.unwind[i])
+		if (mod->arch.unwind[i]) {
 			unwind_table_del(mod->arch.unwind[i]);
+			mod->arch.unwind[i] = NULL;
+		}
+#endif
+}
+
+void
+module_arch_freeing_init(struct module *mod)
+{
+#ifdef CONFIG_ARM_UNWIND
+	if (mod->arch.unwind[ARM_SEC_INIT]) {
+		unwind_table_del(mod->arch.unwind[ARM_SEC_INIT]);
+		mod->arch.unwind[ARM_SEC_INIT] = NULL;
+	}
 #endif
 }
-- 
1.8.5.6

