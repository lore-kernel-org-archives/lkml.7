Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA774C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849CA2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888160;
	bh=cYKOQpl2jlSpjXkWQLRUb8No+CV+k2spKhHIlgEtrU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dr9I3JbfIuytzU+O2foDPtwDGacMNv+rpCdyn3WiGnbAAnhteOcNx0kaDhdO4ObcP
	 gHfhHdbwDL7LdWNx2UW13BySewrZ8bpHxyRIFdWV4SzvPiX3HUoN1+qCQS8J/Bz7F2
	 3T3YJI5FTn3ukZvVjYdiDc0wwG9IHi132YShuqiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfK0Uz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfK0Uzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3ED218BA;
        Wed, 27 Nov 2019 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888154;
        bh=cYKOQpl2jlSpjXkWQLRUb8No+CV+k2spKhHIlgEtrU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBM8d4YxE6R9g52awX+09ksz7eYgLp4a5RbRBWNjwE4cqbntbsPGmoLM31qkb9dWk
         qJYfCtD557Bk2a+efL4eZKGRRrU8U2DFNiA7+Aw39Hyn/a/FcDJZ2e3C8KQL+AzRem
         bP6fESca7Gmix3oo4GK+b/rVDYG1BbKc8DKFTN3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/306] printk: fix integer overflow in setup_log_buf()
Date:   Wed, 27 Nov 2019 21:27:55 +0100
Message-Id: <20191127203116.522442750@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

[ Upstream commit d2130e82e9454304e9b91ba9da551b5989af8c27 ]

The way we calculate logbuf free space percentage overflows signed
integer:

	int free;

	free = __LOG_BUF_LEN - log_next_idx;
	pr_info("early log buf free: %u(%u%%)\n",
		free, (free * 100) / __LOG_BUF_LEN);

We support LOG_BUF_LEN of up to 1<<25 bytes. Since setup_log_buf() is
called during early init, logbuf is mostly empty, so

	__LOG_BUF_LEN - log_next_idx

is close to 1<<25. Thus when we multiply it by 100, we overflow signed
integer value range: 100 is 2^6 + 2^5 + 2^2.

Example, booting with LOG_BUF_LEN 1<<25 and log_buf_len=2G
boot param:

[    0.075317] log_buf_len: -2147483648 bytes
[    0.075319] early log buf free: 33549896(-28%)

Make "free" unsigned integer and use appropriate printk() specifier.

Link: http://lkml.kernel.org/r/20181010113308.9337-1-sergey.senozhatsky@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 59ceaed1aeed7..845efadaf7ecf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1105,7 +1105,7 @@ void __init setup_log_buf(int early)
 {
 	unsigned long flags;
 	char *new_log_buf;
-	int free;
+	unsigned int free;
 
 	if (log_buf != __log_buf)
 		return;
-- 
2.20.1



