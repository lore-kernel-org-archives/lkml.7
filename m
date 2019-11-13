Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB2C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E75320674
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610781;
	bh=Y5gSmstb9HkkjIeygMwLJ2UsJ94HGuiTlu/bS/iLyic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZZy/7FSVNhpikkVWWLi7Wgmy/Jk6a9CJ1uvivhDE28U33an6AmcSU3xPZAEuuXSib
	 E82rk9HPSklUzVU3q0PH6XMc09yaKklGv+nmb3ESofWwrAGir43L5jlan9lQaNccp3
	 OR7gH2AY468r13n9nYedT1w0kSUNBeI+KA2mmNx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfKMCBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbfKMCBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:01:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBD222476;
        Wed, 13 Nov 2019 02:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610468;
        bh=Y5gSmstb9HkkjIeygMwLJ2UsJ94HGuiTlu/bS/iLyic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPtz6PruWH4PBGOytBsKHi1Jwnga9/E6kEH75muLOzjkWdUD29BH8FbvPBp4zMgho
         TlXyE7nPYmkFiXPkvTJMCZU+TMrTcA3MqYe0Y2PJpHyEzpB6V4GV9Lq+vY9xj19zry
         snA5LdGHyHEzZOnHlOGecrnlaZJK677naW6E84Ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     He Zhe <zhe.he@windriver.com>, rostedt@goodmis.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 54/68] printk: Give error on attempt to set log buffer length to over 2G
Date:   Tue, 12 Nov 2019 20:59:18 -0500
Message-Id: <20191113015932.12655-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

[ Upstream commit e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e ]

The current printk() is ready to handle log buffer size up to 2G.
Give an explicit error for users who want to use larger log buffer.

Also fix printk formatting to show the 2G as a positive number.

Link: http://lkml.kernel.org/r/20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz
Cc: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
[pmladek: Fixed to the really safe limit 2GB.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6607d77afe55a..a0339c458c140 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -383,6 +383,7 @@ static u32 clear_idx;
 /* record buffer */
 #define LOG_ALIGN __alignof__(struct printk_log)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
+#define LOG_BUF_LEN_MAX (u32)(1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
@@ -983,18 +984,23 @@ void log_buf_kexec_setup(void)
 static unsigned long __initdata new_log_buf_len;
 
 /* we practice scaling the ring buffer by powers of 2 */
-static void __init log_buf_len_update(unsigned size)
+static void __init log_buf_len_update(u64 size)
 {
+	if (size > (u64)LOG_BUF_LEN_MAX) {
+		size = (u64)LOG_BUF_LEN_MAX;
+		pr_err("log_buf over 2G is not supported.\n");
+	}
+
 	if (size)
 		size = roundup_pow_of_two(size);
 	if (size > log_buf_len)
-		new_log_buf_len = size;
+		new_log_buf_len = (unsigned long)size;
 }
 
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned int size;
+	u64 size;
 
 	if (!str)
 		return -EINVAL;
@@ -1064,7 +1070,7 @@ void __init setup_log_buf(int early)
 	}
 
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %ld bytes not available\n",
+		pr_err("log_buf_len: %lu bytes not available\n",
 			new_log_buf_len);
 		return;
 	}
@@ -1077,8 +1083,8 @@ void __init setup_log_buf(int early)
 	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
 	raw_spin_unlock_irqrestore(&logbuf_lock, flags);
 
-	pr_info("log_buf_len: %d bytes\n", log_buf_len);
-	pr_info("early log buf free: %d(%d%%)\n",
+	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 }
 
-- 
2.20.1

