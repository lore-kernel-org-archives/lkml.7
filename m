Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC76C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB621951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfGVVnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:43:09 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59078 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfGVVnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:43:09 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpg5K-0000mr-Ut from George_Davis@mentor.com ; Mon, 22 Jul 2019 14:43:06 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 22 Jul
 2019 14:43:04 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "George G. Davis" <george_davis@mentor.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tracing: kmem: convert call_site addresses to user friendly symbols
Date:   Mon, 22 Jul 2019 17:42:59 -0400
Message-ID: <1563831780-14888-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While attempting to debug slub freelist pointer corruption bugs
caused by a module, I discovered that the kmem call_site addresses are
not at all user friendly for modules unless you manage to save a copy
of kallsyms for the running kernel beforehand.

So convert kmem call_site addresses to user friendly symbols which is
especially helpful for module callers when you don't have a copy of
kallsyms for the running kernel.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
Change history:
v1:
- First submission
v2:
- Fix kbuild test robot issues as suggested by
  Steven Rostedt.
---
 include/trace/events/kmem.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..09e1eeb4e44d 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -35,8 +35,8 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
-		__entry->call_site,
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
@@ -88,8 +88,8 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node		= node;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
-		__entry->call_site,
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
@@ -131,7 +131,8 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
+	TP_printk("call_site=%pS ptr=%p",
+		(void *)__entry->call_site, __entry->ptr)
 );
 
 DEFINE_EVENT(kmem_free, kfree,
-- 
2.7.4

