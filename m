Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0CCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2EA20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DBwoQNWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFGKtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:49:42 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17387 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfFGKtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:49:40 -0400
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741350"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Jun 2019 12:49:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 07 Jun 2019 12:49:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 07 Jun 2019 12:49:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559904579; x=1591440579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fKg2mD/qwL/cmX0j2krbwJOZX3Iu3z3MEa+o5iUU+44=;
  b=DBwoQNWKuPzt9rGLL4dgvkecWPdqa/WmG7lsqMJ9xUabMGOucUf3q9Bf
   Cs0ltAZKpy2NzHybDGFLhOextb8ZaeI9Uq1EN2+EAPT2GPZT4xSMcjojr
   RJ8Yuqzl9cC08fJlxJHSO07rQ+a/sSNi9NMlaUTbFQc3C+wyzmzKR1sc4
   0NkKB1CMoljyIne2UBxcpQNmCRyoDKIvdLAJKx/W6WEZyhNXMsUt5aB78
   2vfql7zPufxPG6pJq+Cl0bLDNgDZxbarLxKo0S8K2MFL8I8JZ3Uk+zgzJ
   8yCdCbdNN51jYgRkJkTgxsr1HraJFraanXsIBdw5bsMB2t7WeT8W0AuTA
   g==;
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741349"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jun 2019 12:49:39 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5D9FA280074;
        Fri,  7 Jun 2019 12:49:46 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules v2 1/2] module: allow arch overrides for .exit section names
Date:   Fri,  7 Jun 2019 12:49:11 +0200
Message-Id: <20190607104912.6252-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
References: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some archs like ARM store unwind information for .exit.text in sections
with unusual names. As this unwind information refers to .exit.text, it
must not be loaded when .exit.text is not loaded (when CONFIG_MODULE_UNLOAD
is unset); otherwise, loading a module can fail due to relocation failures.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
v2: Use __weak function as suggested by Jessica

 include/linux/moduleloader.h | 5 +++++
 kernel/module.c              | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 31013c2effd3..5229c18025e9 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -29,6 +29,11 @@ void *module_alloc(unsigned long size);
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
+/* Determines if the section name is an exit section (that is only used during
+ * module unloading)
+ */
+bool module_exit_section(const char *name);
+
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
  * or 0.
diff --git a/kernel/module.c b/kernel/module.c
index 6e6712b3aaf5..043c0f965be2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2735,6 +2735,11 @@ void * __weak module_alloc(unsigned long size)
 	return vmalloc_exec(size);
 }
 
+bool __weak module_exit_section(const char *name)
+{
+	return strstarts(name, ".exit");
+}
+
 #ifdef CONFIG_DEBUG_KMEMLEAK
 static void kmemleak_load_module(const struct module *mod,
 				 const struct load_info *info)
@@ -2924,7 +2929,7 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
-		if (strstarts(info->secstrings+shdr->sh_name, ".exit"))
+		if (module_exit_section(info->secstrings+shdr->sh_name))
 			shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
 #endif
 	}
-- 
2.17.1

