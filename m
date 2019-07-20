Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22F7C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3822084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbfGTCXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 22:23:13 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:39727 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfGTCXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 22:23:13 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hof1b-0000VN-Ts from George_Davis@mentor.com ; Fri, 19 Jul 2019 19:23:03 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Jul
 2019 19:23:01 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "George G. Davis" <george_davis@mentor.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: kmem: convert call_site addresses to user friendly symbols
Date:   Fri, 19 Jul 2019 22:22:40 -0400
Message-ID: <1563589361-18337-1-git-send-email-george_davis@mentor.com>
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

Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 include/trace/events/kmem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..ae18e61fa1c0 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
 		__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
@@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node		= node;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
 		__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
@@ -131,7 +131,7 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
+	TP_printk("call_site=%pS ptr=%p", __entry->call_site, __entry->ptr)
 );
 
 DEFINE_EVENT(kmem_free, kfree,
-- 
2.7.4

