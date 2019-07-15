Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A00C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791812083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfGOJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:24:06 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:49554 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfGOJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:24:06 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 05:24:05 EDT
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 6F30D10089E12;
        Mon, 15 Jul 2019 17:14:32 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 277F0201B4B7E;
        Mon, 15 Jul 2019 16:59:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U2UPg0hsyajD; Mon, 15 Jul 2019 16:59:13 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 0348B20424204;
        Mon, 15 Jul 2019 16:59:13 +0800 (CST)
From:   xywang.sjtu@sjtu.edu.cn
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH 2/2] ftrace: replace simple_strtol() by kstrtol()
Date:   Mon, 15 Jul 2019 16:58:56 +0800
Message-Id: <20190715085856.5664-2-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190715085856.5664-1-xywang.sjtu@sjtu.edu.cn>
References: <20190715085856.5664-1-xywang.sjtu@sjtu.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>

The simple_strtol() function is deprecated. kstrtol() is
the correct replacement as it can properly handle overflows.

This patch replaces the deprecated simple_strtol() use introduced recently.
Same as the case of invalid index, it returns zero on string parsing error.

Fixes: f79b3f338564 ("ftrace: Allow enabling of filters via index of available_filter_functions")
Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 kernel/trace/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 576c41644e77..2baabf51a61a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3701,10 +3701,13 @@ static int
 add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 		 int clear_filter)
 {
-	long index = simple_strtoul(func_g->search, NULL, 0);
+	long index;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
+	if (kstrtoul(func_g->search, 0, &index))
+		return 0;
+
 	/* The index starts at 1 */
 	if (--index < 0)
 		return 0;
-- 
2.11.0

