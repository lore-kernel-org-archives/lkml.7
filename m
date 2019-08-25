Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51A7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D682173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfHYFuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:50:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49792 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfHYFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:50:23 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7P5o6nf033711;
        Sun, 25 Aug 2019 14:50:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 25 Aug 2019 14:50:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7P5nxB4033656
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 25 Aug 2019 14:50:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
Date:   Sun, 25 Aug 2019 14:49:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824202224.GA5286@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/25 5:22, Ingo Molnar wrote:
>> So I'd be willing to try that (and then if somebody reports a
>> regression we can make it use "fatal_signal_pending()" instead)
> 
> Ok, will post a changelogged patch (unless Tetsuo beats me to it?).

Here is a patch. This patch also tries to fix handling of return code when
partial read/write happened (because we should return bytes processed when
we return due to -EINTR). But asymmetric between read function and write
function looks messy. Maybe we should just make /dev/{mem,kmem} killable
for now, and defer making /dev/{mem,kmem} interruptible till rewrite of
read/write functions.

 drivers/char/mem.c | 89 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cb8e653..3c6a3c2 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -108,7 +108,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 	ssize_t read, sz;
 	void *ptr;
 	char *bounce;
-	int err;
+	int err = 0;
 
 	if (p != *ppos)
 		return 0;
@@ -132,8 +132,10 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 #endif
 
 	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!bounce)
-		return -ENOMEM;
+	if (!bounce) {
+		err = -ENOMEM;
+		goto failed;
+	}
 
 	while (count > 0) {
 		unsigned long remaining;
@@ -142,7 +144,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 		sz = size_inside_page(p, count);
 		cond_resched();
 		err = -EINTR;
-		if (fatal_signal_pending(current))
+		if (signal_pending(current))
 			goto failed;
 
 		err = -EPERM;
@@ -180,14 +182,11 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 		count -= sz;
 		read += sz;
 	}
+failed:
 	kfree(bounce);
 
 	*ppos += read;
-	return read;
-
-failed:
-	kfree(bounce);
-	return err;
+	return read ? read : err;
 }
 
 static ssize_t write_mem(struct file *file, const char __user *buf,
@@ -197,6 +196,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 	ssize_t written, sz;
 	unsigned long copied;
 	void *ptr;
+	int err = 0;
 
 	if (p != *ppos)
 		return -EFBIG;
@@ -223,13 +223,16 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 
 		sz = size_inside_page(p, count);
 		cond_resched();
-		if (fatal_signal_pending(current))
-			return -EINTR;
+		err = -EINTR;
+		if (signal_pending(current))
+			break;
 
+		err = -EPERM;
 		allowed = page_is_allowed(p >> PAGE_SHIFT);
 		if (!allowed)
-			return -EPERM;
+			break;
 
+		err = -EFAULT;
 		/* Skip actual writing when a page is marked as restricted. */
 		if (allowed == 1) {
 			/*
@@ -238,19 +241,14 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 			 * by the kernel or data corruption may occur.
 			 */
 			ptr = xlate_dev_mem_ptr(p);
-			if (!ptr) {
-				if (written)
-					break;
-				return -EFAULT;
-			}
+			if (!ptr)
+				break;
 
 			copied = copy_from_user(ptr, buf, sz);
 			unxlate_dev_mem_ptr(p, ptr);
 			if (copied) {
 				written += sz - copied;
-				if (written)
-					break;
-				return -EFAULT;
+				break;
 			}
 		}
 
@@ -261,7 +259,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 	}
 
 	*ppos += written;
-	return written;
+	return written ? written : err;
 }
 
 int __weak phys_mem_access_prot_allowed(struct file *file,
@@ -459,8 +457,10 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 		while (low_count > 0) {
 			sz = size_inside_page(p, low_count);
 			cond_resched();
-			if (fatal_signal_pending(current))
-				return -EINTR;
+			if (signal_pending(current)) {
+				err = -EINTR;
+				goto failed;
+			}
 
 			/*
 			 * On ia64 if a page has been mapped somewhere as
@@ -468,11 +468,15 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 			 * by the kernel or data corruption may occur
 			 */
 			kbuf = xlate_dev_kmem_ptr((void *)p);
-			if (!virt_addr_valid(kbuf))
-				return -ENXIO;
+			if (!virt_addr_valid(kbuf)) {
+				err = -ENXIO;
+				goto failed;
+			}
 
-			if (copy_to_user(buf, kbuf, sz))
-				return -EFAULT;
+			if (copy_to_user(buf, kbuf, sz)) {
+				err = -EFAULT;
+				goto failed;
+			}
 			buf += sz;
 			p += sz;
 			read += sz;
@@ -483,12 +487,14 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 
 	if (count > 0) {
 		kbuf = (char *)__get_free_page(GFP_KERNEL);
-		if (!kbuf)
-			return -ENOMEM;
+		if (!kbuf) {
+			err = -ENOMEM;
+			goto failed;
+		}
 		while (count > 0) {
 			sz = size_inside_page(p, count);
 			cond_resched();
-			if (fatal_signal_pending(current)) {
+			if (signal_pending(current)) {
 				err = -EINTR;
 				break;
 			}
@@ -510,6 +516,7 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 		}
 		free_page((unsigned long)kbuf);
 	}
+ failed:
 	*ppos = p;
 	return read ? read : err;
 }
@@ -520,6 +527,7 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 {
 	ssize_t written, sz;
 	unsigned long copied;
+	int err = 0;
 
 	written = 0;
 #ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
@@ -539,8 +547,10 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 
 		sz = size_inside_page(p, count);
 		cond_resched();
-		if (fatal_signal_pending(current))
-			return -EINTR;
+		if (signal_pending(current)) {
+			err = -EINTR;
+			break;
+		}
 
 		/*
 		 * On ia64 if a page has been mapped somewhere as uncached, then
@@ -548,15 +558,16 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 		 * corruption may occur.
 		 */
 		ptr = xlate_dev_kmem_ptr((void *)p);
-		if (!virt_addr_valid(ptr))
-			return -ENXIO;
+		if (!virt_addr_valid(ptr)) {
+			err = -ENXIO;
+			break;
+		}
 
 		copied = copy_from_user(ptr, buf, sz);
 		if (copied) {
 			written += sz - copied;
-			if (written)
-				break;
-			return -EFAULT;
+			err = -EFAULT;
+			break;
 		}
 		buf += sz;
 		p += sz;
@@ -565,7 +576,7 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 	}
 
 	*ppos += written;
-	return written;
+	return written ? written : err;
 }
 
 /*
@@ -600,7 +611,7 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 			unsigned long n;
 
 			cond_resched();
-			if (fatal_signal_pending(current)) {
+			if (signal_pending(current)) {
 				err = -EINTR;
 				break;
 			}
-- 
1.8.3.1
