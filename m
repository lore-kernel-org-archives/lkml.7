Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4A620882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221200;
	bh=AriSTVrwAwPSl1zej9TZXvMbKX1Ub0Yq8gF9IRde1t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7uabYwshfK2Xh8dMgx8Arj3bpzjeKxDZG7pbvqOhthgsPytFG5nFbNilfaiqdyjN
	 sFKIigyQUsDDOOBLwnaIC1QxNxcKJ8EWxtwHNTeGPQCVCIkRI0VhyS+81HJOIu1pjl
	 1opQeNdNNG/eyHbSk0bOuLgwKWZBjQ0LovvStX8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfDBQGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfDBQGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:37 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6122082C;
        Tue,  2 Apr 2019 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221196;
        bh=AriSTVrwAwPSl1zej9TZXvMbKX1Ub0Yq8gF9IRde1t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoOVRVXpWlLOHtjumX/L0mNFyfL5P40fIDPhI6ZPXyEmjZSURsTA9eaHYxYsY9miT
         kuH8S132EO9xy4yi5uaEB69RRun7hzd7mCFJNQRGZIWg6D4FVJN1y1vuFQvAqAuU1T
         T/DjBxdLHxCOQKAsTk4XBVa6BvUaVtrZOGWYptT4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/44] tools lib traceevent: Handle trace_printk() "%px"
Date:   Tue,  2 Apr 2019 13:05:16 -0300
Message-Id: <20190402160549.13544-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

With security updates, %p in the kernel is hashed to protect true kernel
locations. But trace_printk() is not allowed in production systems, and
when a pointer is used, there are many times that the actual address is
needed. "%px" produces the real address. But libtraceevent does not know how
to handle that extension. Add it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164342.837312153@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87494c7c619d..2ebb257ce7ba 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4338,6 +4338,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 					case 'S':
 					case 'f':
 					case 'F':
+					case 'x':
 						break;
 					default:
 						/*
-- 
2.20.1

