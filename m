Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC79206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLJCrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:47:45 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:23285 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfLJCrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:47:45 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id B815C31F3CDA61EB2612;
        Tue, 10 Dec 2019 10:47:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id xBA2iv9h063903;
        Tue, 10 Dec 2019 10:44:57 +0800 (GMT-8)
        (envelope-from zhang.lin16@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019121010450863-1096245 ;
          Tue, 10 Dec 2019 10:45:08 +0800 
From:   zhanglin <zhang.lin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, steven.price@arm.com, david.engraf@sysgo.com,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] initramfs: forcing panic when kstrdup failed
Date:   Tue, 10 Dec 2019 10:48:41 +0800
Message-Id: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-12-10 10:45:08,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-12-10 10:44:59,
        Serialize complete at 2019-12-10 10:44:59
X-MAIL: mse-fl1.zte.com.cn xBA2iv9h063903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preventing further undefined behaviour when kstrdup failed.

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 init/initramfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index fca899622937..39a4fba48cc7 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -125,6 +125,8 @@ static void __init dir_add(const char *name, time64_t mtime)
 		panic("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
+	if (!de->name)
+		panic("can't allocate dir_entry.name buffer");
 	de->mtime = mtime;
 	list_add(&de->list, &dir_list);
 }
@@ -340,6 +342,8 @@ static int __init do_name(void)
 				if (body_len)
 					ksys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
+				if (!vcollected)
+					panic("can not allocate vcollected buffer.");
 				state = CopyFile;
 			}
 		}
-- 
2.17.1

