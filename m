Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81E5214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="baXc8w8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLKJNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:13:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfLKJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:13:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so1179369plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5nDWGTJv3DbBm5FdVeD/qbyjSVi8fiYI1J1aTvInS6M=;
        b=baXc8w8nzDdnAn1X5x3/tXmyNv/eBgdY9U47+D3NnLnuzBUvfe0uu/R4Q5z/pTisYu
         p/7Ens/ifRT8KyRkVf4smSl4zjYLfvP0CWknhY/f6fj/T4g0lw+NRp+L+/FSPfyLftIE
         KqcxDaWi5RLesdO8w53supuouTtW354DyTAHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5nDWGTJv3DbBm5FdVeD/qbyjSVi8fiYI1J1aTvInS6M=;
        b=TXwzooFmHgM3zvtigMCaGkLSt0nS3JRWYYkB5g4+YfG4UV0rFuD+MnQovuxFd4MsS9
         TI/ReQZHXT+iRORO2hl6az6e4SvSTvGg7tQvpIeyuHeHmCR9ytT7KL8wf/FTa9qduJvN
         6diukl/j8Uv4R4SVGjKiOGxxoOZGRo5KzXwyarXJ/LN4dxtpnkdGpwAHy58fsjmkDWV7
         mDq2NlFe6DdV+3OSSZkIqJpiNiqgEaIyBiP4jLE9kZYaUNQEjBCHG8jsxki2LDOyNMVk
         YjdHgm+Q+7QHeNnVxRe1L9cNTdPzWPZULedHN7UIJZLuzq1EZ16s/2I3umRtv1pJhtiQ
         8JBg==
X-Gm-Message-State: APjAAAVXOXDAqrgyWjel1y3RKXidIZM0y0BK6GICm2dmqMlhRVRagRTS
        1x3zy1Ap0AMEw/32bl0qJdzvyA==
X-Google-Smtp-Source: APXvYqyQaxhd16NIqEa4d2RbhVoJqAmzk0TvXPSGmOAsDzosGYrVXsAEPjtlDNgDcJWED+R9ZtqD8w==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr2318402pjb.93.1576055619868;
        Wed, 11 Dec 2019 01:13:39 -0800 (PST)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id r20sm2047161pgu.89.2019.12.11.01.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 01:13:39 -0800 (PST)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi.kubota1012@sslab.ics.keio.ac.jp,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Avoid memory leak in process_system_preds()
Date:   Wed, 11 Dec 2019 09:12:58 +0000
Message-Id: <20191211091258.11310-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When failing in the allocation of filter_item, process_system_preds()
goes to fail_mem, where the allocated filter is freed.

However, this leads to memory leak of filter->filter_string and
filter->prog, which is allocated before and in process_preds().
This bug has been detected by kmemleak as well.

Fix this by changing kfree to __free_fiter.

unreferenced object 0xffff8880658007c0 (size 32):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    63 6f 6d 6d 6f 6e 5f 70 69 64 20 20 3e 20 31 30  common_pid  > 10
    00 00 00 00 00 00 00 00 65 73 00 00 00 00 00 00  ........es......
  backtrace:
    [<0000000067441602>] kstrdup+0x2d/0x60
    [<00000000141cf7b7>] apply_subsystem_event_filter+0x378/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff888060c22d00 (size 64):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 e8 d7 41 80 88 ff ff  ...........A....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b8c1b109>] process_preds+0x243/0x1820
    [<000000003972c7f0>] apply_subsystem_event_filter+0x3be/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff888041d7e800 (size 512):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    70 bc 85 97 ff ff ff ff 0a 00 00 00 00 00 00 00  p...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001e04af34>] process_preds+0x71a/0x1820
    [<000000003972c7f0>] apply_subsystem_event_filter+0x3be/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c9a74f82b14a..bf44f6bbd0c3 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1662,7 +1662,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
-	kfree(filter);
+	__free_filter(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
 		tracepoint_synchronize_unregister();
-- 
2.17.1

