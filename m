Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC64C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF32070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKVWNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:13:24 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54852 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:13:22 -0500
Received: by mail-io1-f70.google.com with SMTP id f66so5950255ioa.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=WTLZqtqfoN0AmabcgLeW8pAz7p65L6LdXI/HHqQhgkA=;
        b=HCdVnvCjnkOzhOGo9ASb5/n7Dex96mIM1Lvey/HmSKDuI5118sjkauIZgHhpaB5Cz6
         PW5OF3VopyiIjeW+85bJ8yU9vT/dBCnGyGjnvCcwl0lIQT2t8RyzhSqSI658uSMlYf7b
         HsuanMspwrrEn1wZjRAhsq5WDartyaTHkbchbdj+yXumSKJ0I2yJdwELoukYbWGhfXuq
         TBqIoRE3AkfJcnyYSj9aIbvTGd8/x74ZsX/RJt4qAtdv0KvzYFIbdrJS0wa/lY4MRF1Z
         dVSLgT1eoUtbmP3e7L7MeK4+Bnn92OlnAMcFqh94NwEomB6csNEVyX3Wn1y0ZiFpVKIo
         F4EQ==
X-Gm-Message-State: APjAAAV922qm8xIuwc5h2SXIZNKIWyXDk5JPvUVoP63SxlFqlEckNIUS
        /jjsnH+loZ3wGMqYP/+HGm51TYbMSxTjeT6CBfOW4FMzcRWX
X-Google-Smtp-Source: APXvYqxD+j/UZwfF9FRVSndN1yrwOhhADOicbq1byMPaVgs8DVQkMgFH0iFDIrWg8l+Zb1dMZGXVJbQwABz2/V/zSh12hT2L7iSG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e9:: with SMTP id s9mr17035334jaq.7.1574460801384;
 Fri, 22 Nov 2019 14:13:21 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:13:21 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911221700420.1511-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c789960597f6b88b@google.com>
Subject: Re: Re: possible deadlock in mon_bin_vma_fault
From:   syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 22 Nov 2019, Pete Zaitcev wrote:

>> > It would be more elegant to do the rp->mmap_active test before calling
>> > kcalloc and mon_alloc_buf.  But of course that's a pretty minor thing.

>> Indeed it feels wrong that so much work gets discarded. However, memory
>> allocations can block, right? In the same time, our main objective here  
>> is
>> to make sure that when a page fault happens, we fill in the page that VMA
>> is intended to refer, and not one that was re-allocated. Therefore, I'm
>> trying to avoid a situation where:

>> 1. thread A checks mmap_active, finds it at zero and proceeds into the
>> reallocation ioctl
>> 2. thread A sleeps in get_free_page()
>> 3. thread B runs mmap() and succeeds
>> 4. thread A obtains its pages and proceeds to substitute the buffer
>> 5. thread B (or any other) pagefaults and ends with the new, unexpected  
>> page

>> The code is not pretty, but I don't see an alternative. Heck, I would
>> love you to find more races if you can.

> The alternative is to have the routines for mmap() hold fetch_lock
> instead of b_lock.  mmap() is allowed to sleep, so that would be okay.
> Then you would also hold fetch_lock while checking mmap_active and
> doing the memory allocations.  That would prevent any races -- in your
> example above, thread A would acquire fetch_lock in step 1, so thread B
> would block in step 3 until step 4 was finished.  Hence B would end up
> mapping the correct pages.

> In practice, I don't see this being a routine problem.  How often do
> multiple threads independently try to mmap the same usbmon buffer?

> Still, let's see syzbot reacts to your current patch.  The line below
> is how you ask syzbot to test a candidate patch.

> Alan Stern

> #syz test: linux-4.19.y f6e27dbb1afa

"linux-4.19.y" does not look like a valid git repo address.


> commit 5252eb4c8297fedbf1c5f1e67da44efe00e6ef6b
> Author: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
> Date:   Thu Nov 21 17:24:00 2019 -0600

>      usb: Fix a deadlock in usbmon between mmap and read

>      Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
>      Reported-by: syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com

> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index ac2b4fcc265f..f48a23adbc35 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1039,12 +1039,18 @@ static long mon_bin_ioctl(struct file *file,  
> unsigned int cmd, unsigned long arg

>   		mutex_lock(&rp->fetch_lock);
>   		spin_lock_irqsave(&rp->b_lock, flags);
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
> +		} else {
> +			mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> +			kfree(rp->b_vec);
> +			rp->b_vec  = vec;
> +			rp->b_size = size;
> +			rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> +			rp->cnt_lost = 0;
> +		}
>   		spin_unlock_irqrestore(&rp->b_lock, flags);
>   		mutex_unlock(&rp->fetch_lock);
>   		}
> @@ -1216,13 +1222,21 @@ mon_bin_poll(struct file *file, struct  
> poll_table_struct *wait)
>   static void mon_bin_vma_open(struct vm_area_struct *vma)
>   {
>   	struct mon_reader_bin *rp = vma->vm_private_data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rp->b_lock, flags);
>   	rp->mmap_active++;
> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>   }

>   static void mon_bin_vma_close(struct vm_area_struct *vma)
>   {
> +	unsigned long flags;
> +
>   	struct mon_reader_bin *rp = vma->vm_private_data;
> +	spin_lock_irqsave(&rp->b_lock, flags);
>   	rp->mmap_active--;
> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>   }

>   /*
> @@ -1234,16 +1248,12 @@ static vm_fault_t mon_bin_vma_fault(struct  
> vm_fault *vmf)
>   	unsigned long offset, chunk_idx;
>   	struct page *pageptr;

> -	mutex_lock(&rp->fetch_lock);
>   	offset = vmf->pgoff << PAGE_SHIFT;
> -	if (offset >= rp->b_size) {
> -		mutex_unlock(&rp->fetch_lock);
> +	if (offset >= rp->b_size)
>   		return VM_FAULT_SIGBUS;
> -	}
>   	chunk_idx = offset / CHUNK_SIZE;
>   	pageptr = rp->b_vec[chunk_idx].pg;
>   	get_page(pageptr);
> -	mutex_unlock(&rp->fetch_lock);
>   	vmf->page = pageptr;
>   	return 0;
>   }



