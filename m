Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06945C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AF4218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfGDRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:21:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45807 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfGDRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:21:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so7339761wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 10:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3vzLyxDbkeyBgYQjFOstI8zIrcnQFzyTjp53BtSBHs=;
        b=o6/dLY+IcqpsVbphLQLqGWlJTHFaw2Xs+m+wZcsWOD+WYTilTQAq6X8iB7PuCPHEVk
         XW5V8+m9soF535WAxX/blV2fteYtyVQlGmb8Q8OIbiAzYQ5Lg04JO99qvPKXRoLYYhTS
         0kt/Vw9Pp2vpyI66430TnJ3bAdlWVrZN7UhCrzZBeHJaBQM/vd06HCS2t/GILg673UmJ
         7wS83TMvl9BT8FG70tV6oIP/nD43PDCFatRqvcWeOELYy4lfB0m8yVgcOKAkkOYVQQ8A
         8Gr99mQB3Pl8KNGRGxdefRLrMtI4LyZxIVdgHbpjPYNEfXmH0P/RZ3+DVWWF1zBJtO5F
         LWaw==
X-Gm-Message-State: APjAAAXosfEK+CQ/b7win446iPTNSnJgbZfpOhi7+z+4p3kcLqyMZTwM
        /BBVDQXQY2Yfq3u+ViSEmz8=
X-Google-Smtp-Source: APXvYqwD2Me8YuZCGlupuMqiaUoghPbAWu7tDveNvD9jtjxBGn88QwPyjXD7QamZ646inpksvESAxQ==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr29539095wrw.337.1562260890178;
        Thu, 04 Jul 2019 10:21:30 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id w23sm6343835wmi.45.2019.07.04.10.21.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 10:21:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Jin <joe.jin@oracle.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: make exported ftrace_set_clr_event non-static
Date:   Thu,  4 Jul 2019 20:21:10 +0300
Message-Id: <20190704172110.27041-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ftrace_set_clr_event is declared static and marked
EXPORT_SYMBOL_GPL(), which is at best an odd combination. Because the
function was decided to be a part of API, this commit removes the static
attribute and adds the declaration to the header.

Fixes: f45d1225adb04 ("tracing: Kernel access to Ftrace instances")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace_events.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731673f7..84bc84f00e8f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -539,6 +539,7 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
 
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 
 /*
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db67f556..b6b46184f6bf 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -795,7 +795,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
-- 
2.21.0

