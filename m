Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FDC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA6B20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKWRSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:18:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33537 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726705AbfKWRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 12:18:15 -0500
Received: (qmail 23030 invoked by uid 500); 23 Nov 2019 12:18:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Nov 2019 12:18:14 -0500
Date:   Sat, 23 Nov 2019 12:18:14 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
cc:     arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tglx@linutronix.de>, <viro@zeniv.linux.org.uk>,
        <zaitcev@redhat.com>
Subject: Re: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <000000000000c789960597f6b88b@google.com>
Message-ID: <Pine.LNX.4.44L0.1911231212330.22374-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, syzbot wrote:

> > #syz test: linux-4.19.y f6e27dbb1afa
> 
> "linux-4.19.y" does not look like a valid git repo address.

Let's try again.  The "git tree" value in the original bug report was
"upstream", so I'll use that even though it doesn't look like a valid 
git repo address either.

Alan Stern

#syz test: upstream f6e27dbb1afa

commit 5252eb4c8297fedbf1c5f1e67da44efe00e6ef6b
Author: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
Date:   Thu Nov 21 17:24:00 2019 -0600

     usb: Fix a deadlock in usbmon between mmap and read

     Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
     Reported-by: syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index ac2b4fcc265f..f48a23adbc35 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1039,12 +1039,18 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg

  		mutex_lock(&rp->fetch_lock);
  		spin_lock_irqsave(&rp->b_lock, flags);
-		mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
-		kfree(rp->b_vec);
-		rp->b_vec  = vec;
-		rp->b_size = size;
-		rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
-		rp->cnt_lost = 0;
+		if (rp->mmap_active) {
+			mon_free_buff(vec, size/CHUNK_SIZE);
+			kfree(vec);
+			ret = -EBUSY;
+		} else {
+			mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
+			kfree(rp->b_vec);
+			rp->b_vec  = vec;
+			rp->b_size = size;
+			rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
+			rp->cnt_lost = 0;
+		}
  		spin_unlock_irqrestore(&rp->b_lock, flags);
  		mutex_unlock(&rp->fetch_lock);
  		}
@@ -1216,13 +1222,21 @@ mon_bin_poll(struct file *file, struct poll_table_struct *wait)
  static void mon_bin_vma_open(struct vm_area_struct *vma)
  {
  	struct mon_reader_bin *rp = vma->vm_private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rp->b_lock, flags);
  	rp->mmap_active++;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
  }

  static void mon_bin_vma_close(struct vm_area_struct *vma)
  {
+	unsigned long flags;
+
  	struct mon_reader_bin *rp = vma->vm_private_data;
+	spin_lock_irqsave(&rp->b_lock, flags);
  	rp->mmap_active--;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
  }

  /*
@@ -1234,16 +1248,12 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
  	unsigned long offset, chunk_idx;
  	struct page *pageptr;

-	mutex_lock(&rp->fetch_lock);
  	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size) {
-		mutex_unlock(&rp->fetch_lock);
+	if (offset >= rp->b_size)
  		return VM_FAULT_SIGBUS;
-	}
  	chunk_idx = offset / CHUNK_SIZE;
  	pageptr = rp->b_vec[chunk_idx].pg;
  	get_page(pageptr);
-	mutex_unlock(&rp->fetch_lock);
  	vmf->page = pageptr;
  	return 0;
  }


