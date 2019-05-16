Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC216C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A120862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEPEJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 00:09:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfEPEJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 00:09:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A14308FA2FCC24549626;
        Thu, 16 May 2019 12:09:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 12:09:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Date:   Thu, 16 May 2019 12:09:31 +0800
Message-ID: <20190516040931.16276-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ulite_probe is not called or failed to registed
uart_register_driver, unload the module will call
uart_unregister_driver, which will tigger NULL
pointer dereference like this:

BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246

CPU: 0 PID: 4246 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #26
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0xa9/0x10e
 ? tty_unregister_driver+0x19/0x100
 ? tty_unregister_driver+0x19/0x100
 __kasan_report+0x171/0x18d
 ? tty_unregister_driver+0x19/0x100
 kasan_report+0xe/0x20
 tty_unregister_driver+0x19/0x100
 uart_unregister_driver+0x30/0xc0
 __x64_sys_delete_module+0x244/0x330
 ? __ia32_sys_delete_module+0x330/0x330
 ? __x64_sys_clock_gettime+0xe3/0x160
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? trace_hardirqs_off_caller+0x3e/0x130
 ? lockdep_hardirqs_off+0xb5/0x100
 ? mark_held_locks+0x1a/0x90
 ? do_syscall_64+0x14/0x2a0
 do_syscall_64+0x72/0x2a0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

This patch fix this by moving uart_unregister_driver
to ulite_remove.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b..2e49fb6 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	uart_unregister_driver(&ulite_uart_driver);
 	return rc;
 }
 
@@ -897,7 +898,6 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
1.8.3.1


