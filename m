Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F6C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0220820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfGOCtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:49:53 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:48418 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfGOCtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:49:53 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 2315AA2E3E3EF8BA9DA7;
        Mon, 15 Jul 2019 10:49:51 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6F2nRc2086806;
        Mon, 15 Jul 2019 10:49:27 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071510492886-2346568 ;
          Mon, 15 Jul 2019 10:49:28 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, jgross@suse.com,
        huang.zijiang@zte.com.cn, karahmed@amazon.de, lijiang@redhat.com,
        m.mizuma@jp.fujitsu.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH] x86/e820: fix coccinelle warnings
Date:   Mon, 15 Jul 2019 10:47:09 +0800
Message-Id: <1563158829-44373-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-15 10:49:28,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-15 10:49:29,
        Serialize complete at 2019-07-15 10:49:29
X-MAIL: mse-fl2.zte.com.cn x6F2nRc2086806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following coccinelle warning:
./arch/x86/kernel/e820.c:89:9-10: WARNING: return of 0/1 in function '_e820__mapped_any' with return type bool

Return type bool instead of 0/1.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kernel/e820.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e69408b..7da2bcd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -86,9 +86,9 @@ static bool _e820__mapped_any(struct e820_table *table,
 			continue;
 		if (entry->addr >= end || entry->addr + entry->size <= start)
 			continue;
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type)
-- 
1.8.3.1

