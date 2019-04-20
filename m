Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093FAC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECA72183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZzH21STK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDTCXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 22:23:13 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57722 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 22:23:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 05BDDF79
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 02:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9rEivAskvXUH for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 21:23:10 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id D1B73F81
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 21:23:10 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id t12so1014117ioc.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MNz7GatuofIkkUh4eG147AyWudtcNieUuNdHadeb8VY=;
        b=ZzH21STKCXugCQGQfpv024ow8+mKSF6+dPsvzPjt4inQ19GYOXhY5GiSfysGzFxhau
         OOQ0QD+tFun1sp8WcODRnjwJ8HtphptXRu9HcZIzOdudVw8t4kv9dvIySFpY1NrK2tOq
         bnO+e0P0IPciUJju8QN8KPGa8fNdlQbsKpmKI/dS8wzk31hamDJuXH1EUswUwr9s6LD0
         4qb8MtxPeb6TY+i1yQ/36FXKwlIhRBlCZs59yJI5uO6YF8LpcTXTGBKrp1pWMyAwKrBd
         l61dy1ddT9HTEI19j2Yz43PXv1B6ITgXmK4V/HcB8Z+rDmAivGe6HpOQkFnEz0QkaRxB
         EEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNz7GatuofIkkUh4eG147AyWudtcNieUuNdHadeb8VY=;
        b=Epi1YbqM/JOo//bll+hZm0vIViF2Zqn1cvW6w7WeG4Ht8XeBP8xcOP9/PPWVszfYWD
         pit66FZgnP4w+4nzofQWknp/IjWbyJKdGZgAgtWxPSlGtgjGw7bh2SKgYch6sCWZpl0t
         B5JZTsZOnGtHVMH8OJnfPGaAUU+5NHXsi7HKJXnqdewziMSoGLZ245OE4hLoobDkoMoZ
         GdAg4sO/meEu09P+qbe2e8GciueA0S4i1HOB4vIAYyDWVVBbnOL1aiqmvWLbW3rAcgfj
         T0Ul7tdcrTkRI7sgq7nDPyb0A8Z89qnt60wh16dYgvtZzVI0j3n8ZjNG8K7W3O0B7O7W
         +/KA==
X-Gm-Message-State: APjAAAVe9ZVBI2my0ns/NXd4HBjDnEjHP0ne3gaE7tgnzNR5juoJGw04
        DK3k0iixnVzTD2+ybPc5XwWjquX8OV+P1eZYr+/Iucjd41XIVY6rlQhAdOozgylEwLaHgMdWa2r
        HhTThFR4Fb00QYnUDoCmoWzJiQ6Uh
X-Received: by 2002:a02:5143:: with SMTP id s64mr5149832jaa.54.1555726990551;
        Fri, 19 Apr 2019 19:23:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEwpFKOR/qnQPEhgKxhwtq/FXMwxkqa6uGigFXa3x53dzxnUyhr0xN7iEag1OrA4rrxSpd7A==
X-Received: by 2002:a02:5143:: with SMTP id s64mr5149826jaa.54.1555726990401;
        Fri, 19 Apr 2019 19:23:10 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id h133sm3330836itb.34.2019.04.19.19.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 19:23:09 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tracing: Fix a memory leak bug
Date:   Fri, 19 Apr 2019 21:22:59 -0500
Message-Id: <1555726979-15633-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In trace_pid_write(), the buffer for trace parser is allocated through
kmalloc() in trace_parser_get_init(). Later on, after the buffer is used,
it is then freed through kfree() in trace_parser_put(). However, it is
possible that trace_pid_write() is terminated due to unexpected errors,
e.g., ENOMEM. In that case, the allocated buffer will not be freed, which
is a memory leak bug.

To fix this issue, free the allocated buffer when an error is encountered.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6c24755..fd12c9c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -496,8 +496,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 	 * not modified.
 	 */
 	pid_list = kmalloc(sizeof(*pid_list), GFP_KERNEL);
-	if (!pid_list)
+	if (!pid_list) {
+		trace_parser_put(&parser);
 		return -ENOMEM;
+	}
 
 	pid_list->pid_max = READ_ONCE(pid_max);
 
@@ -507,6 +509,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 
 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
 	if (!pid_list->pids) {
+		trace_parser_put(&parser);
 		kfree(pid_list);
 		return -ENOMEM;
 	}
-- 
2.7.4

