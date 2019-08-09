Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C514C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6182166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406289AbfHIJwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:52:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406224AbfHIJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:52:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FFCDCF690B9438D699B;
        Fri,  9 Aug 2019 17:52:08 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 17:51:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v6 12/12] powerpc/fsl_booke/32: Document KASLR implementation
Date:   Fri, 9 Aug 2019 18:08:00 +0800
Message-ID: <20190809100800.5426-13-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190809100800.5426-1-yanaijie@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document to explain how we implement KASLR for fsl_booke32.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 Documentation/powerpc/kaslr-booke32.rst | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/powerpc/kaslr-booke32.rst

diff --git a/Documentation/powerpc/kaslr-booke32.rst b/Documentation/powerpc/kaslr-booke32.rst
new file mode 100644
index 000000000000..8b259fdfdf03
--- /dev/null
+++ b/Documentation/powerpc/kaslr-booke32.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+KASLR for Freescale BookE32
+===========================
+
+The word KASLR stands for Kernel Address Space Layout Randomization.
+
+This document tries to explain the implementation of the KASLR for
+Freescale BookE32. KASLR is a security feature that deters exploit
+attempts relying on knowledge of the location of kernel internals.
+
+Since CONFIG_RELOCATABLE has already supported, what we need to do is
+map or copy kernel to a proper place and relocate. Freescale Book-E
+parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
+entries are not suitable to map the kernel directly in a randomized
+region, so we chose to copy the kernel to a proper place and restart to
+relocate.
+
+Entropy is derived from the banner and timer base, which will change every
+build and boot. This not so much safe so additionally the bootloader may
+pass entropy via the /chosen/kaslr-seed node in device tree.
+
+We will use the first 512M of the low memory to randomize the kernel
+image. The memory will be split in 64M zones. We will use the lower 8
+bit of the entropy to decide the index of the 64M zone. Then we chose a
+16K aligned offset inside the 64M zone to put the kernel in::
+
+    KERNELBASE
+
+        |-->   64M   <--|
+        |               |
+        +---------------+    +----------------+---------------+
+        |               |....|    |kernel|    |               |
+        +---------------+    +----------------+---------------+
+        |                         |
+        |----->   offset    <-----|
+
+                              kernstart_virt_addr
+
+To enable KASLR, set CONFIG_RANDOMIZE_BASE = y. If KASLR is enable and you
+want to disable it at runtime, add "nokaslr" to the kernel cmdline.
-- 
2.17.2

