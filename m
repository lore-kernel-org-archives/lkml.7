Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D32C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948C2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557414813;
	bh=rPf8rrfvUjmxPcg4eGhiC9rBuZlxs6VD6GxQu3Q+ULY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXljCjRjUe47W3F0XtO7q/McTF07UfKlKCR9ZdoIGsxJHB8ZQl3svI6MdOt345uul
	 FcGL71ujKcmxv2A9u6YRudCmQMnAzSDIB4ZRwkv65Nlg1SxzELucFLnK3CapLEM6vA
	 u0ofBi2j66eu9Z9Kl0uh+4ubKgAZIW06/wUNHoFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEIPNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:13:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E332173B;
        Thu,  9 May 2019 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557414810;
        bh=rPf8rrfvUjmxPcg4eGhiC9rBuZlxs6VD6GxQu3Q+ULY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOGIvcXOyQIBv0L1uIfZfwboRET5QWD6U4EvJ7pDK0itCRzyGNNFspiJtLBrgDBn4
         dabcbGNLTmkb6J49qcSDOltCl9bCN39A6YZ6NiyUt+6UZZjJH+W+n+U+xgulkXak7K
         /N2xUu4Jowj4mRkSOKsVU3g+pFxlF08nwmApmbIU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH -tip v8 2/6] uaccess: Add non-pagefault user-space read functions
Date:   Fri, 10 May 2019 00:13:24 +0900
Message-Id: <155741480391.28419.7452022061912559686.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155741476971.28419.15837024173365724167.stgit@devnote2>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add probe_user_read(), strncpy_from_unsafe_user() and
strnlen_unsafe_user() which allows caller to access user-space
in IRQ context.

Current probe_kernel_read() and strncpy_from_unsafe() are
not available for user-space memory, because it sets
KERNEL_DS while accessing data. On some arch, user address
space and kernel address space can be co-exist, but others
can not. In that case, setting KERNEL_DS means given
address is treated as a kernel address space.
Also strnlen_user() is only available from user context since
it can sleep if pagefault is enabled.

To access user-space memory without pagefault, we need
these new functions which sets USER_DS while accessing
the data.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
  Changes in v8:
   - Fix style issues and typos according to Ingo's comment (Thanks!)
  Changes in v6:
   - Remove user_access_ok()
  Changes in v5:
   - Simplify probe_user_read() (Thanks, Peter!)
   - Add strnlen_unsafe_user()
  Changes in v3:
   - Use user_access_ok() for probe_user_read().
  Changes in v2:
   - Simplify strncpy_from_unsafe_user() using strncpy_from_user()
     according to Linus's suggestion.
   - Simplify probe_user_read() not using intermediate function.
---
 include/linux/uaccess.h |   14 +++++
 mm/maccess.c            |  122 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5a43ef7db492..9c435c3f2105 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -242,6 +242,17 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 extern long probe_kernel_read(void *dst, const void *src, size_t size);
 extern long __probe_kernel_read(void *dst, const void *src, size_t size);
 
+/*
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
 /*
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
@@ -255,6 +266,9 @@ extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
 extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
+extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+				     long count);
+extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 
 /**
  * probe_kernel_address(): safely attempt to read from a location
diff --git a/mm/maccess.c b/mm/maccess.c
index ec00be51a24f..19c8c3dc14df 100644
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
@@ -29,16 +41,40 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
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
 
+/**
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
+	long ret = -EFAULT;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(USER_DS);
+	if (access_ok(src, size))
+		ret = probe_read_common(dst, src, size);
+	set_fs(old_fs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(probe_user_read);
+
 /**
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
@@ -66,6 +102,7 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 }
 EXPORT_SYMBOL_GPL(probe_kernel_write);
 
+
 /**
  * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
@@ -105,3 +142,76 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 
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
+long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+			      long count)
+{
+	mm_segment_t old_fs = get_fs();
+	long ret;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	set_fs(USER_DS);
+	pagefault_disable();
+	ret = strncpy_from_user(dst, unsafe_addr, count);
+	pagefault_enable();
+	set_fs(old_fs);
+
+	if (ret >= count) {
+		ret = count;
+		dst[ret - 1] = '\0';
+	} else if (ret > 0) {
+		ret++;
+	}
+
+	return ret;
+}
+
+/**
+ * strnlen_unsafe_user: - Get the size of a user string INCLUDING final NUL.
+ * @unsafe_addr: The string to measure.
+ * @count: Maximum count (including NUL)
+ *
+ * Get the size of a NUL-terminated string in user space without pagefault.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ *
+ * If the string is too long, returns a number larger than @count. User
+ * has to check the return value against "> count".
+ * On exception (or invalid count), returns 0.
+ *
+ * Unlike strnlen_user, this can be used from IRQ handler etc. because
+ * it disables pagefaults.
+ */
+long strnlen_unsafe_user(const void __user *unsafe_addr, long count)
+{
+	mm_segment_t old_fs = get_fs();
+	int ret;
+
+	set_fs(USER_DS);
+	pagefault_disable();
+	ret = strnlen_user(unsafe_addr, count);
+	pagefault_enable();
+	set_fs(old_fs);
+
+	return ret;
+}

