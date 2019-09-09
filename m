Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211EEC49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C0721A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wpuA/1C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfIIPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:04:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33079 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732745AbfIIPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:04:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id o9so13313850edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMS/zakUUbsy/GPMPTl/maw8Xc1QupHK9oOnGdfgOfA=;
        b=wpuA/1C1dj6WT3DpUqk+sot5UM5JQKOGrI79qxYatGVXChi01qZvCPOqe4lg3yE9/1
         Sjsg8+UlvjL0CF7JCmhujDaN6Yw1775Vj+xQfXtyvpeCkI2Pwx8Pb/QMmUo+Mm/ilj0M
         9vwKZUnGaaDBekIDoH/BbftKGVpeLWVlwj21AviESJUe/lyOs/O5gFKtAgQaXRQLQJ/q
         uhUxclft4zJolLTcPMBrTpTR8iFAVkexgUFGtgdLn/KC7gTMs+nWR/rTnGxpSsbC2SmW
         cllDcOROTz97szOu938jzkeozHxdTFdpm9L9JP7Law0KIQtxukClyqHdqXCVH2B15GWW
         qQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMS/zakUUbsy/GPMPTl/maw8Xc1QupHK9oOnGdfgOfA=;
        b=b1AEGZ+4zUz5nKDc5mjUSqOOSIdycHsnawOn8jkqHQ7tKKgM1LdfH8csZq+RTpMKUP
         qG0IspNpYayX4actSJuS3Xpd68TerFx9g/sxHrs4V+3hkkCB9H+/2j54OUzoBKMh0OC7
         0XB0S/Kp3p0G0g1LVTJ/2RnSe3Bw0TfeVTsSSr9mDbLbNuyMWca60CrU2jFW7wKROpLF
         MV8DROV+z2Zp1IwkU7Udu7sAZs3BhcBHyN6fNFzVWsgm0qanY9Bc2pvTPBMAFpQEwBX9
         iDGZJ8py/ojWTsuGTSgN+srGBshSYx2Zkf0sGI8BsWzvcEJqCctAXJDCwXs7SRmQzRcI
         /LDg==
X-Gm-Message-State: APjAAAWfDFoVVHJ4SzHDyTDzSCNZpMmVfVYOdNX9Sp9OWjJVoYBty0yy
        hOuxjN5WLHOVZiu5/7fbtCG2Pg==
X-Google-Smtp-Source: APXvYqyrBAicHxLg9EB/4d1Vi2IkqLL3N4PT4h+aNk2LSXp4n4/LAKF3laLCrU/dZLCrW5MYTU7Ljg==
X-Received: by 2002:a50:9512:: with SMTP id u18mr24616454eda.182.1568041454724;
        Mon, 09 Sep 2019 08:04:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h11sm3006093edq.74.2019.09.09.08.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:04:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D143A1003B5; Mon,  9 Sep 2019 18:04:12 +0300 (+03)
Date:   Mon, 9 Sep 2019 18:04:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com>,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in shmem_fault (2)
Message-ID: <20190909150412.ut6fbshii4sohwag@box>
References: <20190831045826.748-1-hdanton@sina.com>
 <20190902135254.GC2431@bombadil.infradead.org>
 <20190902142029.fyq3dwn72pqqlzul@box>
 <20190909135521.GD29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909135521.GD29434@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:55:21AM -0700, Matthew Wilcox wrote:
> On Mon, Sep 02, 2019 at 05:20:30PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Sep 02, 2019 at 06:52:54AM -0700, Matthew Wilcox wrote:
> > > On Sat, Aug 31, 2019 at 12:58:26PM +0800, Hillf Danton wrote:
> > > > On Fri, 30 Aug 2019 12:40:06 -0700
> > > > > syzbot found the following crash on:
> > > > > 
> > > > > HEAD commit:    a55aa89a Linux 5.3-rc6
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12f4beb6600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6a2b9826fdadf9
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=03ee87124ee05af991bd
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > 
> > > > > ==================================================================
> > > > > BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530  
> > > > > include/trace/events/lock.h:13
> > > > > Read of size 8 at addr ffff8880a5cf2c50 by task syz-executor.0/26173
> > > > 
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2021,6 +2021,12 @@ static vm_fault_t shmem_fault(struct vm_
> > > >  			shmem_falloc_waitq = shmem_falloc->waitq;
> > > >  			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> > > >  					TASK_UNINTERRUPTIBLE);
> > > > +			/*
> > > > +			 * it is not trivial to see what will take place after
> > > > +			 * releasing i_lock and taking a nap, so hold inode to
> > > > +			 * be on the safe side.
> > > 
> > > I think the comment could be improved.  How about:
> > > 
> > > 			 * The file could be unmapped by another thread after
> > > 			 * releasing i_lock, and the inode then freed.  Hold
> > > 			 * a reference to the inode to prevent this.
> > 
> > It only can happen if mmap_sem was released, so it's better to put
> > __iget() to the branch above next to up_read(). I've got confused at first
> > how it is possible from ->fault().
> > 
> > This way iput() below should only be called for ret == VM_FAULT_RETRY.
> 
> Looking at the rather similar construct in filemap.c, should we solve
> it the same way, where we inc the refcount on the struct file instead
> of the inode before releasing the mmap_sem?

Are you talking about maybe_unlock_mmap_for_io()? Yeah, worth moving it to
mm/internal.h and reuse.

Care to prepare the patch? :P

-- 
 Kirill A. Shutemov
