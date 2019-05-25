Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B31C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84BC20879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS+PTD/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEYQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:58:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43594 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfEYQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:58:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so5382395plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHWdX5bRXVXprQJcfTQOZjjDs+LJKiejWCqyyIiytjw=;
        b=IS+PTD/EExp6jGbBC0BruCFfVdA/G63y/9h/ezwG9dd9kTfw0QuajTdVTymqbCnWud
         Jy21lFe6Rii2acZJjf/auLVdcBRTPHGGbbkXt5oD9MK6ao6zAnCMiyysbRDv/iWbizDp
         p151fXclJWK++0c1v+HtuPMwuW8WuIRv7MzcqJYoA4BDLD89lc2L7LGiZab04VFUjoyd
         uzWLZtniEWk+xeWXAGKB0hQu01QQ4uibWOau2jNwyRDJ3d6dGYok2YkxrAZcOH5A7Cg2
         AMT/EsLI/z28l+mCMQT9W1iDqC7vwy26tmBjdsTx+Us86m/htlGI/A2LU2P3u/tvzYao
         fp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHWdX5bRXVXprQJcfTQOZjjDs+LJKiejWCqyyIiytjw=;
        b=RsGSZZk28tEJ9x3+Lnx2BZDD9WpzX14dfsnpFA09/mEBbbzIEBA1FamtbfLd23KnII
         YbjbhQ4Ze5E1MIJD0CZgVNzyBqlESN549SgJ8BMktEZYJiPfawfm/2IQuooYDviAqFwW
         APkAdT/kd1wgB7wCmw/KLop4cC0kXNyTTjAK87Q4mGMDwMJPIt1I1OyCxq6RAs2DgMWF
         kyTbl23aL1x1BzDUOLOHoVarlalZ2D9iHmjNbR6Xj1O8wGbXLFBJfA6V8dfU7/1appSS
         E8w3HPYTnDBG8+uJzsEUwU0Tq8r0Oww5jqhtPa9/bqdJkuB8LBqqZxKi3D2c0W82ykIy
         Qm4A==
X-Gm-Message-State: APjAAAUc7ApIqrWEVBhDfjm7IhOfC1dGH8MefhdikJ5mx/gQsNWoVC2E
        FSqg7i8LS/TA+ky3k8yAXlT2zM2y
X-Google-Smtp-Source: APXvYqy65x88PGeBfuFSf5dUtCOoli+6577wXPtADiOwJt7OnzZEsfZn23/PbBe/mrcOAUBMaBSvVA==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr91406118plb.238.1558803490817;
        Sat, 25 May 2019 09:58:10 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id q142sm8787585pfc.27.2019.05.25.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 09:58:10 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/4] trace: fold type initialization into tracing_generic_entry_update()
Date:   Sat, 25 May 2019 09:57:59 -0700
Message-Id: <20190525165802.25944-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of tracing_generic_entry_update() have to initialize
entry->type, so let's just simply move it inside.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/linux/trace_events.h    | 1 +
 kernel/trace/trace.c            | 8 ++++----
 kernel/trace/trace_event_perf.c | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731673f7..5c6f2a6c8cd2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -142,6 +142,7 @@ enum print_line_t {
 enum print_line_t trace_handle_return(struct trace_seq *s);
 
 void tracing_generic_entry_update(struct trace_entry *entry,
+				  unsigned short type,
 				  unsigned long flags,
 				  int pc);
 struct trace_event_file;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c92b3d9ea30..0e0e0e726170 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -743,8 +743,7 @@ trace_event_setup(struct ring_buffer_event *event,
 {
 	struct trace_entry *ent = ring_buffer_event_data(event);
 
-	tracing_generic_entry_update(ent, flags, pc);
-	ent->type = type;
+	tracing_generic_entry_update(ent, type, flags, pc);
 }
 
 static __always_inline struct ring_buffer_event *
@@ -2312,13 +2311,14 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
 void
-tracing_generic_entry_update(struct trace_entry *entry, unsigned long flags,
-			     int pc)
+tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
+			     unsigned long flags, int pc)
 {
 	struct task_struct *tsk = current;
 
 	entry->preempt_count		= pc & 0xff;
 	entry->pid			= (tsk) ? tsk->pid : 0;
+	entry->type			= type;
 	entry->flags =
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 4629a6104474..0892e38ed6fb 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -416,8 +416,7 @@ void perf_trace_buf_update(void *record, u16 type)
 	unsigned long flags;
 
 	local_save_flags(flags);
-	tracing_generic_entry_update(entry, flags, pc);
-	entry->type = type;
+	tracing_generic_entry_update(entry, type, flags, pc);
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
 
-- 
2.21.0

