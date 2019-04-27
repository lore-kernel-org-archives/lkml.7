Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A2C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B16206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ocsStDNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfD0DeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:34:09 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:17156 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3R3Xie9029345;
        Sat, 27 Apr 2019 12:33:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3R3Xie9029345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556336025;
        bh=nRN3KbTI71mxDcDVMkE3kPEQDMn9s9dPdxgPtZcV+64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocsStDNdXFsaveLs0g/okRTy+I6dxFZi6U0XR/yT/7MmsMPQ9ZYdX26iO9TZJYTln
         e2azvj3zCE7bhuvKus43WB6GD8EnjlhMpdDpHAJlHzHm0XmsO9ul/Pt/VF220e9K3j
         Oq4q7IuuUeWPPfLUWjagkprmSIR6XyiofHS7vTF9mN3d4Cmgx428HpOkC9015wbP7G
         pQHccdOnlcTYk5bgomqJiyFQ45Eq3WWflQwTYm0MFSz91vf+31bkkyfwGOnWUUWcQO
         gsdIdT5Fvt4mC+IngUVipgGspGy+1h0TzVIsZz/cC8w2YZ+3r2O6eEJqkdY2t8Hols
         NvBoDjbVra56A==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] samples: guard sub-directories with CONFIG options
Date:   Sat, 27 Apr 2019 12:33:38 +0900
Message-Id: <1556336020-15634-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not descend to sub-directories when unneeded.

I used subdir-$(CONFIG_...) for hidraw, seccomp, and statx because
they only contain host programs.

While we are here, let's add SPDX License tag, and sort the directories
alphabetically.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 samples/Makefile | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/samples/Makefile b/samples/Makefile
index 50f8586..0f2d70d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,6 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux samples code
 
-obj-y			+= kobject/ kprobes/ trace_events/ livepatch/ \
-			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/ binderfs/
+obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+= binderfs/
+obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
+obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
+subdir-y				+= hidraw
+obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
+obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
+obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
+obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
+obj-$(CONFIG_SAMPLE_KPROBES)		+= kprobes/
+obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
+obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
+obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
+subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
+subdir-$(CONFIG_SAMPLE_STATX)		+= statx
+obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
+obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
+obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
+obj-y					+= vfio-mdev/
-- 
2.7.4

