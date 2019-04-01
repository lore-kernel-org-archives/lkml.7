Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A86C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3391D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139950;
	bh=F3Xj8NlU14If4J/gVtdyXOEOC2or/quENy8MAX1JN54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hG/CTyJq/JDGHkNiRhBQcJCkLAop98P2xskqSnwDtRQjwzVhHwiz9kIOuugvHt1ZF
	 Z55biolK8ZYBneRcmLQrFwDK5AjAB8zxpaXqax26wtxthEBOBOaQDctj2KTll4QyZW
	 XPj+k5EFFZqm74Q7saqjXnvBmihSI463QTM/Eip8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfDARc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733023AbfDARcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62379208E4;
        Mon,  1 Apr 2019 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139944;
        bh=F3Xj8NlU14If4J/gVtdyXOEOC2or/quENy8MAX1JN54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9KGO21FLdX/w0r5qzK1LQPYa/REAfdUmKUpTYDwd7612g6i0N0fvURuO7AF2L5C2
         NJcAf8pRsos/SXTfDmD18u3NS68wqRTtynZveSy9VsnxMWmL9BtdXhNfe7la9OHMcH
         iL9uDAs20M8kFDruzF+fSwi/kb52h5RQN60qj0Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 060/131] stm class: Prevent user-controllable allocations
Date:   Mon,  1 Apr 2019 19:02:10 +0200
Message-Id: <20190401170057.328475167@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f08b18266c7116e2ec6885dd53a928f580060a71 ]

Currently, the character device write method allocates a temporary buffer
for user's data, but the user's data size is not sanitized and can cause
arbitrarily large allocations via kzalloc() or an integer overflow that
will then result in overwriting kernel memory.

This patch trims the input buffer size to avoid these issues.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f286de2e86af..e4fa583b57a6 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -410,6 +410,9 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 	char *kbuf;
 	int err;
 
+	if (count + 1 > PAGE_SIZE)
+		count = PAGE_SIZE - 1;
+
 	/*
 	 * if no m/c have been assigned to this writer up to this
 	 * point, use "default" policy entry
-- 
2.19.1



