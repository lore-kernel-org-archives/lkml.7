Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B716F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551357118;
	bh=9WszIXTGUsB4Jqabqis/EIYLG6D7pFY+vQyFOaOxfxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1XHcU/ZMHOuKaCVG7ao1yq6PwpU13ddR/l9CLJPlp+awYMOnSP8+rrIm1BebCks6J
	 ZIwyuB4dMcBujeQLBQaFUvRquzp60am/qtjDR7YcohMLgQn3gml+01GKJmI2B96VMa
	 pIgNLZhr8mrGPi/64MT016s19ttfXDgUrOxb4Oik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfB1Mb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfB1Mb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:31:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCBA2083D;
        Thu, 28 Feb 2019 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551357116;
        bh=9WszIXTGUsB4Jqabqis/EIYLG6D7pFY+vQyFOaOxfxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGbDHmJQdNxzwiw04LquVselB9hJJp3lkk3gzVBf5/3EmZkEhOL4CvCiQ3izyCTXe
         TO/MMC/MNNaEGaxNiAEYUSbaMv8XPsrvkgQwaJnkv09nRGGDEAOItSM3h00Xxwe6MX
         O6FGveXqJcCsWu5k/qhxdNuVRMfIaA7JgLKea5AE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 3/6] uaccess: Add non-pagefault user-space read functions
Date:   Thu, 28 Feb 2019 21:31:31 +0900
Message-Id: <155135709170.438.17142945814945979504.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155135700242.438.12930250099644500209.stgit@devbox>
References: <155135700242.438.12930250099644500209.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add probe_user_read() and strncpy_from_unsafe_user() which
allows caller to access user-space in IRQ context.

Current probe_kernel_read() and strncpy_from_unsafe() are
not available for user-space memory, because it sets
KERNEL_DS while accessing data. On some arch, user address
space and kernel address space can be co-exist, but others
can not. In that case, setting KERNEL_DS means given
address is treated as a kernel address space.

To access user-space memory without pagefault, we need
these new functions which sets USER_DS while accessing
the data.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v3:
   - Use user_access_ok() for probe_user_read().
  Changes in v2:
   - Simplify strncpy_from_unsafe_user() using strncpy_from_user()
     according to Linus's suggestion.
   - Simplify probe_user_read() not using intermediate function.
---
 include/linux/uaccess.h |   13 +++++++
 mm/maccess.c            |   94 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1afd9dfabe67..598a96210d04 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -258,6 +258,17 @@ extern long probe_kernel_read(void *dst, const void *src, size_t size);
 extern long __probe_kernel_read(void *dst, const void *src, size_t size);
 
 /*
+ * probe_user_read(): safely attempt to read from a location in user space
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from address @src to the buffer at @dst.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+extern long probe_user_read(void *dst, const void __user *src, size_t size);
+
+/*
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
  * @src: pointer to the data that shall be written
@@ -270,6 +281,8 @@ extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
 extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
+extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+				     long count);
 
 /**
  * probe_kernel_address(): safely attempt to read from a location
diff --git a/mm/maccess.c b/mm/maccess.c
index ec00be51a24f..b24df3e731c8 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,8 +5,20 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
+static __always_inline long
+probe_read_common(void *dst, const void __user *src, size_t size)
+{
+	long ret;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+
 /**
- * probe_kernel_read(): safely attempt to read from a location
+ * probe_kernel_read(): safely attempt to read from a kernel-space location
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from
  * @size: size of the data chunk
@@ -29,17 +41,47 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	pagefault_disable();
-	ret = __copy_from_user_inatomic(dst,
-			(__force const void __user *)src, size);
-	pagefault_enable();
+	ret = probe_read_common(dst, (__force const void __user *)src, size);
 	set_fs(old_fs);
 
-	return ret ? -EFAULT : 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(probe_kernel_read);
 
 /**
+ * probe_user_read(): safely attempt to read from a user-space location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from. This must be a user address.
+ * @size: size of the data chunk
+ *
+ * Safely read from user address @src to the buffer at @dst. If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+
+long __weak probe_user_read(void *dst, const void __user *src, size_t size)
+    __attribute__((alias("__probe_user_read")));
+
+long __probe_user_read(void *dst, const void __user *src, size_t size)
+{
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	/*
+	 * Since this can be called in IRQ context, we carefully set the
+	 * USER_DS and use user_access_ok() which checks segment setting
+	 * instead of task context.
+	 */
+	set_fs(USER_DS);
+	if (!user_access_ok(src, size))
+		ret = -EFAULT;
+	else
+		ret = probe_read_common(dst, src, size);
+	set_fs(old_fs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(probe_user_read);
+
+/**
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
  * @src: pointer to the data that shall be written
@@ -66,6 +108,7 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 }
 EXPORT_SYMBOL_GPL(probe_kernel_write);
 
+
 /**
  * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
@@ -105,3 +148,42 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 
 	return ret ? -EFAULT : src - unsafe_addr;
 }
+
+/**
+ * strncpy_from_unsafe_user: - Copy a NUL terminated string from unsafe user
+ *				address.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @unsafe_addr: Unsafe user address.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from unsafe user address to kernel buffer.
+ *
+ * On success, returns the length of the string INCLUDING the trailing NUL.
+ *
+ * If access fails, returns -EFAULT (some data may have been copied
+ * and the trailing NUL added).
+ *
+ * If @count is smaller than the length of the string, copies @count-1 bytes,
+ * sets the last byte of @dst buffer to NUL and returns @count.
+ */
+long strncpy_from_unsafe_user(char *dst, const void __user *src, long count)
+{
+	mm_segment_t old_fs = get_fs();
+	long ret;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	set_fs(USER_DS);
+	pagefault_disable();
+	ret = strncpy_from_user(dst, src, count);
+	pagefault_enable();
+	set_fs(old_fs);
+	if (ret >= count) {
+		ret = count;
+		dst[ret - 1] = '\0';
+	} else if (ret > 0)
+		ret++;
+	return ret;
+}

