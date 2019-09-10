Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BEEC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6190206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfIJIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:24:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfIJIYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:24:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D02E163D3A232B0C647;
        Tue, 10 Sep 2019 16:24:44 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 16:24:37 +0800
From:   tiantao6 <tiantao6@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ras: debugfs: Fix warning: no previous prototype
Date:   Tue, 10 Sep 2019 16:22:19 +0800
Message-ID: <1568103739-36667-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the fellow warning when building with warnings enabled (W=1)

drivers/ras/debugfs.c:8:5: warning: no previous prototype for
‘ras_userspace_consumers’ [-Wmissing-prototypes]
int ras_userspace_consumers(void)

drivers/ras/debugfs.c:38:12: warning: no previous prototype for
‘ras_add_daemon_trace’ [-Wmissing-prototypes]
int __init ras_add_daemon_trace(void)

drivers/ras/debugfs.c:54:13: warning: no previous prototype for
‘ras_debugfs_init’ [-Wmissing-prototypes]
void __init ras_debugfs_init(void)

Signed-off-by: tiantao6 <tiantao6@huawei.com>
---
 drivers/ras/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 9c1b717..39b96a5 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/debugfs.h>
+#include <linux/ras.h>
 
 struct dentry *ras_debugfs_dir;
 
-- 
2.7.4

