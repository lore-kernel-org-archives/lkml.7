Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A40206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179589;
	bh=VdKhJwRbFbfM5bBeuH5EBQiicL+atLU1WRNr50An8iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTZjtDIdhoNnEPjjdEEW/cTeywaeUn3u0t0aiIURP+CIW/VvAEU36TNivTjnKEyVx
	 krfZUbnqDu3GMBdaaX5EL5VB/TZa0fpx169MTV0P+nui6yvxF2QfsLRz1B15XU6Vth
	 pOhsDYiCLFLbkpNxceVtNvNTmMcUJBqUMqPfAQ+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395518AbfIVTND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438589AbfIVS5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8495E206C2;
        Sun, 22 Sep 2019 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178670;
        bh=VdKhJwRbFbfM5bBeuH5EBQiicL+atLU1WRNr50An8iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7Mw9S60CX8H9GXs8xU3LCTAp0KjY14ZN7xirI8WqNllzJBnhSoqwoS0o918t4RA/
         7c/Clfrn24OIhT48bfgU4AtuFalSCfsF645k1eKTayMqOHrT04p2wMHlAnkFi2hBsF
         +5JML4DtSuTcecYuKBI7xiAZFNjMLInc/lAx5Ehg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chenzefeng <chenzefeng2@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-ia64@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 21/89] ia64:unwind: fix double free for mod->arch.init_unw_table
Date:   Sun, 22 Sep 2019 14:56:09 -0400
Message-Id: <20190922185717.3412-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenzefeng <chenzefeng2@huawei.com>

[ Upstream commit c5e5c48c16422521d363c33cfb0dcf58f88c119b ]

The function free_module in file kernel/module.c as follow:

void free_module(struct module *mod) {
	......
	module_arch_cleanup(mod);
	......
	module_arch_freeing_init(mod);
	......
}

Both module_arch_cleanup and module_arch_freeing_init function
would free the mod->arch.init_unw_table, which cause double free.

Here, set mod->arch.init_unw_table = NULL after remove the unwind
table to avoid double free.

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/ia64/kernel/module.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 853b5611a894d..95e8d130e1235 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -913,8 +913,12 @@ module_finalize (const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mo
 void
 module_arch_cleanup (struct module *mod)
 {
-	if (mod->arch.init_unw_table)
+	if (mod->arch.init_unw_table) {
 		unw_remove_unwind_table(mod->arch.init_unw_table);
-	if (mod->arch.core_unw_table)
+		mod->arch.init_unw_table = NULL;
+	}
+	if (mod->arch.core_unw_table) {
 		unw_remove_unwind_table(mod->arch.core_unw_table);
+		mod->arch.core_unw_table = NULL;
+	}
 }
-- 
2.20.1

