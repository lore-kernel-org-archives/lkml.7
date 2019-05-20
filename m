Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D21C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082042085A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfETJEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:04:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727301AbfETJEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:04:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2B7C1D3391B934B038E;
        Mon, 20 May 2019 17:04:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 May 2019 17:04:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 1/2] hwtracing: stm: fix vfree() nonexistent vm_area
Date:   Mon, 20 May 2019 17:13:14 +0800
Message-ID: <20190520091315.27898-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_add() in stm_register_device() fails, stm_device_release()
is called to free stm, free stm again on err_device path will trigger
following warning,

  Trying to vfree() nonexistent vm area (0000000054b5e7bc)
  WARNING: CPU: 0 PID: 6004 at mm/vmalloc.c:1595 __vunmap+0x72/0x480 mm/vmalloc.c:1594
  Kernel panic - not syncing: panic_on_warn set ...
  CPU: 0 PID: 6004 Comm: syz-executor.0 Tainted: G         C 5.1.0+ #28
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   __vfree+0x2a/0x80 mm/vmalloc.c:1658
   _vfree+0x49/0x70 mm/vmalloc.c:1688
   stm_register_device+0x295/0x330 [stm_core]
   dummy_stm_init+0xfe/0x1e0 [dummy_stm]
   do_one_initcall+0xb9/0x3b5 init/main.c:914
   do_init_module+0xe0/0x330 kernel/module.c:3468
   load_module+0x38eb/0x4270 kernel/module.c:3819
   __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
   do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Only free stm once if device_add() fails to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/hwtracing/stm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e55b902560de..7b2ab7b2cc4d 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -864,6 +864,7 @@ static void stm_device_release(struct device *dev)
 	struct stm_device *stm = to_stm_device(dev);
 
 	vfree(stm);
+	stm->data->stm = NULL;
 }
 
 int stm_register_device(struct device *parent, struct stm_data *stm_data,
@@ -933,7 +934,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
 err_free:
-	vfree(stm);
+	if (stm->data->stm)
+		vfree(stm);
 
 	return err;
 }
-- 
2.20.1

