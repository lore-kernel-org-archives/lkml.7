Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DEDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48B7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfHZNOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:14:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49453 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfHZNOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:14:37 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7QDDWAn075432;
        Mon, 26 Aug 2019 22:13:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 26 Aug 2019 22:13:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7QDDS22075309
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Aug 2019 22:13:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
Date:   Mon, 26 Aug 2019 22:13:25 +0900
Message-Id: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found that a thread can stall for minutes inside read_mem() or
write_mem() after that thread was killed by SIGKILL [1]. Reading from
iomem areas of /dev/mem can be slow, depending on the hardware.
While reading 2GB at one read() is legal, delaying termination of killed
thread for minutes is bad. Thus, allow reading/writing /dev/mem and
/dev/kmem to be preemptible and killable.

  [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
  [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
  [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
  [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
  [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248

Theoretically, reading/writing /dev/mem and /dev/kmem can become
"interruptible". But this patch chose "killable". Future patch will make
them "interruptible" so that we can revert to "killable" if some program
regressed.

[1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
---
 drivers/char/mem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50..9eb564c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -97,6 +97,13 @@ void __weak unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 }
 #endif
 
+static inline bool should_stop_iteration(void)
+{
+	if (need_resched())
+		cond_resched();
+	return fatal_signal_pending(current);
+}
+
 /*
  * This funcion reads the *physical* memory. The f_pos points directly to the
  * memory location.
@@ -175,6 +182,8 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 		p += sz;
 		count -= sz;
 		read += sz;
+		if (should_stop_iteration())
+			break;
 	}
 	kfree(bounce);
 
@@ -251,6 +260,8 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 		p += sz;
 		count -= sz;
 		written += sz;
+		if (should_stop_iteration())
+			break;
 	}
 
 	*ppos += written;
@@ -468,6 +479,10 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 			read += sz;
 			low_count -= sz;
 			count -= sz;
+			if (should_stop_iteration()) {
+				count = 0;
+				break;
+			}
 		}
 	}
 
@@ -492,6 +507,8 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 			buf += sz;
 			read += sz;
 			p += sz;
+			if (should_stop_iteration())
+				break;
 		}
 		free_page((unsigned long)kbuf);
 	}
@@ -544,6 +561,8 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 		p += sz;
 		count -= sz;
 		written += sz;
+		if (should_stop_iteration())
+			break;
 	}
 
 	*ppos += written;
@@ -595,6 +614,8 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 			buf += sz;
 			virtr += sz;
 			p += sz;
+			if (should_stop_iteration())
+				break;
 		}
 		free_page((unsigned long)kbuf);
 	}
-- 
1.8.3.1

