Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102EC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3F2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UVRbxZ+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgABTqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:46:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41268 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:46:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so22362207pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BinIw4199yqCG0c+gGZlznPchIyL9Pm9n06/Ts9kq1o=;
        b=UVRbxZ+ESJObjtXUeIGy+0c187HOKQbgX4ZvWmu2f6wOILEz9jrB7ZMKjT8qdHfQcS
         CurWFzw0VznwhtOyUq1JppbsAMiENxxJ+EHu1O+hTb63M6NYzOyMqmZ6DdPuVbZBVkSg
         eBMZ/FSQjGIdwaBxeYKAyYI6Or+8w4ny3Qs40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BinIw4199yqCG0c+gGZlznPchIyL9Pm9n06/Ts9kq1o=;
        b=rnX7Cteyj5GtRmuxSQFylS9POoTmOEpcqaFIvOKDJO5bLy9KTirld52HSxaYHQKfiZ
         SEWy733r9r4K+JrEZGb8ZH4fDeYzIFLGK/6YhOcIYxtBfzHnLL7M6TYJZNsQG7jd2waE
         c6LmwZ3i8RJZShGjOiiT5v1NFRrP5uxp85T2bdHqA0+T+IcznZDctYXjHR6n5KnGbYhU
         W6FKRARgmSgKe668w6FbAa3yT3xKYSc/e1zc2WRZyk49TNO11u6Rd2Lc43d4gjaF2DGc
         LcTG2q263YXhleotNSsZ0PKMxFIJSLGPTuLAre5MbB+vu5jVPBuG4Lfu6+LWL+iPgsaY
         i5mQ==
X-Gm-Message-State: APjAAAWPvuZOA8rUq8BLz/NKAuvovPTA+K6VxQXNo3ueAjfIdPlEFE+P
        9q7P02ujtS2uq7NDlPMek3UeWbAA4js=
X-Google-Smtp-Source: APXvYqzxrFsVLXH80UwXESkZJTRGLHL/bsBLNaXrpJZoAPK2qo0BGaycps7YLO0VDVo03u6zhPnQ3g==
X-Received: by 2002:a63:496:: with SMTP id 144mr94420117pge.207.1577994397373;
        Thu, 02 Jan 2020 11:46:37 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 18sm57602040pfj.3.2020.01.02.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:46:36 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Antonio Borneo <antonio.borneo@st.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Sterba <dsterba@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracing: Change offset type to s32 in preempt/irq tracepoints
Date:   Thu,  2 Jan 2020 14:46:25 -0500
Message-Id: <20200102194625.226436-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discussion in the below link reported that symbols in modules can appear
to be before _stext on ARM architecture, causing wrapping with the
offsets of this tracepoint. Change the offset type to s32 to fix this.

Link: http://lore.kernel.org/r/20191127154428.191095-1-antonio.borneo@st.com

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Cc: Antonio Borneo <antonio.borneo@st.com>
---
 include/trace/events/preemptirq.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 95fba0471e5b..3f249e150c0c 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -18,13 +18,13 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 	TP_ARGS(ip, parent_ip),
 
 	TP_STRUCT__entry(
-		__field(u32, caller_offs)
-		__field(u32, parent_offs)
+		__field(s32, caller_offs)
+		__field(s32, parent_offs)
 	),
 
 	TP_fast_assign(
-		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
-		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
+		__entry->caller_offs = (s32)(ip - (unsigned long)_stext);
+		__entry->parent_offs = (s32)(parent_ip - (unsigned long)_stext);
 	),
 
 	TP_printk("caller=%pS parent=%pS",
-- 
2.24.1.735.g03f4e72817-goog

