Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB920878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKTSrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:47:01 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35010 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726023AbfKTSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:47:01 -0500
Received: (qmail 4620 invoked by uid 2102); 20 Nov 2019 13:47:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2019 13:47:00 -0500
Date:   Wed, 20 Nov 2019 13:47:00 -0500 (EST)
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
In-Reply-To: <20191120111235.7d306f23@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.1911201343580.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Pete Zaitcev wrote:

> On Wed, 20 Nov 2019 11:14:05 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > As it happens, I spent a little time investigating this bug report just
> > yesterday.  It seems to me that the easiest fix would be to disallow
> > resizing the buffer while it is mapped by any users.  (Besides,
> > allowing that seems like a bad idea in any case.)
> > 
> > Pete, does that seem reasonable to you?
> 
> Yes, it does seem reasonable.
> 
> I think I understand it now. My fallacy was thinking that since everything
> is nailed down as long as fetch_lock is held, it was okay to grab whatever
> page from our pagemap. What happens later is an attempt to get pages of the
> new buffer while looking at them through the old VMA, in mon_bin_vma_fault.
> 
> It seems to me that the use counter, mmap_active, is correct and sufficient
> to check in the ioctl.
> 
> -- Pete
> 
> P.S. One thing that vaguely bothers me on this is that the bot
> bisected to the commit that clearly fixed worse issues.
> 
> P.P.S. Like this?
> 
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index ac2b4fcc265f..e27d99606adb 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1020,6 +1020,9 @@ static long mon_bin_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>                 int size;
>                 struct mon_pgmap *vec;
>  
> +               if (rp->mmap_active)
> +                       return -EBUSY;
> +
>                 if (arg < BUFF_MIN || arg > BUFF_MAX)
>                         return -EINVAL;

Like that, yes, but the test has to be made while fetch_lock is held.  
Otherwise there's still a race: One thread could pass the test and then
do the resize, and in between another thread could map the buffer and
incur a fault.

Incidentally, the comment for fetch_lock says that it protects b_read 
and b_out, but mon_bin_vma_fault doesn't use either of those fields.

Alan Stern

