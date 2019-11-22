Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05114C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB232070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKVWN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:13:27 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50994 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:13:25 -0500
Received: by mail-il1-f198.google.com with SMTP id l63so7296324ili.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=WTLZqtqfoN0AmabcgLeW8pAz7p65L6LdXI/HHqQhgkA=;
        b=hYoeNjMg+WMJXcSQxNxK0byV3fNvWpd7fNpqsTeNNDYt1Ot86dqXekae9aA2nTU7LS
         0tEN2GsXbCkoLizOTS6qqnQfeZPGah+ez/dB9FomyVdlBtDcYaQeOHFNQAuOUKFU98lI
         rWO/JKUo/TrfyahLtJIAdBpRsmlFE7JxiDTx6zAzF8JWbNz0ciV3KXgNkS0o4Mzfclh2
         9stsxZv2pQDbSwanA8CZCNri7S/z+4EzvMhvjTz9GyN5FNkSuBAUhuScq3d4yf5aeL1T
         TuuD2pA3Ijd60LCQ4vjE5GY86ElVvy1806T5hYn+totFll6Z/rnXDVuLn9uTrNv9iuNW
         ckFA==
X-Gm-Message-State: APjAAAUFlzZ97j2kfCkyDRGTj+ssvSaNLN2k06NwoJKf2myz9/+o4kkQ
        eQsa5FjxGeKDs63Nh517r2B5WoT4xRbBzywlKPB8zsIGIB7s
X-Google-Smtp-Source: APXvYqw3FjkUoue1G/FkUXlf6zNVDpp+pCA+okAW2RjsLWgXj3bTqBh1EyLeiMnNelvMSWTsowFF0AYfCdPDaxl3R0+63Ko15FXG
MIME-Version: 1.0
X-Received: by 2002:a92:9a17:: with SMTP id t23mr19431650ili.40.1574460802802;
 Fri, 22 Nov 2019 14:13:22 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:13:22 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911221700420.1511-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd2ff40597f6b812@google.com>
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



