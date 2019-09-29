Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8AC2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfI2UII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbfI2UHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:07:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996D221925;
        Sun, 29 Sep 2019 20:07:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iEfTw-00082j-Qm; Sun, 29 Sep 2019 16:07:48 -0400
Message-Id: <20190929200748.716201915@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Sep 2019 16:06:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-linus][PATCH 4/5] mm, tracing: Print symbol name for call_site in trace events
References: <20190929200642.036511084@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

To improve the readability of raw slab trace points, print the call_site ip
using '%pS'. Then we can grep events with function names.

[002] ....   808.188897: kmem_cache_free: call_site=putname+0x47/0x50 ptr=00000000cef40c80
[002] ....   808.188898: kfree: call_site=security_cred_free+0x42/0x50 ptr=0000000062400820
[002] ....   808.188904: kmem_cache_free: call_site=put_cred_rcu+0x88/0xa0 ptr=0000000058d74ef8
[002] ....   808.188913: kmem_cache_alloc: call_site=prepare_creds+0x26/0x100 ptr=0000000058d74ef8 bytes_req=168 bytes_alloc=576 gfp_flags=GFP_KERNEL
[002] ....   808.188917: kmalloc: call_site=security_prepare_creds+0x77/0xa0 ptr=0000000062400820 bytes_req=8 bytes_alloc=336 gfp_flags=GFP_KERNEL|__GFP_ZERO
[002] ....   808.188920: kmem_cache_alloc: call_site=getname_flags+0x4f/0x1e0 ptr=00000000cef40c80 bytes_req=4096 bytes_alloc=4480 gfp_flags=GFP_KERNEL
[002] ....   808.188925: kmem_cache_free: call_site=putname+0x47/0x50 ptr=00000000cef40c80
[002] ....   808.188926: kfree: call_site=security_cred_free+0x42/0x50 ptr=0000000062400820
[002] ....   808.188931: kmem_cache_free: call_site=put_cred_rcu+0x88/0xa0 ptr=0000000058d74ef8

Link: http://lkml.kernel.org/r/20190914103215.23301-1-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/kmem.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..69e8bb8963db 100644
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
@@ -131,7 +131,8 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
+	TP_printk("call_site=%pS ptr=%p",
+		  (void *)__entry->call_site, __entry->ptr)
 );
 
 DEFINE_EVENT(kmem_free, kfree,
-- 
2.20.1


