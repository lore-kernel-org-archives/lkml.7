Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA5CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8190D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfDQLyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732113AbfDQLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10A53B025;
        Wed, 17 Apr 2019 11:54:24 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v7 08/10] vsprintf: Prevent crash when dereferencing invalid pointers
Date:   Wed, 17 Apr 2019 13:53:48 +0200
Message-Id: <20190417115350.20479-9-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already prevent crash when dereferencing some obviously broken
pointers. But the handling is not consistent. Sometimes we print "(null)"
only for pure NULL pointer, sometimes for pointers in the first
page and sometimes also for pointers in the last page (error codes).

Note that printk() call this code under logbuf_lock. Any recursive
printks are redirected to the printk_safe implementation and the messages
are stored into per-CPU buffers. These buffers might be eventually flushed
in printk_safe_flush_on_panic() but it is not guaranteed.

This patch adds a check using probe_kernel_read(). It is not a full-proof
test. But it should help to see the error message in 99% situations where
the kernel would silently crash otherwise.

Also it makes the error handling unified for "%s" and the many %p*
specifiers that need to read the data from a given address. We print:

   + (null)   when accessing data on pure pure NULL address
   + (efault) when accessing data on an invalid address

It does not affect the %p* specifiers that just print the given address
in some form, namely %pF, %pf, %pS, %ps, %pB, %pK, %px, and plain %p.

Note that we print (efault) from security reasons. In fact, the real
address can be seen only by %px or eventually %pK.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst |   7 ++
 lib/test_printf.c                         |  22 ++++-
 lib/vsprintf.c                            | 136 ++++++++++++++++++++++--------
 3 files changed, 129 insertions(+), 36 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c37ec7cd9c06..b2cac8d76b66 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -58,6 +58,13 @@ A raw pointer value may be printed with %p which will hash the address
 before printing. The kernel also supports extended specifiers for printing
 pointers of different types.
 
+Some of the extended specifiers print the data on the given address instead
+of printing the address itself. In this case, the following error messages
+might be printed instead of the unreachable information::
+
+	(null)	 data on plain NULL address
+	(efault) data on invalid address
+
 Plain Pointers
 --------------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 250ee864b8b8..359ae4fb1ece 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -239,6 +239,7 @@ plain_format(void)
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
+#define ZEROS ""
 
 static int __init
 plain_format(void)
@@ -268,7 +269,6 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 	return 0;
 }
 
-
 static int __init
 plain_hash(void)
 {
@@ -325,6 +325,24 @@ test_hashed(const char *fmt, const void *p)
 	test(buf, fmt, p);
 }
 
+static void __init
+null_pointer(void)
+{
+	test_hashed("%p", NULL);
+	test(ZEROS "00000000", "%px", NULL);
+	test("(null)", "%pE", NULL);
+}
+
+#define PTR_INVALID ((void *)0x000000ab)
+
+static void __init
+invalid_pointer(void)
+{
+	test_hashed("%p", PTR_INVALID);
+	test(ZEROS "000000ab", "%px", PTR_INVALID);
+	test("(efault)", "%pE", PTR_INVALID);
+}
+
 static void __init
 symbol_ptr(void)
 {
@@ -571,6 +589,8 @@ static void __init
 test_pointer(void)
 {
 	plain();
+	null_pointer();
+	invalid_pointer();
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f471a658422f..b989f1e8f35b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -612,12 +612,45 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
+/*
+ * This is not a fool-proof test. 99% of the time that this will fault is
+ * due to a bad pointer, not one that crosses into bad memory. Just test
+ * the address to make sure it doesn't fault due to a poorly added printk
+ * during debugging.
+ */
+static const char *check_pointer_msg(const void *ptr)
+{
+	char byte;
+
+	if (!ptr)
+		return "(null)";
+
+	if (probe_kernel_address(ptr, byte))
+		return "(efault)";
+
+	return NULL;
+}
+
+static int check_pointer(char **buf, char *end, const void *ptr,
+			 struct printf_spec spec)
+{
+	const char *err_msg;
+
+	err_msg = check_pointer_msg(ptr);
+	if (err_msg) {
+		*buf = string_nocheck(*buf, end, err_msg, spec);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static noinline_for_stack
 char *string(char *buf, char *end, const char *s,
 	     struct printf_spec spec)
 {
-	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
+	if (check_pointer(&buf, end, s, spec))
+		return buf;
 
 	return string_nocheck(buf, end, s, spec);
 }
@@ -792,6 +825,11 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
+		if (check_pointer(&buf, end, d, spec)) {
+			rcu_read_unlock();
+			return buf;
+		}
+
 		p = READ_ONCE(d->d_parent);
 		array[i] = READ_ONCE(d->d_name.name);
 		if (p == d) {
@@ -822,8 +860,12 @@ static noinline_for_stack
 char *bdev_name(char *buf, char *end, struct block_device *bdev,
 		struct printf_spec spec, const char *fmt)
 {
-	struct gendisk *hd = bdev->bd_disk;
-	
+	struct gendisk *hd;
+
+	if (check_pointer(&buf, end, bdev, spec))
+		return buf;
+
+	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
 	if (bdev->bd_part->partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
@@ -942,6 +984,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
+	if (check_pointer(&buf, end, res, spec))
+		return buf;
+
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
 		p = string_nocheck(p, pend, "io  ", str_spec);
@@ -1004,9 +1049,8 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		/* nothing to print */
 		return buf;
 
-	if (ZERO_OR_NULL_PTR(addr))
-		/* NULL pointer */
-		return string(buf, end, NULL, spec);
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'C':
@@ -1053,6 +1097,9 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 	int i, chunksz;
 	bool first = true;
 
+	if (check_pointer(&buf, end, bitmap, spec))
+		return buf;
+
 	/* reused to print numbers */
 	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
 
@@ -1094,6 +1141,9 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	int cur, rbot, rtop;
 	bool first = true;
 
+	if (check_pointer(&buf, end, bitmap, spec))
+		return buf;
+
 	rbot = cur = find_first_bit(bitmap, nr_bits);
 	while (cur < nr_bits) {
 		rtop = cur;
@@ -1132,6 +1182,9 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	char separator;
 	bool reversed = false;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		separator = '-';
@@ -1437,6 +1490,9 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 {
 	char *err_fmt_msg;
 
+	if (check_pointer(&buf, end, ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case '6':
 		return ip6_addr_string(buf, end, ptr, spec, fmt);
@@ -1475,9 +1531,8 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (spec.field_width == 0)
 		return buf;				/* nothing to print */
 
-	if (ZERO_OR_NULL_PTR(addr))
-		return string(buf, end, NULL, spec);	/* NULL pointer */
-
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
 
 	do {
 		switch (fmt[count++]) {
@@ -1523,10 +1578,14 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
-static char *va_format(char *buf, char *end, struct va_format *va_fmt)
+static char *va_format(char *buf, char *end, struct va_format *va_fmt,
+		       struct printf_spec spec, const char *fmt)
 {
 	va_list va;
 
+	if (check_pointer(&buf, end, va_fmt, spec))
+		return buf;
+
 	va_copy(va, *va_fmt->va);
 	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
 	va_end(va);
@@ -1544,6 +1603,9 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	const u8 *index = uuid_index;
 	bool uc = false;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (*(++fmt)) {
 	case 'L':
 		uc = true;		/* fall-through */
@@ -1582,6 +1644,9 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 	unsigned long long num;
 	int size;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		num = *(const netdev_features_t *)addr;
@@ -1595,11 +1660,15 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 }
 
 static noinline_for_stack
-char *address_val(char *buf, char *end, const void *addr, const char *fmt)
+char *address_val(char *buf, char *end, const void *addr,
+		  struct printf_spec spec, const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'd':
 		num = *(const dma_addr_t *)addr;
@@ -1651,12 +1720,16 @@ char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 }
 
 static noinline_for_stack
-char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
+char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
+	      struct printf_spec spec, const char *fmt)
 {
 	bool have_t = true, have_d = true;
 	bool raw = false;
 	int count = 2;
 
+	if (check_pointer(&buf, end, tm, spec))
+		return buf;
+
 	switch (fmt[count]) {
 	case 'd':
 		have_t = false;
@@ -1690,7 +1763,7 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 {
 	switch (fmt[1]) {
 	case 'R':
-		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
+		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
 	default:
 		return string_nocheck(buf, end, "(%ptR?)", spec);
 	}
@@ -1703,8 +1776,8 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
 		return string_nocheck(buf, end, "(%pC?)", spec);
 
-	if (!clk)
-		return string(buf, end, NULL, spec);
+	if (check_pointer(&buf, end, clk, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'n':
@@ -1751,6 +1824,9 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
+	if (check_pointer(&buf, end, flags_ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
@@ -1825,8 +1901,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	if (!IS_ENABLED(CONFIG_OF))
 		return string_nocheck(buf, end, "(%pOF?)", spec);
 
-	if ((unsigned long)dn < PAGE_SIZE)
-		return string_nocheck(buf, end, "(null)", spec);
+	if (check_pointer(&buf, end, dn, spec))
+		return buf;
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
@@ -2021,18 +2097,6 @@ static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
-	const int default_width = 2 * sizeof(void *);
-
-	if (!ptr && *fmt != 'K' && *fmt != 'x') {
-		/*
-		 * Print (null) with the same width as a pointer so it makes
-		 * tabular output look nice.
-		 */
-		if (spec.field_width == -1)
-			spec.field_width = default_width;
-		return string_nocheck(buf, end, "(null)", spec);
-	}
-
 	switch (*fmt) {
 	case 'F':
 	case 'f':
@@ -2074,13 +2138,13 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		return va_format(buf, end, ptr);
+		return va_format(buf, end, ptr, spec, fmt);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
 		return netdev_bits(buf, end, ptr, spec, fmt);
 	case 'a':
-		return address_val(buf, end, ptr, fmt);
+		return address_val(buf, end, ptr, spec, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
 	case 't':
@@ -2714,11 +2778,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
 		case FORMAT_TYPE_STR: {
 			const char *save_str = va_arg(args, char *);
+			const char *err_msg;
 			size_t len;
 
-			if ((unsigned long)save_str > (unsigned long)-PAGE_SIZE
-					|| (unsigned long)save_str < PAGE_SIZE)
-				save_str = "(null)";
+			err_msg = check_pointer_msg(save_str);
+			if (err_msg)
+				save_str = err_msg;
+
 			len = strlen(save_str) + 1;
 			if (str + len < end)
 				memcpy(str, save_str, len);
-- 
2.16.4

