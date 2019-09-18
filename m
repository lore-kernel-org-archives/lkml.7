Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF90C4CED0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5614A21924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788054;
	bh=6VhmvCa2PDTHML0sSxnDeIgYpRqkqlNJF0zD4anQsQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYC0zZu9bi/iTpjGQk7FpsCerFQhFaP5b+kWFH7N+gFZhxbU2zDYpdzlUTJHlU+YK
	 NNgSgF8QIyN5XQ+pEFzItTEGKG1m2Kcpdprcu3rLIsPrfZbMSHsGLlTJ+ywBfhjM7a
	 6HEg+u7w0EA1kMT7t5lG3l/UrHx6Dsk38UiGaMLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfIRG1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbfIRG10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:27:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B358721925;
        Wed, 18 Sep 2019 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788046;
        bh=6VhmvCa2PDTHML0sSxnDeIgYpRqkqlNJF0zD4anQsQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+hi3VEX13y5xx/ZJUUQmk6r53Pa5+jv5+EX15nn/B9gOFhIGupIiBni2QpA9Jt9S
         Uj4f41i6sIYhVjk7nV8ed/dp6ObkNHNc0r8Vf5ey8QfgsRNc7ZuOie4vM/X20Xr2e4
         9d6iijhQI27yMaEwRDe257dyv/iuEcJbUdBD5R5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 5.2 78/85] modules: fix compile error if dont have strict module rwx
Date:   Wed, 18 Sep 2019 08:19:36 +0200
Message-Id: <20190918061237.853175081@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

commit 93651f80dcb616b8c9115cdafc8e57a781af22d0 upstream.

If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not defined,
we need stub for module_enable_nx() and module_enable_x().

If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is defined, but
CONFIG_STRICT_MODULE_RWX is disabled, we need stub for
module_enable_nx.

Move frob_text() outside of the CONFIG_STRICT_MODULE_RWX,
because it is needed anyway.

Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=n")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/module.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1887,7 +1887,7 @@ static void mod_sysfs_teardown(struct mo
 	mod_sysfs_fini(mod);
 }
 
-#ifdef CONFIG_STRICT_MODULE_RWX
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 /*
  * LKM RO/NX protection: protect module's text/ro-data
  * from modification and any data from execution.
@@ -1910,6 +1910,7 @@ static void frob_text(const struct modul
 		   layout->text_size >> PAGE_SHIFT);
 }
 
+#ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
 {
@@ -2022,15 +2023,19 @@ void set_all_modules_text_ro(void)
 	}
 	mutex_unlock(&module_mutex);
 }
-#else
+#else /* !CONFIG_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
-#endif
-
+#endif /*  CONFIG_STRICT_MODULE_RWX */
 static void module_enable_x(const struct module *mod)
 {
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+static void module_enable_nx(const struct module *mod) { }
+static void module_enable_x(const struct module *mod) { }
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
 
 #ifdef CONFIG_LIVEPATCH
 /*


