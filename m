Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66093C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA4A2189F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfHFHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:32:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731576AbfHFHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:32:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 803F17FA8FB05895B325;
        Tue,  6 Aug 2019 15:32:44 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.177) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 6 Aug 2019 15:32:38 +0800
From:   chenzefeng <chenzefeng2@huawei.com>
To:     <linux@armlinux.org.uk>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <allison@lohutok.net>, <jeyu@kernel.org>,
        <gregkh@linuxfoundation.org>, <matthias.schiffer@ew.tq-group.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <chenzefeng2@huawei.com>, <nixiaoming@huawei.com>
Subject: [PATCH] arm:unwind: fix backtrace error with unwind_table
Date:   Tue, 6 Aug 2019 15:32:36 +0800
Message-ID: <1565076756-71682-1-git-send-email-chenzefeng2@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm, when load_module success, the mod->init_layout.base would
be free in function do_free_init, but do not remove it's unwind table
from the unwind_tables' list. And later the above mod->init_layout.base
would alloc for another module's text section, and add to the
unwind_tables which cause one address can found more than two unwind table
in the unwind_tables' list, therefore may get to errror unwind table to
backtrace, and get an error backtrace.

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/arm/kernel/module.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f..a4eb5f4 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -403,14 +403,24 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	return 0;
 }
 
-void
-module_arch_cleanup(struct module *mod)
-{
+
 #ifdef CONFIG_ARM_UNWIND
+void module_arch_cleanup(struct module *mod)
+{
 	int i;
 
 	for (i = 0; i < ARM_SEC_MAX; i++)
-		if (mod->arch.unwind[i])
+		if (mod->arch.unwind[i]) {
 			unwind_table_del(mod->arch.unwind[i]);
-#endif
+			mod->arch.unwind[i] = NULL;
+		}
 }
+
+void module_arch_freeing_init(struct module *mod)
+{
+	if (mod->arch.unwind[ARM_SEC_INIT]) {
+		unwind_table_del(mod->arch.unwind[ARM_SEC_INIT]);
+		mod->arch.unwind[ARM_SEC_INIT] = NULL;
+	}
+}
+#endif
-- 
1.8.5.6

