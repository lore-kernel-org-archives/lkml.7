Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B7CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B2F23B00
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="geU3Y913"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfFCLIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:08:05 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:21981 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfFCLIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:08:01 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 07:08:00 EDT
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665932"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 03 Jun 2019 12:58:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 03 Jun 2019 12:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559559491; x=1591095491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ts5LC/RvHzgs2W6xsbaqMxcECartTZCimeTJSzte1xI=;
  b=geU3Y913XpTWmF+Sa4xYUSpKeGsVtAk0wDtNeV1/ymRejadKSf4WUjrs
   103VgINyi/Q0i67fxF1jRzMh9nTQV9aU6/VpR6phZXXEfJKiPyaSlBa7/
   52RMJWKq8B8jFNIRPHzUj9yg7UGgy+UGM7ZB/3RujWqjd5xlGSqyAMCrP
   saTl8baRYZnb0Sh+5Olvvb0Wimb0ztDudzv/J2PAHR8ff3sssrSw+fPw9
   FZv3zKRgYaYGFZ+wC0wRCqElmTxZlq0kJ25zq2zKc/To5UpeTEfuwS/o/
   0hbFiDNgzak/9oW6wfMIjJt7ZfL6/QBhwFjJl7/DWUTrckDvOrxDLiBMF
   A==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665931"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 801C9280075;
        Mon,  3 Jun 2019 12:58:15 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules 1/2] module: allow arch overrides for .exit section names
Date:   Mon,  3 Jun 2019 12:57:25 +0200
Message-Id: <20190603105726.22436-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
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
 include/linux/moduleloader.h | 8 ++++++++
 kernel/module.c              | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 31013c2effd3..cddbd85fb659 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/elf.h>
+#include <linux/string.h>
 
 /* These may be implemented by architectures that need to hook into the
  * module loader code.  Architectures that don't need to do anything special
@@ -93,4 +94,11 @@ void module_arch_freeing_init(struct module *mod);
 #define MODULE_ALIGN PAGE_SIZE
 #endif
 
+#ifndef HAVE_ARCH_MODULE_EXIT_SECTION
+static inline bool module_exit_section(const char *name)
+{
+	return strstarts(name, ".exit");
+}
+#endif
+
 #endif
diff --git a/kernel/module.c b/kernel/module.c
index 6e6712b3aaf5..e8e4cd0a471f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2924,7 +2924,7 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
-		if (strstarts(info->secstrings+shdr->sh_name, ".exit"))
+		if (module_exit_section(info->secstrings+shdr->sh_name))
 			shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
 #endif
 	}
-- 
2.17.1

