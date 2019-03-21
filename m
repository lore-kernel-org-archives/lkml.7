Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231FE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i77uOOny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCUH5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36674 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfCUH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so3796989pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUrYg5gPfr5+YxKSU7WKTSl4E1D61tEu6638WRvIWF8=;
        b=i77uOOnyP+f7aBg07jhf5PvpcDyoT0OZyYqGV5d8al+HiI9IYK5R+OoyUfCPXXqNot
         Wa5kyTWPMLTNoaXhzVyz5lrcHAzSAurKK2m78S0tm+YsJiwtqgGoBD8jkpuuegTDn1UA
         eYHOHgdamNQ9d3U90MJp4cgAZQxRLlhWKsWOqMUWnp2BmQJaZdkeTMPsXL3tvsFrQ81W
         ANb/OeqY0TqcnwCpcjEM/LjD0rXXvYCKkMxM/1+7rUU0PsKa5qFxwGFiKPUkhapx3w00
         k91Jd4ZaD7akczE47g8pPaJeDiAL0t7+L1MKBvpbiid8p8AS3QOGwINOK2/bTe/nprr+
         MMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LUrYg5gPfr5+YxKSU7WKTSl4E1D61tEu6638WRvIWF8=;
        b=b9ZodvzxE4CU6mOy7e7/S9v4/J8ERr99EK19RlfsZPH2+4f5cqEGvkS+2xfEe1EAZy
         r/7qdec49Lcbl51clJ3eH048aYUd8LGzMip+6Lv6McAI8Af6+05tuJsmndXeDrIX3BW9
         ZsQiCYcUa0IlxBsDTstoBv/emYRB5nDP/mWRCEH/0FVyWEmzNdoSFukq6RfLzT+0ulL9
         yOS2kPgD4zsj0Qfws/gs6JxRq6rWiMuKHEV+mTzEKdm+PQLLdAWQgePgvnswyjxghEt1
         UQe6O0ZIlAKpXLkpZB62V554Pgv3qGgMkKfFM7y+5BvMdMgqGX18LHTMVPUs4K1fsZRM
         bqVA==
X-Gm-Message-State: APjAAAWA6k4IHW8NocjcP5PjVbXWpHhUDqzQs7jG5lWL/al1iSyq7pcF
        Td5I8tsTdwid85mwZq4WHNU=
X-Google-Smtp-Source: APXvYqxDds3Hgg1HWtxAecK2wNNedNT+eI7TSiZaxomZWHBDA4wL/Hpn2bZ6W1oNEKJ26pyS6VcRlg==
X-Received: by 2002:a62:45d2:: with SMTP id n79mr2011665pfi.213.1553155068396;
        Thu, 21 Mar 2019 00:57:48 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:47 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 05/18] locking/lockdep: Print the right depth for chain key colission
Date:   Thu, 21 Mar 2019 15:57:12 +0800
Message-Id: <20190321075725.14054-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chains are separated by irq context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index eeea722..05c31d6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2428,10 +2428,11 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-- 
1.8.3.1

