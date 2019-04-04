Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C285C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC64217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/olchrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfDDWMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:12:02 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:53611 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfDDWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:10:10 -0400
Received: by mail-io1-f74.google.com with SMTP id w11so3143547iom.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wKxzJFaShASQUPZDqYNPu0TXHFOedzxEf0Q8Cs2Imqs=;
        b=K/olchrBgYojss1ShLaC54ZgUit5ZbkPFpnFMC14VFQgxcm937N8YTDmS1+tWbK3C9
         ypEcCcKHIoPEs+/5vYL5tjxIVVnBMHHbR9pRyRn5IeloR3Wxn9TZLssJnimEUJPFNOai
         atrtI4NhRZjjmwc52hE0fQv3TNExg9DIExK8chHpbBctcKxw3Ltynkf15vlRpmH1yzXN
         6hyeh6c0UWJyofbyppVpIYSErGUGL9aP/i0NF2i+hd5cJaH9AoDVBeA7gFA+eywhc5yq
         i+8B6pQLFZWQx+LTHeOqD5pdQ/erjxdd7jistL/jZ5NtkhQQdVNtw86G3zKgjXevYhfb
         IrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wKxzJFaShASQUPZDqYNPu0TXHFOedzxEf0Q8Cs2Imqs=;
        b=L1ksL1PQdHavYrZgN4rHj77ruOr6Vk4DXv6uFxLKqdelE9+FSQYf1DoEmsmVbbNI1J
         212b6TLaFcqqBY7Hb+JM7xquoQuaIEUv8+3q7ybCUljVU0WeRwDwXdsGHGQfl7/dlJau
         uFLtG1Jg8IDE3JuW47lmIxXazz+dp2aMqtqv1pwT7gNBKPzQEvugC2IXUinyCs4+muOf
         /kROoiaNqFWzy3f9IXsrUk1Ij/MFeBmDVOe/i0v/qWHbYMNtWQUBb8CxW9H+EvQDxlOe
         vUuQkxgjfXwhw73eTzdIjdN1Hs7KHDohXfmS+yw/mFAYSpggJ3NB9+uqJQ4hNx1eRv7h
         AGQw==
X-Gm-Message-State: APjAAAVtAwOPr8Mas7zWJZA/rg6GOsZZ74ThTQCQLDER/lW+H3+FAbLH
        eCJ3JbuETr3NaeLbBSXaX468ZHJ0Cfu+uVIIH1JHMg==
X-Google-Smtp-Source: APXvYqyipF3/vxkM9zoVIq5Upxc7QdUxom6tVA8XE2keaddA1+05TZjRpqP8VGABmqMrjJZVX184VZdehl2snAa96oep8Q==
X-Received: by 2002:a24:64e:: with SMTP id 75mr1796712itv.6.1554415809010;
 Thu, 04 Apr 2019 15:10:09 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:06:38 -0700
In-Reply-To: <20190404220652.19765-1-brendanhiggins@google.com>
Message-Id: <20190404220652.19765-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v1 03/17] kunit: test: add string_stream a std::stream like
 string builder
From:   Brendan Higgins <brendanhiggins@google.com>
To:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/string-stream.h |  51 ++++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 144 ++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..567a4629406da
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kref refcount;
+};
+
+struct string_stream *new_string_stream(void);
+
+void destroy_string_stream(struct string_stream *stream);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+int string_stream_add(struct string_stream *this, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *this,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *this);
+
+void string_stream_clear(struct string_stream *this);
+
+bool string_stream_is_empty(struct string_stream *this);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 5efdc4dea2c08..275b565a0e81f 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_KUNIT) +=			test.o
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
new file mode 100644
index 0000000000000..7018194ecf2fa
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <kunit/string-stream.h>
+
+int string_stream_vadd(struct string_stream *this,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *fragment;
+	int len;
+	va_list args_for_counting;
+	unsigned long flags;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	fragment = kmalloc(sizeof(*fragment), GFP_KERNEL);
+	if (!fragment)
+		return -ENOMEM;
+
+	fragment->fragment = kmalloc(len, GFP_KERNEL);
+	if (!fragment->fragment) {
+		kfree(fragment);
+		return -ENOMEM;
+	}
+
+	len = vsnprintf(fragment->fragment, len, fmt, args);
+	spin_lock_irqsave(&this->lock, flags);
+	this->length += len;
+	list_add_tail(&fragment->node, &this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+	return 0;
+}
+
+int string_stream_add(struct string_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(this, fmt, args);
+	va_end(args);
+	return result;
+}
+
+void string_stream_clear(struct string_stream *this)
+{
+	struct string_stream_fragment *fragment, *fragment_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry_safe(fragment,
+				 fragment_safe,
+				 &this->fragments,
+				 node) {
+		list_del(&fragment->node);
+		kfree(fragment->fragment);
+		kfree(fragment);
+	}
+	this->length = 0;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+char *string_stream_get_string(struct string_stream *this)
+{
+	struct string_stream_fragment *fragment;
+	size_t buf_len = this->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry(fragment, &this->fragments, node)
+		strlcat(buf, fragment->fragment, buf_len);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return buf;
+}
+
+bool string_stream_is_empty(struct string_stream *this)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	is_empty = list_empty(&this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return is_empty;
+}
+
+void destroy_string_stream(struct string_stream *stream)
+{
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+static void string_stream_destroy(struct kref *kref)
+{
+	struct string_stream *stream = container_of(kref,
+						    struct string_stream,
+						    refcount);
+	destroy_string_stream(stream);
+}
+
+struct string_stream *new_string_stream(void)
+{
+	struct string_stream *stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+
+	if (!stream)
+		return NULL;
+
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+	kref_init(&stream->refcount);
+	return stream;
+}
+
+void string_stream_get(struct string_stream *stream)
+{
+	kref_get(&stream->refcount);
+}
+
+int string_stream_put(struct string_stream *stream)
+{
+	return kref_put(&stream->refcount, &string_stream_destroy);
+}
+
-- 
2.21.0.392.gf8f6787159e-goog

