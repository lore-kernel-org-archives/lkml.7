Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC38CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A178621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438063AbfJYIzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:55:32 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:61072 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437607AbfJYIzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:55:32 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 1E91D67EC5D1120E5763;
        Fri, 25 Oct 2019 16:55:28 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9P8sScR049383;
        Fri, 25 Oct 2019 16:54:28 +0800 (GMT-8)
        (envelope-from zhang.lin16@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102516550472-127499 ;
          Fri, 25 Oct 2019 16:55:04 +0800 
From:   zhanglin <zhang.lin16@zte.com.cn>
To:     dan.j.williams@intel.com
Cc:     akpm@linux-foundation.org, jgg@ziepe.ca, mingo@kernel.org,
        dave.hansen@linux.intel.com, namit@vmware.com, bp@suse.de,
        christophe.leroy@c-s.fr, rdunlap@infradead.org, osalvador@suse.de,
        richardw.yang@linux.intel.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] kernel: Restrict permissions of /proc/iomem.
Date:   Fri, 25 Oct 2019 16:56:41 +0800
Message-Id: <1571993801-12665-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-25 16:55:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-25 16:54:34,
        Serialize complete at 2019-10-25 16:54:34
X-MAIL: mse-fl2.zte.com.cn x9P8sScR049383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permissions of /proc/iomem currently are -r--r--r--. Everyone can
see its content. As iomem contains information about the physical memory
content of the device, restrict the information only to root.

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 kernel/resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc6..844456e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -139,7 +139,8 @@ static int __init ioresources_init(void)
 {
 	proc_create_seq_data("ioports", 0, NULL, &resource_op,
 			&ioport_resource);
-	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
+	proc_create_seq_data("iomem", S_IRUSR, NULL, &resource_op,
+			&iomem_resource);
 	return 0;
 }
 __initcall(ioresources_init);
-- 
2.15.2

