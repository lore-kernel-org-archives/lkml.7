Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E661C04AB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EC1208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfENDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 23:23:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfENDX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 23:23:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8EBABDA7448C347C207E;
        Tue, 14 May 2019 11:23:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 May 2019 11:23:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] tty: serial: uartlite: avoid null pointer dereference during rmmod
Date:   Tue, 14 May 2019 11:32:19 +0800
Message-ID: <20190514033219.169947-1-wangkefeng.wang@huawei.com>
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

After commit 415b43bdb008 "tty: serial: uartlite: Move uart register to
probe", calling uart_unregister_driver unconditionally will trigger a
null pointer dereference due to ulite_uart_driver may not registed.

  CPU: 1 PID: 3755 Comm: syz-executor.0 Not tainted 5.1.0+ #28
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0xa9/0x10e lib/dump_stack.c:113
   __kasan_report+0x171/0x18d mm/kasan/report.c:321
   kasan_report+0xe/0x20 mm/kasan/common.c:614
   tty_unregister_driver+0x19/0x100 drivers/tty/tty_io.c:3383
   uart_unregister_driver+0x30/0xc0 drivers/tty/serial/serial_core.c:2579
   __do_sys_delete_module kernel/module.c:1027 [inline]
   __se_sys_delete_module kernel/module.c:970 [inline]
   __x64_sys_delete_module+0x244/0x330 kernel/module.c:970
   do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Call uart_unregister_driver only if ulite_uart_driver.state not null to
fix it.

Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/uartlite.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b5a8b9..06e79c11141d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -897,7 +897,8 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
+	if (ulite_uart_driver.state)
+		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.20.1

