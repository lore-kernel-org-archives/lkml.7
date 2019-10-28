Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81247CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B0120873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwx1pjEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390753AbfJ1P5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:57:32 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33377 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfJ1P5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:57:31 -0400
Received: by mail-pf1-f201.google.com with SMTP id z4so8869271pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vl1oAr7RM/zca7FwT/vXMjuwpEGjQxC9D0ySoZ6dSQg=;
        b=rwx1pjEeHweipdLqJFc0f5AUWZAt8f6HXKzgo85WscfDfpxJvb0YoHuhVcrwDm/Y2K
         +j9mtodjaOIEYD8wniTDB2wvsC67omtrPVrl+aass6UblAf/IrU0nPkok+Y/zg4LYLWp
         9A+UQLVPy7bHJBX8av35/sm9p+KV+5GMkLv70djWsjb00967Q9Qs1y7jyblGPK2+h3mh
         o2DYex0fmo7JSQn5aOlfvOiKm8EAOoaT6HFrbMKPssgQbz5uUOP+4IsJ3eDKyUUiwlHf
         oCkBDsYEROwNTcs5tUAd5qatUOz92rhtqKg3UAI1IVzpdOdd3w60mCa0kPsIhyzMEQOX
         4ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vl1oAr7RM/zca7FwT/vXMjuwpEGjQxC9D0ySoZ6dSQg=;
        b=PPSNl2R/NqUDV+ZGW2E1pxHNMy8umcbvqxzLv32D8i6IRjhFIqyvtLhXZqHkqjtDOP
         MLiGH7ZvWcMnLMsZHa6qHSb3pU5wWM1Sp4Dj1VfzeT+CugyJv3qhO1j2GVPp487sZB+p
         dBDGgwxrh1fp6awbl1EBL50lb7OkEvz80wa6Uy/fLBp35nbbtT/EDCROKMnBK9CWOdGM
         m3bETQ39BWcGEZfdXaYJMztTSs/RXA+auVNkL7MxCEA2AaH070dpHazcJgsIEij6mZC5
         CPP1SJI1U7RoJVYwsn7kSjb9mJfGZ10AvB8fT/X1/kyL2eY9OYou8mo07ggUzQiA1JPb
         w79A==
X-Gm-Message-State: APjAAAUzRHpG1S1oDCTQ3zDEqBA204GIOkFt9khFU6t/HY0lHeaWByEx
        krLxDdl/r/T4dkSW30stX4DsUHHZzx/2biWzGUY=
X-Google-Smtp-Source: APXvYqyACCtE23M53x7JIppCj6n56w5xm+Bre24NDBG6Yh3Xzq93jVDklOc8ZlKnuEOUwwg24ZyZ+c7vs/ZnU6fPlZ0=
X-Received: by 2002:a63:9a09:: with SMTP id o9mr21533674pge.276.1572278250647;
 Mon, 28 Oct 2019 08:57:30 -0700 (PDT)
Date:   Mon, 28 Oct 2019 08:57:21 -0700
Message-Id: <20191028155722.23419-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] hexagon: work around compiler crash
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bcain@codeaurora.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sid Manning <sidneym@quicinc.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang cannot translate the string "r30" into a valid register yet.

Link: https://github.com/ClangBuiltLinux/linux/issues/755
Suggested-by: Sid Manning <sidneym@quicinc.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/hexagon/kernel/stacktrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/stacktrace.c b/arch/hexagon/kernel/stacktrace.c
index 35f29423fda8..5ed02f699479 100644
--- a/arch/hexagon/kernel/stacktrace.c
+++ b/arch/hexagon/kernel/stacktrace.c
@@ -11,8 +11,6 @@
 #include <linux/thread_info.h>
 #include <linux/module.h>
 
-register unsigned long current_frame_pointer asm("r30");
-
 struct stackframe {
 	unsigned long fp;
 	unsigned long rets;
@@ -30,7 +28,7 @@ void save_stack_trace(struct stack_trace *trace)
 
 	low = (unsigned long)task_stack_page(current);
 	high = low + THREAD_SIZE;
-	fp = current_frame_pointer;
+	fp = (unsigned long)__builtin_frame_address(0);
 
 	while (fp >= low && fp <= (high - sizeof(*frame))) {
 		frame = (struct stackframe *)fp;
-- 
2.24.0.rc0.303.g954a862665-goog

