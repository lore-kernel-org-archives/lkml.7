Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D25C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C85217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbfITGJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437276AbfITGJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E26AED2F7CFCDE1218ED;
        Fri, 20 Sep 2019 14:09:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:09:00 +0800
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
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 18/32] platform/x86: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:30 +0800
Message-ID: <20190920062544.180997-19-wangkefeng.wang@huawei.com>
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

Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/platform/x86/asus-laptop.c    |  2 +-
 drivers/platform/x86/eeepc-laptop.c   |  2 +-
 drivers/platform/x86/intel_oaktrail.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 472af7edf0af..ca65e1039f92 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1148,7 +1148,7 @@ static void asus_als_switch(struct asus_laptop *asus, int value)
 		ret = write_acpi_int(asus->handle, METHOD_ALS_CONTROL, value);
 	}
 	if (ret)
-		pr_warning("Error setting light sensor switch\n");
+		pr_warn("Error setting light sensor switch\n");
 
 	asus->light_switch = value;
 }
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index f3f74a9c109e..776868d5e458 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -578,7 +578,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 
 	port = acpi_get_pci_dev(handle);
 	if (!port) {
-		pr_warning("Unable to find port\n");
+		pr_warn("Unable to find port\n");
 		goto out_unlock;
 	}
 
diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel_oaktrail.c
index 3c0438ba385e..1a09a75bd16d 100644
--- a/drivers/platform/x86/intel_oaktrail.c
+++ b/drivers/platform/x86/intel_oaktrail.c
@@ -243,7 +243,7 @@ static int oaktrail_backlight_init(void)
 
 	if (IS_ERR(bd)) {
 		oaktrail_bl_device = NULL;
-		pr_warning("Unable to register backlight device\n");
+		pr_warn("Unable to register backlight device\n");
 		return PTR_ERR(bd);
 	}
 
@@ -313,20 +313,20 @@ static int __init oaktrail_init(void)
 
 	ret = platform_driver_register(&oaktrail_driver);
 	if (ret) {
-		pr_warning("Unable to register platform driver\n");
+		pr_warn("Unable to register platform driver\n");
 		goto err_driver_reg;
 	}
 
 	oaktrail_device = platform_device_alloc(DRIVER_NAME, -1);
 	if (!oaktrail_device) {
-		pr_warning("Unable to allocate platform device\n");
+		pr_warn("Unable to allocate platform device\n");
 		ret = -ENOMEM;
 		goto err_device_alloc;
 	}
 
 	ret = platform_device_add(oaktrail_device);
 	if (ret) {
-		pr_warning("Unable to add platform device\n");
+		pr_warn("Unable to add platform device\n");
 		goto err_device_add;
 	}
 
@@ -338,7 +338,7 @@ static int __init oaktrail_init(void)
 
 	ret = oaktrail_rfkill_init();
 	if (ret) {
-		pr_warning("Setup rfkill failed\n");
+		pr_warn("Setup rfkill failed\n");
 		goto err_rfkill;
 	}
 
-- 
2.20.1

