Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4820856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l76iwH7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfIRFY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:24:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41100 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfIRFY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:24:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so3294667pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uq2fhvUe4mweaNsFsji+gZkwDOHKsNYaLUVGLr8i/TY=;
        b=l76iwH7FcEqhqpddZDyEgN3UlDs0CQ2l2yQlHnLqdOOJiFx+1Aj5/MdEAWoJs0Rl3x
         uqae+B/kIrci0t8o1hn7E9TIq/c0LBawsBHnV0ooTMaoF9DIqqIe1Q/NiIIFWVzfeznX
         HNzWM1UwZO+NaSUYwLl5gud7iVJsbqdg0F1sBqhPqreImHULPWUbUKXnuvNPBsENCK0E
         GinaaoeBIwPpDjjzQMk+qao+5+0nXKJVtjnEBOitkRn9qwBEFxE0/hyaMmzW3ietCa9X
         lbfledh5BimnvYsisHK9pXe5aFa/ZI6LIQAY/O/A+UiX8nb9u2kBMwKidC0z7/7RwqOk
         H0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uq2fhvUe4mweaNsFsji+gZkwDOHKsNYaLUVGLr8i/TY=;
        b=J4tUilBffdDGBAFyyKDbrMLSPOl4sd3IXFHf9CQwjBdJKsB0PMuRaNnGLr9zgRid//
         lkMxUJi5Tx80CkFDmVlkN3W0tmPTTr7hynoMebRwDTvjJwV7ocf1ZipghRv5SbYwdARE
         1qkqCWPUVjmE43IiiQZfIC3JroODgJr3knahg9Y5OkWOuXh3ztYcGdEytn6knTyjzPBy
         EAGQebU5p7JFIqetqZ5S6i/xOg+i31I8JNXz7kc3hBQS1p7CQJb5PmnZ5GyUjb1t34VF
         IcAdg4D0W2W1L+sPOFtP28MKjUwHkg2tRrEtCTw525OY6/GULaH8Uh2Wf2a0QN6NfZ+i
         unTw==
X-Gm-Message-State: APjAAAX3JJxwam3no0sZt1TwthLfClE9atGE0sWEaqEC3bFzpgugoJjI
        dyvUGtyiyIidUQ9QFgWYNDboB3I7l1DkqQ==
X-Google-Smtp-Source: APXvYqyyaEpLbiduqJTbAh4BRmNzZc0tnwIgkIx9DG6SJi/DVK9XM5JOYBj07uV1ce1I0qt8nInwRw==
X-Received: by 2002:aa7:9735:: with SMTP id k21mr2266936pfg.174.1568784267984;
        Tue, 17 Sep 2019 22:24:27 -0700 (PDT)
Received: from imac.hsd1.ca.comcast.net (c-98-207-34-143.hsd1.ca.comcast.net. [98.207.34.143])
        by smtp.gmail.com with ESMTPSA id z4sm195654pjt.17.2019.09.17.22.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 22:24:27 -0700 (PDT)
From:   jinshan.xiong@gmail.com
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     yhs@fb.com, jinshan.xiong@uber.com,
        Jinshan Xiong <jinshan.xiong@gmail.com>
Subject: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
Date:   Tue, 17 Sep 2019 22:24:06 -0700
Message-Id: <20190918052406.21385-1-jinshan.xiong@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinshan Xiong <jinshan.xiong@gmail.com>

Invoking bpf program only if kprobe based perf_event has been added into
the percpu list. This is essential to make event tracing for cgroup to work
properly.

Signed-off-by: Jinshan Xiong <jinshan.xiong@gmail.com>
---
 kernel/trace/trace_kprobe.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..40ef0f1945f7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1171,11 +1171,18 @@ static int
 kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
+	struct hlist_head *head = this_cpu_ptr(call->perf_events);
 	struct kprobe_trace_entry_head *entry;
-	struct hlist_head *head;
 	int size, __size, dsize;
 	int rctx;
 
+	/*
+	 * If head is empty, the process currently running on this cpu is not
+	 * interested by kprobe perf PMU.
+	 */
+	if (hlist_empty(head))
+		return 0;
+
 	if (bpf_prog_array_valid(call)) {
 		unsigned long orig_ip = instruction_pointer(regs);
 		int ret;
@@ -1193,10 +1200,6 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 			return 0;
 	}
 
-	head = this_cpu_ptr(call->perf_events);
-	if (hlist_empty(head))
-		return 0;
-
 	dsize = __get_data_size(&tk->tp, regs);
 	__size = sizeof(*entry) + tk->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
