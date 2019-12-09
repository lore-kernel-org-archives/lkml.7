Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115482077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdPsjISO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:57:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfLIP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:57:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id q16so5973707plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUuAyGheMhwZDB/touuU5N8RMvOFRATB9sWAKQFn1Z0=;
        b=AdPsjISORrcCuY6Rqp1pBIwJSMVFhYIQjAvAqaEzmUcCLjlcTvZamhgCOvr/SA8G65
         SZv/bWBwQlkquEkyPkCgT7AtMiMmRpfKHC2wL+e98rwijNTvrtKB4wR8yoBjLPJm5uUD
         kiZ2tXH0i81lGNiQo1pwUqat31BWgS8T/J0xsnZTEyVPJkg3U9FTF0Wa7RVzxdWkJAAq
         BspLMuVEXLmTiP9qNlcylGLkFGnYoZEh4rvg3hXJl/CamFTsrO25JQxs4K8nmw6lil2N
         5/uzDrahKhI4dWREYoUmHgzDUwcPLWiJ8kcM739GAhtZ5qnQKCEXKdmxzxphPo2VquxS
         XNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUuAyGheMhwZDB/touuU5N8RMvOFRATB9sWAKQFn1Z0=;
        b=P/4Qza60m+OM+/RrIQaudYjixDC96Tt5EcOlA3xZUsj5XK9fWMyTZdx+CS/b+EV+JN
         2CJ9DB5xWWxiRNLBjTMJbNcgjyyaW3tUzrbHLOIeRkf1f1BFoZYz1ne1Ilq2fQ7yaFMJ
         TC0EVv2Lst6RzDw2CmefUIkQQlRVAZ8+u4R8W/kUhmQXPvPt2nHUpJUp5nx9W89L4yEd
         70WSUAhAoiFDazqhoSoXULdQj+m6SR2GNsfX9HqRg7Q40DBPaXW2Vm0Jq1Aletydr5k0
         KfOhSCf9uDyv0iYrwJOZ9Ru4DBKHBOKDOqK/W/HZYg1t2Kb/Oay6cTfa2pECNp/dRX45
         NHxQ==
X-Gm-Message-State: APjAAAVoY0omM4jFakVDYxvtN/2Pu10e2fyufG0w/e/bdY5hiYufeNdp
        HqSWmqAQ8Uopheq9m2gMq4c=
X-Google-Smtp-Source: APXvYqw50Jy551utVrIGWik+oKVrkb/CHA+wN2pLLF3Ck742+qnVWrkBiKINb83x8Jbs/FxU+91GIg==
X-Received: by 2002:a17:90b:d89:: with SMTP id bg9mr33435428pjb.75.1575907020773;
        Mon, 09 Dec 2019 07:57:00 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id u1sm27073787pfn.133.2019.12.09.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 07:57:00 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] lib/Kconfig.debug: Fix some messed up configurations
Date:   Mon,  9 Dec 2019 23:56:52 +0800
Message-Id: <20191209155653.7509-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some configuration items are messed up during conflict resolving. For
example, STRICT_DEVMEM should not in testing menu, but kunit should.
This patch fixes all of them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 100 +++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1842fe756d5..1805aa86dfea 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1483,6 +1483,55 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "samples/Kconfig"
+
+config ARCH_HAS_DEVMEM_IS_ALLOWED
+	bool
+
+config STRICT_DEVMEM
+	bool "Filter access to /dev/mem"
+	depends on MMU && DEVMEM
+	depends on ARCH_HAS_DEVMEM_IS_ALLOWED
+	default y if PPC || X86 || ARM64
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  of memory, including kernel and userspace memory. Accidental
+	  access to this is obviously disastrous, but specific access can
+	  be used by people debugging the kernel. Note that with PAT support
+	  enabled, even in this case there are restrictions on /dev/mem
+	  use due to the cache aliasing requirements.
+
+	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
+	  file only allows userspace access to PCI space and the BIOS code and
+	  data regions.  This is sufficient for dosemu and X and all common
+	  users of /dev/mem.
+
+	  If in doubt, say Y.
+
+config IO_STRICT_DEVMEM
+	bool "Filter I/O access to /dev/mem"
+	depends on STRICT_DEVMEM
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  io-memory regardless of whether a driver is actively using that
+	  range.  Accidental access to this is obviously disastrous, but
+	  specific access can be used by people debugging kernel drivers.
+
+	  If this option is switched on, the /dev/mem file only allows
+	  userspace access to *idle* io-memory ranges (see /proc/iomem) This
+	  may break traditional users of /dev/mem (dosemu, legacy X, etc...)
+	  if the driver using a given range cannot be disabled.
+
+	  If in doubt, say Y.
+
+menu "$(SRCARCH) Debugging"
+
+source "arch/$(SRCARCH)/Kconfig.debug"
+
+endmenu
+
+menu "Kernel Testing and Coverage"
+
 source "lib/kunit/Kconfig"
 
 config NOTIFIER_ERROR_INJECTION
@@ -1643,10 +1692,6 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-endmenu # "Kernel Testing and Coverage"
-
-menu "Kernel Testing and Coverage"
-
 config ARCH_HAS_KCOV
 	bool
 	help
@@ -2130,52 +2175,7 @@ config MEMTEST
 	        memtest=17, mean do 17 test patterns.
 	  If you are unsure how to answer this question, answer N.
 
-source "samples/Kconfig"
-
-config ARCH_HAS_DEVMEM_IS_ALLOWED
-	bool
-
-config STRICT_DEVMEM
-	bool "Filter access to /dev/mem"
-	depends on MMU && DEVMEM
-	depends on ARCH_HAS_DEVMEM_IS_ALLOWED
-	default y if PPC || X86 || ARM64
-	---help---
-	  If this option is disabled, you allow userspace (root) access to all
-	  of memory, including kernel and userspace memory. Accidental
-	  access to this is obviously disastrous, but specific access can
-	  be used by people debugging the kernel. Note that with PAT support
-	  enabled, even in this case there are restrictions on /dev/mem
-	  use due to the cache aliasing requirements.
-
-	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
-	  file only allows userspace access to PCI space and the BIOS code and
-	  data regions.  This is sufficient for dosemu and X and all common
-	  users of /dev/mem.
-
-	  If in doubt, say Y.
 
-config IO_STRICT_DEVMEM
-	bool "Filter I/O access to /dev/mem"
-	depends on STRICT_DEVMEM
-	---help---
-	  If this option is disabled, you allow userspace (root) access to all
-	  io-memory regardless of whether a driver is actively using that
-	  range.  Accidental access to this is obviously disastrous, but
-	  specific access can be used by people debugging kernel drivers.
-
-	  If this option is switched on, the /dev/mem file only allows
-	  userspace access to *idle* io-memory ranges (see /proc/iomem) This
-	  may break traditional users of /dev/mem (dosemu, legacy X, etc...)
-	  if the driver using a given range cannot be disabled.
-
-	  If in doubt, say Y.
-
-menu "$(SRCARCH) Debugging"
-
-source "arch/$(SRCARCH)/Kconfig.debug"
-
-endmenu
 
 config HYPERV_TESTING
 	bool "Microsoft Hyper-V driver testing"
@@ -2184,4 +2184,6 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+endmenu # "Kernel Testing and Coverage"
+
 endmenu # Kernel hacking
-- 
2.20.1

