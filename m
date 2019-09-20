Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BEAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692220644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437289AbfITGJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437238AbfITGJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7DADE79800A8023335A;
        Fri, 20 Sep 2019 14:08:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH 05/32] sh: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:17 +0800
Message-ID: <20190920062544.180997-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/boards/mach-sdk7786/nmi.c    | 2 +-
 arch/sh/drivers/pci/fixups-sdk7786.c | 2 +-
 arch/sh/kernel/io_trapped.c          | 2 +-
 arch/sh/kernel/setup.c               | 2 +-
 arch/sh/mm/consistent.c              | 5 ++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-sdk7786/nmi.c b/arch/sh/boards/mach-sdk7786/nmi.c
index c2e09d798537..afba49679a12 100644
--- a/arch/sh/boards/mach-sdk7786/nmi.c
+++ b/arch/sh/boards/mach-sdk7786/nmi.c
@@ -37,7 +37,7 @@ static int __init nmi_mode_setup(char *str)
 		nmi_mode = NMI_MODE_ANY;
 	else {
 		nmi_mode = NMI_MODE_UNKNOWN;
-		pr_warning("Unknown NMI mode %s\n", str);
+		pr_warn("Unknown NMI mode %s\n", str);
 	}
 
 	printk("Set NMI mode to %d\n", nmi_mode);
diff --git a/arch/sh/drivers/pci/fixups-sdk7786.c b/arch/sh/drivers/pci/fixups-sdk7786.c
index 8cbfa5310a4b..6972af7b4e93 100644
--- a/arch/sh/drivers/pci/fixups-sdk7786.c
+++ b/arch/sh/drivers/pci/fixups-sdk7786.c
@@ -53,7 +53,7 @@ static int __init sdk7786_pci_init(void)
 
 		/* Warn about forced rerouting if slot#3 is occupied */
 		if ((data & PCIECR_PRST3) == 0) {
-			pr_warning("Unreachable card detected in slot#3\n");
+			pr_warn("Unreachable card detected in slot#3\n");
 			return -EBUSY;
 		}
 	} else
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index bacad6da4fe4..60c828a2b8a2 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -99,7 +99,7 @@ int register_trapped_io(struct trapped_io *tiop)
 
 	return 0;
  bad:
-	pr_warning("unable to install trapped io filter\n");
+	pr_warn("unable to install trapped io filter\n");
 	return -1;
 }
 EXPORT_SYMBOL_GPL(register_trapped_io);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 2c0e0f37a318..6ef341f6cfee 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -354,7 +354,7 @@ void __init setup_arch(char **cmdline_p)
 /* processor boot mode configuration */
 int generic_mode_pins(void)
 {
-	pr_warning("generic_mode_pins(): missing mode pin configuration\n");
+	pr_warn("generic_mode_pins(): missing mode pin configuration\n");
 	return 0;
 }
 
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..3169a343a5ab 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -43,8 +43,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	r = pdev->resource + pdev->num_resources - 1;
 	if (r->flags) {
-		pr_warning("%s: unable to find empty space for resource\n",
-			name);
+		pr_warn("%s: unable to find empty space for resource\n", name);
 		return -EINVAL;
 	}
 
@@ -54,7 +53,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
-		pr_warning("%s: unable to allocate memory\n", name);
+		pr_warn("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-- 
2.20.1

