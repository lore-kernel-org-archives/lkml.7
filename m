Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E1EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F21208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKNSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfKNSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD312083E;
        Thu, 14 Nov 2019 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhI-0000zp-41; Thu, 14 Nov 2019 13:18:24 -0500
Message-Id: <20191114181823.994683944@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 04/33] ftrace: Separate out the copying of a ftrace_hash from
 __ftrace_hash_move()
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Most of the functionality of __ftrace_hash_move() can be reused, but not all
of it. That is, __ftrace_hash_move() is used to simply make a new hash from
an existing one, using the same size as the original. Creating a dup_hash(),
where we can specify a new size will be useful when we want to create a hash
with a default size, or simply copy the old one.

Signed-off-by: Steven Rostedt (VMWare) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 89e9128652ef..76e5de8c7822 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1372,23 +1372,15 @@ ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 				       struct ftrace_hash *new_hash);
 
-static struct ftrace_hash *
-__ftrace_hash_move(struct ftrace_hash *src)
+static struct ftrace_hash *dup_hash(struct ftrace_hash *src, int size)
 {
 	struct ftrace_func_entry *entry;
-	struct hlist_node *tn;
-	struct hlist_head *hhd;
 	struct ftrace_hash *new_hash;
-	int size = src->count;
+	struct hlist_head *hhd;
+	struct hlist_node *tn;
 	int bits = 0;
 	int i;
 
-	/*
-	 * If the new source is empty, just return the empty_hash.
-	 */
-	if (ftrace_hash_empty(src))
-		return EMPTY_HASH;
-
 	/*
 	 * Make the hash size about 1/2 the # found
 	 */
@@ -1413,10 +1405,23 @@ __ftrace_hash_move(struct ftrace_hash *src)
 			__add_hash_entry(new_hash, entry);
 		}
 	}
-
 	return new_hash;
 }
 
+static struct ftrace_hash *
+__ftrace_hash_move(struct ftrace_hash *src)
+{
+	int size = src->count;
+
+	/*
+	 * If the new source is empty, just return the empty_hash.
+	 */
+	if (ftrace_hash_empty(src))
+		return EMPTY_HASH;
+
+	return dup_hash(src, size);
+}
+
 static int
 ftrace_hash_move(struct ftrace_ops *ops, int enable,
 		 struct ftrace_hash **dst, struct ftrace_hash *src)
-- 
2.23.0


