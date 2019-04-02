Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A82C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E66221473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221211;
	bh=g8PFNOYD/v6kuRTn1RGxEpSkYVpMWcXBC/3jfHbp6J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DWumYFwAtqyGuh+jDEnPRfCiBzF7SMLwJdBS4RHHkBRTHbJw4Jqr2C8D+dgJqdYLi
	 uNY29B9kL7CElLSH3EOSW2KRwnurH5OVRM7ScuTdyypr5aUIcgOw46OO/sHylqWpRi
	 wJhwVy8xrRUDBJNw6ID6+neNGDC9Sth+U7b2TP5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfDBQGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfDBQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:47 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC78A20840;
        Tue,  2 Apr 2019 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221206;
        bh=g8PFNOYD/v6kuRTn1RGxEpSkYVpMWcXBC/3jfHbp6J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doNSryO1wi3Uk7U6/uoLvYapwG2swmC8QAjWj0YLiipmR7gU1+jtSy/rFaqIFReRG
         i3yQk3YdLXCOO7fEvhzzEOELQNXefrDFQU7K4oOxTb5nnomHo9EZBwdivs6vMqhgy0
         bmYFH5Z/DdKGLi9+DsXI6Yax50zeNkHkuMgyHaDk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/44] tools lib traceevent: Add more debugging to see various internal ring buffer entries
Date:   Tue,  2 Apr 2019 13:05:19 -0300
Message-Id: <20190402160549.13544-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

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

