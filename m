Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99CC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA6208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHJHWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:22:50 -0400
Received: from mail5.windriver.com ([192.103.53.11]:49716 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfHJHWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:22:50 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7A7MCJn019665
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 10 Aug 2019 00:22:23 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Sat, 10 Aug 2019 00:22:02 -0700
From:   <zhe.he@windriver.com>
To:     <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] module: Fix load failure when CONFIG_STRICT_MODULE_RWX is diabled
Date:   Sat, 10 Aug 2019 15:22:00 +0800
Message-ID: <1565421720-316924-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

When loading modules with CONFIG_ARCH_HAS_STRICT_MODULE_RWX enabled and
CONFIG_STRICT_MODULE_RWX disabled, the memory allocated for modules would
not be page-aligned and cause the following BUG during frob_text.

------------[ cut here ]------------
kernel BUG at kernel/module.c:1907!
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in:
CPU: 0 PID: 89 Comm: systemd-modules Not tainted 5.3.0-rc2 #1
Hardware name: ARM-Versatile (Device Tree Support)
PC is at frob_text.constprop.0+0x2c/0x40
LR is at load_module+0x14b4/0x1d28
pc : [<c0082930>]    lr : [<c0084bb0>]    psr: 20000013
sp : ce44fe58  ip : 00000000  fp : 00000000
r10: 00000000  r9 : ce44feb8  r8 : 00000000
r7 : 00000001  r6 : bf00032c  r5 : ce44ff40  r4 : bf000320
r3 : bf000400  r2 : 00000fff  r1 : 00000220  r0 : bf000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 0e4c0000  DAC: 00000051
Process systemd-modules (pid: 89, stack limit = 0x9fccc8dc)
Stack: (0xce44fe58 to 0xce450000)
fe40:                                                       00000000 cf1b05b8
fe60: 00000001 ce47cf08 bf002754 c07ae5d8 d0a2a484 bf002060 bf0004f8 00000000
fe80: b6d17910 c017cf1c ce47cf00 d0a29000 ce47cf00 ce44ff34 000014fc 00000000
fea0: 00000000 00000000 bf00025c 00000001 00000000 00000000 6e72656b 00006c65
fec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
fee0: 00000000 00000000 00000000 00000000 00000000 c0ac9048 7fffffff 00000000
ff00: b6d17910 00000005 0000017b c0009208 ce44e000 00000000 b6ebfe54 c008562c
ff20: 7fffffff 00000000 00000003 cefd28f8 00000001 d0a29000 000014fc 00000000
ff40: d0a292cb d0a29380 d0a29000 000014fc d0a29f0c d0a29d90 d0a29a60 00000520
ff60: 00000710 00000718 00000826 00000000 00000000 00000000 00000708 00000023
ff80: 00000024 0000001c 00000000 00000016 00000000 c0ac9048 0041c620 00000000
ffa0: 00000000 c0009000 0041c620 00000000 00000005 b6d17910 00000000 00000000
ffc0: 0041c620 00000000 00000000 0000017b 0041f078 00000000 004098b0 b6ebfe54
ffe0: bedb6bc8 bedb6bb8 b6d0f91c b6c945a0 60000010 00000005 00000000 00000000
[<c0082930>] (frob_text.constprop.0) from [<c0084bb0>] (load_module+0x14b4/0x1d28)
[<c0084bb0>] (load_module) from [<c008562c>] (sys_finit_module+0xa0/0xc4)
[<c008562c>] (sys_finit_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
Exception stack(0xce44ffa8 to 0xce44fff0)
ffa0:                   0041c620 00000000 00000005 b6d17910 00000000 00000000
ffc0: 0041c620 00000000 00000000 0000017b 0041f078 00000000 004098b0 b6ebfe54
ffe0: bedb6bc8 bedb6bb8 b6d0f91c b6c945a0
Code: e7f001f2 e5931008 e1110002 0a000001 (e7f001f2)
---[ end trace e904557128d9aed5 ]---

This patch enables page-aligned allocation when
CONFIG_ARCH_HAS_STRICT_MODULE_RWX is enabled.

Fixes: 93651f80dcb6 ("modules: fix compile error if don't have strict module rwx")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395..9ee9342 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -65,9 +65,9 @@
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
- * only when CONFIG_STRICT_MODULE_RWX=y
+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
  */
-#ifdef CONFIG_STRICT_MODULE_RWX
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 # define debug_align(X) ALIGN(X, PAGE_SIZE)
 #else
 # define debug_align(X) (X)
-- 
2.7.4

