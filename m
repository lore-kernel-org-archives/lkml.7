Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD6CC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F132088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDYQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfDYQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3339020717;
        Thu, 25 Apr 2019 16:28:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hJhEp-0005KQ-Mq; Thu, 25 Apr 2019 12:28:43 -0400
Message-Id: <20190425162843.595658448@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 25 Apr 2019 12:28:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/5] ftrace: Remove ASSIGN_OPS_HASH() macro from ftrace.c
References: <20190425162808.056301033@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ASSIGN_OPS_HASH() macro was moved to fgraph.c where it was used, but for
some reason it wasn't removed from ftrace.c, as it is no longer referenced
there.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 26c8ca9bd06b..bf11e0553450 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -69,12 +69,8 @@
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
-#define ASSIGN_OPS_HASH(opsname, val) \
-	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
 #else
 #define INIT_OPS_HASH(opsname)
-#define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
 enum {
-- 
2.20.1


