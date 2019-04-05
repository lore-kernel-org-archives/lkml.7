Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05794C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C52206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfDEGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:48:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfDEGsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:48:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81B73BF26C006EEB0309;
        Fri,  5 Apr 2019 14:47:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 14:47:52 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] sysctl: redefine zero as a unsigned long
Date:   Fri, 5 Apr 2019 14:52:17 +0800
Message-ID: <20190405065217.125140-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have got KASAN splat when tried to set /proc/sys/fs/file-max:

  BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x3e4/0x8f0
  Read of size 8 at addr ffff20000f9b2980 by task file-max.sh/36819

  Call trace:
   dump_backtrace+0x0/0x3f8
   show_stack+0x3c/0x60
   dump_stack+0x150/0x1a8
   print_address_description+0x2b8/0x5a0
   kasan_report+0x278/0x648
   __asan_load8+0x124/0x170
   __do_proc_doulongvec_minmax+0x3e4/0x8f0
   proc_doulongvec_minmax+0x80/0xa0
   proc_sys_call_handler+0x188/0x2a0
   proc_sys_write+0x5c/0x80
   __vfs_write+0x118/0x578
   vfs_write+0x184/0x418
   ksys_write+0xfc/0x1e8
   __arm64_sys_write+0x88/0xa8
   el0_svc_common+0x1a4/0x500
   el0_svc_handler+0xb8/0x180
   el0_svc+0x8/0xc

  The buggy address belongs to the variable:
   zero+0x0/0x40

The cause is that proc_doulongvec_minmax() is trying to cast an int
pointer (namely &zero) to a unsigned long pointer, and dereferencing it.

Although the warning seems does no harm, because zero will be placed
in a .bss section, but it's better to kill the KASAN warning by
redefining zero as a unsigned long, so it's OK whenever it is accessed
as an int or a a unsigned long.

An alternative fix seems to be set the minimal value of file-max to be 1,
so one_ul can be used instead, but I'm not sure whether or not a file-max
with a value of zero has special purpose (e.g., prohibit the file-related
activities of all no-privileged users).

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5da394d1ca3..03846e015013 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,7 +124,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 
-static int zero;
+static unsigned long zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
-- 
2.16.2.dirty

