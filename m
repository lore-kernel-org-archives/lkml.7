Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3932FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5220652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfDELoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:44:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDELoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:44:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BhQiN2735296
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:43:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BhQe82735293;
        Fri, 5 Apr 2019 04:43:26 -0700
Date:   Fri, 5 Apr 2019 04:43:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (Red Hat)" <tipbot@zytor.com>
Message-ID: <tip-70df6a7311186a7ab0b19f481dee4ca540a73837@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
        tstoyanov@vmware.com, akpm@linux-foundation.org,
        tglx@linutronix.de, acme@redhat.com, rostedt@goodmis.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, tstoyanov@vmware.com,
          akpm@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
          jolsa@redhat.com, rostedt@goodmis.org, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190401164343.257591565@goodmis.org>
References: <20190401164343.257591565@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add more debugging to see
 various internal ring buffer entries
Git-Commit-ID: 70df6a7311186a7ab0b19f481dee4ca540a73837
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  70df6a7311186a7ab0b19f481dee4ca540a73837
Gitweb:     https://git.kernel.org/tip/70df6a7311186a7ab0b19f481dee4ca540a73837
Author:     Steven Rostedt (Red Hat) <rostedt@goodmis.org>
AuthorDate: Mon, 1 Apr 2019 12:43:09 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Add more debugging to see various internal ring buffer entries

When trace-cmd report --debug is set, show the internal ring buffer
entries like time-extends and padding. This requires adding new kbuffer
API to retrieve these items.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164343.257591565@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/kbuffer-parse.c | 49 ++++++++++++++++++++++++++++++++++++
 tools/lib/traceevent/kbuffer.h       | 13 ++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index af2a1f3b7424..b887e7437d67 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -727,3 +727,52 @@ int kbuffer_start_of_data(struct kbuffer *kbuf)
 {
 	return kbuf->start;
 }
+
+/**
+ * kbuffer_raw_get - get raw buffer info
+ * @kbuf:	The kbuffer
+ * @subbuf:	Start of mapped subbuffer
+ * @info:	Info descriptor to fill in
+ *
+ * For debugging. This can return internals of the ring buffer.
+ * Expects to have info->next set to what it will read.
+ * The type, length and timestamp delta will be filled in, and
+ * @info->next will be updated to the next element.
+ * The @subbuf is used to know if the info is passed the end of
+ * data and NULL will be returned if it is.
+ */
+struct kbuffer_raw_info *
+kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf, struct kbuffer_raw_info *info)
+{
+	unsigned long long flags;
+	unsigned long long delta;
+	unsigned int type_len;
+	unsigned int size;
+	int start;
+	int length;
+	void *ptr = info->next;
+
+	if (!kbuf || !subbuf)
+		return NULL;
+
+	if (kbuf->flags & KBUFFER_FL_LONG_8)
+		start = 16;
+	else
+		start = 12;
+
+	flags = read_long(kbuf, subbuf + 8);
+	size = (unsigned int)flags & COMMIT_MASK;
+
+	if (ptr < subbuf || ptr >= subbuf + start + size)
+		return NULL;
+
+	type_len = translate_data(kbuf, ptr, &ptr, &delta, &length);
+
+	info->next = ptr + length;
+
+	info->type = type_len;
+	info->delta = delta;
+	info->length = length;
+
+	return info;
+}
diff --git a/tools/lib/traceevent/kbuffer.h b/tools/lib/traceevent/kbuffer.h
index 03dce757553f..ed4d697fc137 100644
--- a/tools/lib/traceevent/kbuffer.h
+++ b/tools/lib/traceevent/kbuffer.h
@@ -65,4 +65,17 @@ int kbuffer_subbuffer_size(struct kbuffer *kbuf);
 void kbuffer_set_old_format(struct kbuffer *kbuf);
 int kbuffer_start_of_data(struct kbuffer *kbuf);
 
+/* Debugging */
+
+struct kbuffer_raw_info {
+	int			type;
+	int			length;
+	unsigned long long	delta;
+	void			*next;
+};
+
+/* Read raw data */
+struct kbuffer_raw_info *kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf,
+					 struct kbuffer_raw_info *info);
+
 #endif /* _K_BUFFER_H */
