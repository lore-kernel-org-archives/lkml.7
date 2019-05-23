Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C942C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1FB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iR7F2nIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391934AbfEWTfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:35:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37039 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391378AbfEWT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so3141267pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDNGhEy9xcY5qhQBwgmeKY7uMhD3iDBpzQrTh3YeEPI=;
        b=iR7F2nIBUNsTCsMqey8hSHSMrV7DfTTeWHmkCDg8UgtsBXW0zTY327QCqe4ecBJQvf
         hlm7QkGvzRpAj1M1gF92gb11/ehfmWKZavskXkAUbuC8kg3hVu+6mR5yV7wItz7fwLTs
         HG+ZCAu9MRfiHx+lT/iGVZweEzLXd184Cg7wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDNGhEy9xcY5qhQBwgmeKY7uMhD3iDBpzQrTh3YeEPI=;
        b=nwK08rqU4JBP/kyHcqbqAh0Gk9d/EMUYmZJVehRitzwmBJbziQIUjtdJiALFpmYNXF
         ecBfoj1IQ/itEAelrJGyMoXA2p0ew+56PjlxZYO85uU0bCzpchQsDoPJU5he0mKD+ao5
         lH/B1cNtr8gF8bHnRhwhjsIFTOeeX2NWR9OSDX21roflXH79XbbuSiybtlotgjjRu9C9
         8KWQ7tlyTRPu6G8TiaBWUCixTBDyDKuFDTRUF7Uot8Ln0/lkx0QLD2fv2Uu4ynZqVgPo
         NhxC00ZynkBKC2knqWz6CULB/jaiaVvlRRLrQB+ADp0qG/8mu6HCA9RowfDi3bZ+XsOe
         6j4Q==
X-Gm-Message-State: APjAAAWOH80dOtv2qvb/V8wOmz+AD7xqEZRW5xpN+Vxm51IhAJsNLquU
        2eP5v6q6CwXZY4bW5JwXOylDWg==
X-Google-Smtp-Source: APXvYqzctClo+C3NAxQPdNqnyOxQfbbNxFst8N9yeh77qq6xjV64NrqAkKos6MRZQpNcBtuoBglsFw==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr77742018plb.86.1558639598873;
        Thu, 23 May 2019 12:26:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l65sm262626pfb.7.2019.05.23.12.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:26:38 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] tracing: Use correct function name in trace_filter_add_remove_task() comment
Date:   Thu, 23 May 2019 12:26:28 -0700
Message-Id: <20190523192628.134406-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment of trace_filter_add_remove_task() refers to the function as
'trace_pid_filter_add_remove_task', use the correct name.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c92b3d9ea30..d1ab31abc46f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -366,7 +366,7 @@ trace_ignore_this_task(struct trace_pid_list *filtered_pids, struct task_struct
 }
 
 /**
- * trace_pid_filter_add_remove_task - Add or remove a task from a pid_list
+ * trace_filter_add_remove_task - Add or remove a task from a pid_list
  * @pid_list: The list to modify
  * @self: The current task for fork or NULL for exit
  * @task: The task to add or remove
-- 
2.22.0.rc1.257.g3120a18244-goog

