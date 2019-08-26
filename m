Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52542C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BE223407
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfHZPCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:02:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55596 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfHZPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:02:25 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7QF2BpU096737;
        Tue, 27 Aug 2019 00:02:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 27 Aug 2019 00:02:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7QF2BIr096733
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 27 Aug 2019 00:02:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Rewriting read_kmem()/write_kmem() ?
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
 <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
 <92919086-0a7e-520d-0465-b9e3051e965a@i-love.sakura.ne.jp>
 <20190826111944.GA39308@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <acd773b8-89fa-6000-ec43-18815a1ab8c2@i-love.sakura.ne.jp>
Date:   Tue, 27 Aug 2019 00:02:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826111944.GA39308@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/26 20:19, Ingo Molnar wrote:
> Basically making IO primitives interruptible is the norm and it's a 
> quality of implementation issue: it's only a historic accident that 
> /dev/mem read()s aren't.
> 
> So let's try and make it interruptible as the #3 patch I sent did - of 
> course if anything breaks we'll have to undo it. But if we can get away 
> with then by all means let's do so - even shorter reads can generate 
> nasty long processing latencies.
> 
> Ok?

This is how read_kmem()/write_kmem() could be rewritten (before doing
s/fatal_signal_pending/signal_pending/ change). Only compile tested.
Do we want to try this change using several patches?

 drivers/char/mem.c | 202 +++++++++++++++++++----------------------------------
 1 file changed, 73 insertions(+), 129 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 9eb564c..12bca2a 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -430,114 +430,32 @@ static int mmap_kmem(struct file *file, struct vm_area_struct *vma)
 	return mmap_mem(file, vma);
 }
 
-/*
- * This function reads the *virtual* memory as seen by the kernel.
- */
-static ssize_t read_kmem(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t do_copy_kmem(unsigned long p, char __user *buf, size_t count,
+			    loff_t *ppos, const bool is_write)
 {
-	unsigned long p = *ppos;
-	ssize_t low_count, read, sz;
-	char *kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
-	int err = 0;
-
-	read = 0;
-	if (p < (unsigned long) high_memory) {
-		low_count = count;
-		if (count > (unsigned long)high_memory - p)
-			low_count = (unsigned long)high_memory - p;
+	ssize_t copied = 0;
+	ssize_t sz;
 
 #ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
-		/* we don't have page 0 mapped on sparc and m68k.. */
-		if (p < PAGE_SIZE && low_count > 0) {
-			sz = size_inside_page(p, low_count);
-			if (clear_user(buf, sz))
-				return -EFAULT;
-			buf += sz;
-			p += sz;
-			read += sz;
-			low_count -= sz;
-			count -= sz;
-		}
-#endif
-		while (low_count > 0) {
-			sz = size_inside_page(p, low_count);
-
-			/*
-			 * On ia64 if a page has been mapped somewhere as
-			 * uncached, then it must also be accessed uncached
-			 * by the kernel or data corruption may occur
-			 */
-			kbuf = xlate_dev_kmem_ptr((void *)p);
-			if (!virt_addr_valid(kbuf))
-				return -ENXIO;
-
-			if (copy_to_user(buf, kbuf, sz))
-				return -EFAULT;
-			buf += sz;
-			p += sz;
-			read += sz;
-			low_count -= sz;
-			count -= sz;
-			if (should_stop_iteration()) {
-				count = 0;
-				break;
-			}
-		}
-	}
-
-	if (count > 0) {
-		kbuf = (char *)__get_free_page(GFP_KERNEL);
-		if (!kbuf)
-			return -ENOMEM;
-		while (count > 0) {
-			sz = size_inside_page(p, count);
-			if (!is_vmalloc_or_module_addr((void *)p)) {
-				err = -ENXIO;
-				break;
-			}
-			sz = vread(kbuf, (char *)p, sz);
-			if (!sz)
-				break;
-			if (copy_to_user(buf, kbuf, sz)) {
-				err = -EFAULT;
-				break;
-			}
-			count -= sz;
-			buf += sz;
-			read += sz;
-			p += sz;
-			if (should_stop_iteration())
-				break;
-		}
-		free_page((unsigned long)kbuf);
-	}
-	*ppos = p;
-	return read ? read : err;
-}
-
-
-static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	ssize_t written, sz;
-	unsigned long copied;
-
-	written = 0;
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
 		sz = size_inside_page(p, count);
-		/* Hmm. Do something? */
+		if (is_write) {
+			/* Hmm. Do something? */
+		} else {
+			if (clear_user(buf, sz))
+				return -EFAULT;
+		}
 		buf += sz;
 		p += sz;
 		count -= sz;
-		written += sz;
+		copied += sz;
 	}
 #endif
 
 	while (count > 0) {
 		void *ptr;
+		unsigned long n;
 
 		sz = size_inside_page(p, count);
 
@@ -550,78 +468,104 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 		if (!virt_addr_valid(ptr))
 			return -ENXIO;
 
-		copied = copy_from_user(ptr, buf, sz);
-		if (copied) {
-			written += sz - copied;
-			if (written)
+		if (is_write)
+			n = copy_from_user(ptr, buf, sz);
+		else
+			n = copy_to_user(buf, buf, sz);
+		if (n) {
+			copied += sz - n;
+			if (copied)
 				break;
 			return -EFAULT;
 		}
 		buf += sz;
 		p += sz;
 		count -= sz;
-		written += sz;
+		copied += sz;
 		if (should_stop_iteration())
 			break;
 	}
 
-	*ppos += written;
-	return written;
+	*ppos += copied;
+	return copied;
 }
 
-/*
- * This function writes to the *virtual* memory as seen by the kernel.
- */
-static ssize_t write_kmem(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t copy_kmem(char __user *buf, size_t count, loff_t *ppos,
+			 const bool is_write)
 {
 	unsigned long p = *ppos;
-	ssize_t wrote = 0;
-	ssize_t virtr = 0;
-	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
+	ssize_t copied = 0;
 	int err = 0;
 
 	if (p < (unsigned long) high_memory) {
-		unsigned long to_write = min_t(unsigned long, count,
-					       (unsigned long)high_memory - p);
-		wrote = do_write_kmem(p, buf, to_write, ppos);
-		if (wrote != to_write)
-			return wrote;
-		p += wrote;
-		buf += wrote;
-		count -= wrote;
+		unsigned long to_copy = min_t(unsigned long, count,
+					      (unsigned long)high_memory - p);
+
+		copied = do_copy_kmem(p, buf, to_copy, ppos, is_write);
+		if (copied != to_copy)
+			return copied;
+		p += copied;
+		buf += copied;
+		count -= copied;
 	}
 
 	if (count > 0) {
-		kbuf = (char *)__get_free_page(GFP_KERNEL);
+		/* k-addr because vread()/vwrite() takes vmlist_lock rwlock */
+		char *kbuf = (char *)__get_free_page(GFP_KERNEL);
+
 		if (!kbuf)
-			return wrote ? wrote : -ENOMEM;
+			return copied ? copied : -ENOMEM;
 		while (count > 0) {
-			unsigned long sz = size_inside_page(p, count);
-			unsigned long n;
+			ssize_t sz = size_inside_page(p, count);
 
 			if (!is_vmalloc_or_module_addr((void *)p)) {
 				err = -ENXIO;
 				break;
 			}
-			n = copy_from_user(kbuf, buf, sz);
-			if (n) {
-				err = -EFAULT;
-				break;
+			if (is_write) {
+				if (copy_from_user(kbuf, buf, sz)) {
+					err = -EFAULT;
+					break;
+				}
+				vwrite(kbuf, (char *)p, sz);
+			} else {
+				sz = vread(kbuf, (char *)p, sz);
+				if (!sz)
+					break;
+				if (copy_to_user(buf, kbuf, sz)) {
+					err = -EFAULT;
+					break;
+				}
 			}
-			vwrite(kbuf, (char *)p, sz);
 			count -= sz;
 			buf += sz;
-			virtr += sz;
+			copied += sz;
 			p += sz;
 			if (should_stop_iteration())
 				break;
 		}
 		free_page((unsigned long)kbuf);
 	}
-
 	*ppos = p;
-	return virtr + wrote ? : err;
+	return copied ? copied : err;
+}
+
+/*
+ * This function reads the *virtual* memory as seen by the kernel.
+ */
+static ssize_t read_kmem(struct file *file, char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	return copy_kmem(buf, count, ppos, false);
+}
+
+/*
+ * This function writes to the *virtual* memory as seen by the kernel.
+ */
+static ssize_t write_kmem(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	return copy_kmem((char __user *) buf, count, ppos, true);
 }
 
 static ssize_t read_port(struct file *file, char __user *buf,
-- 
1.8.3.1

