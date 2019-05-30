Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A34C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5613025C2E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfE3PGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:06:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfE3PGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:06:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2BE6D373B5D541E28654;
        Thu, 30 May 2019 23:06:40 +0800 (CST)
Received: from huawei.com (10.67.189.240) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 23:06:31 +0800
From:   l00383200 <liucheng32@huawei.com>
To:     <rmk+kernel@arm.linux.org.uk>, <tglx@linutronix.de>
CC:     <peterz@infradead.org>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liucheng32@huawei.com>
Subject: [PATCH] Stacktrace in ARM32 architecture has jumped the first 2 layers, which may ignore the display of save_stack_trace_tsk.
Date:   Thu, 30 May 2019 23:06:39 +0800
Message-ID: <1559228799-84473-1-git-send-email-liucheng32@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.240]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without optimization, both save_stack_trace_tsk and __save_stack_trace
will have stacktrace information in ARM32.

In this situation, "data.skip += 2" operation will skip the first two layers,
which may make the stacktrace strange and different from other architectures.

A simple example is as follows:
In ARM32 architecture:
[<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
[<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
[<ffffff800838aca8>] seq_read+0x130/0x420
[<ffffff8008365c54>] __vfs_read+0x60/0x11c
[<ffffff80083665dc>] vfs_read+0x8c/0x140
[<ffffff800836717c>] SyS_read+0x6c/0xcc
[<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
[<ffffffffffffffff>] 0xffffffffffffffff

In some other architectures(ARM64):
[<ffffff8008209be0>] save_stack_trace_tsk+0x0/0xf0
[<ffffff80083cb3f8>] proc_pid_stack+0xac/0x12c
[<ffffff80083c7c70>] proc_single_show+0x5c/0xa8
[<ffffff800838aca8>] seq_read+0x130/0x420
[<ffffff8008365c54>] __vfs_read+0x60/0x11c
[<ffffff80083665dc>] vfs_read+0x8c/0x140
[<ffffff800836717c>] SyS_read+0x6c/0xcc
[<ffffff8008202cb8>] __sys_trace_return+0x0/0x4
[<ffffffffffffffff>] 0xffffffffffffffff

Therefore, we'd better just jump only one layer to ensure accuracy and consistency.

Signed-off-by: liucheng <liucheng32@huawei.com>
---
 arch/arm/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 71778bb..bb3da38 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -125,7 +125,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 #endif
 	} else {
 		/* We don't want this function nor the caller */
-		data.skip += 2;
+		data.skip += 1;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_stack_pointer;
 		frame.lr = (unsigned long)__builtin_return_address(0);
-- 
1.8.5.6

