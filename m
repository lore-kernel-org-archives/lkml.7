Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5AEC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB32064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHPLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:19:02 -0400
Received: from foss.arm.com ([217.140.110.172]:55214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfHPLS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:18:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA4D28;
        Fri, 16 Aug 2019 04:18:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D3143F706;
        Fri, 16 Aug 2019 04:18:56 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH 2/2] drivers/dax/kmem: give a warning if CONFIG_DEV_DAX_PMEM_COMPAT is enabled
Date:   Fri, 16 Aug 2019 19:18:44 +0800
Message-Id: <20190816111844.87442-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816111844.87442-1-justin.he@arm.com>
References: <20190816111844.87442-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c221c0b0308f ("device-dax: "Hotplug" persistent memory for use
like normal RAM") helps to add persistent memory as normal RAM blocks.
But this driver doesn't work if CONFIG_DEV_DAX_PMEM_COMPAT is enabled.

Here is the debugging call trace when CONFIG_DEV_DAX_PMEM_COMPAT is
enabled.
[    4.443730]  devm_memremap_pages+0x4b9/0x540
[    4.443733]  dev_dax_probe+0x112/0x220 [device_dax]
[    4.443735]  dax_pmem_compat_probe+0x58/0x92 [dax_pmem_compat]
[    4.443737]  nvdimm_bus_probe+0x6b/0x150
[    4.443739]  really_probe+0xf5/0x3d0
[    4.443740]  driver_probe_device+0x11b/0x130
[    4.443741]  device_driver_attach+0x58/0x60
[    4.443742]  __driver_attach+0xa3/0x140

Then the dax0.0 device will be registered as "nd" bus instead of
"dax" bus. This causes the error as follows:
root@ubuntu:~# echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
-bash: echo: write error: No such device

This gives a warning to notify the user.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/dax/kmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index ad62d551d94e..b77f0e880598 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -93,6 +93,11 @@ static struct dax_device_driver device_dax_kmem_driver = {
 
 static int __init dax_kmem_init(void)
 {
+	if (IS_ENABLED(CONFIG_DEV_DAX_PMEM_COMPAT)) {
+		pr_warn("CONFIG_DEV_DAX_PMEM_COMPAT is not compatible\n");
+		pr_warn("kmem dax driver might not be workable\n");
+	}
+
 	return dax_driver_register(&device_dax_kmem_driver);
 }
 
-- 
2.17.1

