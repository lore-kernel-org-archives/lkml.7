Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812EB208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfDAQnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbfDAQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FEB21909;
        Mon,  1 Apr 2019 16:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02B-0004rm-Bt; Mon, 01 Apr 2019 12:43:43 -0400
Message-Id: <20190401164343.257591565@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 04/15] tools/lib/traceevent: Add more debugging to see various internal ring
 buffer entries
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

When trace-cmd report --debug is set, show the internal ring buffer entries
like time-extends and padding. This requires adding new kbuffer API to
retrieve these items.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/kbuffer-parse.c | 49 ++++++++++++++++++++++++++++
 tools/lib/traceevent/kbuffer.h       | 13 ++++++++
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
-- 
2.20.1


