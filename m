Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08181C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C5222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118969;
	bh=VdKhJwRbFbfM5bBeuH5EBQiicL+atLU1WRNr50An8iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oxddpY/R+oubICVe42+TPlQ8WXKEqgjjntJ8dPab4fnvt4IwyGotKS6AA03CGJeR4
	 OKuyyioycysVs/hNuACI0172FKLX03L5MH6jsYQm8IzKiJodKb0HR6IIPdyDLtzj+3
	 Q9Y2mOTDwr3RhH13LdEKoAc3Yb3G8RbvOUeOh9o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbfJCQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfJCQJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:09:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFFE20865;
        Thu,  3 Oct 2019 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118961;
        bh=VdKhJwRbFbfM5bBeuH5EBQiicL+atLU1WRNr50An8iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGXQi4Ktbn/VEG6POSvAnVRhdhika6jA78qTRqjjkOkEjuI3EUCAtbO8ImJBW5ewB
         UONO4daQLT/CqGs+v7b84EQQVkFBYpGKubJ5btF2QhDU5r1juotN3WpGJgCh9Ln8kr
         Bt00fFJlVIEcqw49X19CZPI0dc2iPwWlN6YY2ptA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chenzefeng <chenzefeng2@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 073/185] ia64:unwind: fix double free for mod->arch.init_unw_table
Date:   Thu,  3 Oct 2019 17:52:31 +0200
Message-Id: <20191003154454.055459837@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



