Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9C2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429203;
	bh=vPSgSOm/TM2mYA7OWKX8t8dWZRhtAk1thKzepUZ3yic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGQ5iOSvL/ESxUz7rxoPliXluRwC1Irmy0uRZZ7ngKMNTK/Utf46q7z7U9Pq44wo1
	 VcHYSmkv23V5+ZWM38RJ3AcJzQ2YCgv8JtGVjSfWFnPSFtL0f+JEifRCLNizcP8LkD
	 7BENXFwwdOjnE/8QaFKD7rGh5bQHvDN2zXxuC3ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfG2TkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388267AbfG2Tj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:39:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE69217D4;
        Mon, 29 Jul 2019 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429199;
        bh=vPSgSOm/TM2mYA7OWKX8t8dWZRhtAk1thKzepUZ3yic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZt1rStPaYD2kgBQ/Gy/aIhi15PbV0NFaNuta4k5AM6c4hXdVT2da/cJNmpv9Ij6v
         +SN0Q1R6DascIIp3eLGuFHXoFaVplFssIH+326qzEc+au5wG1nAQwuhjcJWwA4Q6Bh
         WKcl4C+21AuV6JK8/jNyqqmA/x6GZaErvT2ha9SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai26@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/113] memstick: Fix error cleanup path of memstick_init
Date:   Mon, 29 Jul 2019 21:21:49 +0200
Message-Id: <20190729190701.147254323@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 65f1a0d39c289bb6fc85635528cd36c4b07f560e ]

If bus_register fails. On its error handling path, it has cleaned up
what it has done. There is no need to call bus_unregister again.
Otherwise, if bus_unregister is called, issues such as null-ptr-deref
will arise.

Syzkaller report this:

kobject_add_internal failed for memstick (error: -12 parent: bus)
BUG: KASAN: null-ptr-deref in sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
Read of size 8 at addr 0000000000000078 by task syz-executor.0/4460

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa9/0x10e lib/dump_stack.c:113
 __kasan_report+0x171/0x18d mm/kasan/report.c:321
 kasan_report+0xe/0x20 mm/kasan/common.c:614
 sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
 sysfs_remove_file include/linux/sysfs.h:519 [inline]
 bus_remove_file+0x6c/0x90 drivers/base/bus.c:145
 remove_probe_files drivers/base/bus.c:599 [inline]
 bus_unregister+0x6e/0x100 drivers/base/bus.c:916 ? 0xffffffffc1590000
 memstick_init+0x7a/0x1000 [memstick]
 do_one_initcall+0xb9/0x3b5 init/main.c:914
 do_init_module+0xe0/0x330 kernel/module.c:3468
 load_module+0x38eb/0x4270 kernel/module.c:3819
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
 do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai26@huawei.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/memstick.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 1246d69ba187..b1564cacd19e 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -629,13 +629,18 @@ static int __init memstick_init(void)
 		return -ENOMEM;
 
 	rc = bus_register(&memstick_bus_type);
-	if (!rc)
-		rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_destroy_workqueue;
 
-	if (!rc)
-		return 0;
+	rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_bus_unregister;
+
+	return 0;
 
+error_bus_unregister:
 	bus_unregister(&memstick_bus_type);
+error_destroy_workqueue:
 	destroy_workqueue(workqueue);
 
 	return rc;
-- 
2.20.1



