Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAEEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B521897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfH3H3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:29:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfH3H3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:29:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F26753916B59F0EEA57D;
        Fri, 30 Aug 2019 15:09:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 15:08:54 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <dyoung@redhat.com>, <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v6 4/4] kdump: update Documentation about crashkernel on arm64
Date:   Fri, 30 Aug 2019 15:12:00 +0800
Message-ID: <20190830071200.56169-5-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830071200.56169-1-chenzhou10@huawei.com>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support crashkernel=X,[low] on arm64, update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/admin-guide/kdump/kdump.rst       | 13 +++++++++++--
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index ac7e131..e55173e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -299,7 +299,13 @@ Boot into System Kernel
    "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
    starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 use "crashkernel=64M@16M".
+
+   On x86_64, use "crashkernel=Y[@X]" to select a region under 4G first, and
+   fall back to reserve region above 4G when '@offset' hasn't been specified.
+   We can also use "crashkernel=X,high" to select a region above 4G, which
+   also tries to allocate at least 256M below 4G automatically and
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
 
    On ppc64, use "crashkernel=128M@32M".
 
@@ -316,8 +322,11 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
+   On arm64, use "crashkernel=Y[@X]". Note that the start address of
    the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   If crashkernel=Z,low is specified simultaneously, reserve spcified size
+   low memory for crash kdump kernel devices firstly and then reserve memory
+   above 4G.
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4c19719..069a122 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -708,6 +708,9 @@
 			[KNL, x86_64] select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, arm64] If crashkernel=X,low is specified, reserve
+			spcified size low memory for crash kdump kernel devices
+			firstly, and then reserve memory above 4G.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -732,12 +735,19 @@
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate at
-			at least 256M below 4G automatically.
+			least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+			[KNL, arm64] range under 4G.
+			This one let user to specify own low range under 4G
+			for crash dump kernel instead.
+			Different with x86_64, kernel allocates specified size
+			physical memory region only when this parameter is specified
+			instead of trying to allocate at least 256M below 4G
+			automatically.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
-- 
2.7.4

