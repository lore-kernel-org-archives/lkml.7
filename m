Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2FC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7220637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLHTtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:49:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39132 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:49:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie2YF-0007uU-I4; Sun, 08 Dec 2019 19:49:07 +0000
Date:   Sun, 8 Dec 2019 19:49:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix use-after-free in __fput() when a chardev is
 removed but a file is still open
Message-ID: <20191208194907.GW4203@ZenIV.linux.org.uk>
References: <20191125125342.6189-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125125342.6189-1-vdronov@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 01:53:42PM +0100, Vladis Dronov wrote:
> In a case when a chardev file (like /dev/ptp0) is open but an underlying
> device is removed, closing this file leads to a use-after-free. This
> reproduces easily in a KVM virtual machine:
> 
> # cat openptp0.c
> int main() { ... fp = fopen("/dev/ptp0", "r"); ... sleep(10); }

> static void __fput(struct file *file)
> {   ...
>     if (file->f_op->release)
>         file->f_op->release(inode, file); <<< cdev is kfree'd here

>     if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
>              !(mode & FMODE_PATH))) {
>         cdev_put(inode->i_cdev); <<< cdev fields are accessed here
> 
> because of:
> 
> __fput()
>   posix_clock_release()
>     kref_put(&clk->kref, delete_clock) <<< the last reference
>       delete_clock()
>         delete_ptp_clock()
>           kfree(ptp) <<< cdev is embedded in ptp
>   cdev_put
>     module_put(p->owner) <<< *p is kfree'd
> 
> The fix is to call cdev_put() before file->f_op->release(). This fix the
> class of bugs when a chardev device is removed when its file is open, for
> example:

And what's to prevent rmmod coming and freeing ->release code right as you
are executing it?
