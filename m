Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C709720715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKVP1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:27:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59318 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726100AbfKVP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:27:11 -0500
Received: (qmail 2667 invoked by uid 2102); 22 Nov 2019 10:27:10 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Nov 2019 10:27:10 -0500
Date:   Fri, 22 Nov 2019 10:27:10 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>
cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <20191121173825.1527c3a5@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.1911221017590.1511-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Pete Zaitcev wrote:

> On Thu, 21 Nov 2019 11:20:20 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, 21 Nov 2019, Pete Zaitcev wrote:
> > 
> > > Anyway... If you are looking at it too, what do you think about not using
> > > any locks in mon_bin_vma_fault() at all? Isn't it valid? I think I tried
> > > to be "safe", but it only uses things that are constants unless we're
> > > opening and closing; a process cannot make page faults unless it has
> > > some thing mapped; and that is only possible if device is open and stays
> > > open. Can you find a hole in this reasoning?  
> > 
> > I think you're right. [...]
> 
> How about the appended patch, then? You like?
> 
> Do you happen to know how to refer to a syzbot report in a commit message?

As Dmitry mentioned, you should put the Reported-by: line from the
original syzbot bug report (see
<https://marc.info/?l=linux-usb&m=153601206710985&w=2>) in the patch.

> -- Pete
> 
> commit 628f3bbf37eee21cce4cfbfaa6a796b129d7736d
> Author: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
> Date:   Thu Nov 21 17:24:00 2019 -0600
> 
>     usb: Fix a deadlock in usbmon between mmap and read
>     
>     Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> 
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index ac2b4fcc265f..fb7df9810bad 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1039,12 +1039,18 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  
>  		mutex_lock(&rp->fetch_lock);
>  		spin_lock_irqsave(&rp->b_lock, flags);
> -		mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> -		kfree(rp->b_vec);
> -		rp->b_vec  = vec;
> -		rp->b_size = size;
> -		rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> -		rp->cnt_lost = 0;
> +		if (rp->mmap_active) {
> +			mon_free_buff(vec, size/CHUNK_SIZE);
> +			kfree(vec);
> +			ret = -EBUSY;

It would be more elegant to do the rp->mmap_active test before calling
kcalloc and mon_alloc_buf.  But of course that's a pretty minor thing.

> +		} else {
> +			mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> +			kfree(rp->b_vec);
> +			rp->b_vec  = vec;
> +			rp->b_size = size;
> +			rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> +			rp->cnt_lost = 0;
> +		}
>  		spin_unlock_irqrestore(&rp->b_lock, flags);
>  		mutex_unlock(&rp->fetch_lock);
>  		}
> @@ -1093,11 +1099,11 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  			return ret;
>  		if (put_user(ret, &uptr->nfetch))
>  			return -EFAULT;
> -		ret = 0;

What's the reason for this change?

>  		}
>  		break;
>  
> -	case MON_IOCG_STATS: {
> +	case MON_IOCG_STATS:
> +		{

And this one?  This disagrees with the usual kernel style.

>  		struct mon_bin_stats __user *sp;
>  		unsigned int nevents;
>  		unsigned int ndropped;
> @@ -1113,7 +1119,6 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  			return -EFAULT;
>  		if (put_user(nevents, &sp->queued))
>  			return -EFAULT;
> -
>  		}
>  		break;
>  
> @@ -1216,13 +1221,21 @@ mon_bin_poll(struct file *file, struct poll_table_struct *wait)
>  static void mon_bin_vma_open(struct vm_area_struct *vma)
>  {
>  	struct mon_reader_bin *rp = vma->vm_private_data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rp->b_lock, flags);
>  	rp->mmap_active++;
> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>  
>  static void mon_bin_vma_close(struct vm_area_struct *vma)
>  {
> +	unsigned long flags;
> +
>  	struct mon_reader_bin *rp = vma->vm_private_data;
> +	spin_lock_irqsave(&rp->b_lock, flags);
>  	rp->mmap_active--;
> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>  
>  /*
> @@ -1234,16 +1247,12 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
>  	unsigned long offset, chunk_idx;
>  	struct page *pageptr;
>  
> -	mutex_lock(&rp->fetch_lock);
>  	offset = vmf->pgoff << PAGE_SHIFT;
> -	if (offset >= rp->b_size) {
> -		mutex_unlock(&rp->fetch_lock);
> +	if (offset >= rp->b_size)
>  		return VM_FAULT_SIGBUS;
> -	}
>  	chunk_idx = offset / CHUNK_SIZE;
>  	pageptr = rp->b_vec[chunk_idx].pg;
>  	get_page(pageptr);
> -	mutex_unlock(&rp->fetch_lock);
>  	vmf->page = pageptr;
>  	return 0;
>  }

Apart from the items mentioned above, this looks right to me.

Alan Stern

