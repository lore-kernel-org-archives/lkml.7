Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2F420706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll3h2IXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKVUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:52:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbfKVUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574455970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFVZkwFkg1RO4SbcfL/WiEjkxtRPrHSAXfvFvXfJ1Fw=;
        b=Ll3h2IXEE+mep1606nBgoR/GKlwIt3FNsl8migssY1p6QQtzlki/BK+TEZRVIVlWlkv3Pm
        WhqDcCZmWKxj2ibEbM5nX73VxeJwEZ3NWYKNtOYxnYRGkRA9flLZHPfDEO3OBGQpF9HLpI
        bes6NW/cMs4oQr4RXZjcyORaqM6ykiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-MT-ZCL3ZN_q87gAaeuntPQ-1; Fri, 22 Nov 2019 15:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F88CDBE5;
        Fri, 22 Nov 2019 20:52:45 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 086B960BF1;
        Fri, 22 Nov 2019 20:52:43 +0000 (UTC)
Date:   Fri, 22 Nov 2019 14:52:43 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191122145243.6ece9bed@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911221017590.1511-100000@iolanthe.rowland.org>
References: <20191121173825.1527c3a5@suzdal.zaitcev.lan>
        <Pine.LNX.4.44L0.1911221017590.1511-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MT-ZCL3ZN_q87gAaeuntPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 10:27:10 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> As Dmitry mentioned, you should put the Reported-by: line from the
> original syzbot bug report (see
> <https://marc.info/?l=linux-usb&m=153601206710985&w=2>) in the patch.

Thanks, got it. I also dropped all the cosmetic changes.

> >  		mutex_lock(&rp->fetch_lock);
> >  		spin_lock_irqsave(&rp->b_lock, flags);
> > -		mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> > -		kfree(rp->b_vec);
> > -		rp->b_vec  = vec;
> > -		rp->b_size = size;
> > -		rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> > -		rp->cnt_lost = 0;
> > +		if (rp->mmap_active) {
> > +			mon_free_buff(vec, size/CHUNK_SIZE);
> > +			kfree(vec);
> > +			ret = -EBUSY;  
> 
> It would be more elegant to do the rp->mmap_active test before calling
> kcalloc and mon_alloc_buf.  But of course that's a pretty minor thing.

Indeed it feels wrong that so much work gets discarded. However, memory
allocations can block, right? In the same time, our main objective here is
to make sure that when a page fault happens, we fill in the page that VMA
is intended to refer, and not one that was re-allocated. Therefore, I'm
trying to avoid a situation where:

1. thread A checks mmap_active, finds it at zero and proceeds into the
reallocation ioctl
2. thread A sleeps in get_free_page()
3. thread B runs mmap() and succeeds
4. thread A obtains its pages and proceeds to substitute the buffer
5. thread B (or any other) pagefaults and ends with the new, unexpected page

The code is not pretty, but I don't see an alternative. Heck, I would
love you to find more races if you can.

-- Pete

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

