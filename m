Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9BCC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA932182B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfGPTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbfGPTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB56217D9;
        Tue, 16 Jul 2019 19:00:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hnSh7-0006Dt-8p; Tue, 16 Jul 2019 15:00:57 -0400
Message-Id: <20190716190057.160953156@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 16 Jul 2019 15:00:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [for-next][PATCH 4/5] tracing: Let filter_assign_type() detect FILTER_PTR_STRING
References: <20190716190014.840939538@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

filter_assign_type() could detect dynamic string and static
string, but not string pointers. Teach filter_assign_type()
to detect string pointers, and this will be needed by trace
event injection code.

BTW, trace event hist uses FILTER_PTR_STRING too.
Link: http://lkml.kernel.org/r/20190525165802.25944-3-xiyou.wangcong@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d3e59312ef40..550e8a0d048a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1080,6 +1080,9 @@ int filter_assign_type(const char *type)
 	if (strchr(type, '[') && strstr(type, "char"))
 		return FILTER_STATIC_STRING;
 
+	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
+		return FILTER_PTR_STRING;
+
 	return FILTER_OTHER;
 }
 
-- 
2.20.1


