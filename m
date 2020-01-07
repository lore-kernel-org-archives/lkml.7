Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D3DC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1950924677
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430968;
	bh=082g/+E/r/Uzy/BpXGTHlxw9TEPrw/aq7wuayti0Uhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2vgZP/apgx9HbhgrLwq6m6eeY7wzxu8QFle/fN16t52HdSoLOJz8QgATdM3CQmXA
	 wUWQ7hbPB7mzjywp7s4IHgXA6KAu3Y0zD4sXxWpcOcNRtOQbX1HMdbRvchL+2HgCIH
	 8Mk3FiG0zqmze0cdPav3yT5WGM7XuL/CRE6eQujo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgAGVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgAGVCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:02:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DB72077B;
        Tue,  7 Jan 2020 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430962;
        bh=082g/+E/r/Uzy/BpXGTHlxw9TEPrw/aq7wuayti0Uhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1M6+GcOKkGOqOCD+LdffhY3ixJkI9X1BabwU8EJdFlvOPLVMgbcHKTttGg3yOisB
         HYJp9jdfvDWhDwrDsuoYMs65qAzV/dh8DQsTf4o1ismAYQ7fRxpwS/oI3UZ8tS8tU0
         V5RAlY7XPqeQvYrGQw+fvGmOEXhm4g0FhBacDrrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.4 131/191] ftrace: Avoid potential division by zero in function profiler
Date:   Tue,  7 Jan 2020 21:54:11 +0100
Message-Id: <20200107205339.982782846@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit e31f7939c1c27faa5d0e3f14519eaf7c89e8a69d upstream.

The ftrace_profile->counter is unsigned long and
do_div truncates it to 32 bits, which means it can test
non-zero and be truncated to zero for division.
Fix this issue by using div64_ul() instead.

Link: http://lkml.kernel.org/r/20200103030248.14516-1-wenyang@linux.alibaba.com

Cc: stable@vger.kernel.org
Fixes: e330b3bcd8319 ("tracing: Show sample std dev in function profiling")
Fixes: 34886c8bc590f ("tracing: add average time in function to function profiler")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -524,8 +524,7 @@ static int function_stat_show(struct seq
 	}
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	avg = rec->time;
-	do_div(avg, rec->counter);
+	avg = div64_ul(rec->time, rec->counter);
 	if (tracing_thresh && (avg < tracing_thresh))
 		goto out;
 #endif
@@ -551,7 +550,8 @@ static int function_stat_show(struct seq
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev,
+				  rec->counter * (rec->counter - 1) * 1000);
 	}
 
 	trace_seq_init(&s);


