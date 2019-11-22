Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0853FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C712F2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exFw81iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:18:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35411 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKVHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:18:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id i19so5460674qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9hrKZqcsJy6v4SmU4cyAJHQyfkmwgDM2yXTgkEnUJE=;
        b=exFw81iuonnCEtoZ4O1YR8hThC1FfvNeaHFS4CEnIocjmE9ZOe4cRL4q/WbRrrJ2om
         W/rg1Lk+Vs19b40pxP0uTqRAM7GF21xD/sh52G+gMqkYmPddatJqNHveHQn61dNWwU7C
         ngX82QLaxpBmFOA3Ue6ly5xLUQptsOD+himLeCaeoz2+jkEVTvnUTJIjfqy7m32j72Eg
         b12mh40KzWD2DVyMryG6dr22uC7H89hr4Ac+OrtZJWAWfVodujE7Jt6wKNm2q/64MSAA
         SxTqd32sDejiwu9fX3jukZdmJX+SP07yGDBV1/D5ubwLGegwfRMU/vXbuJEgIUCdteOg
         4PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9hrKZqcsJy6v4SmU4cyAJHQyfkmwgDM2yXTgkEnUJE=;
        b=SFjAoqmnk/btAtrFOmMgcZHbximPEV1s0gR/qfn1gv9LqB5CJLaal3SAEw4KA77ETb
         2jIhhSQ1BpcQH5K6Zphb2tlsCfYbhDUCduMPsJklIcNH23J63J+BEwcfgwFZyuQ2cQNW
         cx9brTEGcGKjUYZFuYb0RDe+B6BZB/NCveywGLvGdKt9REPI0hm8airkSvxzQ50vuqDo
         yZ9ZHtWcsOETggHK1yyHwriLUgqJD+h2Umd+6bhjsQiWeA1pjniPFBdw/TdMB6ZOeMok
         4uoH/hAjaGJjggx1M0pzDGzed24gXGLu+W4DULpz83T81rKTqoSznU3jwI+BHZ8tsJ89
         2FAQ==
X-Gm-Message-State: APjAAAXvYKosOyqvOIBlPtrvW9E+ZUENjVCCRCHg25/zjSWyRrxROEO/
        +dGutjSgs0SYM7fa2g9acFZhRYUBoQuAWT+LA1hFow==
X-Google-Smtp-Source: APXvYqxfa3+wTMG+RtVeaI8V0pLRlOl0L0oDodcOQwhk+InnRfndgYLERdc/oGgcjCydFLjErmGojqU0b1usyuKBFAU=
X-Received: by 2002:a37:8185:: with SMTP id c127mr1384425qkd.43.1574407120578;
 Thu, 21 Nov 2019 23:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20191121084842.095edf87@suzdal.zaitcev.lan> <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
 <20191121173825.1527c3a5@suzdal.zaitcev.lan>
In-Reply-To: <20191121173825.1527c3a5@suzdal.zaitcev.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Nov 2019 08:18:28 +0100
Message-ID: <CACT4Y+bsZP4G7LXNzZ2OWLFUUYSQT+xRC48i0hzquJrrCVqhwA@mail.gmail.com>
Subject: Re: possible deadlock in mon_bin_vma_fault
To:     Pete Zaitcev <zaitcev@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:38 AM Pete Zaitcev <zaitcev@redhat.com> wrote:
>
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
>
> -- Pete
>
> commit 628f3bbf37eee21cce4cfbfaa6a796b129d7736d
> Author: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
> Date:   Thu Nov 21 17:24:00 2019 -0600
>
>     usb: Fix a deadlock in usbmon between mmap and read
>
>     Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

/\/\/\/\/\/\/\/\/\/\

Please don't forget the Reported-by

> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index ac2b4fcc265f..fb7df9810bad 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1039,12 +1039,18 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>
>                 mutex_lock(&rp->fetch_lock);
>                 spin_lock_irqsave(&rp->b_lock, flags);
> -               mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> -               kfree(rp->b_vec);
> -               rp->b_vec  = vec;
> -               rp->b_size = size;
> -               rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> -               rp->cnt_lost = 0;
> +               if (rp->mmap_active) {
> +                       mon_free_buff(vec, size/CHUNK_SIZE);
> +                       kfree(vec);
> +                       ret = -EBUSY;
> +               } else {
> +                       mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
> +                       kfree(rp->b_vec);
> +                       rp->b_vec  = vec;
> +                       rp->b_size = size;
> +                       rp->b_read = rp->b_in = rp->b_out = rp->b_cnt = 0;
> +                       rp->cnt_lost = 0;
> +               }
>                 spin_unlock_irqrestore(&rp->b_lock, flags);
>                 mutex_unlock(&rp->fetch_lock);
>                 }
> @@ -1093,11 +1099,11 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>                         return ret;
>                 if (put_user(ret, &uptr->nfetch))
>                         return -EFAULT;
> -               ret = 0;
>                 }
>                 break;
>
> -       case MON_IOCG_STATS: {
> +       case MON_IOCG_STATS:
> +               {
>                 struct mon_bin_stats __user *sp;
>                 unsigned int nevents;
>                 unsigned int ndropped;
> @@ -1113,7 +1119,6 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>                         return -EFAULT;
>                 if (put_user(nevents, &sp->queued))
>                         return -EFAULT;
> -
>                 }
>                 break;
>
> @@ -1216,13 +1221,21 @@ mon_bin_poll(struct file *file, struct poll_table_struct *wait)
>  static void mon_bin_vma_open(struct vm_area_struct *vma)
>  {
>         struct mon_reader_bin *rp = vma->vm_private_data;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&rp->b_lock, flags);
>         rp->mmap_active++;
> +       spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>
>  static void mon_bin_vma_close(struct vm_area_struct *vma)
>  {
> +       unsigned long flags;
> +
>         struct mon_reader_bin *rp = vma->vm_private_data;
> +       spin_lock_irqsave(&rp->b_lock, flags);
>         rp->mmap_active--;
> +       spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>
>  /*
> @@ -1234,16 +1247,12 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
>         unsigned long offset, chunk_idx;
>         struct page *pageptr;
>
> -       mutex_lock(&rp->fetch_lock);
>         offset = vmf->pgoff << PAGE_SHIFT;
> -       if (offset >= rp->b_size) {
> -               mutex_unlock(&rp->fetch_lock);
> +       if (offset >= rp->b_size)
>                 return VM_FAULT_SIGBUS;
> -       }
>         chunk_idx = offset / CHUNK_SIZE;
>         pageptr = rp->b_vec[chunk_idx].pg;
>         get_page(pageptr);
> -       mutex_unlock(&rp->fetch_lock);
>         vmf->page = pageptr;
>         return 0;
>  }
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20191121173825.1527c3a5%40suzdal.zaitcev.lan.
